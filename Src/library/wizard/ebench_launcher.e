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
			eif_4 := get ("EIFFEL4")
			plat := get ("PLATFORM")
			if eif_4 = void then
				io.put_string ("Your environment variable $EIFFEL4 is not defined !!! %N You have to compile the generated project by your own")
--			elseif plat = Void then
--				io.put_string ("Your environment variable $PLATFORM is not defined !!! %N You have to compile the generated project by your own")
			end
			if plat = Void then
				plat := "windows"
			end

			es4_location := eif_4 + "/bench/spec/" + plat + "/bin/"
		end

	launch is
			-- launch es4 to compile a generated project
		require
			valid_path: project_path /= Void and then not project_path.is_equal ("")
			valid_ace: ace_name /= Void and then not ace_name.is_equal ("")
		local
			command: STRING
		do					
				command:= es4_location + "ec -batch -ace " + ace_name + " -project_path " + project_path
				system (command)
				change_working_directory (project_path + "\EIFGEN\W_Code")
				ex_launch (es4_location + "finish_freezing.exe")
				is_compiled := TRUE
		end

	display is
			-- launch ebench to use the generated project
		require
			project_already_compile: is_compiled
		local
			command: STRING
			dir: DIRECTORY
		do
			change_working_directory (project_path)
			create dir.make (project_path)
			if dir.has_entry (project_name + ".epr") then
				command:= es4_location + "ebench " + project_path + "\" + project_name + ".epr"
				ex_launch (command)
			end
		end
		
			

feature -- Access

	project_path: STRING
		-- Path of the Eiffel Project to compile

	ace_name: STRING
		-- Name of the ace file

	es4_location: STRING
		-- Location of es4, and ebench

	project_name: STRING
		-- Name of the project

	is_compiled: BOOLEAN
		-- Is the project already compiled

--	to_compile: BOOLEAN
		-- Is the project will be compile


end -- class EBENCH_LAUNCHER
