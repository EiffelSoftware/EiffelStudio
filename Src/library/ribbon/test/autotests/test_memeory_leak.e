note
	description: "Eiffel tests that can be executed by testing tool."
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_MEMEORY_LEAK

inherit
	EV_VISION2_TEST_SET

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
		do
			run_test (agent perform_memory_leak)
		end

feature {NONE} -- Implementation

	perform_memory_leak
		local
			main_window: MAIN_WINDOW
		do
			create main_window
			main_window.set_title ("Do not close me, close the other one.")

				-- Test `enabled' and `set_enabled', when the window is not shown.
			main_window.application_menu.menu_group_1.button_3.set_enabled (True)
			assert_32 ("Button 3 is enabled", main_window.application_menu.menu_group_1.button_3.is_enabled)
			main_window.application_menu.menu_group_1.button_3.set_enabled (False)
			assert_32 ("Button3 is disabled", not main_window.application_menu.menu_group_1.button_3.is_enabled)

			main_window.show

			process_events

			check_leaks
		end

	check_leaks
			-- Check leaks
		do
			memory.full_collect
			ensure_remaining_one_object_of_type (({detachable RIBBON_1}).type_id)
			ensure_remaining_one_object_of_type (({detachable MAIN_WINDOW}).type_id)
			ensure_remaining_one_object_of_type (({detachable TAB_1}).type_id)
			ensure_remaining_one_object_of_type (({detachable BUTTON_1}).type_id)
			ensure_remaining_one_object_of_type (({detachable BUTTON_2}).type_id)
			ensure_remaining_one_object_of_type (({detachable GROUP_1}).type_id)
			ensure_remaining_one_object_of_type (({detachable EV_RIBBON_TITLED_WINDOW_IMP}).type_id)
		end

	ensure_remaining_one_object_of_type (a_type: INTEGER)
			-- Ensure that only one object of `a_type' is left in the system
			-- Otherwise raise an exception
		local
			l_list: detachable ARRAYED_LIST [ANY]
		do
			l_list := memory.memory_map.item (a_type)
			if l_list /= Void then
				if l_list.count /= 1 then
						-- Only one object is left
					(create {DEVELOPER_EXCEPTION}).raise
				end
			else
				(create {DEVELOPER_EXCEPTION}).raise
			end
		end

	dll_des: STRING_32
			-- Test folder
		once
			if attached Env.item ("ISE_LIBRARY") as l_v then
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

	dll_name: STRING_32
			-- Test folder
		once
			if attached Env.item ("ISE_LIBRARY") as l_v then
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

	memory: MEMORY
		once
			create Result
		end
end


