
deferred class HELPABLE 

inherit

	CONSTANTS
	
feature 

	help_text: STRING is
		local
			full_path: STRING;
			help_file: PLAIN_TEXT_FILE;
			temp: STRING;
		do
			!! full_path.make (0);
			full_path.append (Environment.help_directory);
			full_path.extend (Environment.directory_separator);
			temp := clone (help_file_name);
			temp.to_lower;
			full_path.append (temp);
			!! help_file.make (full_path);
			if
				help_file.exists and then help_file.is_readable
			then
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
				!! Result.make (0);
				Result.append (Help_const.no_help_available_message);
				Result.append (full_path);
				Result.append (Help_const.contact_ise_message);
			end;
		end;
	
feature {NONE}

	Help_const: HELP_CONSTANTS is
		once
			!! Result
		end;

	help_file_name: STRING is
		deferred
		end;

end
