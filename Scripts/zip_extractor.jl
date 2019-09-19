if Sys.islinux()
    root_dir = dirname(pwd())
    file_prefix = "COTAHIST_A"
    file_begin_counter = 1995
    file_end_counter = 2019

    path_sufix = "/Datasets/Dataset_Bovespa/"
	path_sender = "Zipped/"
	path_destiny = "Unzipped/"
	
	location = root_dir * path_sufix * path_sender
	destiny = root_dir * path_sufix * path_destiny

    println(location)
    println(destiny)

    if !isdir(destiny)
        mkdir(destiny)
    else
        rm(destiny, recursive=true)
        mkdir(destiny)
    end

    for year in range(file_begin_counter, stop=file_end_counter)
        path_sender_with_year = [location * file_prefix * string(year)]
        path_destiny_with_year = [destiny]
        full_command = `unzip $path_sender_with_year -d $path_destiny_with_year`
        run(full_command)
    end
else
    if Sys.iswindows()
        root_dir = dirname(pwd())
        file_prefix = "COTAHIST_A"
        file_begin_counter = 1995
        file_end_counter = 2019
        fileExtension = ".zip"
    
        path_sufix = "\\Datasets\\Dataset_Bovespa\\"
        path_sender = "Zipped\\"
        path_destiny = "Unzipped\\"
        
        location = root_dir * path_sufix * path_sender
        destiny = root_dir * path_sufix * path_destiny
    
        println(location)
        println(destiny)
    
        if !isdir(destiny)
            mkdir(destiny)
        else
            rm(destiny, recursive=true)
            mkdir(destiny)
        end
    
        #=
        powerShellCommand = 'Expand-Archive -Force '

	    for year in range(fileStartYear, fileEndYear + 1):
		    completeCommand = powerShellCommand + location + filePrefix + str(year) + fileExtension + ' ' + destiny
		    print(completeCommand)
		    result = subprocess.Popen(['powershell.exe',completeCommand])
		    print(result)
        print("Done.")
        =#

        #=
        for year in range(file_begin_counter, stop=file_end_counter)
            path_sender_with_year = [location * file_prefix * string(year)]
            path_destiny_with_year = [destiny]
            full_command = `unzip $path_sender_with_year -d $path_destiny_with_year`
            run(full_command)
        end 
        =#
    else
        if Sys.isapple()
            println("Macbook")
            root_dir = dirname(pwd())
            file_prefix = "COTAHIST_A"
            file_begin_counter = 1995
            file_end_counter = 2019

            path_sufix = "/Datasets/Dataset_Bovespa/"
	        path_sender = "Zipped/"
	        path_destiny = "Unzipped/"
            
	        location = root_dir * path_sufix * path_sender
	        destiny = root_dir * path_sufix * path_destiny

            println(location)
            println(destiny)

            if !isdir(destiny)
                mkdir(destiny)
            else
                rm(destiny, recursive=true)
                mkdir(destiny)
            end
            #=
            for year in range(file_begin_counter, stop=file_end_counter)
                path_sender_with_year = [location * file_prefix * string(year)]
                path_destiny_with_year = [destiny]
                full_command = `unzip $path_sender_with_year -d $path_destiny_with_year`
                run(full_command)
            end
            =#
        else
            println("System not implemented")
        end
    end
end

println("Done.")