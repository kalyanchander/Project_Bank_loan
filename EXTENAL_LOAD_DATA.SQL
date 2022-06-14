-- CREATING TABLE-----
---------------------- 

create or replace table consumer_banks_loan (ID varchar, year varchar, loan_limit varchar, Gender varchar, approv_in_adv varchar, loan_purpose varchar, Credit_Worthiness varchar,
                                             open_credit varchar,business_or_commercial varchar, loan_amount varchar, rate_of_interest varchar, Interest_rate_spread varchar, 
                                             Upfront_charges varchar, term varchar, Neg_ammortization varchar,interest_only varchar, lump_sum_payment varchar, property_value varchar,
                                             Secured_by varchar, total_units varchar,income varchar, credit_type varchar, Credit_Score varchar,co_applicant_credit_type varchar, age varchar,
                                             LTV varchar, Region varchar, Security_Type varchar, Status_num varchar, dtir1 varchar);
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----file format creation-----
---------------------------


create or replace file format my_csv_format
type = csv field_delimiter = ','
field_optionally_enclosed_by ='"'
null_if=('NULL', 'null')
empty_field_as_null = true;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----stage creation-------
--------------------------


create or replace stage project.PUBLIC.project_stage
url="s3://kalyanchander/MYFOLDER1"
STORAGE_INTEGRATION=s3_int
file_format = my_csv_format;


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--copy command------
--------------------

CREATE or replace TASK task_project
WAREHOUSE = COMPUTE_WH
SCHEDULE = 'USING CRON 0 0 * * 4 America/Los_Angeles'
AS
copy into project.public.consumer_banks_loan
from (select t.$1 ,t.$2,t.$3,t.$4,t.$5,t.$6 ,t.$7,t.$8,t.$9,t.$10,t.$11,t.$12,t.$13,t.$14,t.$15,t.$16 ,t.$17,t.$18,t.$19,t.$20,t.$21 ,t.$22,t.$23,t.$24,t.$25,t.$26,t.$27 ,t.$28,t.$29,t.$30
      from @project.public.project_stage as t)
file_format = (type = csv field_optionally_enclosed_by='"' skip_header=1);


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



