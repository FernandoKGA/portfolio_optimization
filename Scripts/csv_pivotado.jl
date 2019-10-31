using DataFrames, FileIO, Dates, CSV

root_dir = dirname(pwd())
unzipped_files_path = *(root_dir, "/Datasets/Dataset_Bovespa/Unzipped/")
csv_file_name = (unzipped_files_path * "COTAHIST_PIVOTED" * ".csv")

#csv = open(csv_file_name,"r")

df = CSV.read(csv_file_name)
println(size(names(df),1)-1) #remove data
#header = true

liquidez = 0.8
lqdf = DataFrame(df[2:size(names(df),1)-1])
println(lqdf)
