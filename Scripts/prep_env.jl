imports = "imports.jl"
zip_extractor = "zip_extractor.jl"
file_name_changer = "file_name_changer.jl"

run(`julia $imports`)
run(`julia $zip_extractor`)
run(`julia $file_name_changer`)