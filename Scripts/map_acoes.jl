using JLD2, FileIO

root_dir = dirname(pwd())
unzipped_files_path = *(root_dir, "/Datasets/Dataset_Bovespa/Unzipped/")
hdf5_file_name = (unzipped_files_path * "COTAHIST" * ".jld2")

matrix = load(hdf5_file_name, "COTAHIST/2019")
codneg = matrix[:,3]

acoes = Array{String,1}()

count = 0
#"ALUP4"
for acao in eachrow(codneg)
    #println(typeof(acao[1]))
    #break
    #result = filter(x -> occursin(acao[1],x),acoes)
    #println(result)
    #println(length(result))
    global count += 1
    println(count)
    if (length(filter(x -> occursin(acao[1],x),acoes)) == 0)
        push!(acoes,acao[1])
        #println(acoes)
        #sleep(0.05)
        #println(acao[1])
    end
end

#println(acoes)