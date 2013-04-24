note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_MEMEORY_LEAK

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

feature {NONE} -- Prepare

	on_prepare
			-- Prepare
		local
			l_file: RAW_FILE
			l_des: RAW_FILE
		do
				-- Copy dll to W_code folder.
			create l_file.make_open_read (dll_name)
			create l_des.make_open_write (dll_des)
			l_file.copy_to (l_des)
			l_des.close
			l_file.close
		end

feature -- Test routines

	test_memory_leak
			-- New test routine
		local
			l_app: RIBBON_APPLICATION
		do
			create l_app.make_and_launch
		end

feature {NONE} -- Implementation

	dll_des: STRING
			-- Test folder
		once
			if attached Env.get ("ISE_LIBRARY") as l_v then
				Result := l_v.twin
				Result.append_character (Operating_environment.Directory_separator)
				Result.append ("library")
				Result.append_character (Operating_environment.Directory_separator)
				Result.append ("ribbon")
				Result.append_character (Operating_environment.Directory_separator)
				Result.append ("test")
				Result.append_character (Operating_environment.Directory_separator)
				Result.append ("EIFGENs")
				Result.append_character (Operating_environment.Directory_separator)
				Result.append ("test_ribbon")
				Result.append_character (Operating_environment.Directory_separator)
				Result.append ("W_code")
				Result.append_character (Operating_environment.Directory_separator)
				Result.append ("eiffel_ribbon_1.dll")
			else
				create Result.make_empty
			end
		end

	dll_name: STRING
			-- Test folder
		once
			if attached Env.get ("ISE_LIBRARY") as l_v then
				Result := l_v.twin
				Result.append_character (Operating_environment.Directory_separator)
				Result.append ("library")
				Result.append_character (Operating_environment.Directory_separator)
				Result.append ("ribbon")
				Result.append_character (Operating_environment.Directory_separator)
				Result.append ("test")
				Result.append_character (Operating_environment.Directory_separator)
				Result.append ("src")
				Result.append_character (Operating_environment.Directory_separator)
				Result.append ("eiffel_ribbon_1.dll")
			else
				create Result.make_empty
			end
		end

	env: EXECUTION_ENVIRONMENT
			-- Execution environment
		once
			create Result
		end

end


