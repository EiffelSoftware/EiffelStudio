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

	make is
			-- create tester for completion info
		do
			create menu.make ("Completion Info")
			add_menu_items
			menu.show
		end

feature -- Agent Handlers

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
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("1", "Perform all completion info test", agent on_all_completion_info_test))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("x", "Exit Menu", Void))
			menu.set_return_item (menu.items.last)
		end
		
	menu: CONSOLE_MENU
		
		
invariant
	non_void_menu: menu /= Void

end -- class COMPLETION_INFO_TESTER
