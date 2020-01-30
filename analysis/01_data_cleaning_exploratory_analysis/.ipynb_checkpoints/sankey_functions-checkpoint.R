options(warn=-1)

getDataFiltered = function(selGJS='E1',selYear=2009,dataAll){
  
  #gather the workers at the begin of selected Year
  selWorkers = unique(filter(dataAll,year==selYear, (gjs_code_label == selGJS | selGJS ==''), gjs_sort_order != 0)$worker)
  #filter the data based on workers and yeat
  selData =   dataAll  %>% 
    filter(worker %in% selWorkers,year >= selYear)   %>% 
    arrange(worker,month)  
  
  #select the job order (for promotion) and add the last record as valid year (end of period for sankey)
  dataPre = selData %>% 
    group_by(worker,year) %>%
    summarize(gjs_code = gjs_code_label[1]
              ,gjs_sort_order = gjs_sort_order[1])  %>%
    ungroup() %>%
    union_all(selData %>%
                filter(month == max(selData$month)) %>%
                select(worker
                       ,year=month
                       ,gjs_code=gjs_code_label
                       ,gjs_sort_order)
    ) 
  #creating full dataset requiring a record per worker and per year (if year is not present the worker termianted)
  dataOri= dataPre %>%
    right_join(merge(unique(dataPre$year),unique(dataPre$worker),all=TRUE),by=c('year'='x','worker'='y'))%>%
    group_by(worker) %>%
    mutate(status = ifelse(is.na((gjs_sort_order)),'Separated','Active'))  %>%
    ungroup()
  return(dataOri)
}


getSankey <- function(selGJS='E1',selYear=2009,dataAll){
  dataOri = getDataFiltered(selGJS=selGJS,selYear=selYear,dataAll=dataAll)
  #select the first node
  first_node = dataOri %>% 
    filter(year== min(dataOri$year))  %>%
    slice(1) %>%
    transmute(year
              ,gjs_code
              ,gjs_sort_order
              ,name = paste0(year,' ')
              # ,count=n()
    )
  
  #calculate the job level of next year and define if it is a separation, promotion, or demotion
  data = dataOri %>%
    arrange(worker,year) %>%
    group_by(worker) %>%
    mutate(next_gjs_sort_order = lead(gjs_sort_order,1,default=NA,order_by = year)
           ,next_year = lead(year,1,default=NA,order_by = year)
           ,next_status = lead(status,1,default=NA,order_by = year)
    ) %>%
    filter(! is.na(next_year )) %>%
    mutate(action = ifelse(next_status=='Separated','Separated'
                           ,ifelse(next_gjs_sort_order > gjs_sort_order[1], 'Promotion'
                                   ,ifelse(next_gjs_sort_order < gjs_sort_order[1], 'Demotion'
                                           , 'NoChange')
                           ))
           ,next_node = paste0( next_year,' ',action) #create the name of nodes
    ) %>%
    mutate(curr_node = lag(next_node,1,default= paste0(year[1],' '),order_by=year)) #calculate the name of current node
  
  #group all data for the final dataset for sankey
  dataTot=data %>%
    group_by( action,year,curr_node,next_year,next_node) %>% #we need only the name ofnodes and action
    summarise(count=n()) %>% #count of people
    ungroup() %>%
    arrange(year,action,curr_node) %>% 
    filter(next_year ==  as.numeric(year)  +1) #we don't want any issue with missing years (not really needed this)
  
  #gather the nodes name for sankey
  nodes = union_all(transmute(first_node
                              ,node=name
                              ,year  = as.character(year)
                              ,action='NoChange' #defauly
                              ,count = sum(filter(dataTot,year == first_node$year )$count))
                    ,select(dataTot,node=next_node,year=next_year,action,count)) %>%
    group_by(node,year ,action) %>%
    summarise(total = sum(count)) %>% #count of peple by action
    group_by(year) %>%
    mutate(total_perc = total/sum(total)) %>% #percentage
    ungroup()   %>%
    mutate(action=factor(action,levels=c('Promotion', 'NoChange','Demotion','Separated','ERROR'))) %>% #make sure the factros are in the right order
    arrange(action) %>%
    mutate(label=paste0(scales::percent(round(total_perc,2)),' ',node)  #labels or node
           ,id=1:n()
    )
  
  #create the link between nodes for sankey
  dataTotId=dataTot %>% 
    left_join(select(nodes,node,id),by=c('curr_node'='node')) %>% dplyr::rename(currNodeID=id) %>% 
    left_join(select(nodes,node,id),by=c('next_node'='node')) %>% dplyr::rename(nextNodeID=id) %>%
    arrange(year,action)
  
  #colors
  actionsColors = data.frame(action=c('Promotion','NoChange','Demotion','Separated')
                             ,color=c('#1a9850','#4393c3','#f46d43','#878787'))
  #past colors to D3 dataframe
  colorsD3 <- paste0('d3.scaleOrdinal()'
                     ,' .domain(["',paste0(actionsColors$action,collapse='", "'),'"])'
                     ,' .range(["',paste0(actionsColors$color,collapse='", "'),'"])')
  #finally! sankey
  networkD3::sankeyNetwork(Links=data.frame(transmute(dataTotId,Source=currNodeID-1,Target=nextNodeID-1,Value=count,Group=action))
                           ,Nodes = data.frame(select(nodes,Name=label,Group=action))
                           ,Source='Source'
                           ,Target='Target'
                           ,Value='Value'
                           ,NodeID='Name'
                           ,NodeGroup ='Group'
                           ,LinkGroup='Group'
                           ,colourScale =colorsD3
                           ,fontSize=7
                           ,fontFamily = 'Arial'
                           ,iterations = 0
                           ,nodeWidth = 10
                           ,nodePadding=10
                           ,sinksRight = F
                           ,margin=0
                           
  )
  
}