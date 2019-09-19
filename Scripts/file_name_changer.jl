using Base.Filesystem
const fs = Base.Filesystem

path_base = dirname(pwd())
path_sufix = "/Datasets/Dataset_Bovespa/"
path_destiny = "Unzipped/"

location = path_base * path_sufix * path_destiny

file_prefix = "COTAHIST.A"
file_start_year = 1995
file_end_year = 2000

file_prefix_desired = "COTAHIST_A"
file_extension = ".TXT"

for year in range(file_start_year, stop=file_end_year)
    path_original = location * file_prefix * string(year)
    path_renamed = location * file_prefix_desired * string(year) * file_extension
    fs.mv(path_original, path_renamed)
end

path_original = location * file_prefix_desired * "2001"
path_renamed = location * file_prefix_desired * "2001" * file_extension
fs.mv(path_original, path_renamed)

println("Files from 1995 to 2001 were successfully converted!!")