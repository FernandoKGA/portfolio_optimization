include("file_reader_functions.jl")
using CSV, DataFrames, .FuncoesArquivoBovespa

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
        println("DATA DO PREGAO "*DataPregao(line))
#= 
println("CODBDI "*CodBdi(line))
println("CODNEG "*CodNeg(line))
println("TPMERC "*TpMerc(line))
println("NOMRES "*NomRes(line))
println("ESPECI "*Especi(line))
println("PRAZOT "*PrazoT(line))
println("MODREF "*ModRef(line))
println("PREABE "*PreAbe(line))
println("PREMAX "*PreMax(line))
println("PREMIN "*PreMin(line))
println("PREMED "*PreMed(line))
println("PREULT "*PreUlt(line))
println("PREOFC "*PreOfc(line))
println("PREOFV "*PreOfv(line))
println("TOTNEG "*TotNeg(line))
println("QUATOT "*QuaTot(line))
println("VOLTOT "*VolTot(line))
println("PREEXE "*PreExe(line))
println("INDOPC "*IndOpc(line))
println("DATVEN "*DatVen(line))
println("FATCOT "*FatCot(line))
println("PTOEXE "*PtoExe(line))
println("CODISI "*CodIsi(line))
println("DISMES "*DisMes(line)) =#
        break;
    else 
        println("fim")        
    end
end

close(csv)