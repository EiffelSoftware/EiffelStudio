
class INIT_CHECK

inherit

	CONSTANTS;
	WINDOWS

feature 

	error: BOOLEAN;
			-- Did the check result in an error?

	perform_initial_check is
			-- Check EiffelBuild environment 
			-- variable and for the existance of
			-- Bitmaps directory.
		do
			check_screen;
			if not error then
				check_eiffelbuild_var_name;
				if not error then
					check_bitmaps_directory;
				end
			end;
		end;
	
	build_dir: STRING;

feature {NONE}

	check_screen is
		local
			display_name: STRING
		do
				-- Force creation of screen
			if eb_screen = Void then end;
			if not eb_screen.is_valid then
				io.error.putstring ("Cannot open display %"");
				display_name := Environment.get ("DISPLAY");
				if display_name /= Void then
					io.error.putstring (display_name);
				end;
				io.error.putstring ("%"%N%
					%Check that $DISPLAY is properly set and that you are%N%
					%authorized to connect to the corresponding server%N");
			   error := True;
			end
		end;

	check_bitmaps_directory is
			-- Set error to True if the Bitmaps
			-- directory can not be found.
		local
			dir: FILE_NAME;
			temp: STRING
		do
			temp := clone (Environment.bitmaps_directory);
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
			string := Environment.get (Environment.eiffel3_variable_name);
			if string = Void then
				io.error.putstring ("Environment variable ");
				io.error.putstring (Environment.eiffel3_variable_name);
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
					io.error.putstring (Environment.eiffel3_variable_name);
					io.error.putstring (" needs to be defined to the correct directory%N");
					error := True
				else
					build_dir := clone (string);
					!!dir.make (0);
					dir.from_string (Environment.eiffelbuild_directory);
					if not dir.exists then
						io.error.putstring ("Directory ");
						io.error.putstring (dir);
						io.error.putstring (" does not exist%N");
						error := True;
					else
						error := False;
					end;
				end;
			end
		end;

end	
