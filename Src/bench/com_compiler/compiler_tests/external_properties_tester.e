indexing
	description: "Tests IEIFFEL_SYSTEM_EXTERNALS_INTERFACE"
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_PROPERTIES_TESTER

inherit
	COMPILER_TESTER_SHARED
	
create 
	make
	
feature {NONE} -- Initialization

	make (a_interface: like system_externals_interface) is
			-- create tester for completion info
		require
			non_void_interface: a_interface /= Void
		do
			system_externals_interface := a_interface
			create menu.make ("External Properties")
			add_menu_items
			menu.show
		end

feature -- Agent Handlers
		
	on_add_object_file_selected (args: ARRAYED_LIST [STRING]) is
			-- perform safe addition of object file external 
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_add_object_file, args, False, True)
			-- display number of failures
			display_failure_count
		end

	test_add_object_file (args: ARRAYED_LIST [STRING]) is
			-- perform addition of object file external
		do
			put_string ("%NTesting 'add_object_file'%N")
			display_include_paths
			put_string ("%N  Enter object file to add: ")
			read_line
			add_object_file (last_string)
			display_object_files
		end
		
	on_remove_object_file_selected (args: ARRAYED_LIST [STRING]) is
			-- perform safe removal of object file external
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_remove_object_file, args, False, True)
			-- display number of failures
			display_failure_count
		end

	test_remove_object_file (args: ARRAYED_LIST [STRING]) is
			-- perform removal of object file external 
		do
			put_string ("%NTesting 'remove_object_file'%N")
			display_include_paths
			put_string ("%N  Enter object file to remove: ")
			read_line
			remove_object_file (last_string)
			display_object_files
		end

	on_replace_object_file_selected (args: ARRAYED_LIST [STRING]) is
			-- perform safe replace of object file external
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_replace_object_file, args, False, True)
			-- display number of failures
			display_failure_count
		end
		
	test_replace_object_file (args: ARRAYED_LIST [STRING]) is
			-- perform replace of object file external 
		local
			l_new_object_files: STRING
			l_old_object_files: STRING
		do
			put_string ("%NTesting 'replace_object_file'%N")
			display_include_paths
			put_string ("%N  Enter old object file: ")
			read_line
			l_old_object_files := last_string
			put_string ("%N  Enter new object_file: ")
			read_line
			l_new_object_files := last_string
			replace_object_file (l_new_object_files, l_old_object_files)
			display_include_paths
		end

	on_add_include_path_selected (args: ARRAYED_LIST [STRING]) is
			-- perform safe addition of include path external 
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_add_include_path, args, False, True)
			-- display number of failures
			display_failure_count
		end

	test_add_include_path (args: ARRAYED_LIST [STRING]) is
			-- perform addition of include path external
		do
			put_string ("%NTesting 'add_include_path'%N")
			display_include_paths
			put_string ("%N  Enter include path to add: ")
			read_line
			add_include_path (last_string)
			display_include_paths
		end
		
	on_remove_include_path_selected (args: ARRAYED_LIST [STRING]) is
			-- perform safe removal of include path external
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_remove_include_path, args, False, True)
			-- display number of failures
			display_failure_count
		end

	test_remove_include_path (args: ARRAYED_LIST [STRING]) is
			-- perform removal of include path external 
		do
			put_string ("%NTesting 'remove_include_path'%N")
			display_include_paths
			put_string ("%N  Enter include path to remove: ")
			read_line
			remove_include_path (last_string)
			display_include_paths
		end
		
	on_replace_include_path_selected (args: ARRAYED_LIST [STRING]) is
			-- perform safe removal of include path external
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_replace_include_path, args, False, True)
			-- display number of failures
			display_failure_count
		end
		
	test_replace_include_path (args: ARRAYED_LIST [STRING]) is
			-- perform removal of include path external 
		local
			l_new_include_path: STRING
			l_old_include_path: STRING
		do
			put_string ("%NTesting 'replace_include_path'%N")
			display_include_paths
			put_string ("%N  Enter old include path: ")
			read_line
			l_old_include_path := last_string
			put_string ("%N  Enter new include path: ")
			read_line
			l_new_include_path := last_string
			replace_include_path (l_new_include_path, l_old_include_path)
			display_include_paths
		end
		
	on_store_selected (args: ARRAYED_LIST [STRING]) is
			-- test apply
		do
			test_failure_count := 0
			call_test (agent test_store, args, False, True)
			display_failure_count
		end

	test_store (args: ARRAYED_LIST [STRING]) is
			--
		do
			system_externals_interface.store
		end

feature {NONE} -- Implementation

	display_object_files is
			-- display current object files
		local
			l_enum_object_files: IENUM_OBJECT_FILES_INTERFACE
			l_index: INTEGER
			l_object_file: CELL[STRING]
		do
			l_enum_object_files := system_externals_interface.object_files
			
			put_string ("%N  Current object files: Count (")
			put_int (l_enum_object_files.count)
			put_string (")")
			from
				l_index := 1
			until
				l_index > l_enum_object_files.count
			loop
				create l_object_file.put (Void)
				l_enum_object_files.ith_item (l_index, l_object_file)
				put_string ("%N    ")
				put_string (l_object_file.item)
				l_index := l_index + 1
			end
			if l_enum_object_files.count = 0 then
				put_string ("<None>")
			end
			put_string ("%N")
		end
		
	add_object_file (a_object_file: STRING) is
			-- attempt to add an object file
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N    Adding Object File: '")
				put_string (a_object_file)
				put_string ("'")
				system_externals_interface.add_object_file (a_object_file)
			else
				put_string ("%N%N#   Failed to add object file: '")
				put_string (a_object_file)
				put_string ("'%N")
				test_failure_count := test_failure_count + 1
			end
		rescue
			retried := True
			retry
		end
		
	remove_object_file (a_object_file: STRING) is
			-- attempt to remove an object file
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N    Removing Object File: '")
				put_string (a_object_file)
				put_string ("'")
				system_externals_interface.remove_object_file (a_object_file)
			else
				put_string ("%N%N#   Failed to remove object file: '")
				put_string (a_object_file)
				put_string ("'%N")
				test_failure_count := test_failure_count + 1
			end
		rescue
			retried := True
			retry
		end
			
	display_include_paths is
			-- display current include paths
		local
			l_enum_include_paths: IENUM_INCLUDE_PATHS_INTERFACE
			l_index: INTEGER
			l_include_path: CELL[STRING]
		do
			l_enum_include_paths := system_externals_interface.include_paths
			
			put_string ("%N  Current include paths: Count (")
			put_int (l_enum_include_paths.count)
			put_string (")")
			from
				l_index := 1
			until
				l_index > l_enum_include_paths.count
			loop
				create l_include_path.put (Void)
				l_enum_include_paths.ith_item (l_index, l_include_path)
				put_string ("%N    ")
				put_string (l_include_path.item)
				l_index := l_index + 1
			end
			if l_enum_include_paths.count = 0 then
				put_string ("<None>")
			end
			put_string ("%N")
		end
		
	replace_object_file (new_value, old_value: STRING) is
			-- replace an object file 'old_value' with a 'new_value'
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N    Replacing Object File: '")
				put_string (old_value)
				put_string ("' with '")
				put_string (new_value)
				put_string ("'")
				system_externals_interface.replace_object_file (new_value, old_value)
			else
				put_string ("%N%N#   Failed to replace object file: '")
				put_string (old_value)
				put_string ("' with '")
				put_string (new_value)
				put_string ("'%N")
				test_failure_count := test_failure_count + 1
			end
		rescue
			retried := True
			retry
		end
		
	add_include_path (a_include_path: STRING) is
			-- attempt to add an include path
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N    Adding Include Path: '")
				put_string (a_include_path)
				put_string ("'")
				system_externals_interface.add_include_path (a_include_path)
			else
				put_string ("%N%N#   Failed to add include path: '")
				put_string (a_include_path)
				put_string ("'%N")
				test_failure_count := test_failure_count + 1
			end
		rescue
			retried := True
			retry
		end
		
	remove_include_path (a_include_path: STRING) is
			-- attempt to remove an include path
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N    Removing Include Path: '")
				put_string (a_include_path)
				put_string ("'")
				system_externals_interface.remove_include_path (a_include_path)
			else
				put_string ("%N%N#   Failed to remove include path: '")
				put_string (a_include_path)
				put_string ("'%N")
				test_failure_count := test_failure_count + 1
			end
		rescue
			retried := True
			retry
		end	
		
	replace_include_path (new_value, old_value: STRING) is
			-- replace an include path 'old_value' with a 'new_value'
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N    Replacing Include Path: '")
				put_string (old_value)
				put_string ("' with '")
				put_string (new_value)
				put_string ("'")
				system_externals_interface.replace_include_path (new_value, old_value)
			else
				put_string ("%N%N#   Failed to replace include path: '")
				put_string (old_value)
				put_string ("' with '")
				put_string (new_value)
				put_string ("'%N")
				test_failure_count := test_failure_count + 1
			end
		rescue
			retried := True
			retry
		end
		
	add_menu_items is
			-- add menu items to menu
		do
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("1", "Test add_object_file", agent on_add_object_file_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("2", "Test remove_object_file", agent on_remove_object_file_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("3", "Test replace_object_file", agent on_replace_object_file_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("4", "Test add_include_path", agent on_add_include_path_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("5", "Test remove_include_path", agent on_remove_include_path_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("6", "Test replace_include_path", agent on_replace_include_path_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("s", "Test store", agent on_store_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("x", "Exit Menu", Void))
			menu.set_return_item (menu.items.last)
		end
		
	menu: CONSOLE_MENU
			-- menu
			
	system_externals_interface:IEIFFEL_SYSTEM_EXTERNALS_INTERFACE
			-- test interface
		
invariant
	non_void_menu: menu /= Void
	non_void_interface: system_externals_interface /= Void
	
end -- class EXTERNAL_PROPERTIES_TESTER
