import pandas as pd

df=pd.read_csv ('/content/Loan.csv')

df=pd.read_csv (r'/content/Loan.csv')
df.to_json (r'/content/JsonLoan')

----------------------------------------------------------