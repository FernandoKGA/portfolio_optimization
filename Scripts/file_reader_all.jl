root_dir = dirname(pwd())
unzipped_files_path = *(root_dir, "/Datasets/Dataset_Bovespa/Unzipped/")
println(unzipped_files_path)
file_prefix = "COTAHIST_A"
file_begin_counter = 1995
file_end_counter = 2019

file_counter = file_begin_counter

while (file_counter < file_end_counter)
    file_path_concat = unzipped_files_path*file_prefix*string(file_counter)*".TXT"
    println(file_path_concat)
    file = open(file_path_concat,"r")
    
    local count = 0
    
    for line in eachline(file)
        count += 1
        if (SubString(line,1,2) == "00")
            println("header")
        elseif (SubString(line,1,2) == "01")
            
        else 
            println("fim")        
        end
    end

    global file_counter += 1
end