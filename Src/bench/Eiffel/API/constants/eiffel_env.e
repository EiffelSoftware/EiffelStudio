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

	Freeze_command_name: FILE_NAME is
		once
			!! Result.make_from_string (Eiffel3_dir_name);
			Result.extend_from_array (<<"bench", "spec", Execution_environment.get ("PLATFORM") , "bin">>);
			Result.set_file_name (Finish_freezing_script);
		end

	Prelink_command_name: FILE_NAME is
		once
			!! Result.make_from_string (Eiffel3_dir_name);
			Result.extend_from_array (<<"bench", "spec", Execution_environment.get ("PLATFORM") , "bin">>);
			Result.set_file_name (Prelink_script);
		end;

	Default_class_file: FILE_NAME is
		once
			!! Result.make_from_string (Eiffel3_dir_name);
			Result.extend_from_array (<<"bench", "help", "defaults">>);
			Result.set_file_name (Default_Class_filename)
		end;

	Default_ace_name: FILE_NAME is
		once
			!! Result.make_from_string (Eiffel3_dir_name);
			Result.extend_from_array (<<"bench", "help", "defaults">>);
			Result.set_file_name (Default_Ace_file)
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

	Default_precompiled_location: DIRECTORY_NAME is
			-- Default location for the precompiled base
			-- $EIFFEL3/precomp/spec/$PLATFORM
		once
			!! Result.make_from_string (Eiffel3_dir_name);
			Result.extend_from_array (<<"precomp", "spec", Execution_environment.get ("PLATFORM")>>);
		end;

	Default_precompiled_base_location: DIRECTORY_NAME is
			-- Default location for the precompiled base
			-- $EIFFEL3/precomp/spec/$PLATFORM/base
		once
			!! Result.make_from_string (Eiffel3_dir_name);
			Result.extend_from_array (<<"precomp", "spec", Execution_environment.get ("PLATFORM"), "base">>);
		end;

	filter_path: DIRECTORY_NAME is
		once
			!! Result.make_from_string (Eiffel3_dir_name);
			Result.extend_from_array (<<"bench", "filters">>)
		end;

	profile_path: DIRECTORY_NAME is
			-- Location of the profiler configuration files
		once
			!! Result.make_from_string (Eiffel3_dir_name);
			Result.extend_from_array(<<"bench", "profiler">>);
		end;

	tmp_directory: DIRECTORY_NAME is
			-- Locate of the temporary directory
		once
			!! Result.make;
			Result.set_directory ("tmp");
		end;

	date_string (a_date: INTEGER): STRING is
			-- String representation of `a_date'
		external
			"C"
		alias
			"eif_date_string"
		end;
			
end -- class EIFFEL_ENV
