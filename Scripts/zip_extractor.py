import subprocess as subprocess
import os
import platform

opSystem = platform.system()

if(opSystem == 'Linux'):
	pathBase = os.path.split(os.path.dirname(os.path.abspath(__file__)))[0] + '/'
	pathSufix = 'Datasets/Dataset_Bovespa/'
	pathSender = 'Zipped/'
	pathDestiny = 'Unzipped'
	
	location = pathBase + pathSufix + pathSender
	destiny = pathBase + pathSufix + pathDestiny

	filePrefix = 'COTAHIST_A'
	fileStartYear = 1986
	fileEndYear = 2019
	
	linuxCommand = 'unzip '
	linuxCommandArg = '-d '

	for year in range(fileStartYear, fileEndYear + 1):
		completeCommand = (linuxCommand + location + filePrefix + str(year) + ' ' + linuxCommandArg + destiny)
		print(completeCommand)
		subprocess.Popen(completeCommand)

if(opSystem == 'Windows'):
	
	pathBase = os.path.split(os.path.dirname(os.path.abspath(__file__)))[0] + '\\'
	pathSufix = 'Datasets\\Dataset_Bovespa\\'
	pathSender = 'Zipped\\'
	pathDestiny = 'Unzipped'

	location = pathBase + pathSufix + pathSender
	destiny = pathBase + pathSufix + pathDestiny

	filePrefix = 'COTAHIST_A'
	fileStartYear = 1986
	fileEndYear = 2019
	fileExtension = '.zip'

	powerShellCommand = 'Expand-Archive -Force '

	for year in range(fileStartYear, fileEndYear + 1):
		completeCommand = powerShellCommand + location + filePrefix + str(year) + fileExtension + ' ' + destiny
		print(completeCommand)
		result = subprocess.Popen(['powershell.exe',completeCommand])
		print(result)
	print("Done.")