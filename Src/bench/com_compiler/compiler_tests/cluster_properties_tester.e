indexing
	description: "Tests IEIFFEL_CLUSTER_PROPERTIES_INTERFACE"
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_PROPERTIES_TESTER

inherit
	COMPILER_TESTER_SHARED
		export
			{NONE} all
		end
	
create 
	make
	
feature {NONE} -- Initialization

	make (a_interface: like cluster_properties_interface) is
			-- create tester for IEIFFEL_CLUSTER_PROPERTIES_INTERFACE
		require
			non_void_interface: a_interface /= Void
		do
			cluster_properties_interface := a_interface
			create menu.make ("IEIFFEL_CLUSTER_PROPERTIES_INTERFACE Tests")
			add_menu_items
			menu.show
		end
		
feature {NONE} -- Agent Handlers

	on_all_properties_selected (args: ARRAYED_LIST [STRING]) is
			--
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_all_properties, args, False, True)
			-- display number of failures
			display_failure_count
		end
		
	test_all_properties (args: ARRAYED_LIST [STRING]) is
			--
		do
			put_string ("%NTesting All Properties%N")
			test_string ("Name", agent cluster_properties_interface.name, Void, <<>>)
			--test_bool ("has_children", agent cluster_properties_interface.has_children, Void, Void)
			--test_bool ("has_par", agent cluster_properties_interface.has_children, Void, Void)
			--test_string ("Namespace", agent cluster_properties_interface.cluster_namespace, agent cluster_properties_interface.set_cluster_namespace, <<"Valid.Name_Space", "1InvalidNamespace", "_invalidnamespace", "invalid name space", "", Void>>)
			--test_string ("Cluster Path", agent cluster_properties_interface.cluster_path, agent cluster_properties_interface.set_cluster_path, <<"$avalid\path", "invalid_patu/sd", "", Void>>)
			--test_string ("Expanded Cluster Path", agent cluster_properties_interface.expanded_cluster_path, agent cluster_properties_interface.set_cluster_path, <<"$ISE_EIFFEL\path", "$(ISE_EIFFEL)\path", "path$ISE_EIFFEL\path", "path$(ISE_EIFFEL)\path", "$ISE_EIFFEL", "$(ISE_EIFFEL)", "$ISE_EIFFEL$EIFFEL_SRC">>)
		end
		
	on_has_parent_selected (args: ARRAYED_LIST [STRING]) is
			-- safley test 'has_parent'
		do
			test_failure_count := 0
			call_test (agent test_has_parent, args, False, True)
			display_failure_count
		end
		
	test_has_parent (args: ARRAYED_LIST [STRING]) is
			-- test 'parent_name'
		do
			put_string ("%NTesting has_parent:")
			put_string ("%N  has_parent=")
			put_bool (cluster_properties_interface.has_parent)
		end
		
	on_cluster_namespace_selected (args: ARRAYED_LIST [STRING]) is
			-- safley test 'cluster_namespace'
		do
			test_failure_count := 0
			cache_current_properties
			call_test (agent test_cluster_namespace, args, False, True)
			diff_cluster_properties
			display_failure_count
		end
		
	test_cluster_namespace (args: ARRAYED_LIST [STRING]) is
			-- test 'cluster_namespace'
		do
			put_string ("%NTesting cluster_namespace")
			put_string ("%Ncluster_namespace=")
			put_string (cluster_properties_interface.cluster_namespace)
			put_string ("%NSet cluster_namespace to: ")
			read_line
			put_string ("%NSetting cluster_namespace to:")
			put_string (last_string)
			cluster_properties_interface.set_cluster_namespace (last_string)
		end
		
	on_cluster_path_selected (args: ARRAYED_LIST [STRING]) is
			-- safley test 'cluster_path'
		do
			test_failure_count := 0
			cache_current_properties
			call_test (agent test_cluster_path, args, False, True)
			diff_cluster_properties
			display_failure_count
		end
		
	test_cluster_path (args: ARRAYED_LIST [STRING]) is
			-- test 'cluster_path'
		do
			put_string ("%NTesting cluster_path")
			put_string ("%Ncluster_path=")
			put_string (cluster_properties_interface.cluster_path)
			put_string ("%NSet cluster_path to: ")
			read_line
			put_string ("%NSetting cluster_path to:")
			put_string (last_string)
			cluster_properties_interface.set_cluster_path (last_string)
		end
		
	on_override_selected (args: ARRAYED_LIST [STRING]) is
			-- safley test 'override'
		do
			test_failure_count := 0
			cache_current_properties
			call_test (agent test_override, args, False, True)
			diff_cluster_properties
			display_failure_count
		end
		
	test_override (args: ARRAYED_LIST [STRING]) is
			-- test 'override'
		do
			put_string ("%NTesting override")
			put_string ("%Noverride=")
			put_bool (cluster_properties_interface.override)
			put_string ("%NSet override to: ")
			read_line
			put_string ("%NSetting override to:")
			put_string (last_string)
			if last_string.is_boolean then
				cluster_properties_interface.set_override (last_string.to_boolean)
			end
		end
		
	on_is_library_selected (args: ARRAYED_LIST [STRING]) is
			-- safley test 'is_library'
		do
			test_failure_count := 0
			cache_current_properties
			call_test (agent test_is_library, args, False, True)
			diff_cluster_properties
			display_failure_count
		end
		
	test_is_library (args: ARRAYED_LIST [STRING]) is
			-- test 'is_library'
		do
			put_string ("%NTesting is_library")
			put_string ("%Nis_library=")
			put_bool (cluster_properties_interface.is_library)
			put_string ("%NSet is_library to: ")
			read_line
			put_string ("%NSetting is_library to:")
			put_string (last_string)
			if last_string.is_boolean then
				cluster_properties_interface.set_is_library (last_string.to_boolean)
			end
		end
		
	on_all1_selected (args: ARRAYED_LIST [STRING]) is
			-- safley test 'all1'
		do
			test_failure_count := 0
			cache_current_properties
			call_test (agent test_all1, args, False, True)
			diff_cluster_properties
			display_failure_count
		end
		
	test_all1 (args: ARRAYED_LIST [STRING]) is
			-- test 'all1'
		do
			put_string ("%NTesting all1")
			put_string ("%Nall=")
			put_bool (cluster_properties_interface.all1)
			put_string ("%NSet all to: ")
			read_line
			put_string ("%NSetting all1 to:")
			put_string (last_string)
			if last_string.is_boolean then
				cluster_properties_interface.set_all (last_string.to_boolean)
			end
		end
		
	on_use_system_default_selected (args: ARRAYED_LIST [STRING]) is
			-- safley test 'use_system_default'
		do
			test_failure_count := 0
			cache_current_properties
			call_test (agent test_use_system_default, args, False, True)
			diff_cluster_properties
			display_failure_count
		end
		
	test_use_system_default (args: ARRAYED_LIST [STRING]) is
			-- test 'use_system_default'
		do
			put_string ("%NTesting use_system_default")
			put_string ("%Nuse_system_default=")
			put_bool (cluster_properties_interface.use_system_default)
			put_string ("%NSet use_system_default to: ")
			read_line
			put_string ("%NSetting use_system_default to:")
			put_string (last_string)
			if last_string.is_boolean then
				cluster_properties_interface.set_use_system_default (last_string.to_boolean)
			end
		end
		
	on_assertions_selected (args: ARRAYED_LIST [STRING]) is
			-- safley test 'assertions'
		do
			test_failure_count := 0
			cache_current_properties
			call_test (agent test_assertions, args, False, True)
			diff_cluster_properties
			display_failure_count
		end
		
	test_assertions (args: ARRAYED_LIST [STRING]) is
			-- test 'assertions'
		local
			l_check: BOOLEAN
			l_ensure: BOOLEAN
			l_invariant: BOOLEAN
			l_loop: BOOLEAN
			l_require: BOOLEAN
		do
			put_string ("%NTesting assertions")
			put_string ("%Nassertions=")
			if cluster_properties_interface.evaluate_check_by_default then
				put_string ("Check ")	
			end
			if cluster_properties_interface.evaluate_ensure_by_default then
				put_string ("Ensure ")	
			end
			if cluster_properties_interface.evaluate_invariant_by_default then
				put_string ("Invariant ")	
			end
			if cluster_properties_interface.evaluate_loop_by_default then
				put_string ("Loop ")	
			end
			if cluster_properties_interface.evaluate_require_by_default then
				put_string ("Require")	
			end
			put_string ("%NSet assertions to: %N")
			put_string ("Check: ")
			read_line
			l_check := last_string.is_boolean				
			put_string ("Ensure: ")
			read_line
			l_ensure := last_string.is_boolean
			put_string ("Invariant: ")
			read_line
			l_invariant := last_string.is_boolean
			put_string ("Loop: ")
			read_line
			l_loop := last_string.is_boolean
			put_string ("Require: ")
			read_line
			l_require := last_string.is_boolean
			cluster_properties_interface.set_assertions (l_check, l_require, l_ensure, l_loop, l_invariant)
		end
		
	on_add_exclude_selected (args: ARRAYED_LIST [STRING]) is
			-- safley test 'add_exclude'
		do
			test_failure_count := 0
			cache_current_properties
			call_test (agent test_add_exclude, args, False, True)
			diff_cluster_properties
			display_failure_count
		end
		
	test_add_exclude (args: ARRAYED_LIST [STRING]) is
			-- test 'add_exclude'
		do
			put_string ("%NTesting test_add_exclude")
			display_excludes
			put_string ("%NEnter new exclude: ")
			read_line
			put_string ("%NAdding exclude: ")
			put_string (last_string)
			cluster_properties_interface.add_exclude (last_string)
			display_excludes
		end
		
	on_remove_exclude_selected (args: ARRAYED_LIST [STRING]) is
			-- safley test 'remove_exclude'
		do
			test_failure_count := 0
			cache_current_properties
			call_test (agent test_remove_exclude, args, False, True)
			diff_cluster_properties
			display_failure_count
		end
		
	test_remove_exclude (args: ARRAYED_LIST [STRING]) is
			-- test 'remove_exclude'
		do
			put_string ("%NTesting test_add_exclude")
			display_excludes
			put_string ("%NEnter exclude to remove: ")
			read_line
			put_string ("%NRemovong exclude: ")
			put_string (last_string)
			cluster_properties_interface.remove_exclude (last_string)
			display_excludes
		end
		
feature {NONE} -- Output

	on_display_selected (args: ARRAYED_LIST [STRING])  is
			-- display all of a clusters properties
		do
			put_string ("%NAll Cluster Property Values")
			put_string ("%N  name: ")
			put_string (cluster_properties_interface.name)
			put_string ("%N  cluster_id: ")
			put_int (cluster_properties_interface.cluster_id)
			put_string ("%N  cluster_path: ")
			put_string (cluster_properties_interface.cluster_path)
			put_string ("%N  expanded_cluster_path: ")
			put_string (cluster_properties_interface.expanded_cluster_path)
			put_string ("%N  cluster_namespace: ")
			put_string (cluster_properties_interface.cluster_namespace)
			put_string ("%N  parent_name: ")
			put_string (cluster_properties_interface.parent_name)
			put_string ("%N  all1: ")
			put_bool (cluster_properties_interface.all1)
			put_string ("%N  is_eiffel_library: ")
			put_bool (cluster_properties_interface.is_eiffel_library)
			put_string ("%N  is_library: ")
			put_bool (cluster_properties_interface.is_library)
			put_string ("%N  override: ")
			put_bool (cluster_properties_interface.override)
			put_string ("%N  evaluate_check_by_default: ")
			put_bool (cluster_properties_interface.evaluate_check_by_default)
			put_string ("%N  evaluate_ensure_by_default: ")
			put_bool (cluster_properties_interface.evaluate_ensure_by_default)
			put_string ("%N  evaluate_invariant_by_default: ")
			put_bool (cluster_properties_interface.evaluate_invariant_by_default)
			put_string ("%N  evaluate_loop_by_default: ")
			put_bool (cluster_properties_interface.evaluate_loop_by_default)
			put_string ("%N  evaluate_require_by_default: ")
			put_bool (cluster_properties_interface.evaluate_require_by_default)
			put_string ("%N  has_children: ")
			put_bool (cluster_properties_interface.has_children)
			put_string ("%N  has_parent: ")
			put_bool (cluster_properties_interface.has_parent)
			put_string ("%N  use_system_default: ")
			put_bool (cluster_properties_interface.use_system_default)
			display_excludes
			display_sub_clusters
			put_string ("%N")
		end
		
	diff_cluster_properties is
			-- display all of a clusters properties
		require
			cache_called: cached_called
		do
			put_string ("%N  Diff Cluster Property Values")
			if not cluster_properties_interface.name.is_equal (name) then
				put_string ("%N    name: ")
				put_string (name)				
				put_string (" -> ")
				put_string (cluster_properties_interface.name)				
			end
			if cluster_properties_interface.cluster_id /= cluster_id then
				put_string ("%N    cluster_id: ")
				put_int (cluster_id)				
				put_string (" -> ")
				put_int (cluster_properties_interface.cluster_id)				
			end
			if not cluster_properties_interface.cluster_path.is_equal (cluster_path) then
				put_string ("%N    cluster_path: ")
				put_string (cluster_path)				
				put_string (" -> ")
				put_string (cluster_properties_interface.cluster_path)				
			end
			if not cluster_properties_interface.expanded_cluster_path.is_equal (expanded_cluster_path) then
				put_string ("%N    expanded_cluster_path: ")
				put_string (expanded_cluster_path)				
				put_string (" -> ")
				put_string (cluster_properties_interface.expanded_cluster_path)				
			end
			if not cluster_properties_interface.cluster_namespace.is_equal (cluster_namespace) then
				put_string ("%N    cluster_namespace: ")
				put_string (cluster_namespace)				
				put_string (" -> ")
				put_string (cluster_properties_interface.cluster_namespace)				
			end
			if not cluster_properties_interface.parent_name.is_equal (parent_name) then
				put_string ("%N    parent_name: ")
				put_string (parent_name)				
				put_string (" -> ")
				put_string (cluster_properties_interface.parent_name)				
			end
			if cluster_properties_interface.all1 /= all1 then
				put_string ("%N    all1: ")
				put_bool (all1)				
				put_string (" -> ")
				put_bool (cluster_properties_interface.all1)				
			end
			if cluster_properties_interface.is_eiffel_library /= is_eiffel_library then
				put_string ("%N    is_eiffel_library: ")
				put_bool (is_eiffel_library)				
				put_string (" -> ")
				put_bool (cluster_properties_interface.is_eiffel_library)				
			end
			if cluster_properties_interface.is_library /= is_library then
				put_string ("%N    is_library: ")
				put_bool (is_library)				
				put_string (" -> ")
				put_bool (cluster_properties_interface.is_library)				
			end
			if cluster_properties_interface.override /= override then
				put_string ("%Noverride: ")
				put_bool (override)				
				put_string (" -> ")
				put_bool (cluster_properties_interface.override)	
			end
			if cluster_properties_interface.evaluate_check_by_default /= evaluate_check_by_default then
				put_string ("%N    evaluate_check_by_default: ")
				put_bool (evaluate_check_by_default)				
				put_string (" -> ")
				put_bool (cluster_properties_interface.evaluate_check_by_default)				
			end
			if cluster_properties_interface.evaluate_ensure_by_default /= evaluate_ensure_by_default then
				put_string ("%N    evaluate_ensure_by_default: ")
				put_bool (evaluate_ensure_by_default)				
				put_string (" -> ")
				put_bool (cluster_properties_interface.evaluate_ensure_by_default)				
			end
			if cluster_properties_interface.evaluate_invariant_by_default /= evaluate_invariant_by_default then
				put_string ("%N    evaluate_invariant_by_default: ")
				put_bool (evaluate_invariant_by_default)				
				put_string (" -> ")
				put_bool (cluster_properties_interface.evaluate_invariant_by_default)				
			end
			if cluster_properties_interface.evaluate_loop_by_default /= evaluate_loop_by_default then
				put_string ("%N    evaluate_loop_by_default: ")
				put_bool (evaluate_loop_by_default)				
				put_string (" -> ")
				put_bool (cluster_properties_interface.evaluate_loop_by_default)				
			end
			if cluster_properties_interface.evaluate_require_by_default /= evaluate_require_by_default then
				put_string ("%N    evaluate_require_by_default: ")
				put_bool (evaluate_require_by_default)				
				put_string (" -> ")
				put_bool (cluster_properties_interface.evaluate_require_by_default)				
			end
			if cluster_properties_interface.has_children /= has_children then
				put_string ("%N    has_children: ")
				put_bool (has_children)				
				put_string (" -> ")
				put_bool (cluster_properties_interface.has_children)				
			end
			if cluster_properties_interface.has_parent /= has_parent then
				put_string ("%N    has_parent: ")
				put_bool (has_parent)				
				put_string (" -> ")
				put_bool (cluster_properties_interface.has_parent)				
			end
			if cluster_properties_interface.use_system_default /= use_system_default then
				put_string ("%N    use_system_default: ")
				put_bool (use_system_default)				
				put_string (" -> ")
				put_bool (cluster_properties_interface.use_system_default)				
			end
			put_string ("%N  End%N")
		end
		
	display_excludes is
			-- display cluster exclude files and directories
		local
			l_exclude_items: IENUM_CLUSTER_EXCLUDES_INTERFACE
			l_exclude_item: CELL [STRING]
			l_index: INTEGER
		do
			l_exclude_items := cluster_properties_interface.excluded
			put_string ("%N  Cluster Excluded Items")
			if l_exclude_items /= Void then
				if l_exclude_items.count > 0 then
					from
						l_index := 1
					until
						l_index > l_exclude_items.count
					loop
						create l_exclude_item.put (Void)
						l_exclude_items.ith_item (l_index, l_exclude_item)
						put_string ("%N    ")
						put_string (l_exclude_item.item)
						l_index := l_index + 1
					end
				else
					put_string ("%N    <NONE>")
				end
			else
				put_string ("%N    ")
				put_string (Void)
			end
		end
		
	display_sub_clusters is
			-- display cluster sub clusters
		local
			l_sub_clusters: IENUM_CLUSTER_PROP_INTERFACE
			l_cluster: CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE]
			l_index: INTEGER
		do
			l_sub_clusters := cluster_properties_interface.subclusters
			put_string ("%N  Cluster Excluded Items")
			if l_sub_clusters /= Void then
				if l_sub_clusters.count > 0 then
					from
						l_index := 1
					until
						l_index > l_sub_clusters.count
					loop
						create l_cluster.put (Void)
						l_sub_clusters.ith_item (l_index, l_cluster)
						put_string ("%N    ")
						put_string (l_cluster.item.name)
						l_index := l_index + 1
					end
				else
					put_string ("%N    <NONE>")
				end
			else
				put_string ("%N    ")
				put_string (Void)
			end
		end
		
		
feature {NONE} -- Persistance

	cache_current_properties is
			-- cache current cluster properties
		do
			name := cluster_properties_interface.name
			cluster_id := cluster_properties_interface.cluster_id
			cluster_path := cluster_properties_interface.cluster_path
			expanded_cluster_path := cluster_properties_interface.expanded_cluster_path
			cluster_namespace := cluster_properties_interface.cluster_namespace
			parent_name := cluster_properties_interface.parent_name
			all1 := cluster_properties_interface.all1
			is_eiffel_library := cluster_properties_interface.is_eiffel_library
			is_library := cluster_properties_interface.is_library
			evaluate_check_by_default := cluster_properties_interface.evaluate_check_by_default
			evaluate_ensure_by_default := cluster_properties_interface.evaluate_ensure_by_default
			evaluate_invariant_by_default := cluster_properties_interface.evaluate_invariant_by_default
			evaluate_loop_by_default := cluster_properties_interface.evaluate_loop_by_default
			evaluate_require_by_default := cluster_properties_interface.evaluate_require_by_default
			has_children := cluster_properties_interface.has_children
			has_parent := cluster_properties_interface.has_parent
			use_system_default := cluster_properties_interface.use_system_default
			override := cluster_properties_interface.override
			cached_called := True
		end

feature {NONE} -- Implementation

	add_menu_items is
			-- add menu items to menu
		do
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("1", "Test All Properties", agent on_all_properties_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("3", "Test cluster_namespace", agent on_cluster_namespace_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("4", "Test cluster_path", agent on_cluster_path_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("6", "Test override", agent on_override_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("7", "Test is_library", agent on_is_library_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("8", "Test all", agent on_all1_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("9", "Test use_system_default", agent on_use_system_default_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("10", "Test assertions", agent on_assertions_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("11", "Test add_exclude", agent on_add_exclude_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("12", "Test remove_exclude", agent on_remove_exclude_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("d", "Display All Properties", agent on_display_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("x", "Exit Menu", Void))
			menu.set_return_item (menu.items.last)
		end
		
	menu: CONSOLE_MENU
		-- menu
		
	cluster_properties_interface: IEIFFEL_CLUSTER_PROPERTIES_INTERFACE
		-- cluster properties interface
		
	name: STRING
	cluster_id: INTEGER
	cluster_path: STRING
	expanded_cluster_path: STRING
	cluster_namespace: STRING
	parent_name: STRING
	all1: BOOLEAN
	is_eiffel_library: BOOLEAN
	is_library: BOOLEAN
	override: BOOLEAN
	evaluate_check_by_default: BOOLEAN
	evaluate_ensure_by_default: BOOLEAN
	evaluate_invariant_by_default: BOOLEAN
	evaluate_loop_by_default: BOOLEAN
	evaluate_require_by_default: BOOLEAN
	has_children: BOOLEAN
	has_parent:  BOOLEAN
	use_system_default: BOOLEAN
		-- cached cluster properties
		
	cached_called: BOOLEAN
		-- has 'cache_current_properties' been called?
		
invariant
	non_void_menu: menu /= Void
	non_void_cluster_properties_interface: cluster_properties_interface /= Void

end -- class CLUSTER_PROPERTIES_TESTER
