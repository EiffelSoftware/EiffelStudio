indexing
	description: "Tests IEIFFEL_SYSTEM_CLUSTERS_INTERFACE"
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_CLUSTER_TESTER

inherit
	COMPILER_TESTER_SHARED
	
create 
	make
	
feature {NONE} -- Initialization

	make (a_interface: like system_clusters_interface) is
			-- create tester for completion info
		require
			non_void_interface: a_interface /= Void
		do
			system_clusters_interface := a_interface
			create menu.make ("IEIFFEL_SYSTEM_CLUSTERS_INTERFACE Tests")
			add_menu_items
			menu.show
		end

feature {NONE} -- Agent Handlers

	on_is_valid_name_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'is_valid_name'
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_is_valid_name, args, False, True)
			-- display number of failures
			display_failure_count
		end	
		
	test_is_valid_name (args: ARRAYED_LIST [STRING]) is
			-- test 'is_valid_name'
		do
			put_string ("%NTesting 'is_valid_name'")
			if args /= Void and args.count >= 1 then
				from 
					args.start
				until
					args.after
				loop
					is_valid_name (args.item)
					args.forth
				end
			else
				put_string ("%NEnter cluster name to validate: ")
				read_line 
				is_valid_name (last_string)
			end
		end
		
	on_cluster_properties_by_id_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'cluster_properties_by_id'
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_cluster_properties_by_id, args, False, True)
			-- display number of failures
			display_failure_count
		end	
		
	test_cluster_properties_by_id (args: ARRAYED_LIST [STRING]) is
			-- test 'cluster_properties_by_id'
		local
			l_enum_clusters: IENUM_CLUSTER_PROP_INTERFACE
			l_cluster: CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE]
			l_index: INTEGER
		do
			put_string ("%NTesting 'cluster_properties_by_id'")
			from
				l_enum_clusters := system_clusters_interface.flat_clusters
				l_index := 1
			until
				l_index > l_enum_clusters.count
			loop
				create l_cluster.put (Void)
				l_enum_clusters.ith_item (l_index, l_cluster)
				put_string ("%N  (" + l_cluster.item.cluster_id.out + ") ")
				put_string (l_cluster.item.name)
				l_index := l_index + 1
			end
			put_string ("%N  Choose cluster id: ")
			read_line
			if last_string /= Void then
				if last_string.is_integer then
					cluster_properties_by_id (last_string.to_integer)
				end
			else
				cluster_properties_by_id (Void)
			end
			put_string ("%N")
		end
		
	on_cluster_properties_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'cluster_properties'
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_cluster_properties, args, False, True)
			-- display number of failures
			display_failure_count
		end	
		
	test_cluster_properties (args: ARRAYED_LIST [STRING]) is
			-- test 'cluster_properties'
		local
			l_enum_clusters: IENUM_CLUSTER_PROP_INTERFACE
			l_cluster: CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE]
			l_index: INTEGER
		do
			put_string ("%NTesting 'cluster_properties'")
			from
				l_enum_clusters := system_clusters_interface.flat_clusters
				l_index := 1
			until
				l_index > l_enum_clusters.count
			loop
				create l_cluster.put (Void)
				l_enum_clusters.ith_item (l_index, l_cluster)
				put_string ("%N  (" + l_cluster.item.name + ") ")
				put_string (l_cluster.item.cluster_path)
				l_index := l_index + 1
			end
			put_string ("%N  Choose cluster name: ")
			read_line
			cluster_properties (last_string)
			put_string ("%N")
		end
		
	on_get_cluster_fullname_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'get_cluster_fullname'
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_get_cluster_fullname, args, False, True)
			-- display number of failures
			display_failure_count
		end	
		
	test_get_cluster_fullname (args: ARRAYED_LIST [STRING]) is
			-- test 'get_cluster_fullname'
		local
			l_enum_clusters: IENUM_CLUSTER_PROP_INTERFACE
			l_cluster: CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE]
			l_index: INTEGER
		do
			put_string ("%NTesting 'get_cluster_fullname'")
			from
				l_enum_clusters := system_clusters_interface.flat_clusters
				l_index := 1
			until
				l_index > l_enum_clusters.count
			loop
				create l_cluster.put (Void)
				l_enum_clusters.ith_item (l_index, l_cluster)
				put_string ("%N  (" + l_cluster.item.name + ") ")
				put_string (l_cluster.item.cluster_id.out)
				l_index := l_index + 1
			end
			put_string ("%N  Choose cluster name: ")
			read_line
			get_cluster_fullname (last_string)
			put_string ("%N")
		end
		
	on_change_cluster_name_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'change_cluster_name'
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_change_cluster_name, args, False, True)
			-- display number of failures
			display_failure_count
		end	
		
	test_change_cluster_name (args: ARRAYED_LIST [STRING]) is
			-- test 'change_cluster_name'
		local
			l_enum_clusters: IENUM_CLUSTER_PROP_INTERFACE
			l_cluster: CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE]
			l_index: INTEGER
			l_old_cluster_name: STRING
		do
			put_string ("%NTesting 'get_cluster_fullname'")
			from
				l_enum_clusters := system_clusters_interface.flat_clusters
				l_index := 1
			until
				l_index > l_enum_clusters.count
			loop
				create l_cluster.put (Void)
				l_enum_clusters.ith_item (l_index, l_cluster)
				put_string ("%N  (" + l_cluster.item.name + ") ")
				put_string (l_cluster.item.cluster_id.out)
				l_index := l_index + 1
			end
			put_string ("%N  Choose cluster name: ")
			read_line
			l_old_cluster_name := last_string.clone (last_string)
			put_string ("%N  Change cluster name to: ")
			read_line
			change_cluster_name (last_string, l_old_cluster_name)
			put_string ("%N")
			display_clusters
		end
		
	on_flat_clusters_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'flat_clusters'
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_flat_clusters, args, False, True)
			-- display number of failures
			display_failure_count
		end	
		
	test_flat_clusters (args: ARRAYED_LIST [STRING]) is
			-- test 'test_flat_clusters'
		do
			put_string ("%NTesting 'test_flat_clusters'")
			display_clusters
		end
		
	on_cluster_tree_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'cluster_tree'
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_cluster_tree, args, False, True)
			-- display number of failures
			display_failure_count
		end	
		
	test_cluster_tree (args: ARRAYED_LIST [STRING]) is
			-- test 'cluster_tree'
		local
			l_enum_clusters: IENUM_CLUSTER_PROP_INTERFACE
			l_cluster: CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE]
			l_index: INTEGER
		do
			put_string ("%NTesting 'cluster_tree'")
			from
				l_enum_clusters := system_clusters_interface.cluster_tree
				l_index := 1
			until
				l_index > l_enum_clusters.count
			loop
				create l_cluster.put (Void)
				l_enum_clusters.ith_item (l_index, l_cluster)
				put_string ("%N  ")
				put_string (l_cluster.item.name)
				put_string (" - ")
				put_string (l_cluster.item.cluster_path)
				l_index := l_index + 1
			end
			put_string ("%N")
		end
		
	on_add_cluster_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'flat_clusters'
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_add_cluster, args, False, True)
			-- display number of failures
			display_failure_count
		end	
		
	test_add_cluster (args: ARRAYED_LIST [STRING]) is
			-- test 'test_flat_clusters'
		local
			l_cluster_name: STRING
			l_cluster_parent: STRING
			l_cluster_path: STRING
		do
			put_string ("%NTesting 'add_cluster'")
			put_string ("%NEnter cluster name: ")
			read_line
			l_cluster_name := last_string
			put_string ("%NCluster parent:")
			read_line
			l_cluster_parent := last_string
			put_string ("%NCluster path:")
			read_line
			l_cluster_path := last_string
			add_cluster (l_cluster_name, l_cluster_parent, l_cluster_path)
			display_clusters
			put_string ("%N")
		end
		
	on_remove_cluster_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'remove_cluster'
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_remove_cluster, args, False, True)
			-- display number of failures
			display_failure_count
		end	
		
	test_remove_cluster (args: ARRAYED_LIST [STRING]) is
			-- test 'remove_cluster'
		local
			l_cluster_name: STRING
		do
			put_string ("%NTesting 'remove_cluster'")
			display_clusters
			put_string ("%NEnter cluster name to remove: ")
			read_line
			l_cluster_name := last_string
			remove_cluster (l_cluster_name)
			display_clusters
			put_string ("%N")
		end
		
	on_test_cluster_properties_menu_selected (args: ARRAYED_LIST [STRING]) is
			-- test cluster properties
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_cluster_properties_menu, args, False, True)
			-- display number of failures
			display_failure_count
		end
		
	test_cluster_properties_menu (args: ARRAYED_LIST [STRING]) is
			-- create cluster properties menu
		local
			l_tests: CLUSTER_PROPERTIES_TESTER
			l_enum_clusters: IENUM_CLUSTER_PROP_INTERFACE
			l_cluster: CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE]
			l_index: INTEGER
		do
			from
				l_enum_clusters := system_clusters_interface.flat_clusters
				l_index := 1
			until
				l_index > l_enum_clusters.count
			loop
				create l_cluster.put (Void)
				l_enum_clusters.ith_item (l_index, l_cluster)
				put_string ("%N  (" + l_cluster.item.cluster_id.out + ") ")
				put_string (l_cluster.item.name)
				l_index := l_index + 1
			end
			put_string ("%N  Choose cluster id: ")
			read_line
			if not last_string.is_empty then
				create l_tests.make (system_clusters_interface.cluster_properties_by_id (last_string.to_integer))
			end
		end
		
	on_store_selected (args: ARRAYED_LIST [STRING]) is
			-- safley test 'store'
		do
			test_failure_count := 0
			call_test (agent test_store, args, False, True)
			display_failure_count
		end
		
	test_store (args: ARRAYED_LIST [STRING]) is
			-- test 'store'
		do
			put_string ("%NTesting store")
			system_clusters_interface.store
		end
		
feature {NONE} -- Output

	display_clusters is
			-- display a list of clusters currently held in memeory
		local
			l_enum_clusters: IENUM_CLUSTER_PROP_INTERFACE
			l_cluster: CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE]
			l_index: INTEGER
		do
			put_string ("%N  Current Clusters")
			from
				l_enum_clusters := system_clusters_interface.flat_clusters
				l_index := 1
			until
				l_index > l_enum_clusters.count
			loop
				create l_cluster.put (Void)
				l_enum_clusters.ith_item (l_index, l_cluster)
				put_string ("%N    ")
				put_string (l_cluster.item.name)
				put_string (" (")
				put_string (l_cluster.item.parent_name)
				put_string (") - ")
				put_string (l_cluster.item.cluster_path)
				l_index := l_index + 1
			end
			put_string ("%N")
		end
			
		
feature {NONE} -- Implementation

	is_valid_name (a_cluster_name: STRING) is
			-- test 'a_cluster_name' with 'is_valid_name'
		local
			retried: BOOLEAN
			l_result: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing is_valid with '")
				put_string (a_cluster_name)
				put_string ("'")
				if a_cluster_name.is_equal ("void") then
					l_result := system_clusters_interface.is_valid_name (Void)
				else
					l_result := system_clusters_interface.is_valid_name (a_cluster_name)					
				end
				put_string ("%N    Result=")
				put_bool (l_result)
			else
				test_failure_count := test_failure_count + 1
				put_string ("%N# Failed%N")
			end
		rescue
			retried := True
			retry
		end
		
	cluster_properties_by_id (a_cluster_id: INTEGER) is
			-- test 'a_cluster_id' with 'cluster_properties_by_id'
		local
			retried: BOOLEAN
			l_result: IEIFFEL_CLUSTER_PROPERTIES_INTERFACE
		do
			if not retried then
				put_string ("%N  Testing cluster_properties_by_id with '")
				put_int (a_cluster_id)
				put_string ("'")
				l_result := system_clusters_interface.cluster_properties_by_id (a_cluster_id)
				put_string ("%N    Result=")
				if l_result = Void then
					put_string (Void)
				else
					put_string (l_result.name)
				end
			else
				test_failure_count := test_failure_count + 1
				put_string ("%N# Failed%N")
			end
		rescue
			retried := True
			retry
		end
		
	cluster_properties (a_cluster_name: STRING) is
			-- test 'a_cluster_name' with 'cluster_properties'
		local
			retried: BOOLEAN
			l_result: IEIFFEL_CLUSTER_PROPERTIES_INTERFACE
		do
			if not retried then
				put_string ("%N  Testing cluster_properties with '")
				put_string (a_cluster_name)
				put_string ("'")
				l_result := system_clusters_interface.cluster_properties (a_cluster_name)
				put_string ("%N    Result=")
				if l_result = Void then
					put_string (Void)
				else
					put_string (l_result.cluster_path)
				end
			else
				test_failure_count := test_failure_count + 1
				put_string ("%N# Failed%N")
			end
		rescue
			retried := True
			retry
		end
		
	get_cluster_fullname (a_cluster_name: STRING) is
			-- test 'a_cluster_name' with 'get_cluster_fullname'
		local
			retried: BOOLEAN
			l_result: STRING
		do
			if not retried then
				put_string ("%N  Testing get_cluster_fullname with '")
				put_string (a_cluster_name)
				put_string ("'")
				l_result := system_clusters_interface.get_cluster_fullname (a_cluster_name)
				put_string ("%N    Result=")
				put_string (l_result)
			else
				test_failure_count := test_failure_count + 1
				put_string ("%N# Failed%N")
			end
		rescue
			retried := True
			retry
		end
		
	change_cluster_name (a_new_cluster_name, a_cluster_name: STRING) is
			-- test 'change_cluster_name' with 'a_new_cluster_name' and 'a_cluster_name'
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing change_cluster_name from '")
				put_string (a_cluster_name)
				put_string ("' to '")
				put_string (a_new_cluster_name)
				put_string ("'")
				system_clusters_interface.change_cluster_name (a_cluster_name, a_new_cluster_name)
			else
				test_failure_count := test_failure_count + 1
				put_string ("%N# Failed%N")
			end
		rescue
			retried := True
			retry
		end
		
	add_cluster (a_cluster_name, a_cluster_parent, a_cluster_path: STRING) is
			-- test 'change_cluster_name' with 'a_new_cluster_name' and 'a_cluster_name'
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing add_cluster with '")
				put_string (a_cluster_name)
				put_string ("', '")
				put_string (a_cluster_parent)
				put_string ("' and '")
				put_string (a_cluster_path)
				put_string ("'")
				system_clusters_interface.add_cluster (a_cluster_name, a_cluster_parent, a_cluster_path)
			else
				test_failure_count := test_failure_count + 1
				put_string ("%N# Failed%N")
			end
		rescue
			retried := True
			retry
		end
		
	remove_cluster (a_cluster_name: STRING) is
			-- test 'remove_cluster' with 'a_cluster_name'
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing remove_cluster with '")
				put_string (a_cluster_name)
				put_string ("'")
				system_clusters_interface.remove_cluster (a_cluster_name)
			else
				test_failure_count := test_failure_count + 1
				put_string ("%N# Failed%N")
			end
		rescue
			retried := True
			retry
		end

	add_menu_items is
			-- add menu items to menu
		do
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("1", "Test add_cluster", agent on_add_cluster_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("2", "Test change_cluster_name", agent on_change_cluster_name_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("3", "Test cluster_properties", agent on_cluster_properties_selected))			
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("4", "Test cluster_properties_by_id", agent on_cluster_properties_by_id_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("5", "Test clusters_tree", agent on_cluster_tree_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("6", "Test get_cluster_fullname", agent on_get_cluster_fullname_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("7", "Test flat_clusters", agent on_flat_clusters_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("8", "Test is_valid_name", agent on_is_valid_name_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("9", "Test remove_cluster", agent on_remove_cluster_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("10", "Test Cluster Properties with new cluster", agent on_test_cluster_properties_menu_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("s", "Store", agent on_store_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("x", "Exit Menu", Void))
			menu.set_return_item (menu.items.last)
		end
		
	menu: CONSOLE_MENU
		-- menu
		
	system_clusters_interface: IEIFFEL_SYSTEM_CLUSTERS_INTERFACE
		-- SYSTEM_CLUSTERS interface
		
invariant
	non_void_menu: menu /= Void
	non_void_interace: system_clusters_interface /= Void
	
end -- class SYSTEM_CLUSTER_TESTER
