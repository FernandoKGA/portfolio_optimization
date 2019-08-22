rootDir = dirname(pwd())
unzippedFiles = *(rootDir, "\\Datasets\\Dataset_Bovespa\\Unzipped\\")
print(unzippedFiles)
file = open((unzippedFiles*"COTAHIST_A1986.txt"),"r")