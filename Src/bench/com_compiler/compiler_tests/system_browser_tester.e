indexing
	description: "Tests IEIFFEL_SYSTEM_BROWSER_INTERFACE"
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_BROWSER_TESTER

inherit
	COMPILER_TESTER_SHARED
	
create 
	make
	
feature {NONE} -- Initialization

	make (a_interface: IEIFFEL_SYSTEM_BROWSER_INTERFACE) is
			-- create tester for IEIFFEL_SYSTEM_BROWSER_INTERFACE interface
		do
			browser_interface := a_interface
			create menu.make ("IEIFFEL_SYSTEM_BROWSER_INTERFACE Tests")
			add_menu_items
			menu.show
		end

feature {NONE} -- Agent Handlers

	on_assemblies_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'assemblies' safely
		do
			test_failure_count := 0
			call_test (agent test_assemblies, args, False, False)
			display_failure_count
		end
		
	test_assemblies (args: ARRAYED_LIST [STRING]) is
			-- test 'assemblies'
		do
			put_string ("%NTesting 'assemblies'")
			assemblies
		end
		
	on_external_clusters_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'external_clusters' safely
		do
			test_failure_count := 0
			call_test (agent test_external_clusters, args, False, False)
			display_failure_count
		end
		
	test_external_clusters (args: ARRAYED_LIST [STRING]) is
			-- test 'external_clusters'
		do
			put_string ("%NTesting 'external_clusters'")
			external_clusters
		end
		
	on_system_classes_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'system_classes' safely
		do
			test_failure_count := 0
			call_test (agent test_system_classes, args, False, False)
			display_failure_count
		end
		
	test_system_classes (args: ARRAYED_LIST [STRING]) is
			-- test 'system_classes'
		do
			put_string ("%NTesting 'system_classes'")
			system_classes
		end
		
	on_system_clusters_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'system_clusters' safely
		do
			test_failure_count := 0
			call_test (agent test_system_clusters, args, False, False)
			display_failure_count
		end
		
	test_system_clusters (args: ARRAYED_LIST [STRING]) is
			-- test 'system_clusters'
		do
			put_string ("%NTesting 'system_clusters'")
			system_clusters
		end
		
	on_class_descriptor_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'class_descriptor' safely
		do
			test_failure_count := 0
			call_test (agent test_class_descriptor, args, False, False)
			display_failure_count
		end
		
	test_class_descriptor (args: ARRAYED_LIST [STRING]) is
			-- test 'class_descriptor'
		do
			put_string ("%NTesting 'class_descriptor'")
			put_string ("%N  Enter class name:")
			read_line
			class_descriptor (last_string)
		end
		
	on_search_classes_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'search_classes' safely
		do
			test_failure_count := 0
			call_test (agent test_search_classes, args, False, False)
			display_failure_count
		end
		
	test_search_classes (args: ARRAYED_LIST [STRING]) is
			-- test 'search_classes'
		local
			l_class_name: STRING
			l_sub_string: BOOLEAN
		do
			put_string ("%NTesting 'search_classes'")
			put_string ("%N  Enter class name:")
			read_line
			l_class_name := last_string
			--search_classes 
		end
		
	on_search_features_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'search_features' safely
		do
			test_failure_count := 0
			call_test (agent test_search_features, args, False, False)
			display_failure_count
		end
		
	test_search_features (args: ARRAYED_LIST [STRING]) is
			-- test 'search_features'
		do
			put_string ("%NTesting 'search_features'")
			--search_features
		end
		
	on_feature_descriptor_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'feature_descriptor' safely
		do
			test_failure_count := 0
			call_test (agent test_feature_descriptor, args, False, False)
			display_failure_count
		end
		
	test_feature_descriptor (args: ARRAYED_LIST [STRING]) is
			-- test 'feature_descriptor'
		do
			put_string ("%NTesting 'feature_descriptor'")
			--feature_descriptor
		end
		
	on_cluster_descriptor_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'cluster_descriptor' safely
		do
			test_failure_count := 0
			call_test (agent test_cluster_descriptor, args, False, False)
			display_failure_count
		end
		
	test_cluster_descriptor (args: ARRAYED_LIST [STRING]) is
			-- test 'cluster_descriptor'
		do
			put_string ("%NTesting 'cluster_descriptor'")
			--cluster_descriptor
		end
		
	on_description_from_dotnet_feature_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'description_from_dotnet_feature' safely
		do
			test_failure_count := 0
			call_test (agent test_description_from_dotnet_feature, args, False, False)
			display_failure_count
		end
		
	test_description_from_dotnet_feature (args: ARRAYED_LIST [STRING]) is
			-- test 'description_from_dotnet_feature'
		do
			put_string ("%NTesting 'description_from_dotnet_feature'")
		--	description_from_dotnet_feature
		end
		
	on_description_from_dotnet_type_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'description_from_dotnet_type' safely
		do
			test_failure_count := 0
			call_test (agent test_description_from_dotnet_type, args, False, False)
			display_failure_count
		end
		
	test_description_from_dotnet_type (args: ARRAYED_LIST [STRING]) is
			-- test 'description_from_dotnet_type'
		do
			put_string ("%NTesting 'description_from_dotnet_type'")
		--	description_from_dotnet_type
		end
		
	on_display_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'display' safely
		do
			test_failure_count := 0
			call_test (agent test_display, args, False, False)
			display_failure_count
		end
		
	test_display (args: ARRAYED_LIST [STRING]) is
			-- test 'display'
		do
			display_current_properties
		end

feature {NONE} -- Output

	display_current_properties is
			-- display 'browser_interface' current properties
		do
			put_string ("%N  Current Properties")
			put_string ("%N    root_cluster=")
			if browser_interface.root_cluster /= Void then
				put_string (browser_interface.root_cluster.name)
			else
				put_string (Void)
			end
			put_string ("%N    class_count=")
			put_int (browser_interface.class_count)
			put_string ("%N    cluster_count=")
			put_int (browser_interface.cluster_count)
			put_string ("%N")
		end

feature {NONE} -- Implementation

	assemblies is
			-- display all assemblies in project
		local
			l_assemblies: IENUM_ASSEMBLY_INTERFACE
			l_assembly: CELL [IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE]
			l_index: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Current Assemblies:")
				l_assemblies := browser_interface.assemblies
				if l_assemblies /= Void then
					if l_assemblies.count > 0 then
						from
							l_index := 1
						until
							l_index > l_assemblies.count
						loop
							put_string ("%N    ")
							create l_assembly.put (Void)
							l_assemblies.ith_item (l_index, l_assembly)
							put_string (l_assembly.item.assembly_name)
							l_index := l_index + 1
						end
					else
						put_string ("%N    <NONE>")
					end
				else
					put_string ("%N    Void List")
				end
			else
				put_string ("%N# Failed!")
			end
		end
		
	external_clusters is
			--
		do
		end
		
	system_classes is
			--
		do
		end
		
	system_clusters is
			--
		do
		end
		
	class_descriptor (class_name1: STRING) is
			--
		do
			--Result :=
		end
		
	search_classes (a_string: STRING; is_substring: BOOLEAN) is
			--
		do
			--Result :=
		end
		
	search_features (a_string: STRING; is_substring: BOOLEAN) is
			--
		do
			--Result :=
		end
		
	feature_descriptor (class_name1, feature_name: STRING) is
			--
		do
			--Result :=
		end
		
	cluster_descriptor (cluster_name: STRING) is
			--
		do
			--Result :=
		end
		
	description_from_dotnet_feature (a_assembly_name, a_full_dotnet_type, a_feature_signature: STRING) is
			--
		do
			--Result :=
		end
		
	description_from_dotnet_type (a_assembly_name, a_full_dotnet_type: STRING) is
			--
		do
			--Result :=
		end
		
	add_menu_items is
			-- add menu items to menu
		require
			non_void_menu: menu /= Void
		do
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("1", "Test assemblies", agent on_assemblies_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("2", "Test external_clusters", agent on_external_clusters_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("3", "Test system_classes", agent on_system_classes_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("4", "Test system_clusters", agent on_system_clusters_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("5", "Test class_descriptor", agent on_class_descriptor_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("6", "Test search_classes", agent on_search_classes_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("7", "Test search_features", agent on_search_features_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("8", "Test feature_descriptor", agent on_feature_descriptor_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("9", "Test cluster_descriptor", agent on_cluster_descriptor_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("10", "Test description_from_dotnet_feature", agent on_description_from_dotnet_feature_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("11", "Test description_from_dotnet_type", agent on_description_from_dotnet_type_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("d", "Display Current Properties", agent on_display_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("x", "Exit Menu", Void))
			menu.set_return_item (menu.items.last)
		end
		
	menu: CONSOLE_MENU
		-- menu
		
	browser_interface: IEIFFEL_SYSTEM_BROWSER_INTERFACE
		-- IEIFFEL_browser_interface interface
		
invariant
	non_void_menu: menu /= Void
	non_void_interace: browser_interface /= Void

end -- class SYSTEM_BROWSER_TESTER