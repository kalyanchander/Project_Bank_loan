-------creating stream-------
--------------------------------
create or replace stream project_stream on table consumer_banks_loan;

select * from project_stream;

--------------------------------------------------------------------------------

--CREATING CONSUMER TABLE AND COPYING DATA FROM STREAM

create or replace table consumer_banks_loan_target ( ID varchar, year varchar, loan_limit varchar, Gender varchar, approv_in_adv varchar, loan_purpose varchar, Credit_Worthiness varchar,
                                                    open_credit varchar,business_or_commercial varchar, loan_amount varchar, rate_of_interest varchar, Interest_rate_spread varchar, 
                                                    Upfront_charges varchar, term varchar,Neg_ammortization varchar, interest_only varchar, lump_sum_payment varchar, property_value varchar,
                                                    Secured_by varchar, total_units varchar, income varchar, credit_type varchar,Credit_Score varchar, co_applicant_credit_type varchar, 
                                                    age varchar, LTV varchar, Region varchar, Security_Type varchar, Status_num varchar,dtir1 varchar,stream_type string default null, 
                                                    rec_version number default 0,REC_DATE TIMESTAMP_LTZ);

merge into consumer_banks_loan_target t
using project_stream s
on t.id=s.id and (metadata$action='DELETE')
when matched and metadata$isupdate='FALSE' then update set rec_version=9999, stream_type='DELETE'
when matched and metadata$isupdate='TRUE' then update set rec_version=rec_version-1, stream_type='DELETE'
when not matched then insert (id ,year , loan_limit , Gender , approv_in_adv , loan_purpose ,
Credit_Worthiness , open_credit , business_or_commercial , loan_amount , rate_of_interest ,
Interest_rate_spread , Upfront_charges , term , Neg_ammortization , interest_only ,
lump_sum_payment ,property_value , Secured_by , total_units , income , credit_type ,
Credit_Score , co_applicant_credit_type , age ,LTV , Region ,
Security_Type , Status_num , dtir1 ,stream_type,rec_version,REC_DATE) values(s.id , s.year , s.loan_limit , s.Gender , s.approv_in_adv , s.loan_purpose ,
s.Credit_Worthiness , s.open_credit , s.business_or_commercial , s.loan_amount , s.rate_of_interest ,
s.Interest_rate_spread , s.Upfront_charges , s.term , s.Neg_ammortization , s.interest_only ,
s.lump_sum_payment ,s.property_value , s.Secured_by , s.total_units , s.income , s.credit_type ,
s.Credit_Score , s.co_applicant_credit_type , s.age , s.LTV , s.Region ,
s.Security_Type , s.Status_num , s.dtir1 , metadata$action,0,CURRENT_TIMESTAMP());

update consumer_banks_loan set gender = 'kalyan' where id=62075;


select * from project_stream;

select * from consumer_banks_loan_target;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
