
deferred class HELPABLE 

inherit

	UNIX_ENV
		export
			{NONE} all
		end
    
feature 

	help_text: STRING is
		local
			full_path: FILE_NAME;
			help_file: UNIX_FILE;
			temp: STRING;
        do
            !!full_path.make (0);
            full_path.append (EiffelBuild_directory);
            full_path.append ("/help/");
			temp := clone (help_file_name);
			temp.to_lower;
            full_path.append (temp);
            if
                full_path.exists and then full_path.readable
            then
                help_file := full_path.to_file;
                help_file.open_read;
                from
                    help_file.readstream (256);
                    Result := clone (help_file.laststring)
                until
                    help_file.end_of_file
                loop
                    help_file.readstream (256);
                    Result.append (help_file.laststring)
                end;
                help_file.close
            else
                Result := "No help available"
            end;
        end;
 
	
feature {NONE}

	help_file_name: STRING is
		deferred
		end;

end
