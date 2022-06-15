 -- Apply column-level security using Secure Views------
-- create a secure view-------------
-------------------------------------------------------

create or replace role manager_id;
create or replace role user_id;

create or replace user manager123 password = '123' default_Role = 'public' must_change_password = false;
create or replace user employee password = '123' default_Role = 'public' must_change_password = false;


grant role manager_id to user manager123;
grant role user_id to user manager123;


USE ROLE manager_id;

SELECT * FROM "PROJECT"."PUBLIC"."VW_FOR_MANAGER";

USE ROLE user_id ;

SELECT * FROM "PROJECT"."PUBLIC"."VW_MASK_TABLE_FOR_USER";


grant usage on warehouse compute_Wh to role user_id;
grant usage on database project to role user_id;
grant usage on schema public to role user_id;




grant usage on warehouse compute_Wh to role manager_id;
grant usage on database project to role manager_id;
grant usage on schema public to role manager_id;



CREATE or replace MASKING POLICY project.Public.masking_id_pol AS (VAL varchar) RETURNS STRING ->
CASE
WHEN CURRENT_ROLE() IN ('manager_id') THEN VAL
ELSE regexp_replace(val,'[0-9]{3}','***')
END;



CREATE or replace MASKING POLICY project.Public.masking_gender_pol AS (VAL varchar) RETURNS STRING ->
CASE
when CURRENT_ROLE() in ('manager_id') then val
when val='Sex Not Available'or val= 'Joint' then 'n/a'
else val
END;



CREATE or replace MASKING POLICY project.Public.masking_loan_amount_pol AS (VAL varchar) RETURNS STRING ->
CASE
when CURRENT_ROLE() in ('manager_id') then val
else '******'
END;




CREATE OR REPLACE TABLE project.PUBLIC.mask_table( ID varchar MASKING POLICY project.Public.masking_id_pol,
year varchar,
loan_limit varchar,
Gender varchar MASKING POLICY project.Public.masking_gender_pol,
approv_in_adv varchar,
loan_purpose varchar,
Credit_Worthiness varchar,
open_credit varchar,
business_or_commercial varchar,
loan_amount varchar MASKING POLICY project.Public.masking_loan_amount_pol,
rate_of_interest varchar,
Interest_rate_spread varchar,
Upfront_charges varchar,
term varchar,
Neg_ammortization varchar,
interest_only varchar,
lump_sum_payment varchar,
property_value varchar,
Secured_by varchar,
total_units varchar,
income varchar,
credit_type varchar,
Credit_Score varchar,
co_applicant_credit_type varchar,
age varchar,
LTV varchar,
Region varchar,
Security_Type varchar,
Status_num varchar,
dtir1 varchar);




INSERT INTO project.PUBLIC.mask_table(ID,year, loan_limit, Gender , approv_in_adv , loan_purpose ,
Credit_Worthiness , open_credit , business_or_commercial , loan_amount , rate_of_interest ,
Interest_rate_spread , Upfront_charges , term , Neg_ammortization, interest_only ,
lump_sum_payment ,property_value , Secured_by , total_units , income , credit_type ,
Credit_Score , co_applicant_credit_type , age ,LTV , Region ,
Security_Type , Status_num , dtir1 )
SELECT ID,year, loan_limit, Gender , approv_in_adv , loan_purpose ,
Credit_Worthiness , open_credit , business_or_commercial , loan_amount , rate_of_interest ,
Interest_rate_spread , Upfront_charges , term , Neg_ammortization, interest_only ,
lump_sum_payment ,property_value , Secured_by , total_units , income , credit_type ,
Credit_Score , co_applicant_credit_type , age ,LTV , Region ,
Security_Type , Status_num , dtir1 FROM project.Public.consumer_banks_loan;





select * from mask_table;

========================================================================================================



create or replace secure view vw_mask_table_for_user as
select i.*
from project.public.mask_table i;

select * from vw_mask_table_for_user;

grant select on view project.public.vw_mask_table_for_user to role user_id;


create or replace secure view vw_for_manager as
select i.*
from project.public.consumer_banks_loan i;

grant select on view project.public.vw_for_manager to role manager_id;

---------------------------------------------------
select * from vw_for_manager;




grant select on view project.public.vw_for_manager to role user_id;
grant select on view project.public.vw_for_manager to role manager_id;


grant select on view project.public.vw_mask_table_for_user to role user_id;
grant select on view project.public.vw_for_manager to role manager_id;

=======================================================================================================================================================================

