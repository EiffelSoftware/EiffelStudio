
-- Environment for bitmaps, help, binaries, scripts....

class EIFFEL_ENV

inherit

	SYSTEM_CONSTANTS;
	SHARED_EXEC_ENVIRONMENT
	
feature {NONE}

	Eiffel3_dir_name: STRING is
		once
			Result := Execution_environment.get ("EIFFEL3")
		end;

	Freeze_command_name: STRING is
		local
			c: CHARACTER
		once
			c := Directory_separator;
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.extend (c);
			Result.append ("bench");
			Result.extend (c);
			Result.append ("spec");
			Result.extend (c);
			Result.append ("$PLATFORM");
			Result.extend (c);
			Result.append ("bin");
			Result.extend (c);
			Result.append (Finish_freezing_script);
		end;

	Prelink_command_name: STRING is
		local
			c: CHARACTER
		once
			c := Directory_separator;
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.extend (c);
			Result.append ("bench");
			Result.extend (c);
			Result.append ("spec");
			Result.extend (c);
			Result.append ("$PLATFORM");
			Result.extend (c);
			Result.append ("bin");
			Result.extend (c);
			Result.append (Prelink_script);
		end;

	Default_ace_name: STRING is
		once
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.extend (Directory_separator);
			Result.append (Default_ace_file);
		end;

	help_path: STRING is
		local
			c: CHARACTER
		once
			c := Directory_separator;
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.extend (c);
			Result.append ("bench");
			Result.extend (c);
			Result.append ("help");
			Result.extend (c);
			Result.append ("errors");
			Result.extend (c);
		end;

	filter_path: STRING is
		local
			c: CHARACTER
		once
			Result := Execution_environment.get ("EIF_FILTER_PATH");
			if Result = Void or else Result.empty then
					-- EIF_FILTER_PATH was not set.
				c := Directory_separator;
				!!Result.make (50); 
				Result.append (Eiffel3_dir_name);
				Result.extend (c);
				Result.append ("bench");
				Result.extend (c);
				Result.append ("help");
				Result.extend (c);
				Result.append ("filters");
				Result.extend (c)
			end
		end;
end
