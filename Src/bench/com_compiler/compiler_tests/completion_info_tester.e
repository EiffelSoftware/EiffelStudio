indexing
	description: "Tests compilers completion info features"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPLETION_INFO_TESTER

inherit
	COMPILER_TESTER_SHARED
	
create 
	make
	
feature {NONE} -- Initialization

	make (a_interface: like completion_interface) is
			-- create tester for completion info
		do
			completion_interface := a_interface
			create menu.make ("IEIFFEL_COMPLETION_INFO")
			add_menu_items
			menu.show
		end

feature {NONE} -- Agent Handlers

	on_all_completion_info_test (args: ARRAYED_LIST [STRING]) is
			-- test all completion info related tests with safe recovery from raised exceptions
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_completion_info, args, True, False)
			-- display number of failures
			display_failure_count
		end
		
	test_completion_info (args: ARRAYED_LIST [STRING]) is
			-- test completion info
		require
			non_void_project_manager: project_manager /= Void
		do
			perform_completion_info_tests (project_manager.completion_information)
		end

	on_add_argument_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'add_argument' safely
		do
			test_failure_count := 0
			call_test (agent test_add_argument, args, False, False)
			display_failure_count
		end
		
	test_add_argument (args: ARRAYED_LIST [STRING]) is
			-- test 'add_argument'
		local
			l_arg_name: STRING
			l_arg_type: STRING
		do
			put_string ("%NTesting 'add_argument'")
			put_string ("%N  Enter argument name: ")
			read_line
			l_arg_name := last_string
			put_string ("%N  Enter argument type: ")
			read_line
			l_arg_type := last_string
			add_argument (l_arg_name, l_arg_type)
			put_string ("%N")
		end
		
	on_add_local_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'add_local' safely
		do
			test_failure_count := 0
			call_test (agent test_add_local, args, False, False)
			display_failure_count
		end
		
	test_add_local (args: ARRAYED_LIST [STRING]) is
			-- test 'add_local'
		local
			l_local_name: STRING
			l_local_type: STRING
		do
			put_string ("%NTesting 'add_local'")
			put_string ("%N  Enter local name: ")
			read_line
			l_local_name := last_string
			put_string ("%N  Enter local type: ")
			read_line
			l_local_type := last_string
			add_local (l_local_name, l_local_type)
			put_string ("%N")
		end
		
	on_target_feature_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'target_feature' safely
		do
			test_failure_count := 0
			call_test (agent test_target_feature, args, False, False)
			display_failure_count
		end
		
	test_target_feature (args: ARRAYED_LIST [STRING]) is
			-- test 'target_feature'
		local
			l_target: STRING
			l_feature_name: STRING
			l_file_name: STRING
		do
			put_string ("%NTesting 'target_feature'")
			put_string ("%N  Enter target: ")
			read_line
			l_target := last_string
			put_string ("%N  Enter feature name: ")
			read_line
			l_feature_name := last_string
			put_string ("%N  Enter file name: ")
			read_line
			l_file_name := last_string
			target_feature (l_target, l_feature_name, l_file_name)
			put_string ("%N")
		end
		
	on_target_features_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'target_features' safely
		do
			test_failure_count := 0
			call_test (agent test_target_features, args, False, False)
			display_failure_count
		end
		
	test_target_features (args: ARRAYED_LIST [STRING]) is
			-- test 'target_features'
		local
			l_target: STRING
			l_feature_name: STRING
			l_file_name: STRING
		do
			put_string ("%NTesting 'target_features'")
			put_string ("%N  Enter target: ")
			read_line
			l_target := last_string
			put_string ("%N  Enter feature name: ")
			read_line
			l_feature_name := last_string
			put_string ("%N  Enter file name: ")
			read_line
			l_file_name := last_string
			target_features (l_target, l_feature_name, l_file_name)
			put_string ("%N")
		end
		
feature {NONE} -- Implementation

	perform_completion_info_tests (interface: IEIFFEL_COMPLETION_INFO_INTERFACE) is
			-- Test completion information component.
		local
			entries: IENUM_COMPLETION_ENTRY_INTERFACE
			l_feature: IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE
		do
			interface.add_local ("s", "STRING")
			entries := interface.target_features ("s.", "make", "C:\Documents and Settings\Remote\My Documents\Visual Studio Projects\blank_project6\root_class.e")
			display_entries (entries)
			interface.add_local ("s", "STRING")
			l_feature := interface.target_feature ("s.append_real", "make", "C:\Documents and Settings\Remote\My Documents\Visual Studio Projects\blank_project6\root_class.e")
			display_feature (l_feature)
		end
		
	add_argument (name, type: STRING) is
			--
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing add_argument with '")
				put_string (name)
				put_string ("', '")
				put_string (type)
				put_string ("'")
				completion_interface.add_argument (name, type)
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end
		
	add_local (name, type: STRING) is
			--
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing add_local with '")
				put_string (name)
				put_string ("', '")
				put_string (type)
				put_string ("'")
				completion_interface.add_local (name, type)
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end
		
	target_feature (target, feature_name, file_name: STRING) is
			--
		local
			l_result: IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing target_feature with '")
				put_string (target)
				put_string ("', '")
				put_string (feature_name)
				put_string ("', '")
				put_string (file_name)
				put_string ("'")
				l_result := completion_interface.target_feature (target, feature_name, file_name)
				put_string ("%N    Result=")
				if l_result /= Void then
					display_feature (l_result)
				else
					put_string (Void)
				end
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end
		
	target_features (target, feature_name, file_name: STRING) is
			--
		local
			l_result: IENUM_COMPLETION_ENTRY_INTERFACE
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing target_features with '")
				put_string (target)
				put_string ("', '")
				put_string (feature_name)
				put_string ("', '")
				put_string (file_name)
				put_string ("'")
				l_result := completion_interface.target_features (target, feature_name, file_name)
				put_string ("%N    Result=")
				if l_result /= Void then
					display_entries (l_result)
				else
					put_string (Void)
				end
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Output

	display_entries (entries: IENUM_COMPLETION_ENTRY_INTERFACE) is
			-- Display elements in `entries'.
		local
			i, count: INTEGER
			rgelt: CELL [IEIFFEL_COMPLETION_ENTRY_INTERFACE]
		do
			from
				count := entries.count
				create rgelt.put (Void)
				i := 1
			until
				i > count
			loop
				entries.ith_item (i, rgelt)
				io.put_string ("name: " + rgelt.item.name + "%N")
				io.put_string ("signature: " + rgelt.item.signature + "%N%N")
				i := i + 1
			end
		end
	
	display_feature (l_feature: IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE) is
			-- Display `l_feature'.
		require
			non_void_feature: l_feature /= Void
		local
			params: IENUM_PARAMETER_INTERFACE
			i, count: INTEGER
			rgelt: CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE]
		do
			io.put_string ("feature " + l_feature.name + "%N")
			io.put_string ("signature: " + l_feature.signature + "%N")
			io.put_string ("description: " + l_feature.description + "%N%N")
			params := l_feature.parameters
			count := params.count
			create rgelt.put (Void)
			from
				i := 1
			until
				i > count
			loop
				params.ith_item (i, rgelt)
				io.put_string ("Param " + i.out + " name: " + rgelt.item.name + "%N")
				io.put_string ("Param " + i.out + " display: " + rgelt.item.display + "%N")
				i := i + 1
			end
		end

	add_menu_items is
			-- add menu items to menu
		do
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("1", "Test add_argument", agent on_add_argument_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("2", "Test add_local", agent on_add_local_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("3", "Test target_feature", agent on_target_feature_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("4", "Test target_features", agent on_target_features_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("a", "Perform all completion info test", agent on_all_completion_info_test))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("x", "Exit Menu", Void))
			menu.set_return_item (menu.items.last)
		end
		
	menu: CONSOLE_MENU
		-- menu
		
	completion_interface: IEIFFEL_COMPLETION_INFO_INTERFACE
		-- completion info interface
		
invariant
	non_void_menu: menu /= Void
	non_void_interface: completion_interface /= Void

end -- class COMPLETION_INFO_TESTER
