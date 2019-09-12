import Pkg; Pkg.add("CSV"),Pkg.add("Tables")
using CSV, Tables

root_dir = dirname(pwd())
unzipped_files_path = *(root_dir, "/Datasets/Dataset_Bovespa/Unzipped/")
println(unzipped_files_path)
file_name = "COTAHIST_A1995"
file_extension = ".TXT"

file = open(unzipped_files_path*file_name*file_extension,"r")
    
count = 0
    
for line in eachline(file)
    global count += 1
    if (SubString(line,1,2) == "00")
        println("header")
        csv = open((unzipped_files_path*file_name*".csv"),"w")
        #CSV.write(,csv)
        close(csv)
    elseif (SubString(line,1,2) == "01")
        
    else 
        println("fim")        
    end
end