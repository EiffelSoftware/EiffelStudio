indexing
	description: "Tests CEIFFEL_PROJECT_COCLASS and IEIFFEL_PROJECT_INTERFACE"
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECT_MANAGER_TESTER

inherit
	COMPILER_TESTER_SHARED
	
create 
	make
	
feature {NONE} -- Initialization

	make is
			-- create tester for completion info
		do
			project_manager_interface := create {CEIFFEL_PROJECT_COCLASS_IMP}.make
			create menu.make ("IEIFFEL_PROJECT_INTERFACE Tests")
			add_menu_items
			menu.show
		end

feature {NONE} -- Agent Handlers

	on_retrieve_project_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'retreieve_project'
		do
			test_failure_count := 0
			call_test (agent test_retrieve_project, args, False, True)
			display_failure_count
		end
		
	test_retrieve_project (args: ARRAYED_LIST [STRING]) is
			-- test 'store'
		do
			put_string ("%NTesting 'retreieve_project'")
			display_current_properties
			put_string ("Please enter a project filename: ")
			read_line
			retrieve_project (last_string)
			display_current_properties
		end

	on_create_project_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'create_project'
		do
			test_failure_count := 0
			call_test (agent test_create_project, args, False, True)
			display_failure_count
		end
		
	test_create_project (args: ARRAYED_LIST [STRING]) is
			-- test 'create_project'
		local
			l_ace_filename: STRING
			l_project_directory: STRING
		do
			put_string ("%NTesting 'create_project'")
			display_current_properties
			put_string ("%NPlease enter a project ace filename: ")
			read_line
			l_ace_filename := last_string
			put_string ("%NPlease enter a project path: ")
			read_line
			l_project_directory := last_string
			create_project (l_ace_filename, l_project_directory)
			display_current_properties
		end

	on_compiler_selected (args: ARRAYED_LIST [STRING]) is
			-- safely test 'compiler'
		do
			test_failure_count := 0
			call_test (agent test_compiler, args, False, False)
			display_failure_count
		end
		
	test_compiler (args: ARRAYED_LIST [STRING]) is
			-- test 'compiler'
		local
			l_menu: COMPILER_TESTER
		do
			create l_menu.make (project_manager_interface.compiler)
		end

	on_display_selected (args: ARRAYED_LIST [STRING]) is
			-- display properties safely
		do
			test_failure_count := 0
			call_test (agent test_display, args, False, False)
			display_failure_count
		end
		
	test_display (args: ARRAYED_LIST [STRING]) is
			-- display current properties
		do
			display_current_properties
			put_string ("%N")
		end

feature {NONE} -- Output

	display_current_properties is
			-- display 'project_manager_interface' current properties
		do
			put_string ("%N  Current Properties")
			put_string ("%N    ace_file_name=")
			put_string (project_manager_interface.ace_file_name)
			put_string ("%N    compiler=")
			if project_manager_interface.compiler /= Void then
				put_string ("[Object]")
			else
				put_string (Void)
			end
			put_string ("%N    completion_information=")
			if project_manager_interface.valid_project and project_manager_interface.completion_information /= Void then
				put_string ("[Object]")
			else
				put_string (Void)
			end
			put_string ("%N    html_doc_generator=")
			if project_manager_interface.valid_project and project_manager_interface.html_doc_generator /= Void then
				put_string ("[Object]")
			else
				put_string (Void)
			end
			put_string ("%N    is_compiled=")
			put_bool (project_manager_interface.is_compiled)
			put_string ("%N    last_error_message=")
			put_string (project_manager_interface.last_error_message)
			put_string ("%N    project_directory=")
			put_string (project_manager_interface.project_directory)
			put_string ("%N    project_file_name=")
			put_string (project_manager_interface.project_file_name)
			put_string ("%N    project_has_updated=")
			put_bool (project_manager_interface.project_has_updated)
			put_string ("%N    project_properties=")
			if project_manager_interface.valid_project and project_manager_interface.project_properties /= Void then
				put_string ("[Object]")
			else
				put_string (Void)
			end
			put_string ("%N    system_browser=")
			if project_manager_interface.valid_project and project_manager_interface.system_browser /= Void then
				put_string ("[Object]")
			else
				put_string (Void)
			end
			put_string ("%N    valid_project=")
			put_bool (project_manager_interface.valid_project)
		end
		
	
feature {NONE} -- Implementation

	retrieve_project (a_filename: STRING) is
			-- retrieve project 'a_filename'
		local
			retried: BOOLEAN
		do
			if not retried  then
				put_string ("%N  Testing retrieve_project with '")
				put_string (a_filename)
				put_string ("'")
				project_manager_interface.retrieve_project (a_filename)
			else
				put_string ("%N#  Failed")
			end
		rescue
			retried := True
			retry
		end
		
	create_project (a_filename, a_directory: STRING) is
			-- create a project using 'a_filename' in 'a_directory'
		local
			retried: BOOLEAN
		do
			if not retried  then
				put_string ("%N  Testing create_project with '")
				put_string (a_filename)
				put_string ("', '")
				put_string (a_directory)
				put_string ("'")
				project_manager_interface.create_project (a_filename, a_directory)
			else
				put_string ("%N#  Failed")
			end
		rescue
			retried := True
			retry	
		end
		
		

	add_menu_items is
			-- add menu items to menu
		require
			non_void_menu: menu /= Void
		do
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("1", "Test retrieve_project", agent on_retrieve_project_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("2", "Test create_project", agent on_create_project_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("3", "Test compiler", agent on_compiler_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("d", "Display Current Properties", agent on_display_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("x", "Exit Menu", Void))
			menu.set_return_item (menu.items.last)
		end
		
	menu: CONSOLE_MENU
		-- menu
		
	project_manager_interface: IEIFFEL_PROJECT_INTERFACE
		-- PROJECT_MANAGER interface
		
invariant
	non_void_menu: menu /= Void
	non_void_interace: project_manager_interface /= Void

end -- class PROJECT_MANAGER_TESTER
