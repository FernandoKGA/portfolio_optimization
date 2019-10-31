root_dir = dirname(pwd())
dados_processados_file_prefix = "COTAHIST"
dados_reduzidos_file_prefix = "COTAHIST_REDUCED"
extension = ".jld2"
path_sufix = "/Datasets/Dataset_Bovespa/Unzipped/"
	
dados_processados = root_dir * path_sufix * dados_processados_file_prefix * extension
dados_reduzidos = root_dir * path_sufix * dados_reduzidos_file_prefix * extension

if isfile(dados_processados)
    data_to_reduced_matrix_jld2 = "data_to_reduced_matrix_jld2.jl"
    run(`julia $data_to_reduced_matrix_jld2`)
    
    if isfile(dados_reduzidos)
        reduced_matrix_to_single_dataframe = "reduced_matrix_to_single_dataframe.jl"
        run(`julia $reduced_matrix_to_single_dataframe`)
    else
        println("Arquivo com dados reduzidos não foi encontrado! Abortando operação.")
    end
else
    println("Arquivo com dados processados não encontrado! Abortando operação.")
end