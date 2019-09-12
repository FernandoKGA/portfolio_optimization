using CSV, DataFrames

root_dir = dirname(pwd())
unzipped_files_path = *(root_dir, "/Datasets/Dataset_Bovespa/Unzipped/")
println(unzipped_files_path)
file_name = "COTAHIST_A1995"
file_extension = ".TXT"

file = open(unzipped_files_path*file_name*file_extension,"r")
    
count = 0
    
csv = open((unzipped_files_path*file_name*".csv"),"w")

for line in eachline(file)
    global count += 1
    if (SubString(line,1,2) == "00")
        println("header")
    elseif (SubString(line,1,2) == "01")
        println("DATA DO PREGAO "*SubString(line,3,10))
        println("CODBDI "*SubString(line,11,12))
        println("CODNEG "*SubString(line,13,24))
        println("TPMERC "*SubString(line,25,27))
        println("NOMRES "*SubString(line,28,39))
        println("ESPECI "*SubString(line,40,49))
        println("PRAZOT "*SubString(line,50,52))
        println("MODREF "*SubString(line,53,56))
        println("PREABE "*SubString(line,57,69))
        println("PREMAX "*SubString(line,70,82))
        println("PREMIN "*SubString(line,83,95))
        println("PREMED "*SubString(line,96,108))
        println("PREULT "*SubString(line,109,121))
        println("PREOFC "*SubString(line,122,134))
        println("PREOFV "*SubString(line,135,147))
        println("TOTNEG "*SubString(line,148,152))
        println("QUATOT "*SubString(line,153,170))
        println("VOLTOT "*SubString(line,171,188))
        println("PREEXE "*SubString(line,189,201))
        println("INDOPC "*SubString(line,202,202))
        println("DATVEN "*SubString(line,203,210))
        println("FATCOT "*SubString(line,211,217))
        println("PTOEXE "*SubString(line,218,230))
        println("CODISI "*SubString(line,231,242))
        println("DISMES "*SubString(line,243,245))
        break;
    else 
        println("fim")        
    end
end

close(csv)