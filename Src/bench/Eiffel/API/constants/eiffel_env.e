indexing

	description: 
		"Environment for bitmaps, help, binaries, scripts....";
	date: "$Date$";
	revision: "$Revision $"

class EIFFEL_ENV

inherit

	SYSTEM_CONSTANTS;
	ENV_INTERP
	
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

	Default_class_file: STRING is
		local
			file_name: FILE_NAME
		once
			!! file_name.make_from_string (Eiffel3_dir_name);
			file_name.extend_from_array (<<"bench", "help", "defaults">>);
			file_name.set_file_name (Default_Class_filename);
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

	Cursor_path: DIRECTORY_NAME is
		once
			!! Result.make_from_string (Eiffel3_dir_name);
			Result.extend_from_array (<<"bench", "bitmaps", "cursor">>);
		end;

	Bitmap_path: DIRECTORY_NAME is
		once
			!! Result.make_from_string (Eiffel3_dir_name);
			Result.extend_from_array (<<"bench", "bitmaps">>);
			Result.extend (Pixmap_suffix)
		end;

	Help_path: DIRECTORY_NAME is
		once
			!! Result.make_from_string (Eiffel3_dir_name);
			Result.extend_from_array (<<"bench", "help", "errors">>);
		end;

	Default_precompiled_location: STRING is
			-- Default location for the precompiled base
			-- $EIFFEL3/precomp/spec/$PLATFORM
		local
			dir_name: DIRECTORY_NAME
		once
			!!dir_name.make_from_string (Eiffel3_dir_name);
			dir_name.extend_from_array (<<"precomp", "spec", Execution_environment.get ("PLATFORM")>>);
			Result := dir_name
		end;

	Default_precompiled_base_location: STRING is
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
			Result := dir_name
		end;

	profile_path: STRING is
			-- Location of the profiler configuration files
		local
			dir_name: DIRECTORY_NAME
		once
			!! dir_name.make_from_string (Eiffel3_dir_name);
			dir_name.extend_from_array(<<"bench", "profiler">>);
			Result := dir_name
		end;

	tmp_directory: STRING is
			-- Locate of the temporary directory
		local
			dir_name: DIRECTORY_NAME
		once
			!!dir_name.make;
			dir_name.set_directory ("tmp");
			Result := dir_name
		end;

	date_string (a_date: INTEGER): STRING is
			-- String representation of `a_date'
		external
			"C"
		alias
			"eif_date_string"
		end;
			
end -- class EIFFEL_ENV
