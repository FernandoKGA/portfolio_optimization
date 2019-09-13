module FuncoesArquivoBovespa

export DataPregao, CodBdi, CodNeg, TpMerc, NomRes, Especi,
PrazoT, ModRef, PreAbe, PreMax, PreMin, PreMed, PreUlt,
PreOfc, PreOfv, TotNeg, QuaTot, VolTot, PreExe, IndOpc,
DatVen, FatCot, PtoExe, CodIsi, DisMes

function DataPregao(line)
    return SubString(line,3,10)
end

function CodBdi(line)
    return SubString(line,11,12)
end

function CodNeg(line)
    return SubString(line,13,24)
end

function TpMerc(line)
    return SubString(line,25,27)
end

function NomRes(line)
    return SubString(line,28,39)
end

function Especi(line)
    return SubString(line,40,49)
end

function PrazoT(line)
    return SubString(line,50,52)
end

function ModRef(line)
    return SubString(line,53,56)
end

function PreAbe(line)
    return SubString(line,57,69)
end

function PreMax(line)
    return SubString(line,70,82)
end

function PreMin(line)
    return SubString(line,83,95)
end

function PreMed(line)
    return SubString(line,96,108)
end

function PreUlt(line)
    return SubString(line,109,121)
end

function PreOfc(line)
    return SubString(line,122,134)
end

function PreOfv(line)
    return SubString(line,135,147)
end

function TotNeg(line)
    return SubString(line,148,152)
end

function QuaTot(line)
    return SubString(line,153,170)
end

function VolTot(line)
    return SubString(line,171,188)
end

function PreExe(line)
    return SubString(line,189,201)
end

function IndOpc(line)
    return SubString(line,202,202)
end

function DatVen(line)
    return SubString(line,203,210)
end

function FatCot(line)
    return SubString(line,211,217)
end

function PtoExe(line)
    return SubString(line,218,230)
end

function CodIsi(line)
    return SubString(line,231,242)
end

function DisMes(line)
    return SubString(line,243,245)
end

end