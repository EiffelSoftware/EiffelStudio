
class INIT_CHECK

inherit

	UNIX_ENV

feature 

	error: BOOLEAN;
			-- Did the check result in an error?

	perform_initial_check is
			-- Check EiffelBuild environment 
			-- variable and for the existance of
			-- Bitmaps directory.
		do
			check_eiffelbuild_var_name;
			if not error then
				check_bitmaps_directory
			end;
		end;

feature {NONE}

	check_bitmaps_directory is
			-- Set error to True if the Bitmaps
			-- directory can not be found.
		local
			dir: FILE_NAME;
			temp: STRING
		do
			temp := Bitmaps_directory.duplicate;
			!!dir.make (0);
			dir.from_string (temp);
			if not dir.exists then
				io.error.putstring ("Bitmap directory ");
				io.error.putstring (temp);
				io.error.putstring (" does not exist%N");
				error := True
			else
				error := False
			end;
		end;

	check_eiffelbuild_var_name is
			-- Set error to True if EiffelBuild_var_name 
			-- has not been set or the directory does 
			-- not exist.
		local
			env_var: STRING;
			temp, temp2: ANY;
			dir: FILE_NAME;
			string: STRING
		do
			!!env_var.make (EiffelBuild_var_name.count);
			env_var.append (EiffelBuild_var_name);
			!!string.make (0);
			temp2 := env_var.to_c;
			temp := unix_env_getenv ($temp2);
			if temp = Void then
				io.error.putstring ("Environment varaible EiffelBuild not defined%N");
				error := True
			else
				!!dir.make (0);
				string.from_c (temp);
				dir.from_string (string);
				if not dir.exists then
					io.error.putstring ("Directory ");
					io.error.putstring (string);
					io.error.putstring (" does not exist%N");
					error := True
				else
					error := False
				end;
			end
		end;

end	
