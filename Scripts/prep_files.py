import os

os.system("julia zip_extractor.jl")
os.system("python3 file_name_changer.py")
os.system("julia imports.jl")