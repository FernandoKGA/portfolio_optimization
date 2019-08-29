import subprocess as subprocess
import os
import platform

opSystem = platform.system()

if(opSystem == 'Linux'):

	pathBase = os.path.split(os.path.dirname(os.path.abspath(__file__)))[0] + '/'
	pathSufix = 'Datasets/Dataset_Bovespa/'
	pathDestiny = 'Unzipped/'
	
	location = pathBase + pathSufix + pathSender

	filePrefix = 'COTAHIST.A'
	fileStartYear = 1986
	fileEndYear = 2000

    filePrefixDesired = "COTAHIST_A"
    fileExtension = '.txt'

	linuxCommand = 'mv'

	for year in range(fileStartYear, fileEndYear + 1):
        completeCommand = linuxCommand + ' ' + location + filePrefix + str(year) + ' ' + filePrefixDesired + str(year) + fileExtension
        print(completeCommand)
        result = subprocess.Popen(completeCommand, shell=True)
        print(result)
    print("Conversion done from 1986 to 1999.")
    
    completeCommand = powerShellCommand + location + filePrefixDesired + str(2000) + ' ' + commandComplement + ' ' + filePrefixDesired + str(2000) + fileExtension
    result = subprocess.Popen(completeCommand, shell=True)
    print(result)

if(opSystem == 'Windows'):

    pathBase = os.path.split(os.path.dirname(os.path.abspath(__file__)))[0] + '\\'

    pathSufix = 'Datasets\\Dataset_Bovespa\\'
    pathSender = 'Unzipped\\'

    location = pathBase + pathSufix + pathSender

    filePrefix = 'COTAHIST.A'
    fileStartYear = 1986
    fileEndYear = 2000

    filePrefixDesired = 'COTAHIST_A'
    fileExtension = '.txt'

    powerShellCommand = 'Rename-Item -Path '
    commandComplement = '-NewName'

    for year in range(fileStartYear, fileEndYear + 1):
        completeCommand = powerShellCommand + location + filePrefix + str(year) + ' ' + commandComplement + ' ' + filePrefixDesired + str(year) + fileExtension
        print(completeCommand)
        result = subprocess.Popen(['powershell.exe',completeCommand])
        print(result)
    print("Conversion done from 1986 to 1999.")
    
    completeCommand = powerShellCommand + location + filePrefixDesired + str(2000) + ' ' + commandComplement + ' ' + filePrefixDesired + str(2000) + fileExtension
    result = subprocess.Popen(['powershell.exe',completeCommand])
    print(result)