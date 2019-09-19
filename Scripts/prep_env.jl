imports = "imports.jl"
zip_extractor = "zip_extractor.jl"
file_name_changer = "file_name_changer.py"

run(`julia $imports`)
run(`julia $zip_extractor`)
run(`python3 $file_name_changer`)