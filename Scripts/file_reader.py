import os
import fileinput
import platform

opSystem = platform.system()

if(opSystem == 'Linux'):
    count = 0
    with fileinput.input(files=('/home/informatica/Documentos/portfolio_optimization/Datasets/Dataset_Bovespa/Unzipped/COTAHIST_A1986.txt')) as file:
        for line in file:
            if (count == 0):
                count = count + 1
                print(line)
                print(len(line))
                print(line[0:2])
                print(line[2:15])
                print(line[15:23])
                print(line[23:31])
                print(len(line[31:246]))
            else:
                break

if(opSystem == 'Windows'):
    count = 0
    with fileinput.input(files=('C:\\Users\\Fernando\\Desktop\\portfolio_optimization\\Datasets\\Dataset_Bovespa\\Unzipped\\COTAHIST_A1986.txt')) as file:
        for line in file:
            if (count == 0):
                count = count + 1
                print(line)
                print(len(line))
                print(line[0:2])
                print(line[2:15])
                print(line[15:23])
                print(line[23:31])
                print(len(line[31:245]))
            else:
                break