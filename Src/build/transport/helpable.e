
deferred class HELPABLE 

inherit

	CONSTANTS
	
feature 

	help_text: STRING is
		local
			full_path: FILE_NAME;
			help_file: PLAIN_TEXT_FILE;
			temp: STRING;
		do
			!! full_path.make_from_string (Environment.help_directory);
			temp := clone (help_file_name);
			temp.to_upper;
			full_path.extend (temp);
			!! help_file.make (full_path);
			if help_file.exists and then help_file.is_readable then
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
