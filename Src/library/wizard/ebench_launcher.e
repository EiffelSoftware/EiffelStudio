indexing
	description: "Objects that to launch a compilation"
	author: "Davids"
	date: "$Date$"
	revision: "$Revision$"


-- FIXME 
-- There are some io.put_string which must be replace by Dialog_box when they will be in Vision2
-- Then the question in the lauch feature to clean the directory should be asked in the Final_state

-- FIXME
-- Platform is not recognized with ISE eiffel 4.5

class
	EBENCH_LAUNCHER

inherit
	EXECUTION_ENVIRONMENT
		rename 
			launch as ex_launch
		end

create
	make

feature -- Initialization

	make (ace: STRING; project: STRING; name: STRING) is
			-- Setting
		local
			eif_4, plat: STRING
		do
			ace_name := ace
			project_path := project
			project_name := name
			eif_4 := get ("ISE_EIFFEL")
			plat := get ("ISE_PLATFORM")
			if eif_4 = void then
				io.put_string ("Your environment variable $ISE_EIFFEL is not defined ! %N You have to compile the generated project on your own")
			elseif plat = Void then
				io.put_string ("Your environment variable $ISE_PLATFORM is not defined ! %N You have to compile the generated project on your own")
			end
			if plat = Void then
				plat := "windows"
			end

			create es4_location.make_from_string (eif_4)
			es4_location.extend_from_array (<<"studio", "spec", plat, "bin">>)
		end

	launch is
			-- launch es4 to compile a generated project
		require
			valid_path: project_path /= Void and then not project_path.is_equal ("")
			valid_ace: ace_name /= Void and then not ace_name.is_equal ("")
		local
			command: STRING
			fn: FILE_NAME
			ecn: FILE_NAME
			ffn: FILE_NAME
		do					
				ecn := clone (es4_location)
				ecn.set_file_name ("ec")
				command := ecn
				command := command + " -batch -ace " + ace_name + " -project_path " + project_path
				system (command)
				create fn.make_from_string (project_path)
				fn.extend ("EIFGEN")
				fn.extend ("W_code")
				change_working_directory (fn)
				ffn := clone (es4_location)
				ffn.set_file_name ("finish_freezing")
				ex_launch (ffn)
				is_compiled := TRUE
		end

	display is
			-- launch estudio to use the generated project
		require
			project_already_compile: is_compiled
		local
			command: STRING
			dir: DIRECTORY
			fn: FILE_NAME
			stn: FILE_NAME
		do
			change_working_directory (project_path)
			create dir.make (project_path)
			create fn.make_from_string (project_name)
			fn.add_extension ("epr")
			if dir.has_entry (fn) then
				fn.set_directory (project_path)
				stn := clone (es4_location)
				stn.set_file_name ("estudio")
				command := stn
				command := command + " " + fn
				ex_launch (command)
			end
		end
		
			

feature -- Access

	project_path: STRING
		-- Path of the Eiffel Project to compile

	ace_name: STRING
		-- Name of the ace file

	es4_location: FILE_NAME
		-- Location of es4, and estudio

	project_name: STRING
		-- Name of the project

	is_compiled: BOOLEAN
		-- Is the project already compiled

--	to_compile: BOOLEAN
		-- Is the project will be compile


end -- class EBENCH_LAUNCHER


--|----------------------------------------------------------------
--| EiffelWizard: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

