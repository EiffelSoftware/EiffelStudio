indexing
	description: "Tests ace external properties"
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_PROPERTIES_TESTER

inherit
	COMPILER_TESTER_SHARED
	
create 
	make
	
feature {NONE} -- Initialization

	make is
			-- create tester for completion info
		do
			create menu.make ("External Properties")
			add_menu_items
			menu.show
		end

feature -- Agent Handlers
		
	on_add_external_object_selected (args: ARRAYED_LIST [STRING]) is
			-- perform safe addition of object file external 
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent add_external_object_test, args, False, True)
			-- display number of failures
			display_failure_count
		end

	add_external_object_test (args: ARRAYED_LIST [STRING]) is
			-- perform addition of object file external
		require
			non_void_project_manager: project_manager /= Void
			non_void_project_properties: project_manager.project_properties /= Void
		local
			l_system_externals: IEIFFEL_SYSTEM_EXTERNALS_INTERFACE
			l_enum_object_files: IENUM_OBJECT_FILES_INTERFACE
			l_object_file: CELL[STRING]
			l_string: STRING
		do
			put_string ("%NTesting Object File Addition%N")
			l_system_externals := project_manager.project_properties.externals
			display_object_files (l_system_externals)
			
			if args.count >=1 then
				l_string := args.i_th (1)
			else
				put_string ("%N  Please enter the external file name:")
				io.read_line
				l_string := io.last_string				
			end
			add_object_file (l_string, l_system_externals)
			display_object_files (l_system_externals)
			
			put_string ("%N  Adding last external file name again:")
			add_object_file (l_string, l_system_externals)
			display_object_files (l_system_externals)

			put_string ("%N  Adding duplicate external file name:")
			l_enum_object_files := l_system_externals.object_files
			if l_enum_object_files.count > 0 then
				create l_object_file.put (Void)
				l_enum_object_files.ith_item (1, l_object_file)
				add_object_file (l_object_file.item, l_system_externals)
				display_object_files (l_system_externals)				
			else
				test_failure_count := test_failure_count + 1
				put_string ("%N# Failed to added duplicated because enum is empty%N")
			end
			
			put_string ("%N  Adding empty object file:")
			add_object_file ("", l_system_externals)
			display_object_files (l_system_externals)

			put_string ("%N  Adding Void object file:")
			add_object_file (Void, l_system_externals)
			display_object_files (l_system_externals)
		end
		
	on_remove_external_object_selected (args: ARRAYED_LIST [STRING]) is
			-- perform safe removal of object file external
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent remove_external_object, args, False, True)
			-- display number of failures
			display_failure_count
		end

	remove_external_object (args: ARRAYED_LIST [STRING]) is
			-- perform removal of object file external 
		require
			non_void_project_manager: project_manager /= Void
			non_void_project_properties: project_manager.project_properties /= Void
		local
			l_system_externals: IEIFFEL_SYSTEM_EXTERNALS_INTERFACE
			l_enum_object_files: IENUM_OBJECT_FILES_INTERFACE
			l_object_file: CELL[STRING]
		do
			put_string ("%NTesting Removal of Object File%N")
			l_system_externals := project_manager.project_properties.externals
			if l_system_externals.object_files.count = 0 then
				put_string ("%N  No externals in ace - Adding some")
				add_object_file ("object_file1", l_system_externals)
				add_object_file ("object_file2", l_system_externals)
				add_object_file ("object_file3", l_system_externals)
				put_string ("%N")
				display_object_files (l_system_externals)
			end
			put_string ("%N  Removing known object file:")
			l_enum_object_files := l_system_externals.object_files
			create l_object_file.put (Void)
			l_enum_object_files.ith_item (1, l_object_file)
			remove_object_file (l_object_file.item, l_system_externals)
			display_object_files (l_system_externals)
			
			put_string ("%N  Attempt to removing same object file:")
			remove_object_file (l_object_file.item, l_system_externals)
			display_object_files (l_system_externals)
			
			put_string ("%N  Attempt to removing empty object file:")
			remove_object_file ("", l_system_externals)
			display_object_files (l_system_externals)
			
			put_string ("%N  Attempt to removing Void object file:")
			remove_object_file (Void, l_system_externals)
			display_object_files (l_system_externals)
		end

	on_replace_external_object_selected (args: ARRAYED_LIST [STRING]) is
			-- perform safe replace of object file external
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent replace_external_object, args, False, True)
			-- display number of failures
			display_failure_count
		end
		
	replace_external_object (args: ARRAYED_LIST [STRING]) is
			-- perform replace of object file external 
		require
			non_void_project_manager: project_manager /= Void
			non_void_project_properties: project_manager.project_properties /= Void
		local
			l_system_externals: IEIFFEL_SYSTEM_EXTERNALS_INTERFACE
			l_enum_object_files: IENUM_OBJECT_FILES_INTERFACE
			l_object_file_old: CELL[STRING]
			l_object_file_new: CELL[STRING]
		do
			put_string ("%NTesting Removal of Object File%N")
			l_system_externals := project_manager.project_properties.externals
			if l_system_externals.object_files.count < 3 then
				put_string ("%N  Less than 3 object files - Adding some")
				add_object_file ("object_file1", l_system_externals)
				add_object_file ("object_file2", l_system_externals)
				add_object_file ("object_file3", l_system_externals)
				put_string ("%N")
				display_object_files (l_system_externals)
			end
			l_enum_object_files := l_system_externals.object_files
			check
				enough_object_files: l_enum_object_files.count >= 3
			end
			put_string ("%N  Replacing first object file:")
			create l_object_file_old.put (Void)
			l_enum_object_files.ith_item (1, l_object_file_old)
			replace_object_file ("replaced_object_file1", l_object_file_old.item, l_system_externals)
			display_object_files (l_system_externals)
			
			put_string ("%N  Replacing last object file:")
			create l_object_file_old.put (Void)
			l_enum_object_files.ith_item (l_enum_object_files.count, l_object_file_old)
			replace_object_file ("replaced_object_file3", l_object_file_old.item, l_system_externals)
			display_object_files (l_system_externals)
			
			put_string ("%N  Replacing intermediate object file:")
			create l_object_file_old.put (Void)
			l_enum_object_files.ith_item (2, l_object_file_old)
			replace_object_file ("replaced_object_file2", l_object_file_old.item, l_system_externals)
			display_object_files (l_system_externals)
			
			l_enum_object_files := l_system_externals.object_files
			check
				enough_object_files: l_enum_object_files.count > 0
			end
			put_string ("%N  Replacing object file with same value:")
			create l_object_file_old.put (Void)
			l_enum_object_files.ith_item (1, l_object_file_old)
			replace_object_file (l_object_file_old.item, l_object_file_old.item, l_system_externals)
			display_object_files (l_system_externals)
			
			put_string ("%N  Replacing object file using uppercase value with any value:")
			create l_object_file_old.put (Void)
			l_enum_object_files.ith_item (1, l_object_file_old)
			l_object_file_old.item.to_upper
			replace_object_file ("upper_cased_object_file", l_object_file_old.item, l_system_externals)
			display_object_files (l_system_externals)
			
			l_enum_object_files := l_system_externals.object_files
			check
				enough_object_files: l_enum_object_files.count > 0
			end
			put_string ("%N  Replacing non existent object file with any value:")
			create l_object_file_old.put (Void)
			l_enum_object_files.ith_item (1, l_object_file_old)
			replace_object_file ("object_file3", "object_file1", l_system_externals)
			display_object_files (l_system_externals)
			
			put_string ("%N  Replacing object file with empty value:")
			create l_object_file_old.put (Void)
			l_enum_object_files.ith_item (1, l_object_file_old)
			replace_object_file ("", l_object_file_old.item, l_system_externals)
			display_object_files (l_system_externals)
			
			put_string ("%N  Replacing object file with void same value:")
			create l_object_file_old.put (Void)
			l_enum_object_files.ith_item (1, l_object_file_old)
			replace_object_file (Void, l_object_file_old.item, l_system_externals)
			display_object_files (l_system_externals)
			
			put_string ("%N  Replacing empty object file with empty value:")
			replace_object_file ("", "", l_system_externals)
			display_object_files (l_system_externals)
			
			put_string ("%N  Replacing void object file with void value:")
			replace_object_file (Void, Void, l_system_externals)
			display_object_files (l_system_externals)
		end

	on_add_external_include_selected (args: ARRAYED_LIST [STRING]) is
			-- perform safe addition of include path external 
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent add_external_include_test, args, False, True)
			-- display number of failures
			display_failure_count
		end

	add_external_include_test (args: ARRAYED_LIST [STRING]) is
			-- perform addition of include path external
		require
			non_void_project_manager: project_manager /= Void
			non_void_project_properties: project_manager.project_properties /= Void
		local
			l_system_externals: IEIFFEL_SYSTEM_EXTERNALS_INTERFACE
			l_enum_include_paths: IENUM_INCLUDE_PATHS_INTERFACE
			l_include_path: CELL[STRING]
			l_string: STRING
		do
			put_string ("%NTesting Include Path Addition%N")
			l_system_externals := project_manager.project_properties.externals
			display_include_paths (l_system_externals)
			
			if args.count >=1 then
				l_string := args.i_th (1)
			else
				put_string ("%N  Please enter the external file name:")
				io.read_line
				l_string := io.last_string				
			end
			add_include_path (l_string, l_system_externals)
			display_include_paths (l_system_externals)
			
			put_string ("%N  Adding last external file name again:")
			add_include_path (l_string, l_system_externals)
			display_include_paths (l_system_externals)

			put_string ("%N  Adding duplicate external file name:")
			l_enum_include_paths := l_system_externals.include_paths
			if l_enum_include_paths.count > 0 then
				create l_include_path.put (Void)
				l_enum_include_paths.ith_item (1, l_include_path)
				add_include_path (l_include_path.item, l_system_externals)
				display_include_paths (l_system_externals)				
			else
				test_failure_count := test_failure_count + 1
				put_string ("%N# Failed to added duplicated because enum is empty%N")
			end
			
			put_string ("%N  Adding empty include path:")
			add_include_path ("", l_system_externals)
			display_include_paths (l_system_externals)

			put_string ("%N  Adding Void include path:")
			add_include_path (Void, l_system_externals)
			display_include_paths (l_system_externals)
		end
		
	on_remove_external_include_selected (args: ARRAYED_LIST [STRING]) is
			-- perform safe removal of include path external
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent remove_external_include, args, False, True)
			-- display number of failures
			display_failure_count
		end

	remove_external_include (args: ARRAYED_LIST [STRING]) is
			-- perform removal of include path external 
		require
			non_void_project_manager: project_manager /= Void
			non_void_project_properties: project_manager.project_properties /= Void
		local
			l_system_externals: IEIFFEL_SYSTEM_EXTERNALS_INTERFACE
			l_enum_include_paths: IENUM_INCLUDE_PATHS_INTERFACE
			l_include_path: CELL[STRING]
		do
			put_string ("%NTesting Removal of Include Path%N")
			l_system_externals := project_manager.project_properties.externals
			if l_system_externals.include_paths.count = 0 then
				put_string ("%N  No externals in ace - Adding some")
				add_include_path ("include_path1", l_system_externals)
				add_include_path ("include_path2", l_system_externals)
				add_include_path ("include_path3", l_system_externals)
				put_string ("%N")
				display_include_paths (l_system_externals)
			end
			put_string ("%N  Removing known include path:")
			l_enum_include_paths := l_system_externals.include_paths
			create l_include_path.put (Void)
			l_enum_include_paths.ith_item (1, l_include_path)
			remove_include_path (l_include_path.item, l_system_externals)
			display_include_paths (l_system_externals)
			
			put_string ("%N  Attempt to removing same include path:")
			remove_include_path (l_include_path.item, l_system_externals)
			display_include_paths (l_system_externals)
			
			put_string ("%N  Attempt to removing empty include path:")
			remove_include_path ("", l_system_externals)
			display_include_paths (l_system_externals)
			
			put_string ("%N  Attempt to removing Void include path:")
			remove_include_path (Void, l_system_externals)
			display_include_paths (l_system_externals)
		end
		
	on_replace_external_include_selected (args: ARRAYED_LIST [STRING]) is
			-- perform safe removal of include path external
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent replace_external_include, args, False, True)
			-- display number of failures
			display_failure_count
		end
		
	replace_external_include (args: ARRAYED_LIST [STRING]) is
			-- perform removal of include path external 
		require
			non_void_project_manager: project_manager /= Void
			non_void_project_properties: project_manager.project_properties /= Void
		local
			l_system_externals: IEIFFEL_SYSTEM_EXTERNALS_INTERFACE
			l_enum_include_paths: IENUM_INCLUDE_PATHS_INTERFACE
			l_include_path_old: CELL[STRING]
			l_include_path_new: CELL[STRING]
		do
			put_string ("%NTesting Removal of Include Path%N")
			l_system_externals := project_manager.project_properties.externals
			if l_system_externals.include_paths.count < 3 then
				put_string ("%N  Less than 3 include paths - Adding some")
				add_include_path ("include_path1", l_system_externals)
				add_include_path ("include_path2", l_system_externals)
				add_include_path ("include_path3", l_system_externals)
				put_string ("%N")
				display_include_paths (l_system_externals)
			end
			l_enum_include_paths := l_system_externals.include_paths
			check
				enough_include_paths: l_enum_include_paths.count >= 3
			end
			put_string ("%N  Replacing first include path:")
			create l_include_path_old.put (Void)
			l_enum_include_paths.ith_item (1, l_include_path_old)
			replace_include_path ("replaced_include_path1", l_include_path_old.item, l_system_externals)
			display_include_paths (l_system_externals)
			
			put_string ("%N  Replacing last include path:")
			create l_include_path_old.put (Void)
			l_enum_include_paths.ith_item (l_enum_include_paths.count, l_include_path_old)
			replace_include_path ("replaced_include_path3", l_include_path_old.item, l_system_externals)
			display_include_paths (l_system_externals)
			
			put_string ("%N  Replacing intermediate include path:")
			create l_include_path_old.put (Void)
			l_enum_include_paths.ith_item (2, l_include_path_old)
			replace_include_path ("replaced_include_path2", l_include_path_old.item, l_system_externals)
			display_include_paths (l_system_externals)
			
			l_enum_include_paths := l_system_externals.include_paths
			check
				enough_include_paths: l_enum_include_paths.count > 0
			end
			put_string ("%N  Replacing include path with same value:")
			create l_include_path_old.put (Void)
			l_enum_include_paths.ith_item (1, l_include_path_old)
			replace_include_path (l_include_path_old.item, l_include_path_old.item, l_system_externals)
			display_include_paths (l_system_externals)
			
			put_string ("%N  Replacing include path using uppercase value with any value:")
			create l_include_path_old.put (Void)
			l_enum_include_paths.ith_item (1, l_include_path_old)
			l_include_path_old.item.to_upper
			replace_include_path ("upper_cased_include_path", l_include_path_old.item, l_system_externals)
			display_include_paths (l_system_externals)
			
			l_enum_include_paths := l_system_externals.include_paths
			check
				enough_include_paths: l_enum_include_paths.count > 0
			end
			put_string ("%N  Replacing non existent include path with any value:")
			create l_include_path_old.put (Void)
			l_enum_include_paths.ith_item (1, l_include_path_old)
			replace_include_path ("include_path3", "include_path1", l_system_externals)
			display_include_paths (l_system_externals)
			
			put_string ("%N  Replacing include path with empty value:")
			create l_include_path_old.put (Void)
			l_enum_include_paths.ith_item (1, l_include_path_old)
			replace_include_path ("", l_include_path_old.item, l_system_externals)
			display_include_paths (l_system_externals)
			
			put_string ("%N  Replacing include path with void same value:")
			create l_include_path_old.put (Void)
			l_enum_include_paths.ith_item (1, l_include_path_old)
			replace_include_path (Void, l_include_path_old.item, l_system_externals)
			display_include_paths (l_system_externals)
			
			put_string ("%N  Replacing empty include path with empty value:")
			replace_include_path ("", "", l_system_externals)
			display_include_paths (l_system_externals)
			
			put_string ("%N  Replacing void include path with void value:")
			replace_include_path (Void, Void, l_system_externals)
			display_include_paths (l_system_externals)
		end

feature {NONE} -- Implementation

	display_object_files (a_interface: IEIFFEL_SYSTEM_EXTERNALS_INTERFACE) is
			-- display current object files
		require
			non_void_interface: a_interface /= Void
		local
			l_enum_object_files: IENUM_OBJECT_FILES_INTERFACE
			l_index: INTEGER
			l_object_file: CELL[STRING]
		do
			l_enum_object_files := a_interface.object_files
			
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
		
	add_object_file (a_object_file: STRING; a_interface: IEIFFEL_SYSTEM_EXTERNALS_INTERFACE) is
			-- attempt to add an object file
		require
			non_void_interface: a_interface /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N    Adding Object File: '")
				put_string (a_object_file)
				put_string ("'")
				a_interface.add_object_file (a_object_file)
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
		
	remove_object_file (a_object_file: STRING; a_interface: IEIFFEL_SYSTEM_EXTERNALS_INTERFACE) is
			-- attempt to remove an object file
		require
			non_void_interface: a_interface /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N    Removing Object File: '")
				put_string (a_object_file)
				put_string ("'")
				a_interface.remove_object_file (a_object_file)
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
			
	display_include_paths (a_interface: IEIFFEL_SYSTEM_EXTERNALS_INTERFACE) is
			-- display current include paths
		require
			non_void_interface: a_interface /= Void
		local
			l_enum_include_paths: IENUM_INCLUDE_PATHS_INTERFACE
			l_index: INTEGER
			l_include_path: CELL[STRING]
		do
			l_enum_include_paths := a_interface.include_paths
			
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
		
	replace_object_file (new_value, old_value: STRING; a_interface: IEIFFEL_SYSTEM_EXTERNALS_INTERFACE) is
			-- replace an object file 'old_value' with a 'new_value'
		require
			non_void_interface: a_interface /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N    Replacing Object File: '")
				put_string (old_value)
				put_string ("' with '")
				put_string (new_value)
				put_string ("'")
				a_interface.replace_object_file (new_value, old_value)
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
		
	add_include_path (a_include_path: STRING; a_interface: IEIFFEL_SYSTEM_EXTERNALS_INTERFACE) is
			-- attempt to add an include path
		require
			non_void_interface: a_interface /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N    Adding Include Path: '")
				put_string (a_include_path)
				put_string ("'")
				a_interface.add_include_path (a_include_path)
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
		
	remove_include_path (a_include_path: STRING; a_interface: IEIFFEL_SYSTEM_EXTERNALS_INTERFACE) is
			-- attempt to remove an include path
		require
			non_void_interface: a_interface /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N    Removing Include Path: '")
				put_string (a_include_path)
				put_string ("'")
				a_interface.remove_include_path (a_include_path)
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
		
	replace_include_path (new_value, old_value: STRING; a_interface: IEIFFEL_SYSTEM_EXTERNALS_INTERFACE) is
			-- replace an include path 'old_value' with a 'new_value'
		require
			non_void_interface: a_interface /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N    Replacing Include Path: '")
				put_string (old_value)
				put_string ("' with '")
				put_string (new_value)
				put_string ("'")
				a_interface.replace_include_path (new_value, old_value)
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
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("1", "Add external object file [object_file]", agent on_add_external_object_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("2", "Remove external object file", agent on_remove_external_object_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("3", "Replace external object file", agent on_replace_external_object_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("4", "Add external object file [object_file]", agent on_add_external_include_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("5", "Remove external object file", agent on_remove_external_include_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("6", "Replace external include path", agent on_replace_external_include_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("x", "Exit Menu", Void))
			menu.set_return_item (menu.items.last)
		end
		
	menu: CONSOLE_MENU
		
invariant
	non_void_menu: menu /= Void
	
end -- class EXTERNAL_PROPERTIES_TESTER
