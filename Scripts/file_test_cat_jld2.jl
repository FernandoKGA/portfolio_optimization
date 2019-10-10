using DataFrames, Dates, JLD2, FileIO

root_dir = dirname(pwd())
unzipped_files_path = *(root_dir, "/Datasets/Dataset_Bovespa/Unzipped/")
println(unzipped_files_path)
file_name = "COTAHIST_A1995"
file_extension = ".TXT"

file = open(unzipped_files_path * file_name * file_extension, "r")
    
count = 0
dataFrame = DataFrame(DATPRG = [], CODBDI = [], CODNEG = [],
    TPMERC = [], NOMRES = [], ESPECI = [],
    PRAZOT = [], MODREF = [], PREABE = [],
    PREMAX = [], PREMIN = [], PREMED = [],
    PREULT = [], PREOFC = [], PREOFV = [],
    TOTNEG = [], QUATOT = [], VOLTOT = [],
    PREEXE = [], INDOPC = [], DATVEN = [],
    FATCOT = [], PTOEXE = [], CODISI = [],
    DISMES = [])
println(names(dataFrame))

hdf5_file_name = (unzipped_files_path * "COTAHIST_test" * ".jld2")
println(hdf5_file_name)

time_inicio = Dates.now()

matrix = Matrix{Any}(undef, 0, 25)

for line in eachline(file)
    global count += 1
    if (SubString(line, 1, 2) == "00")
        println("header")
        header = ["DATPRG" "CODBDI" "CODNEG" "TPMERC" "NOMRES" "ESPECI" "PRAZOT" "MODREF" "PREABE" "PREMAX" "PREMIN" "PREMED" "PREULT" "PREOFC" "PREOFV" "TOTNEG" "QUATOT" "VOLTOT" "PREEXE" "INDOPC" "DATVEN" "FATCOT" "PTOEXE" "CODISI" "DISMES"]
    elseif (SubString(line, 1, 2) == "01")
        data = SubString(line,3,10)
        data_pregao = Date(parse(Int,SubString(data,1,4)),parse(Int,SubString(data,5,6)),parse(Int,SubString(data,7,8)))
        codbdi = string(SubString(line, 11, 12))
        codneg = string(SubString(line, 13, 24))
        tpmerc = parse(Int,SubString(line, 25, 27))
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
        totneg = parse(Int,SubString(line, 148, 152))
        quatot = parse(Int,SubString(line, 153, 170))
        voltot = string(SubString(line, 171, 188))
        preexe = string(SubString(line, 189, 201))
        indopc = parse(Int,SubString(line, 202, 202))
        data_dataven =SubString(line, 203, 210)
        datven = Date(parse(Int,SubString(data_dataven,1,4)),parse(Int,SubString(data_dataven,5,6)),parse(Int,SubString(data_dataven,7,8)))
        fatcot = parse(Int,SubString(line, 211, 217))
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

matrix = convert(Matrix{Any}, dataFrame)
save(hdf5_file_name, "matrix", matrix)

time_fim = Dates.now()
println("TI: " * Dates.format(time_inicio, "S:s"))
println("TF: " * Dates.format(time_fim, "S:s"))
println(time_fim - time_inicio)