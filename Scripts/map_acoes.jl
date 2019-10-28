using CSV, JLD2, FileIO, DataFrames

root_dir = dirname(pwd())
unzipped_files_path = *(root_dir, "/Datasets/Dataset_Bovespa/Unzipped/")
hdf5_file_name = (unzipped_files_path * "COTAHIST" * ".jld2")

csv = open((unzipped_files_path*"COTAHIST_2019"*".csv"),"w")
matrix = load(hdf5_file_name, "COTAHIST/2019")

df = DataFrame(data = [], codneg = [], preult = [])

for acao in eachrow(matrix)
    if (acao[4] == 10 || acao[4] == 20) #mercado lote padrao ou fracionario
        push!(df, [acao[1], rstrip(acao[3]), acao[13]])
    end
end

df = unstack(df, :data, :codneg, :preult) #pivota a tabela para as acoes
df = coalesce.(df, 0)  #substitui missing por 0
CSV.write(csv, df)