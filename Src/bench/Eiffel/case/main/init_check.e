indexing

	description: 	
		"Initial check to see if the main% 
		%directories exists";
	date: "$Date$";
	revision: "$Revision $"

class INIT_CHECK

inherit

	EC_COMMAND;
	CONSTANTS;
	ONCES

feature -- Properties

	error: BOOLEAN
			-- Was there an error?

feature -- Execution

	execute (arg: ANY) is
			-- Perform checks.
		do
			check_screen;
			if not error then
				check_eiffelcase_directory;
				if not error then
					check_bitmaps_directory
				end
			end
		end;

feature {NONE} -- Implementation

	check_screen is
			-- Set error to True if the screen is invalid.
		require
			screen_created: Windows.screen /= Void
		local
			display_name: STRING
		do
			if not Windows.screen.is_valid then
				io.error.putstring ("Cannot open display %"");
				display_name := Environment.get ("DISPLAY");
				if display_name /= Void then
					io.error.putstring (display_name);
				end;
				io.error.putstring ("%" %N%
					%Check that $DISPLAY is properly set and that you are%N%
					%authorized to connect to the corresponding server%N");
				error := True;
			end
		end;

	check_bitmaps_directory is
			-- Set error to True if the Bitmaps
			-- directory can not be found.
		local
			dir: RAW_FILE;
			temp: STRING
		do
			temp := clone (Environment.Bitmap_directory);
			!!dir.make (temp);
			if not dir.exists then
				io.error.putstring ("Bitmap directory ");
				io.error.putstring (temp);
				io.error.putstring (" does not exist%N");
				error := True
			else
				error := False
			end;
		end;

	check_eiffelcase_directory is
			-- Set error to True if eiffelcase_variable_name
			-- has not been set or the directory does
			-- not exist.
		local
			dir: RAW_FILE;
			string: STRING
		do
			string := Environment.get (Environment.eiffel_variable_name);
			if string = Void or string.empty then
				io.error.putstring ("Environment variable ");
				io.error.putstring (Environment.eiffel_variable_name);
				io.error.putstring (" not defined%N");
				error := True
			else
				!! dir.make (string);
				if not dir.exists then
					io.error.putstring ("Directory ");
					io.error.putstring (string);
					io.error.putstring (" does not exist%N");
					io.error.putstring ("Environment variable ");
					io.error.putstring (Environment.eiffel_variable_name);
					io.error.putstring (" needs to be defined to the correct directory%N");
					error := True
				else
					!!dir.make (Environment.eiffelCase_directory);
					if not dir.exists then
						io.error.putstring ("Directory ");
						io.error.putstring (Environment.eiffelCase_directory);
						io.error.putstring (" does not exist%N");
						error := True;
					else
						error := False;
					end;
				end;
			end
		end;

end -- class INIT_CHECK
