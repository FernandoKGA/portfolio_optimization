using DataFrames, Dates, JLD2, FileIO
matrix = load("/home/informatica/portfolio_optimization/Datasets/Dataset_Bovespa/Unzipped/COTAHIST.jld2","COTAHIST/2019")
dataframe = convert(DataFrame, matrix)
print(dataframe)