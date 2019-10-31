using JLD2, FileIO, DataFrames, Dates

println("Iniciando redução dos dados para matrizes de 3 colunas.")

root_dir = dirname(pwd())
unzipped_files_path = *(root_dir, "/Datasets/Dataset_Bovespa/Unzipped/")
matrix_jld2_file_name = (unzipped_files_path * "COTAHIST" * ".jld2")

# caminho para matriz reduzida
reduced_matrix_file_name = (unzipped_files_path * "COTAHIST_REDUCED" * ".jld2")

file_begin_counter = 1995
file_end_counter = 2019
file_counter = file_begin_counter

time_inicio = Dates.now()

jldopen(reduced_matrix_file_name, "w") do jldfile
    cotahist_reduced_prefix = "COTAHIST_REDUCED"
    cotahist_reduced = JLD2.Group(jldfile, cotahist_reduced_prefix)
    while (file_counter <= file_end_counter)
        local file_counter_string = string(file_counter)
        
        # criacao do dataframe
        local df = DataFrame(data = [], codneg = [], preult = [])

        # matriz com dados completos
        local matrix = load(matrix_jld2_file_name, "COTAHIST/" * file_counter_string)

        for acao in eachrow(matrix)
            #if (acao[4] == 10 || acao[4] == 20) #mercado lote padrao ou fracionario
            if (acao[4] == 10)
                push!(df, [acao[1], rstrip(acao[3]), acao[13]]) # acao[1] = data; acao[3] = nome acao; acao[13] = preult
            end
        end

        local matrix_reduced = convert(Matrix{Any}, df)
        cotahist_reduced[file_counter_string] = matrix_reduced
        global file_counter += 1
    end
end

time_fim = Dates.now()
println("TI: " * Dates.format(time_inicio, "S:s"))
println("TF: " * Dates.format(time_fim, "S:s"))
println(time_fim - time_inicio)
println("Finalizada execução de redução dos dados para matrizes de 3 colunas.")