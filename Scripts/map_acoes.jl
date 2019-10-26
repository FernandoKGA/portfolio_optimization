using CSV, JLD2, FileIO, DataFrames

root_dir = dirname(pwd())
unzipped_files_path = *(root_dir, "/Datasets/Dataset_Bovespa/Unzipped/")
hdf5_file_name = (unzipped_files_path * "COTAHIST" * ".jld2")

csv = open((unzipped_files_path*"COTAHIST_2019"*".csv"),"w")
matrix = load(hdf5_file_name, "COTAHIST/2019")

df = DataFrame(data = [], codneg = [], preult = [])
#acoes = Array{String,1}()

count = 0
#"ALUP4"
for acao in eachrow(matrix)
    #println(acao[4])
    #println(rstrip(acao[3]))
    if (acao[4] == 10 || acao[4] == 20)
        push!(df, [acao[1], rstrip(acao[3]), acao[13]])
    end
    #unstack
    #result = filter(x -> occursin(acao[1],x),acoes)
    #println(result)
    #println(length(result))
    #global count += 1
    #println(count)
    #if (length(filter(x -> occursin(acao[1],x),acoes)) == 0)
        #push!(acoes,acao[1])
        #println(acoes)
        #sleep(0.05)
        #println(acao[1])
    #end
end

df = unstack(df, :data, :codneg, :preult)
df = coalesce.(df, 0)
CSV.write(csv, df)