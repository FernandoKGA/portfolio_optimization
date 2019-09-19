if Sys.islinux()
    pathBase = os.path.split(os.path.dirname(os.path.abspath(__file__)))[0] + '/'
    pathSufix = 'Datasets/Dataset_Bovespa/'
    pathDestiny = 'Unzipped/'

    location = pathBase + pathSufix + pathDestiny

    filePrefix = 'COTAHIST.A'
    fileStartYear = 1995
    fileEndYear = 2000

    filePrefixDesired = 'COTAHIST_A'
    fileExtension = '.TXT'

    for year in range(fileStartYear, fileEndYear + 1):
        os.rename(location + filePrefix + str(year), location + filePrefixDesired + str(year) + fileExtension)
        print(location + filePrefix + str(year) + ' ' + location + filePrefixDesired + str(year) + fileExtension)
    print("Conversion done from 1995 to 2000.")

    print(location + filePrefixDesired + str(2001), location + filePrefixDesired + str(2001) + fileExtension)
    os.rename(location + filePrefixDesired + str(2001), location + filePrefixDesired + str(2001) + fileExtension)

if Sys.iswindows()
    pathBase = os.path.split(os.path.dirname(os.path.abspath(__file__)))[0] + '\\'

    pathSufix = 'Datasets\\Dataset_Bovespa\\'
    pathSender = 'Unzipped\\'

    location = pathBase + pathSufix + pathSender

    filePrefix = 'COTAHIST.A'
    fileStartYear = 1995
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
    print("Conversion done from 1995 to 2000.")
    
    completeCommand = powerShellCommand + location + filePrefixDesired + str(2000) + ' ' + commandComplement + ' ' + filePrefixDesired + str(2000) + fileExtension
    result = subprocess.Popen(['powershell.exe',completeCommand])
    print(result)