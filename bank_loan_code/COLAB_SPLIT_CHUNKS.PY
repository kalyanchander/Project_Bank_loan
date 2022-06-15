chunk_size=10000

batch_no=1



for chunk in pd.read_csv('business.csv.zip',chunksize=chunk_size):

  chunk.to_csv('business.csv.zip' + str(batch_no) + '.csv', index=False)

  batch_no +=1

---------------------------------------------------------------------------------------------------