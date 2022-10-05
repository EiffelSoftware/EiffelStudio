note
	description: "[
				Object that encapsulates all the clusters and the classes of the project
				The favorites are project-wide.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLUSTERS

inherit
	COMPILER_EXPORTER
		undefine
			default_create
		end

	SHARED_EIFFEL_PROJECT
		undefine
			default_create
		end

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create
		end

	SHARED_WORKBENCH
		undefine
			default_create
		end

	EB_SHARED_WINDOW_MANAGER
		undefine
			default_create
		end

	EB_CONSTANTS
		undefine
			default_create
		end

	CONF_ACCESS
		undefine
			default_create
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		undefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Initialization.
		do
			create observer_list.make (10)
			create clusters.make_default
			create overrides.make_default
			create libraries.make_default
			create assemblies.make_default
		end

feature -- Initialization

	load_tree
			-- Load all clusters and classes.
		local
			l_target: CONF_TARGET
			l_libs: STRING_TABLE [CONF_GROUP]
			l_cls: STRING_TABLE [CONF_CLUSTER]
			l_cls_lst: STRING_TABLE [CONF_CLUSTER]
			l_cluster: CONF_CLUSTER
		do
			if workbench.universe_defined then
				l_target := universe.target
			end
			if l_target /= Void then
				l_cls := l_target.clusters
				create l_cls_lst.make (l_cls.count)
				across
					l_cls as c
				loop
					l_cluster := c.item
					if l_cluster.parent = Void and l_cluster.classes_set then
						l_cls_lst.force (l_cluster, l_cluster.name)
					end
				end
				clusters := create_groups (l_cls_lst)
				l_cls := l_target.overrides
				create l_cls_lst.make (l_cls.count)
				across
					l_cls as c
				loop
					l_cluster := c.item
					if l_cluster.parent = Void and l_cluster.classes_set then
						l_cls_lst.force (l_cluster, l_cluster.name)
					end
				end
				overrides := create_groups (l_cls_lst)
				l_libs := l_target.libraries
				if l_target.precompile /= Void and l_target.precompile.classes_set then
					l_libs.force (l_target.precompile, l_target.precompile.name)
				end
				libraries := create_groups (l_libs)
				assemblies := create_groups (l_target.assemblies)
			end
		end

feature -- Observer Pattern

	add_observer (an_observer: EB_CLUSTER_MANAGER_OBSERVER)
		require
			an_observer_not_void: an_observer /= Void
		do
			if not observer_list.has (an_observer) then
				observer_list.extend (an_observer)
			end
		end

	remove_observer (an_observer: EB_CLUSTER_MANAGER_OBSERVER)
		require
			an_observer_not_void: an_observer /= Void
		do
			observer_list.start
			observer_list.prune_all (an_observer)
		end

	refresh
			-- Reload the tree.
			-- Useful in case clusters are modified directly without
			-- notifying `Current'. (during compilations for instance)
		do
			load_tree

			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.refresh
				observer_list.forth
			end
		end

	on_cluster_added (a_cluster: CLUSTER_I)
			-- `a_cluster' has been added.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_cluster_added (a_cluster)
				observer_list.forth
			end
		end

	on_class_added (a_class: CLASS_I)
			-- `a_class' has been added.
		require
			a_class_not_void: a_class /= Void
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_class_added (a_class)
				observer_list.forth
			end
		end

	on_class_removed (a_class: CLASS_I)
			-- `a_class' has been removed.
		require
			a_class_not_void: a_class /= Void
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_class_removed (a_class)
				observer_list.forth
			end
		end

	on_class_moved (a_class: CONF_CLASS; old_group: CONF_GROUP; old_path: READABLE_STRING_32)
			-- `a_class' has been moved away from `old_cluster'.
			-- `old_path' is old relative path in `old_group'
		require
			a_class_not_void: a_class /= Void
			old_group_not_void: old_group /= Void
			old_path_not_void: old_path /= Void
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_class_moved (a_class, old_group, old_path)
				observer_list.forth
			end
		end

	on_cluster_changed (a_cluster: CLUSTER_I)
			-- `a_cluster' has been modified
		require
			a_cluster_not_void: a_cluster /= Void
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_cluster_changed (a_cluster)
				observer_list.forth
			end
		end

	on_cluster_moved (a_cluster: EB_SORTED_CLUSTER; old_cluster: CLUSTER_I)
			-- `a_cluster' has been moved away from `old_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_cluster_moved (a_cluster, old_cluster)
				observer_list.forth
			end
		end

	on_cluster_removed (a_group: CONF_GROUP; a_path: STRING)
			-- `a_cluster' has been removed.
		require
			a_cluster_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
			path_implies_cluster: not a_path.is_empty implies a_group.is_cluster
		local
			sorted: EB_SORTED_CLUSTER
		do
			sorted := folder_from_cluster (a_group)
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_cluster_removed (sorted, a_path)
				observer_list.forth
			end
		end

	on_project_loaded
			-- A new project has been loaded.
		do
			load_tree

			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_project_loaded
				observer_list.forth
			end
		end

	on_project_unloaded
			-- Current project has been closed.
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_project_unloaded
				observer_list.forth
			end

			clusters.wipe_out
			libraries.wipe_out
			overrides.wipe_out
			assemblies.wipe_out
		end

feature -- Access

	clusters: DS_ARRAYED_LIST [EB_SORTED_CLUSTER]
			-- Root clusters in sorted order.

	overrides: DS_ARRAYED_LIST [EB_SORTED_CLUSTER]
			-- Root overrides in a sorted order.

	libraries: DS_ARRAYED_LIST [EB_SORTED_CLUSTER]
			-- Root libraries in a sorted order.

	assemblies: DS_ARRAYED_LIST [EB_SORTED_CLUSTER]
			-- Root assemblies in a sorted order.

	last_added_class: CLASS_I
			-- Last class which was added during a call to `add_class_to_cluster'.

	last_added_cluster: CLUSTER_I
			-- Last cluster which was added during a call to `add_cluster'.

feature -- Element change

	wipe_out
			-- Erase the observer list.
		do
			observer_list.wipe_out
		end

	prune (obs: EB_CLUSTER_MANAGER_OBSERVER)
			-- Prune an observer from the observer list.
		require
			obs_not_void: obs /= Void
		do
			observer_list.start
			observer_list.prune (obs)
		end

	extend (obs: EB_CLUSTER_MANAGER_OBSERVER)
			-- Add an observer to the observer list.
		require
			obs_not_void: obs /= Void
		do
			observer_list.extend (obs)
		end

	remove_class (a_class: CLASS_I)
			-- Remove `a_class' from its parent and notify observers.
		require
			a_class_not_void: a_class /= Void
		do
				-- Notify observers.
			on_class_removed (a_class)

				-- Mark `a_class' as invalid
			a_class.config_class.invalidate
			system.set_melt
				-- we need to rebuild and then the rest will be done during rebuild
			system.force_rebuild
		end

	move_class (a_class: CONF_CLASS; old_group: CONF_GROUP; new_cluster: CONF_CLUSTER; new_path: READABLE_STRING_32)
			-- Move `a_class' from `old_group' to `new_cluster'/`new_path'.
		require
			valid_class: a_class /= Void
			valid_clusters: old_group /= Void and new_cluster /= Void
			valid_path: new_path /= Void
		local
			old_file: RAW_FILE
			new_file: RAW_FILE
			input: STRING
			retried: BOOLEAN
			tdirsrc, tdirdes: DIRECTORY
			l_lib_usage: ARRAYED_LIST [CONF_LIBRARY]
			l_src_path, l_dst_path: PATH
			l_old_relative_path: STRING_32
		do
			if
				not retried
			then
				if
					not new_cluster.is_readonly and then
					not old_group.is_readonly
				then
					l_old_relative_path := a_class.path
					if l_old_relative_path = Void then
						create l_old_relative_path.make_empty
					end
					l_src_path := old_group.location.build_path (a_class.path, "")
					l_dst_path := new_cluster.location.build_path (new_path, "")
					create tdirsrc.make_with_path (l_src_path)
					create tdirdes.make_with_path (l_dst_path)
					if
						tdirsrc.exists and then
						tdirdes.exists
					then
						if not l_src_path.same_as (l_dst_path) then
							create old_file.make_with_path (a_class.full_file_name)
							create new_file.make_with_path (l_dst_path.extended (a_class.file_name))
							if
								old_file.exists and then
								old_file.is_readable and then
								old_file.is_writable and then
								new_file.is_creatable
							then
									-- Really move `a_class'.
								old_file.open_read
								old_file.read_stream (old_file.count)
								old_file.close
								input := old_file.last_string
								new_file.create_read_write
								new_file.put_string (input)
								new_file.close
								old_file.delete

									-- if the group changed we have to do some things
								if old_group = new_cluster then
									a_class.rebuild (a_class.file_name, new_cluster, new_path)
								else
										-- Remove `a_class' from the old_group
									old_group.classes.remove (a_class.name)
									l_lib_usage := old_group.target.system.used_in_libraries
									if l_lib_usage /= Void then
										from
											l_lib_usage.start
										until
											l_lib_usage.after
										loop
											l_lib_usage.item.classes.remove (a_class.name)
											l_lib_usage.forth
										end
									end

										-- Add `a_class' to the new cluster
									a_class.rebuild (a_class.file_name, new_cluster, new_path)
									if not new_cluster.classes_set then
										new_cluster.set_classes (create {STRING_TABLE [CONF_CLASS]}.make (1))
									end
									new_cluster.classes.force (a_class, a_class.name)

										-- force a rebuild to handle the rest
									system.force_rebuild
								end

									-- Rebuild old and new folders
								folder_from_cluster (old_group).reinitialize
								folder_from_cluster (new_cluster).reinitialize

									-- Notify observers.
								on_class_moved (a_class, old_group, l_old_relative_path)
							else
								prompts.show_error_prompt (Warning_messages.w_Cannot_move_class, Void, Void)
							end
						else
							-- The source and destination are identical: do nothing.
						end
					else
						prompts.show_error_prompt (Warning_messages.w_Invalid_cluster, Void, Void)
					end
				else
					prompts.show_error_prompt (Warning_messages.w_Invalid_cluster, Void, Void)
				end
			else
				prompts.show_error_prompt (Warning_messages.w_Cannot_move_class, Void, Void)
			end
		rescue
			retried := True
			retry
		end

	add_class_to_cluster (a_class: READABLE_STRING_GENERAL; a_cluster: CONF_CLUSTER; a_path: READABLE_STRING_GENERAL; a_class_name: READABLE_STRING_32; a_perform_quickmelt: BOOLEAN)
			-- Add class with file name `a_class' to `a_cluster' under `a_path' and notify observers.
		require
			a_class_not_void: a_class /= Void
			a_cluster_not_void: a_cluster /= Void
			a_path_not_void: a_path /= Void
			a_class_name_not_void: a_class_name /= Void
			a_class_name_not_empty: not a_class_name.is_empty
		local
			l_new_class: EIFFEL_CLASS_I
			l_clu: CLUSTER_I
			l_fact: CONF_COMP_FACTORY
			l_file_path: PATH
		do
			create l_fact
			l_clu ?= a_cluster
			check cluster_i: l_clu /= Void end
			l_new_class := l_fact.new_class (a_class.to_string_32, l_clu, a_path.to_string_32, a_class_name)
			if not l_clu.classes_set then
				l_clu.set_classes (create {like {CLUSTER_I}.classes}.make (1))
				l_clu.set_classes_by_filename (create {like {CLUSTER_I}.classes_by_filename}.make (1))
			end
			l_clu.classes.force (l_new_class, l_new_class.name)
			create l_file_path.make_from_string (a_path)
			l_file_path := l_file_path.extended (l_new_class.base_name)
			l_clu.classes_by_filename.force (l_new_class, l_file_path)

				-- update folder
			folder_from_cluster (a_cluster).reinitialize
			on_class_added (l_new_class)

				-- force rebuild
			system.force_rebuild
				-- force compilation of class
			system.add_unref_class (l_new_class)

			last_added_class := l_new_class

			if a_perform_quickmelt then
					-- Perform a quick melt so that class is correctly added to the system as unreferenced.
				eiffel_project.quick_melt (True, True, False)
			end

			if attached last_added_class as l_class_i then
					-- Must set_stone before `synchronize_all', otherwise {EB_DEVELOPMENT_WINDOW}.synchronize
					-- would switch editor tab to last stone which is not the class just created. see bug#16707
				window_manager.last_focused_development_window.set_stone (create {CLASSI_STONE}.make (l_class_i))
			end

				-- Synchronize so that diagram is correctly updated.
			window_manager.synchronize_all
		ensure
			last_added_class_set: last_added_class /= Void
		end

	remove_group (a_group: CONF_GROUP; a_path: STRING)
			-- Remove `a_group' from its parent and notify observers.
		require
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
		do
			if not error_in_config then
				remove_group_from_config (a_group, a_path)
				on_cluster_removed (a_group, a_path)
			else
				prompts.show_error_prompt (Warning_messages.w_Could_not_parse_ace, Void, Void)
			end
		end

	add_cluster (a_name: READABLE_STRING_GENERAL; a_parent: CONF_GROUP; a_path: PATH; a_is_tests_cluster: BOOLEAN)
			-- Add new cluster with `a_name' optionally `a_parent' and `a_path'.
			--
			-- `a_name': Name of new cluster.
			-- `a_parent': If not Void, create new cluster so it is a child of `a_parent'.
			-- `a_path': Path for new cluster.
			-- `a_is_tests_cluster': If True, new cluster will be a tests cluster.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty and a_name.as_lower.is_equal (a_name)
			a_path_ok: a_path /= Void and then not a_path.is_empty
			a_parent_ok: a_parent /= Void implies a_parent.is_cluster or a_parent.is_library
			config_up_to_date: a_parent /= Void implies not a_parent.target.system.date_has_changed
			config_up_to_date: a_parent = Void implies not universe.target.system.date_has_changed
		local
			l_target: CONF_TARGET
			l_clu: CLUSTER_I
			l_sys: CONF_SYSTEM
			l_fact: CONF_COMP_FACTORY
			l_over, l_over_parent: OVERRIDE_I
		do
			create l_fact
			error_in_config := False
			if a_parent = Void then
				l_target := universe.target
			else
				l_target := a_parent.target
			end
			if a_parent /= Void and then a_parent.is_override then
				l_over := l_fact.new_override (a_name, l_fact.new_location_from_path (a_path.name, l_target), l_target)
				last_added_cluster := l_over
			else
				if a_is_tests_cluster then
					last_added_cluster := l_fact.new_test_cluster (a_name, l_fact.new_location_from_path (a_path.name, l_target), l_target)
				else
					last_added_cluster := l_fact.new_cluster (a_name, l_fact.new_location_from_path (a_path.name, l_target), l_target)
				end
			end
				-- create empty class list, so that the folder can be displayed
			last_added_cluster.set_classes (create {like last_added_cluster.classes}.make (0))
			last_added_cluster.set_classes_by_filename (create {like last_added_cluster.classes_by_filename}.make (0))

			if a_parent /= Void and then a_parent.is_cluster then
				if a_parent.is_override then
					l_over_parent ?= a_parent
					l_over.set_parent (l_over_parent)
					l_over_parent.add_child (l_over)
				else
					l_clu ?= a_parent
					last_added_cluster.set_parent (l_clu)
					l_clu.add_child (last_added_cluster)
				end
			end
			if l_over /= Void then
				l_target.add_override (l_over)
			else
				l_target.add_cluster (last_added_cluster)
			end
			l_sys := l_target.system
			l_sys.store
			error_in_config := not l_sys.store_successful
			l_sys.set_file_date
				-- force rebuild as we know, that we changed the group layout
			system.force_rebuild

			refresh
			on_cluster_added (last_added_cluster)
		ensure
			last_added_cluster_set: last_added_cluster /= Void
		end

feature {NONE} -- Implementation

	create_groups (a_groups: STRING_TABLE [CONF_GROUP]): DS_ARRAYED_LIST [EB_SORTED_CLUSTER]
			-- Create sorted groups out of `a_groups'.
		require
			a_groups_not_void: a_groups /= Void
		do
			create Result.make (a_groups.count)
			across
				a_groups as g
			loop
				if g.item.classes_set then
					Result.force_last (create {EB_SORTED_CLUSTER}.make (g.item))
				end
			end
			Result.sort (create {DS_QUICK_SORTER [EB_SORTED_CLUSTER]}.make (create {KL_COMPARABLE_COMPARATOR [EB_SORTED_CLUSTER]}.make))
		ensure
			Result_not_void: Result /= Void
		end

	name: STRING = "Clusters"
			-- Name of the item.

--	move_directory (old_path: STRING; new_path: STRING) is
--			-- Recursively move a directory from `old_path' to `new_path'.
--			-- If renaming fails, copy recursively and delete.
--		require
--			old_path_not_void: old_path /= Void
--			old_path_not_empty: not old_path.is_empty
--			new_path_not_void: new_path /= Void
--			new_path_not_empty: not new_path.is_empty
--		local
--			dir: DIRECTORY
--			retried: BOOLEAN
--		do
--			if not retried then
--				create dir.make (old_path)
--				dir.change_name (new_path)
--			end
--		rescue
--			create dir.make (new_path)
--			dir_rec_copy (old_path, new_path)
--			retried := True
--			retry
--		end

--	dir_rec_copy (old_path: STRING; new_path: STRING) is
--			-- Recursively move a directory from `old_path' to `new_path'.
--		require
--			old_path_not_void: old_path /= Void
--			old_path_not_empty: not old_path.is_empty
--			new_path_not_void: new_path /= Void
--			new_path_not_empty: not new_path.is_empty
--		local
--			dir1, dir2: DIRECTORY
--			tmpdir: DIRECTORY
--			tmpfile: RAW_FILE
--			file2: RAW_FILE
--			fname1, fname2: FILE_NAME
--			entry: STRING
--			content: STRING
--		do
--			create dir1.make_open_read (old_path)
--			create dir2.make (new_path)
--			dir2.create_dir
--			from
--				dir1.start
--
--					-- '.' and '..' must not be moved.
--				dir1.readentry
--				dir1.readentry
--
--				dir1.readentry
--				entry := dir1.lastentry
--			until
--				entry = Void
--			loop
--				create fname1.make_from_string (old_path)
--				fname1.set_subdirectory (entry)
--				create tmpdir.make (fname1)
--				if tmpdir.exists then
--					create fname2.make_from_string (new_path)
--					fname2.set_subdirectory (entry)
--					dir_rec_copy (fname1, fname2)
--				else
--					create tmpfile.make (fname1)
--					if tmpfile.exists then
--						tmpfile.open_read
--						tmpfile.read_stream (tmpfile.count)
--						content := tmpfile.last_string
--						tmpfile.close
--						create fname2.make_from_string (new_path)
--						fname2.set_subdirectory (entry)
--						create file2.make_create_read_write (fname2)
--						file2.put_string (content)
--						file2.close
--						tmpfile.delete
--					end
--				end
--				dir1.readentry
--				entry := dir1.lastentry
--			end
--			dir1.close
--			dir1.delete
----		rescue
----			io.put_string ("Cant move directory")
--		end

	folder_from_cluster (a_group: CONF_GROUP): EB_SORTED_CLUSTER
			-- Find a sorted cluster representing `a_cluster'.
		require
			a_cluster_not_void: a_group /= Void
		do
			across
				cluster_parents (a_group) as p
			loop
				Result := find_cluster_in (p.item, Result)
			end
		end

	cluster_parents (a_group: CONF_GROUP): LINKED_LIST [CONF_GROUP]
			-- List of parent groups of `group', from the root to `group', `cluster' included.
		local
			l_group, l_next_group: CONF_GROUP
			l_cluster: CONF_CLUSTER
			l_sys: CONF_SYSTEM
		do
			l_sys := universe.target.system
			from
				create Result.make
				l_group := a_group
			until
				l_group = Void -- root attained
			loop
				Result.put_front (l_group)
				if l_group.is_cluster then
					l_cluster ?= l_group
					check cluster: l_cluster /= Void end
					l_next_group := l_cluster.parent
				else
					l_next_group := Void
				end
				if l_next_group = Void then
					l_next_group := l_group.target.system.lowest_used_in_library
				end
				l_group := l_next_group
			end
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end

	find_cluster_in (clusteri: CONF_GROUP; parent_cluster: EB_SORTED_CLUSTER): EB_SORTED_CLUSTER
			-- Find the sorted cluster associated to `clusteri' in `parent_cluster'.
		require
			clusteri_not_void: clusteri /= Void
		local
			parent_cluster_sons: DS_LIST [EB_SORTED_CLUSTER]
		do
			if parent_cluster = Void then
				if clusteri.is_override then
					parent_cluster_sons := overrides
				elseif clusteri.is_cluster then
					parent_cluster_sons := clusters
				elseif clusteri.is_assembly or clusteri.is_physical_assembly then
					parent_cluster_sons := assemblies
				elseif clusteri.is_library then
					parent_cluster_sons := libraries
				else
					check should_not_reach: False end
				end
			else
				if parent_cluster.is_cluster then
					parent_cluster_sons := parent_cluster.clusters
				elseif parent_cluster.is_assembly then
					parent_cluster_sons := parent_cluster.assemblies
				elseif parent_cluster.is_library then
					if clusteri.is_cluster then
						parent_cluster_sons := parent_cluster.clusters
					elseif clusteri.is_assembly or clusteri.is_physical_assembly then
						parent_cluster_sons := parent_cluster.assemblies
					elseif clusteri.is_library then
						parent_cluster_sons := parent_cluster.libraries
					elseif clusteri.is_override then
						parent_cluster_sons := parent_cluster.overrides
					else
						check should_not_reach: False end
					end
				else
					check should_not_reach: False end
				end
			end
			check
				parent_cluster_sons_not_void: parent_cluster_sons /= Void
			end

			from
				parent_cluster_sons.start
			until
				parent_cluster_sons.after or Result /= Void
			loop
				if parent_cluster_sons.item_for_iteration.actual_group = clusteri then
					Result := parent_cluster_sons.item_for_iteration
				end
				parent_cluster_sons.forth
			end
		end

	remove_group_from_config (a_group: CONF_GROUP; a_path: STRING)
			-- Remove the entry corresponding to `a_group' from the config file.
			-- If `a_group' is a recursive cluster and a_path is not empty, add a file rule excluding `a_path'.
		require
			valid_group: a_group /= Void
			not_readonly: a_group.is_cluster implies not a_group.is_readonly
			valid_path: a_path /= Void
			path_implies_cluster: not a_path.is_empty implies is_recursive_cluster (a_group)
			config_up_to_date: not a_group.target.system.date_has_changed
		local
			retried: BOOLEAN
			l_sys: CONF_SYSTEM
			l_fr: CONF_FILE_RULE
		do
			error_in_config := False
			if not retried then
				l_sys := a_group.target.system
					-- update config
				if a_path.is_empty then
					if a_group.is_cluster then
						a_group.target.remove_cluster (a_group.name)
						if attached {CONF_CLUSTER} a_group as l_cl then
							if attached l_cl.parent as l_parent then
								l_parent.remove_child (l_cl)
							end
						else
							check must_be_cluster: False end
						end
					elseif a_group.is_library then
						a_group.target.remove_library (a_group.name)
					elseif a_group.is_assembly then
						a_group.target.remove_assembly (a_group.name)
					elseif a_group.is_override then
						a_group.target.remove_override (a_group.name)
						if attached {CONF_OVERRIDE} a_group as l_ov then
							if attached l_ov.parent as l_parent then
								l_parent.remove_child (l_ov)
							end
						else
							check must_be_override: False end
						end
					else
						check should_not_reach: False end
					end
					a_group.invalidate
				else
					if attached {CONF_CLUSTER} a_group as l_cl then
						create l_fr.make
						l_fr.add_exclude (build_pattern (a_path))
						l_cl.add_file_rule (l_fr)
					else
						check must_be_cluster: False end
					end
				end
					-- store it to disk
				l_sys.store
				error_in_config := not l_sys.store_successful
				l_sys.set_file_date
					-- force reparsing of configuration
				lace.reset_date_stamp
			else
				error_in_config := True
			end
		rescue
			retried := True
			retry
		end

	error_in_config: BOOLEAN
			-- Did an error occur during the last call to `add_cluster_in_ace' or `remove_group_from_config'?

feature {NONE} -- Attributes

	observer_list: ARRAYED_LIST [EB_CLUSTER_MANAGER_OBSERVER];

feature {NONE} -- Implementation

	build_pattern (a_path: STRING): STRING
			-- Build a regular expression for `a_path'.
		require
			a_path_ok: a_path /= Void and then not a_path.is_empty
		do
			Result := a_path.twin
			Result.prepend_character ('^')
			Result.append_character ('$')
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Contracts

	is_recursive_cluster (a_group: CONF_GROUP): BOOLEAN
			-- Is `a_grp' a recursive cluster?
		require
			a_group_not_void: a_group /= Void
		local
			l_cl: CONF_CLUSTER
		do
			if a_group.is_cluster then
				l_cl ?= a_group
				Result := l_cl.is_recursive
			end
		end

invariant
	clusters_not_void: clusters /= Void
	overrides_not_void: overrides /= Void
	libraries_not_void: libraries /= Void
	assemblies_not_void: assemblies /= Void

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
