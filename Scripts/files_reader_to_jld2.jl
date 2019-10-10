using DataFrames, Dates, JLD2, FileIO

root_dir = dirname(pwd())
unzipped_files_path = *(root_dir, "/Datasets/Dataset_Bovespa/Unzipped/")
println(unzipped_files_path)
file_prefix = "COTAHIST_A"
file_begin_counter = 1995
file_end_counter = 2019

file_counter = file_begin_counter

hdf5_file_name = (unzipped_files_path * "COTAHIST" * ".jld2")

time_inicio = Dates.now()

jldopen(hdf5_file_name,"w") do jldfile
    cotahist = JLD2.Group(jldfile,"COTAHIST")
    while (file_counter <= file_end_counter)
        file_path_concat_txt = unzipped_files_path * file_prefix * string(file_counter) * ".TXT"
        println(file_path_concat_txt)
        file = open(file_path_concat_txt, "r")
        
        local count = 0
        
        local dataFrame = DataFrame(DATPRG = [], CODBDI = [], CODNEG = [],
            TPMERC = [], NOMRES = [], ESPECI = [],
            PRAZOT = [], MODREF = [], PREABE = [],
            PREMAX = [], PREMIN = [], PREMED = [],
            PREULT = [], PREOFC = [], PREOFV = [],
            TOTNEG = [], QUATOT = [], VOLTOT = [],
            PREEXE = [], INDOPC = [], DATVEN = [],
            FATCOT = [], PTOEXE = [], CODISI = [],
            DISMES = [])
    
        for line in eachline(file)
            count += 1
            if (SubString(line, 1, 2) == "00")
                println("header")
            elseif (SubString(line, 1, 2) == "01")
                data_pregao = string(SubString(line, 3, 10))
                codbdi = string(SubString(line, 11, 12))
                codneg = string(SubString(line, 13, 24))
                tpmerc = string(SubString(line, 25, 27))
                nomres = string(SubString(line, 28, 39))
                especi = string(SubString(line, 40, 49))
                prazot = string(SubString(line, 50, 52))
                modref = string(SubString(line, 53, 56))
                preabe = string(SubString(line, 57, 69))
                premax = string(SubString(line, 70, 82))
                premin = string(SubString(line, 83, 95))
                premed = string(SubString(line, 96, 108))
                preult = string(SubString(line, 109, 121))
                preofc = string(SubString(line, 122, 134))
                preofv = string(SubString(line, 135, 147))
                totneg = string(SubString(line, 148, 152))
                quatot = string(SubString(line, 153, 170))
                voltot = string(SubString(line, 171, 188))
                preexe = string(SubString(line, 189, 201))
                indopc = string(SubString(line, 202, 202))
                datven = string(SubString(line, 203, 210))
                fatcot = string(SubString(line, 211, 217))
                ptoexe = string(SubString(line, 218, 230))
                codisi = string(SubString(line, 231, 242))
                dismes = string(SubString(line, 243, 245))
    
                #row = [codbdi codneg tpmerc nomres especi  prazot  modref  preabe  premax premin  premed  preult  preofc  preofv totneg  quatot  voltot  preexe  indopc datven  fatcot  ptoexe  codisi  dismes]
            
                push!(dataFrame,
                    (data_pregao, codbdi, codneg, tpmerc, nomres,
                        especi, prazot, modref, preabe, premax,
                        premin, premed, preult, preofc, preofv,
                        totneg, quatot, voltot, preexe, indopc,
                        datven, fatcot, ptoexe, codisi, dismes))
            else 
                println("fim")        
            end
        end
    
        matrix = convert(Matrix{String}, dataFrame)
        cotahist[string(file_counter)] = matrix
    
        global file_counter += 1
    end
end    


time_fim = Dates.now()
println("TI: " * Dates.format(time_inicio, "S:s"))
println("TF: " * Dates.format(time_fim, "S:s"))
println(time_fim - time_inicio)