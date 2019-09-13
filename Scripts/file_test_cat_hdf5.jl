using DataFrames, Dates, HDF5

root_dir = dirname(pwd())
unzipped_files_path = *(root_dir, "/Datasets/Dataset_Bovespa/Unzipped/")
println(unzipped_files_path)
file_name = "COTAHIST_A1995"
file_extension = ".TXT"

file = open(unzipped_files_path*file_name*file_extension,"r")
    
count = 0
dataFrame = DataFrame(
    DATPRG = [], CODBDI = [], CODNEG = [],
    TPMERC = [], NOMRES = [], ESPECI = [],
    PRAZOT = [], MODREF = [], PREABE = [],
    PREMAX = [], PREMIN = [], PREMED = [],
    PREULT = [], PREOFC = [], PREOFV = [],
    TOTNEG = [], QUATOT = [], VOLTOT = [],
    PREEXE = [], INDOPC = [], DATVEN = [],
    FATCOT = [], PTOEXE = [], CODISI = [],
    DISMES = []
)
println(names(dataFrame))

hdf5 = h5open((unzipped_files_path*"COTAHIST"*".h5"),"w")

time_inicio = Dates.now()

for line in eachline(file)
    global count += 1
    if (SubString(line,1,2) == "00")
        println("header")
    elseif (SubString(line,1,2) == "01")
        data_pregao = SubString(line,3,10)
        codbdi = SubString(line,11,12)
        codneg = SubString(line,13,24)
        tpmerc = SubString(line,25,27)
        nomres = SubString(line,28,39)
        especi = SubString(line,40,49)
        prazot = SubString(line,50,52)
        modref = SubString(line,53,56)
        preabe = SubString(line,57,69)
        premax = SubString(line,70,82)
        premin = SubString(line,83,95)
        premed = SubString(line,96,108)
        preult = SubString(line,109,121)
        preofc = SubString(line,122,134)
        preofv = SubString(line,135,147)
        totneg = SubString(line,148,152)
        quatot = SubString(line,153,170)
        voltot = SubString(line,171,188)
        preexe = SubString(line,189,201)
        indopc = SubString(line,202,202)
        datven = SubString(line,203,210)
        fatcot = SubString(line,211,217)
        ptoexe = SubString(line,218,230)
        codisi = SubString(line,231,242)
        dismes = SubString(line,243,245)
        
        push!(dataFrame,
            (
                data_pregao, codbdi, codneg, tpmerc, nomres,
                especi, prazot, modref, preabe, premax,
                premin, premed, preult, preofc, preofv,
                totneg, quatot, voltot, preexe, indopc,
                datven, fatcot, ptoexe, codisi, dismes
            )
        )
    else 
        println("fim")        
    end
end

time_fim = Dates.now()
println("TI: "*Dates.format(time_inicio, "S:s"))
println("TF: "*Dates.format(time_fim, "S:s"))
println(time_fim-time_inicio)