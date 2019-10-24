using DataFrames, Dates, JLD2, FileIO

#caminho do arquivo
root_dir = dirname(pwd())
unzipped_files_path = *(root_dir, "/Datasets/Dataset_Bovespa/Unzipped/")
println(unzipped_files_path)
file_name = "COTAHIST_A1995"
file_extension = ".TXT"

#abre o arquivo
file = open(unzipped_files_path * file_name * file_extension, "r")

#defini dataframe (apenas o nome das colunas)
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
println(names(dataFrame)) #nome das colunas

#nome do arquivo final
hdf5_file_name = (unzipped_files_path * "COTAHIST_test" * ".jld2")
println(hdf5_file_name)

#calculo de tempo de execucao
time_inicio = Dates.now()

matrix = Matrix{Any}(undef, 0, 25)

#percorre o arquivo e passa para o dataframe

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

        preabe_string = string(SubString(line, 57, 69))
        preabe_inteira = tryparse(Float32,string(SubString(preabe_string,1,11)))
        preabe_decimal = tryparse(Float32,"0."*string(SubString(preabe_string,12,13)))
        preabe = preabe_inteira + preabe_decimal

        premax_string = string(SubString(line, 70, 82))
        premax_inteira = tryparse(Float32,string(SubString(premax_string,1,11)))
        premax_decimal = tryparse(Float32,"0."*string(SubString(premax_string,12,13)))
        premax = premax_inteira + premax_decimal

        premin_string = string(SubString(line, 83, 95))
        premin_inteira = tryparse(Float32, string(SubString(premin_string,1,11)))
        premin_decimal = tryparse(Float32,"0."*string(SubString(premin_string,12,13)))
        premin = premin_inteira + premin_decimal

        premed_string = string(SubString(line, 96, 108))
        premed_inteira = tryparse(Float32, string(SubString(premed_string,1,11)))
        premed_decimal = tryparse(Float32,"0."*string(SubString(premed_string,12,13)))
        premed = premed_inteira + premed_decimal

        preult_string = string(SubString(line, 109, 121))
        preult_inteira = tryparse(Float32, string(SubString(preult_string,1,11)))
        preult_decimal = tryparse(Float32,"0."*string(SubString(preult_string,12,13)))
        preult = preult_inteira + preult_decimal

        preofc_string = string(SubString(line, 122, 134))
        preofc_inteira = tryparse(Float32, string(SubString(preofc_string,1,11)))
        preofc_decimal = tryparse(Float32,"0."*string(SubString(preofc_string,12,13)))
        preofc = preofc_inteira + preofc_decimal

        preofv_string = string(SubString(line, 135, 147))
        preofv_inteira = tryparse(Float32, string(SubString(preofv_string,1,11)))
        preofv_decimal = tryparse(Float32,"0."*string(SubString(preofv_string,12,13)))
        preofv = preofv_inteira + preofv_decimal

        totneg = parse(Int,SubString(line, 148, 152))
        quatot = parse(Int,SubString(line, 153, 170))

        voltot_string = string(SubString(line, 171, 188))
        voltot_inteira = tryparse(Float32,string(SubString(voltot_string,1,16)))
        voltot_decimal = tryparse(Float32,"0."*string(SubString(voltot_string,17,18)))
        voltot = voltot_inteira + voltot_decimal

        preexe_string = string(SubString(line, 189, 201))
        preexe_inteira = tryparse(Float32, string(SubString(preexe_string,1,11)))
        preexe_decimal = tryparse(Float32,"0."*string(SubString(preexe_string,12,13)))
        preexe = preexe_inteira + preexe_decimal

        indopc = parse(Int,SubString(line, 202, 202))
        data_dataven =SubString(line, 203, 210)
        datven = Date(parse(Int,SubString(data_dataven,1,4)),parse(Int,SubString(data_dataven,5,6)),parse(Int,SubString(data_dataven,7,8)))
        fatcot = parse(Int,SubString(line, 211, 217))

        ptoexe_string = string(SubString(line, 218, 230))
        ptoexe_inteira = tryparse(Float32, string(SubString(ptoexe_string,1,7)))
        ptoexe_decimal = tryparse(Float32,"0."*string(SubString(ptoexe_string,8,13)))
        ptoexe = ptoexe_inteira + ptoexe_decimal
        
        #=if (ptoexe_string != "0000000000000") 
            println(data_pregao)
            println(nomres)
            println(ptoexe_string)
            println(ptoexe)
        end=#

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