using CSV, JLD2, FileIO, DataFrames, Dates

println("Iniciando a redução das matrizes de 3 colunas para um CSV único.")

root_dir = dirname(pwd())
unzipped_files_path = *(root_dir, "/Datasets/Dataset_Bovespa/Unzipped/")
matrix_jld2_file_name = (unzipped_files_path * "COTAHIST" * ".jld2")

# caminho para matriz reduzida
reduced_matrix_file_name = (unzipped_files_path * "COTAHIST_REDUCED" * ".jld2")

csv = open((unzipped_files_path*"COTAHIST_PIVOTED"*".csv"),"w")

file_begin_counter = 1995
file_end_counter = 2019
file_counter = file_begin_counter

dataframe_total = DataFrame(data = [], codneg = [], preult = [])

time_inicio = Dates.now()

while (file_counter <= file_end_counter)
    local file_counter_string = string(file_counter)

    # matriz com dados completos
    local matrix = load(reduced_matrix_file_name, "COTAHIST_REDUCED/" * file_counter_string)

    local dataframe_reduced = convert(DataFrame, matrix)
    
    # remapea os dados
    dataframe_reduced[!,1] = map(x -> convert(Date,x), dataframe_reduced[!,1])
    dataframe_reduced[!,2] = map(x -> convert(String,x), dataframe_reduced[!,2])
    dataframe_reduced[!,3] = map(x -> convert(Float32,x), dataframe_reduced[!,3])
    
    # renomea as colunas para bater com o outro dataframe
    names!(dataframe_reduced, [:data, :codneg, :preult])
    append!(dataframe_total, dataframe_reduced)
    
    global file_counter += 1
    println(file_counter_string)
end

# pivota a tabela
dataframe_pivotado = unstack(dataframe_total, :data, :codneg, :preult) # pivota a tabela para as acoes
dataframe_pivotado = coalesce.(dataframe_pivotado, 0)  # substitui missing por 0
#println(names(dataframe_pivotado))
CSV.write(csv, dataframe_pivotado)

time_fim = Dates.now()
println("TI: " * Dates.format(time_inicio, "S:s"))
println("TF: " * Dates.format(time_fim, "S:s"))
println(time_fim - time_inicio)

println("Finalizando a redução das matrizes de 3 colunas para um CSV único.")