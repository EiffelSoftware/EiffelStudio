
class INIT_CHECK

inherit

	UNIX_ENV;

	BUILD_LIC
		redefine
			build_dir
	end;

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
				check_bitmaps_directory;
				if not error then
					licence.get_registration_info;
					licence.set_application_name ("eiffelbuild");
					licence.set_version(1);
					licence.register;
					if licence.registered then
						licence.open_licence;
						if licence.licenced then
							error := False;
						else
							error := True;
						end;
					else
						error := True;
					end;
				end;
			end;
		end;
	
	build_dir: STRING;

feature {NONE}

	check_bitmaps_directory is
			-- Set error to True if the Bitmaps
			-- directory can not be found.
		local
			dir: FILE_NAME;
			temp: STRING
		do
			temp := clone (Bitmaps_directory);
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
			dir: FILE_NAME;
			string: STRING
		do
			string := get (EiffelBuild_var_name);
			if string = Void then
				io.error.putstring ("Environment varaible ");
				io.error.putstring (EiffelBuild_var_name);
				io.error.putstring (" not defined%N");
				error := True
			else
				!!dir.make (0);
				dir.from_string (string);
				if not dir.exists then
					io.error.putstring ("Directory ");
					io.error.putstring (string);
					io.error.putstring (" does not exist%N");
					io.error.putstring ("Environment varaible ");
					io.error.putstring (EiffelBuild_var_name);
					io.error.putstring (" needs to be defined to correct directory%N");
					error := True
				else
					build_dir := clone (string);
					!!dir.make (0);
					dir.from_string (EiffelBuild_directory);
					if not dir.exists then
						io.error.putstring ("Directory ");
						io.error.putstring (EiffelBuild_directory);
						io.error.putstring (" does not exist%N");
						error := True;
					else
						error := False;
					end;
				end;
			end
		end;

end	
