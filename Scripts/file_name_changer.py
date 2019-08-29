import subprocess as subprocess
import os
import platform

pathBase = os.path.split(os.path.dirname(os.path.abspath(__file__)))[0] + '/'

pathSufix = 'Datasets/Dataset_Bovespa/'
pathSender = 'Unzipped/'

location = pathBase + pathSufix + pathSender

filePrefix = 'COTAHIST.A'
fileStartYear = 1986
fileEndYear = 2000

filePrefixDesired = 'COTAHIST_A'
fileExtension = '.txt'

if platform.system() == "Linux":

    for year in range(fileStartYear, fileEndYear + 1):
        os.rename(location + filePrefix + str(year), location + filePrefixDesired + str(year) + fileExtension)
        print(location + filePrefix + str(year) + ' ' + location + filePrefixDesired + str(year) + fileExtension)
        #result = subprocess.Popen(['powershell.exe',completeCommand])
        #print(result)
    print("Conversion done from 1986 to 1999.")

else:
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