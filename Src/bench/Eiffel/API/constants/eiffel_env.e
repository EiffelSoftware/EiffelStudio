
-- Environment for bitmaps, help, binaries, scripts....

class EIFFEL_ENV

inherit

	SYSTEM_CONSTANTS;
	ENV_INTERP;
	SHARED_RESOURCES
	
feature {NONE}

	Eiffel3_dir_name: STRING is
		once
			Result := Execution_environment.get ("EIFFEL3")
		end;

	Freeze_command_name: STRING is
		local
			file_name: FILE_NAME
		once
			!!file_name.make_from_string (Eiffel3_dir_name);
			file_name.extend_from_array (<<"bench", "spec", Execution_environment.get ("PLATFORM") , "bin">>);
			file_name.set_file_name (Finish_freezing_script);
			Result := file_name
		end

	Prelink_command_name: STRING is
		local
			file_name: FILE_NAME
		once
			!!file_name.make_from_string (Eiffel3_dir_name);
			file_name.extend_from_array (<<"bench", "spec", Execution_environment.get ("PLATFORM") , "bin">>);
			file_name.set_file_name (Prelink_script);
			Result := file_name
		end;

	Default_ace_name: STRING is
		local
			file_name: FILE_NAME
		once
			!!file_name.make_from_string (Eiffel3_dir_name);
			file_name.extend_from_array (<<"bench", "help", "defaults">>);
			file_name.set_file_name (Default_Ace_file);
			Result := file_name
		end;

	help_path: STRING is
		local
			dir_name: DIRECTORY_NAME
		once
			!!dir_name.make_from_string (Eiffel3_dir_name);
			dir_name.extend_from_array (<<"bench", "help", "errors">>);
			Result := dir_name
		end;

	Default_precompiled_location: STRING is
			-- Default location for the precompiled base
			-- $EIFFEL3/precomp/spec/$PLATFORM/base
		local
			dir_name: DIRECTORY_NAME
		once
			!!dir_name.make_from_string (Eiffel3_dir_name);
			dir_name.extend_from_array (<<"precomp", "spec", Execution_environment.get ("PLATFORM"), "base">>);
			Result := dir_name
		end;

	filter_path: STRING is
		local
			dir_name: DIRECTORY_NAME
		once
			!!dir_name.make_from_string (Eiffel3_dir_name);
			dir_name.extend_from_array (<<"bench", "filters">>);
			Result := resources.get_string (r_Filter_path, dir_name);
			if Result.empty then
				Result := dir_name
			else
					-- Interpretation of the environment variables
				Result := interpret (Result)
			end
		end;

	tmp_directory: STRING is
		local
			dir_name: DIRECTORY_NAME
		once
			!!dir_name.make;
			dir_name.set_directory ("tmp");
			Result := resources.get_string (r_Tmp_directory, dir_name);
			if Result.empty then
				Result := dir_name
			else
					-- Interpretation of the environment variables
				Result := interpret (Result)
			end
		end;

end
