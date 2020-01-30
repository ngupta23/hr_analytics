# HR Analytics 
**Promotability and Attrition Prediction for a large multi-national company**

## Background

This project is focused on performing HR analytics for the company Wakko. Due to the sensitive nature of the data, the company name has been concealed and we are using the fictional name "Wakko". We obtained authorization by the company to use the data, but again due to the sensitive nature, the data was anonymized, raw numbers (such as salary, bonus, etc.) were normalized and sensitive fields (such as gender, age, etc.) were left out of the analysis. In addition, the raw data is not available publicly, just the final analysis can be shared.

## About the Company

The company Wakko designes and manufactures Fidgets. The company is focused on innovation, and employees more than 20,000 employee. Wakko has locations in multiple  countries across the globe, with a mix of manufacturing, R&D, support and Marketing offices.

## The Issue

Retention and growth of critical talent is a key factor for the success of the company. Wakko invests a large sum to attract the best candidates, by providing cutting edge tools and training, competitive compensation, and opportunity for growth. Promotion is an important part of the professional growth of any employee in Wakko and the company relies on management to set expectation and follow each employee to make sure they are ready for a promotion at the appropriate time.

The company has a periodic engagement survey to collect feedback from employees, and has also an 'Exit Survey' for employees leaving the company. In both surveys the inconsistency on the Promotion process has been a negative factor for engagement and retention. 

Wakko's management thinks this may be caused by managers not following up with all employees about their readiness for promotion at an appropriate time. Lack of consistency across groups on the requirements for promotion may also be another factor.


## The Objectives 

Managers should have better visibility into the promotability of an employee and how long it would be before employees would be ready for a promotion. If an employee is identified as having high potential for promotion, the manager can discuss with the employee, the best path to follow for successful career growth. If a high potential employee is near the promotion expected time, the manager can review the employee's achievements and readiness for promotion. 

In addition, factors identifying attrition should also be analyzed so that appropriate retention incentive can be incorporated in the benefit packages for these high potential employees.


## The Solution

Wakko's management is asking our team to create models that can:

1. **Identify early on (leading indicator), the likelihood og an employee getting a promotion in the future.**
2. **If an employee is likely to get a promotion, identify the expected number of months till the next promotion (i.e. a promotion window).**
3. **Identify the factors that could be leading to attrition.**


## Team

The Team working on this project is composed of 

- Nikhil Gupta (guptan@mail.smu.edu)
- Hayley Horn (hhorn@mail.smu.edu)
- Max Moro (mmoro@email.smu.edu)
- Michael Tieu (mtieu@mail.smu.edu)

## Data

### Data Sources

Data has been extracted from Wakko Human Resource SQL Data-warehouse using the following SQL queries (not publicly available):

- **promo_education.sql** is used to extract worker's highest degree, the date of the graduation, GPA, and area of study

- **promo_engagement.sql** is used to extract the Engagement survey results per each worker. Engagement survey is run every 6 month (February and August) and started 2 years ago.

- **promo_PPA.sql** used to extract the performance ratings. Every manager discuss and evaluate the work performance for each employee once per year between September and  December

- **promotions.sql** used to extract the demographic information per each employee and the events of promotion, demotion, lateral moves etc..

**NOTE: Data was only available from 2009 onwards.**

Data obtained from above queries has subsequently been combined and transformed to get the following fields (features). 

 

### Fields

|Field| Type| Description
|------|-----|--------------
|worker| Nominal| Anonymized identifier of the worker
|month| Interval| Year and Month of the observation
|month_seq| Interval| A sequential count of month number, starting from 2008 Jan
|year| Interval |Year of the observation
|qtr| Interval| Quarter number of the observation
|promotion| Nominal| Is 1 if the person received a promotion, 0 if not
|months_since_promotion| Ratio| Number of months since the last promotion
|promotion_cnt| Ratio| Number of promotion the person received since hiring or 2009 Jan
|comparatio_cent_scale| Ratio |Comparatio is the ratio between the person salary and a predefined target salary for the job and country the employee mapped into. To number has been centered and scaled, to grant anonymity
|span_of_control_direct| Ratio| Number of employees directly reporting to the individual
|span_of_control_total| Ratio| Number of employee directly and indirectly reporting to the individual
|month_in_job| Ratio| Number of month the person is the current job
|months_in_GJS| Ratio| GJS is a mapping the job based on the content (Engineering, Technician, etc..) and level (example:1 for new entry, 5 for expert). This field shows the number of months the person has been in the current GJS
|movement_lateral_cnt_sum| Ratio| Number of lateral moves received since last promotion. Lateral move is when an employees change job but is not a promotion (increase GJS level)  nor a demotion (decrease GJS level)
|movement_demote_event_cnt_sum|Ratio| Number of demotion received since last promotion. Demotion is a decrease on GJS level, this is based on an internal designed matrix.
|transfer_event_cnt_sum| Ratio| Number of transfers since last promotion. A Transfer is a change in group or Cost Center
|worker_is_terminated| Nominal | Is 1 if the person left the company as Regular Employee
|changes_spv_cnt_sum| Ratio|  Number of change in supervisory the individual experience since last promotion.
|awards_points_cnt_sum| Ratio| Number of events of awards in form of 'Points' received since last promotion. Points is a form of small and immediate monetary recognition. Points can be converted into products
|awards_points_sum| Ratio| Number of points received since last promotion
|awards_bonus_cnt_sum| Ratio|  Number of events of awards in form of monetary Bonus received since last promotion. 
|awards_bonus_sum_cent_scale| Ratio|  Number of events of awards in form of monetary Bonus received since last promotion.  This value has been centered and scaled
|awards_peer_cnt_sum| Ratio|  Number of  peer recognition received. A Peer recognition is non-monetary form of recognition given between employees
|reporting_level| Ratio|  Number of reporting levels up to the company CEO
|supervisor_flag| Nominal|  1 if the person is a supervisor, 0 if is an individual contributors
|tenure_in_months| Ratio|  Number of month of seniority in the company
|top_balance| Ratio| Number of hours of Vacation the person has. 
|top_change| Ratio| Difference of Top Balance between current and previous month
|accountability_matrix_label| Nominal | Organization the person is working in. This field has been anonymized using a random selection of words
|company_code| Nominal | Wakko has different entities across the global, this fields contain the name of the entity the person is working for
|cost_center_code| Nominal | Code of the Cost Center the person is working for. This field has been anonymized using a random selection of words
|supervisor| Nominal | Worker Code of the worker's supervisor
|mgr_01 - mgr_14| Nominal | Encrypted name of the organization chart of the the worker's, mgr01 is the CEO and mgr02 is 2nd level, etc..
|functional_area| Nominal | Function (Manufacturing, R&D, SG&A) the person is working for. This field has been anonymized using a random selection of words
|gjs_code_label| Nominal | Job Framework and level of the person. the first letter indicates the Job Framework, the second the level. The highest the number, the highest is the career level
|gjs_framework| Nominal | Job Framework of the person.
|gjs_sort_order| Ordinal | Identify a pseudo-career-order of each GJS the highest the number the highest is the career level.
|job_family_label| Nominal | The family of the job of the person. Each job is mapped to a family (ex: Junior Accountant is mapped to the Accountants job family). This field has been anonymized using a random selection of words
|job_long_text| Nominal | The job code of the person. (like Junior Accountant). This field has been anonymized using a random selection of words
|operational_rollup_label| Nominal | The roll-up of group the person is working with (Compensation org is under HR). This field has been anonymized using a random selection of words
|org_unit_desc| Nominal | The group the person is working with. This field has been anonymized using a random selection of words
|site_city_code| Nominal | The city where the person is working. This field has been anonymized using a random selection of words
|site_country_code| Nominal | The country code where the person is working. This field has been anonymized using a random selection of words
|site_country_region| Nominal | The country name where the person is working. This field has been anonymized using a random selection of words
|site_country_segment| Nominal | The country segment where the person is working. Segment is Europe, USA, Asia,etc...This field has been anonymized using a random selection of words
|site_desc| Nominal | The name of the site where the person is working, This field has been anonymized using a random selection of words
|ppa_rating| ordinal | The most recent performance rating the person received. The rating goes from 1 (poor) to 5 (excellent)
|spv_ppa_rating| ordinal | The most recent performance rating of the supervisor of the person . The rating goes from 1 (poor) to 5 (excellent)
|GPA| ordinal | The GPA of the highest degree of the person
|school_tier| Nominal | Schools are mapped to tiers based on the company strategy. This is the tier code of the school where the person received the highest degree
|study_focus| Nominal | Area of focus of the highest degree the person received.
|certificate_text| Nominal | Level of highest degree 
|engagement_avg| Ratio | Average Latest Engagement  scores the person had it. The score is an average of 20 elements, with values that ranges from 1 (totally disengaged) to 7 (fully engaged)
|engagement_std| Ratio | Standard deviation  of Latest Engagement s the person had it.



# Analysis Organization

The analysis has been organized into 5 parts. In each part, business understanding has been applied to make appropriate decisions.

1. Data Cleaning and Exploratory Analysis
2. Creating a Baseline model
3. Creating a better model (improved metrics)
4. Creating even better models using advanced methods
5. Identifying factors that might be affecting attrition

A summary of each of these analyses can be found below, with the detailed analysis (with code) found under the **_analysis_** folder.


## Part 1: Data Cleaning and Exploratory Analysis

### Techniques Used: 
- **Basic Visualization:** Scatterplots, Histograms, Countplots
- **Advanced Visulization:** Feature Correlations, Similarity Plots, Principal Component Analysis (PCA), Parallel Coordinate Plots
- **Business Understanding:** Categorizing features into similar themes to analyze the data.

### Libraries Used: 
- Pandas, Matplotlib

### Executive Summary:

After the data cleanup and imputation, we decided to break the "features" into 8 themes in order to analyze the data effectively. These were:

**Theme 1 - Performance**

* Employee Rating ranges from 0 to 5, with most employees (at least 75%) at or below 3. A rating of 4 and 5 was reserved for exceptional employees. The mean rating for promoted employees was 3.44 vs. 3.14 for non-promoted employees.
* Ratings of 1 and 2 are also rare as most of these employees are likely to not be retained).
* Interestingly, the time taken to get promoted did not depend on the employee's rating. 
* Comparatio represents the ratio of the salary to the median salary for that role. We expected the median comparatio to be close to 1 and that is what we observed in the statistics as well (0.972). The distribution of Comparatio was almost normal which aligns well with market insights. Interestingly however, we did not a remarkable difference in the compa ratio between employees who were promoted and those that were not.
* All awards related fields are right skewed with outliers. Most employees do not receive awards of any kind, but a few employees are rewarded for exceptional work (both by manangement and peers). Similar to comparatio, we did not see a remarkable difference in the awards given to employees that were promoted and those that were not. 
* **These findings could point to the fact that the company may not be able to give promotion to all deserving employees, but may try to retain them using financial incentives in line with those that do get promoted.**

**Theme 2 - Supervision Status**

* About 12.3% of employees are currently in a supervisory role and about 17.2% of employees were at least once in a supervisory role. As expected, the second number is larger than the first since some emplyees were once a supervisor, but then may have changed to an individual contributor role (either voluntarily or involuntarily).
* An employee who is currently in a managerial (supervisory) role is more likely to be promoted compared to those who are not in a managerial role however, they take longer to get promoted than those who are not in a managerial role. Similarity plots also indicated that this might be an important factor in determing the promotability of an employee.
    
**Theme 3 - Regional**

* The largest country by employees was the United States. However the largest region was Asia (predominantly due to the combied employees from Singapre, China, Taiwan and Japan). 
* Employees in EMEA has a lower probability of getting promoted, but for those that got promoted, employees in the Americas took a noticeably longer time to get promoted than those in EMEA and Asia. 

**Theme 4 - Manager**

* The company has a deep hiererchy (given the large number of employees). Most employees have up to 8 levels of management (median), with few having up to 12 levels of management. We will see later that this is an important factor that is correlated with attrition.
* Unlike the overall employee rating, where > 75% of the employees had a rating of 3 or less, supervisors tended to have a higher average rating (more than 25% have a rating of 4 or more). **This was expected and we should not draw causation between being a manager and receiving higher rating. The company is more likely to assign manangement roles to higher performers.**
* For employees who got promoted, having less number of managers was correlated  to a higher probability of getting promoted and a shorter amount of time to get promoted.  This can be related to the fact the employee has to establishd his/her reputation with the manager multiple times if the manager keeps changing.


**Theme 5 - Functional Area**

* The company has 3 functional areas and most of the observations (>82,000 out of ~ 105,000) were in "Manufacturing". R&D and SG&A represented a much smaller set of observations.
* Employees in R&D has a marginally higher rate of promotion than those in manufacturing and SG&A, however these employees took a noticeably longer time to get promoted compared to these other functional areas.

**Theme 6 - Job Grade**

* The company has 9 job frameworks and most of the observations (>40,000 out of ~ 105,000) are mapped as "Technical Engineers". Operators and technicians were also a big chunk of the observations (these come from the manufacturing group). 
* Those in technical leadership and at the executive level had a lower probability of getting promoted and if they were promoted, they took a longer time to get promoted compared to other job grades. However, this could be (and is likely) due to the fact that these employees have already reached the top of their respective ladders.

**Theme 7 - Tenure**

* Altough tenure (in months) was right skewed, The company has a healthy mix of young and old employees with tenure ranges from 0 to 601 months. This is expected, which many newer employees having less tenure and seaseoned employees being around for a long time.
* We found that tenure was negatively correlated to the probability of getting promoted and the similarity plots also offered a clear distinction based on tenure. Hence this might be an important feature to consider for any future modeling.


**Theme 8 - Education**

* There were 14 levels of education groups in the company's system. More than 34% (~34500 / ~105000) of the observations are mapped to employees having a bachelor's degree. Employees with a diploma or masters degree also make up a fair share of the observations. 
* The company maps schools from 0 (no tier) to 3 (1,2,3 represent the preferred schools in descending order). We noticed that although tiers 1, 2 and 3 had very few observations, employees from these schools had a higher probability of getting promoted and took less time to get promoted that those from school tier 0. Hence, this could be an  important factor to deterine employee promotion. 


## Part 2: Creating a Baseline model

* Techniques Used: 
    - Businesss Understanding: Creating a Custom Metric (Cost Function) taking multiple factors into consideration.
    - Models: Logistic Regression, Support Vector Machine (SVM) 
    - Model Tuning / Tradeoffs: Grid Search, Learning Curves
    - Model Explainibility Techniques: Feature Importance
* Libraries Used: Scikit-learn

### Executive Summary:

## Part 3: Creating a better model (improved metrics)

* Techniques Used: 
    - Businesss Understanding: Creating a Custom Metric (Cost Function) taking multiple factors into consideration.
    - Models: SVM, Randon Forest, K-Nearest Neighbors (KNN) 
    - Model Tuning: Bayesian Optimization
    - Model Comparison: Confusion Matrix, ROC Curves, t-tests
    - Model Explainibility: Feature Importance
* Libraries Used: Scikit-learn

### Executive Summary:

## Part 4: Creating even better models using advanced methods

* Techniques Used: Neural Networks
* Libraries Used: Pytorch, fast.ai

### Executive Summary:

## Part 5: Identifying factors that might be affecting attrition

* Techniques Used: 
    - Models: Clustering (K-Means and Agglomerative)
    - Visualizing Clusters: Custom Heatmap Based Cluster Visualization
    - Model Tuning: Baysian Optimization
    - Model Comparison: Elbow plots, Silhoutte Score
* Libraries Used: 
    - Scikit-learn
    - **Custom developed library ("more") for visualization and clustering helper classes**

### Executive Summary:


## A Note of Caution

Correlation vs. Causation



