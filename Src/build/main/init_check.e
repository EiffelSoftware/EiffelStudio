indexing
	description: "Initial tests."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class INIT_CHECK

inherit
	WINDOWS

	CONSTANTS

feature 

	error: BOOLEAN
			-- Did the check result in an error?

	perform_initial_check is
			-- Check EiffelBuild environment 
			-- variable and for the existance of
			-- Bitmaps directory.
		do
			check_screen
			if not error then
				check_eiffelbuild_var_name
				if not error then
					check_bitmaps_directory
				end
			end
		end

feature {NONE}

	check_screen is
		local
			display_name: STRING
		do
				-- Force creation of screen
			if screen = Void then end
--			if not screen.is_valid then
--				io.error.putstring ("Cannot open display %"")
--				display_name := Environment.get ("DISPLAY")
--				if display_name /= Void then
--					io.error.putstring (display_name)
--				end
--				io.error.putstring ("%"%N%
--					%Check that $DISPLAY is properly set and that you are%N%
--					%authorized to connect to the corresponding server%N")
--			   error := True
--			end
		end

	check_bitmaps_directory is
			-- Set error to True if the Bitmaps
			-- directory cannot be found.
		local
			dir: PLAIN_TEXT_FILE
		do
			create dir.make (clone (Environment.bitmaps_directory))
			if not dir.exists or else not dir.is_readable then
				io.error.putstring ("Bitmap directory ")
				io.error.putstring (dir.name)
				io.error.putstring (" is not readable.%N")
				error := True
			else
				error := False
			end
		end

	check_eiffelbuild_var_name is
			-- Set error to True if EiffelBuild_var_name 
			-- has not been set or the directory does 
			-- not exist.
		local
			dir: PLAIN_TEXT_FILE
			path_name: STRING
		do
			path_name := Environment.get (Environment.Eiffel_variable_name)
			if path_name = Void or else path_name.empty then
				io.error.putstring ("Environment variable ")
				io.error.putstring (Environment.Eiffel_variable_name)
				io.error.putstring (" not defined%N")
				error := True
			else
				create dir.make (path_name)
				if not dir.exists or else not dir.is_readable then
					io.error.putstring ("Directory ")
					io.error.putstring (path_name)
					io.error.putstring (" is not readable.%N")
					io.error.putstring ("Environment variable ")
					io.error.putstring (Environment.Eiffel_variable_name)
					io.error.putstring (" needs to be set to the correct directory%N")
					error := True
				else
					create dir.make (Environment.eiffelbuild_directory)
					if not dir.exists or else not dir.is_readable then
						io.error.putstring ("Directory ")
						io.error.putstring (dir.name)
						io.error.putstring (" is not readable.%N")
						error := True
					else
						path_name := Environment.get 
							(Environment.platform_variable_name)
						if path_name = Void or else path_name.empty then
							io.error.putstring ("Environment variable ")
							io.error.putstring (Environment.platform_variable_name)
							io.error.putstring (" not defined%N")
							error := True
						else
							error := False
						end
					end
				end
			end
		end

end	-- class INIT_CHECK

