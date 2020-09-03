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

Data obtained from above queries was subsequently combined and transformed to get the following fields (features). 

 

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



# Analysis

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

#### Theme 1 - Performance

* Employee Rating ranges from 0 to 5, with most employees (at least 75%) at or below 3. A rating of 4 and 5 was reserved for exceptional employees. The mean rating for promoted employees was 3.44 vs. 3.14 for non-promoted employees.
* Ratings of 1 and 2 are also rare as most of these employees are likely to not be retained).
* Interestingly, the time taken to get promoted did not depend on the employee's rating. 
* Comparatio represents the ratio of the salary to the median salary for that role. We expected the median comparatio to be close to 1 and that is what we observed in the statistics as well (0.972). The distribution of Comparatio was almost normal which aligns well with market insights. Interestingly however, we did not a remarkable difference in the compa ratio between employees who were promoted and those that were not.
* All awards related fields are right skewed with outliers. Most employees do not receive awards of any kind, but a few employees are rewarded for exceptional work (both by manangement and peers). Similar to comparatio, we did not see a remarkable difference in the awards given to employees that were promoted and those that were not. 
* **These findings could point to the fact that the company may not be able to give promotion to all deserving employees, but may try to retain them using financial incentives in line with those that do get promoted.**

#### Theme 2 - Supervision Status

* About 12.3% of employees are currently in a supervisory role and about 17.2% of employees were at least once in a supervisory role. As expected, the second number is larger than the first since some emplyees were once a supervisor, but then may have changed to an individual contributor role (either voluntarily or involuntarily).
* An employee who is currently in a managerial (supervisory) role is more likely to be promoted compared to those who are not in a managerial role however, they take longer to get promoted than those who are not in a managerial role. Similarity plots also indicated that this might be an important factor in determing the promotability of an employee.
    
#### Theme 3 - Regional

* The largest country by employees was the United States. However the largest region was Asia (predominantly due to the combied employees from Singapre, China, Taiwan and Japan). 
* Employees in EMEA has a lower probability of getting promoted, but for those that got promoted, employees in the Americas took a noticeably longer time to get promoted than those in EMEA and Asia. 

#### Theme 4 - Manager

* The company has a deep hiererchy (given the large number of employees). Most employees have up to 8 levels of management (median), with few having up to 12 levels of management. We will see later that this is an important factor that is correlated with attrition.
* Unlike the overall employee rating, where > 75% of the employees had a rating of 3 or less, supervisors tended to have a higher average rating (more than 25% have a rating of 4 or more). **This was expected and we should not draw causation between being a manager and receiving higher rating. The company is more likely to assign manangement roles to higher performers.**
* For employees who got promoted, having less number of managers was correlated  to a higher probability of getting promoted and a shorter amount of time to get promoted.  This can be related to the fact the employee has to establishd his/her reputation with the manager multiple times if the manager keeps changing.


#### Theme 5 - Functional Area

* The company has 3 functional areas and most of the observations (>82,000 out of ~ 105,000) were in "Manufacturing". R&D and SG&A represented a much smaller set of observations.
* Employees in R&D has a marginally higher rate of promotion than those in manufacturing and SG&A, however these employees took a noticeably longer time to get promoted compared to these other functional areas.

#### Theme 6 - Job Grade

* The company has 9 job frameworks and most of the observations (>40,000 out of ~ 105,000) are mapped as "Technical Engineers". Operators and technicians were also a big chunk of the observations (these come from the manufacturing group). 
* Those in technical leadership and at the executive level had a lower probability of getting promoted and if they were promoted, they took a longer time to get promoted compared to other job grades. However, this could be (and is likely) due to the fact that these employees have already reached the top of their respective ladders.

#### Theme 7 - Tenure

* Altough tenure (in months) was right skewed, The company has a healthy mix of young and old employees with tenure ranges from 0 to 601 months. This is expected, which many newer employees having less tenure and seaseoned employees being around for a long time.
* We found that tenure was negatively correlated to the probability of getting promoted and the similarity plots also offered a clear distinction based on tenure. Hence this might be an important feature to consider for any future modeling.


#### Theme 8 - Education

* There were 14 levels of education groups in the company's system. More than 34% (~34500 / ~105000) of the observations are mapped to employees having a bachelor's degree. Employees with a diploma or masters degree also make up a fair share of the observations. 
* The company maps schools from 0 (no tier) to 3 (1,2,3 represent the preferred schools in descending order). We noticed that although tiers 1, 2 and 3 had very few observations, employees from these schools had a higher probability of getting promoted and took less time to get promoted that those from school tier 0. Hence, this could be an  important factor to deterine employee promotion. 


## Part 2: Creating a Baseline model

### Techniques Used: 

* Businesss Understanding: Creating a Custom Metric (Cost Function) taking multiple factors into consideration.
* Models: Logistic Regression, Support Vector Machine (SVM) 
* Model Tuning / Tradeoffs: Grid Search, Learning Curves
* Model Explainibility Techniques: Feature Importance

### Libraries Used:
* Scikit-learn

### Executive Summary:

#### Custom Metric

* We created a baseline model to predict whether an employee was going to be promoted or not. 
* Based on business understanding, we set a custom metric for model evalaution which included the **"Recall" for the "Promoted Class"** and the **F1 Score (Weighted)**. 
    - Recall essentially provided us the answer - "What percentage of the employees that were actually promoted were predicted correctly by our model ". This was the primary objective and hence the main factor in the custom metric.
    - However, this can not be the only metric we consider since the model could predict that everyone gets promoted, in which case the "Recall" would be 1, but this would not be a useful model. Hence to make sure that the model results are balances and do not have lots of false positives (predicting that an employee will get promoted when they are not likely to be), we also included the Weighted F1 score in the final metric (which takes both false positives and false negatives into account).
    - Our target was to get these numbers to be > 0.75 for both these metrics. 

#### Logistic Regression Model
* After fine tuning the model based on grid search, we found that the best model gave a Recall Score of ~0.76 and a Weighted F1 score of ~ 0.74. Both of these were close to our initial target. Based on the learning curves, we concluded that the model was able to generalize well and did not show any overfitting.

#### Support Vector Machine Model
* After fine tuning the model based on grid search, we found that the best model gave a Recall Score of ~0.78 and a Weighted F1 score of ~ 0.73. Both of these were close to our initial target (and not much different from what we obtained from the logistic regression model). Based on the learning curves, we concluded that the model was able to generalize well and did not show any overfitting.

#### Features correlated with Promotability

**Note: While it might be tempting to infer causality from this analysis , we should be careful not to do so. The data is observational (not collected through a randomized experiment).** In order to understand this, let's take a simple example. Lets say we collect observational data on on past fires and notice that whenever there is fire, there is also smoke. We can not conclude from this data that smoke causes fire. We can only say that smoke is associated or correlated with fire. A factor that causes a change in another factor can only be determined if we perform a controlled statistical experiment which is not possible (and even ethical) in our use case of promotion and attrition.

So is the analysis of correlation using an observational study of any use? It is. Even though we can not pinpoint causailty, a domain expert can still use this data to make informed decisions and conclusions. Again as an anecdotal example, the effect of smoking on lung cancer was studies heavily in the 20th century, but they were all observational studies (a controlled experiment here would have been unethical). Most of these studies pointed to a strong correlation between smoking and lung cancer. Even though the investigators could not conclude causation, there was a strong probability that smoking causes lung cancer based on the evidence presented and the interaction of the smoke with the lungs. This as we all know led to "informed decisions" being made and changes in policies by the governments around the world. 

**Theme 1: Performance Related**
* The logistic regression model showed that the most highly correlated factors with promotability were the employees rating (positively correlated, weight ~ 0.57), change of group or cost center (positively correlated, weight = 0.2) and months since last promotion (negatively correlated, weight = -0.4).

**Theme 2: Supervision Status** 
* From the logistic regression model. we found that if an employee was in a supervisory role, this is was positively associated (weight = 0.35) with the chance of getting a promotion.

**Theme 3: Regional**
* From the logistic regression model, we found that these factors did not seem to impact promotion.

**Theme 4: Manager**
* From the logistic regression model, we found that the number of managers for an employee had a negative correlation (weight = -0.35) to the chance of getting a promotion. This could be due to the fact that the employee has to establish themselves in the eyes of many managers and there is loss of continuity. This might be worth investigatig further by the HR department of the company. 

**Theme 5: Functional Area**
* From the logistic regression model, we found that these factors did not seem to impact promotion.

**Theme 6: Job Grade**
* From the logistic regression model, we found that these factors did not seem to impact promotion.

**Theme7: Tenure**
* The logistic regression model shows a negative correlation (weight = -0.28) between an employees tenure and the chance of getting promoted. We should be very careful (especially in this case) in concluding causation of age based discrimination. It could very well be possible that more seasoned employees have already been promoted in the past and hence have a lower probability of getting promoted again in the future. 

**Theme 8: Education**
* The logistic regression model shows that a "Bacheor's" degree is mildly positively correlated (weights < 0.1) with promotabiliy whereas other degrees are mildly negatively correlated to promotability (weights < 0.125). The emphasis is on the word mild since these factors were not as strong compared to some of the other factors described above. Again, we must be careful not to draw any causal relationships here as there may be other factors at play.

**In summary, based on the logistic regression model, we found that the most positively correlated themes to promotability were the "performance" and "manager" themes, particularly the employees rating and whether the employee was in a supervisory role.** These results were not suprising - the better the rating of an employee, the greater the change of them getting promoted. Also, if an employee is in a supervisory role, they might have already been identified as a strong candidate for promotion. **The most negatively correlated themes were the number of managers that an employee had and the tenure of the employee.** While we dont want to draw any causal relationships here, the HR department might want to investigate this further to get a better sense of the root cause. 

## Part 3: Creating a better model (improved metrics)

### Techniques Used: 
* Businesss Understanding: Creating a Custom Metric (Cost Function) taking multiple factors into consideration.
* Models: SVM, Randon Forest, K-Nearest Neighbors (KNN) 
* Model Tuning: Bayesian Optimization
* Model Comparison: Confusion Matrix, ROC Curves, t-tests
* Model Explainibility: Feature Importance

### Libraries Used: 
* Scikit-learn
* skopt for Bayesian Hyperparameter Optimization

### Executive Summary (Promotability):

#### Custom Metric
* We continued building on the baseline model developed in Part 2 to predict promotability of an employee. In this part we created a **single custom score** by combining the "Recall for the Promoted Class" and the "Weighted F1 scorere " with an overall goal of exceeding 1.50. This was needed for 2 reasons
    1. So that we can have a **single number evaluation metric to automatically compare different models**. If we notice carefully from the baseline model, the SVM model had a higher Recall score, but a lower Weighted F1 score compred to the logistic regression model. Hence it would become hard to compare the 2 models in a programatic way. Having a combined single number evaluation metic overcomes this problem.
    2. Random grid search to find the optimum set of hyperparameters is considered better than a predefined frid search. Even then, hyperparameter optimization using random grid search can be time consuming and we are never sure if we have the best set of hyperparametrs for the model in the end. However using a technique such as **Bayesian Optimization** can help us find the "best" set of hyperparameters relatively quickly compared to a random grid search. One of the requirements is that we have a single metric evaluation function (a cost function) to optimize for to obtain the best set of hyperparameters. 

#### Support Vector Macine
* In this part, we did not use logistic regression, but we reran the SVM model with Bayesian Hyperpparameter optimization to find the best model. 
* The final model using the best parameters from Bayesian optimization produces an average recall for the promoted class of 0.77 and an average weighted F1 score of 0.73 across 3-folds. This was practically the same as the baseline model that we developed in Part 2. The original model was close to optimum, and while we could not improve it using Bayesian grid search, we have greater confidence we have obtained the most optimal model possible. The combined total score for the final model is 0.77 + 0.73 = 1.50.
* We also used ROC to evaluate the model. The mean ROC across the 3 folds was 0.71. Any number > 0.5 means that the model is doing better than random guessing, but when comparing models, we want to choose a model which has an ROC value closest to 1. We used this metric at the end to compare different models as well in addition to our custom metric.

#### Random Forest Model
* Since we did not create a baseline random forest model in Part 2, we did that in this part. We obtained a model with a recall score (for the promoted class) of 0.84 and a weighted F1 score of 0.82. Both these values are exceeding our original target of 0.75. The combined total score for the baseline model is 0.84 + 0.82 = 1.66.
* The final model with Bayesian hyperparameter optimization yielded slightly better results. We obtained a combined custom score of 1.68 and an average ROC of 0.8 across 3 folds. Both these metrics were better than the SVM model.

#### K-Nearest Neighbors (KNN) 
* Since we did not create a baseline KNN model in Part 2, we did that in this part. We obtained a model with a recall score (for the promoted class) of 0.59 and a weighted F1 score of 0.79 which gave a combined score of 1.38.
* The final model with Bayesian hyperparameter optimization yielded slightly better results. We obtained a combined custom score of 1.42 and an average ROC of 0.64 across 3 folds. Amongst all the models, this was the worst performing model and did not meet our original targets.

#### Model Comparison
* While a direct comparison of numbers can be used as a 1st pass for model comparison, we should really rely upon statistical methods to perform a scientific model comparison. Hence we conducted a 2 sample t-test to compare the models in pairs. Since the variability between the different folds of any single models was not large, this test confirmed the original findings that the Random Forest model was better than SVM model which in turn was better than the KNN model. Hence we **choose the Random Forest model as the final model for prediction**.

#### Features correlated with Promotability
* The Random Forest Model can be used to determine Feature Importance. It does that by lookig at how many times a feature is used to split the tree across all the "trees is the forest". 
* The featire importance from the Random Forest model highlighted some of the same themes that were highlighted by the Logistic Regression (baseline) model, namely "tenure", "employee rating", and "number of managers". In addition, this model found that some other feaures such as "comparatio" and "employee awards" were also good predictors of promotability. These new "important features" identified by this model are not a surprise though since these are lagging indicators and not leading indicators. 
* One drawback of using feature importance from a Random Forest model is that while it does give us the feature importance, it does not give us the direction (whether the feature is positively or negatively correlated to the outcome). Becuse of this reason, although we may decide to use this model as the final model, we may still want to rely on the simpler baseline logistic regression model for feature importance.
* As a follow on, we could also use techniques such as LIME in the future to improve the model explainibility.


### Executive Summary (Time to Promotion):

This was the second prediction task that was assigned to us - For the employees who were likely to be promoted, what was the approximate time window of promotion. We decided to break the output into windows of 0-1 year, 1-2 years, 2-3 years and > 3 years.

#### Custom Metric
* For an employee that gets promoted in the 0-1 year bucket, predicting that he/she gets promoted in > 3 years is costlier than predicting that he/she gets promoted in 1-2 years. For this reason, **not all cells in the confusion matrix are weighted equally** when coming up with a metric to train and evaluate models. To adjust for this, we came up with a **custom cost matrix**. Since the classes were ordered, predictions that are further away from the actual class were penalized more. We used the square of the difference [(predicted label - actual label)2] as an aggressive penalty factor. For example:

    - If the actual label is 1 and the prediction is 1, the cost is (1-1)2 = 0.
    - If the actual label is 1 and the prediction is 2, the cost is (2-1)2 = 1.
    - If the actual label is 1 and the prediction is 0, the cost is (0-1)2 = 1.
    - If the actual label is 1 and the prediction is 3, the cost is (3-1)2 = 4.
* In the end, we selected a model that minimizes the sum of all the cells in this custom cost matrix. Unlike in the previous case of predicting promotability, in this case, the lower this metric, the better the model.

#### Support Vector Machine model
* The baseline model gave a custom cost matrix score of 0.608
* The model obtained after Bayesian Hyperparaeter optimization gave a custom score of 0.569 (a slight improvement over the baseline model).
* The ROC curves gave a micro-average ROC of 0.84 and a macro average ROC of 0.80.

#### Random Forest model
* The baseline model gave a custom cost matrix score of 0.33 (much better than the SVM model).
* The model obtained after Bayesian Hyperparaeter optimization gave a custom score of 0.234 (a **significant improvement over the baseline model**).
* The ROC curves gave a micro-average and a macro-average ROC of 0.96 which is very close to the maximum value of 1.

#### K Nearest Neighbors (KNN) model
* The baseline model gave a custom cost matrix score of 0.92 (much worse than the SVM model)
* The model obtained after Bayesian Hyperparaeter optimization gave a custom score of 0.573 (which was a significant improvemnt over the baseline model and in lines with the best SVM model that we obtained).
* The ROC curves gave a micro-average ROC of 0.88 and a macro average ROC of 0.87 (which were better than the SVM model but not as good as the Random Forest model).

#### Features correlated with Promotability
* Even for this task, the models pointed to similar "important features" as shown by the models for the previous tasks, namely "tenure in months", "number of managers", and "employee awards".
* One interesting finding from the SVM feature importance plots was that the number of managers for an employee has a significant impact on them taking longer to get promoted (> 2 years) while those that get promoted in < 2 years are not impacted by this. This lines up well with our original hypothesis as well (from EDA) that it may be that the employee needs more time to establish himself/herself with managers (if the managers keep changing frequently). 

## Part 4: Creating models using nore advanced methods (Neural Networks)

#### Techniques Used: 
* Neural Networks

#### Libraries Used: 
* Pytorch,
* fast.ai

### Executive Summary:

#### Using native PyTorch
* In this case, results with the best random forest were slightly better than those obtained from the neural network (custom score = 1.62 for Neural Network vs 1.66 for Random Forest). This is just a baseline neuaral netowrk model and by using Bayesian Optimization, this could porentially be improved in the future. 


#### Using fast.ai
* Neural Network with Embeddings allow use of most categorical variables irrespective of the number of levels
* The Neural network model obtained does not overfit (we used early stopping to prevent that). This was also be confirmed by looking at the confusion matrix of the test set and confirming that it was close to the confusion matrix for the validation set.
* In this case, results with the best random forest were slightly better than those obtained from the neural network (custom score = 1.55 for Neural Network vs 1.66 for Random Forest). Again, this is just a baseline neuaral netowrk model and by using Bayesian Optimization, this could porentially be improved in the future. 


## Part 5: Identifying factors that might be affecting attrition

* Techniques Used: 
    - Models: Clustering (K-Means and Agglomerative)
    - Visualizing Clusters: Custom Heatmap Based Cluster Visualization
    - Model Tuning: Baysian Optimization
    - Model Comparison: Elbow plots, Silhoutte Score, Custom metric to scale, weight and combine these 2 metrics
* Libraries Used: 
    - Scikit-learn
    - **Custom developed library ("more") for visualization and clustering helper classes**

### Executive Summary:

**Promoted employees** were clustered into 5 groups after evaluating various clustering methods. Two of these groups had a relatively higher attrition rate (around 1 in 4) than the other three (around 1 in 6). The factors that seemed to be highly correlated to the attrition in these 2 groups were 
1. **Levels of Hierarchy:** Higher number of levels of hierarchy were correlated with higher attrition. This could be due to the fact that these employees feel far remved from the decision making process and dont feel a sense of ownership or buy-in. There are different approaches such as roundtables with leaders, anonymous surveys, or even an organizational restructure to reduce the number of layers in the organization to boost inclusion and reduce turnover rate.
2. **Lack of Bonus:** This was especially true for promoted employees who had a lower tenure with the company. Furthermore this group had the largest number of employees (amongst the employees that were promoted), indicating that the awards program is not widely applied. This could also indicate there are not many opportunities for new and different job experiences (based on GJS and site variables), especially for low-tenured employees. A shadow program, job rotation, or mentorship program may help on improving employee best fit.

## A Note of Caution

**Correlation vs. Causation:** While this analysis is focussed on using existing employee data, this is not a randomized experiment. Hence the findings can not be treated as causal. Nonetheless, this provides useful insights into the factors that could potentially impact promotability and attrition and point to areas that could be explored further by the Human Resourse department in order to improve outcomes. In the end, this analysis is meant to augment the informaton available to the HR department and the managers and not meant to be a replacement for the human element involved in making promotion decisions. 

