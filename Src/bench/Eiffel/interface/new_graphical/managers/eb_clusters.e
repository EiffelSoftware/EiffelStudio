indexing
	description	: "Object that encapsulates all the clusters and the classes of the project%
				  %The favorites are project-wide."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

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

	SHARED_EXEC_ENVIRONMENT
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

	LACE_AST_FACTORY
		undefine
			default_create
		end

	CONF_REFACTORING
		undefine
			default_create
		end

	CONF_ACCESS
		undefine
			default_create
		end

	SHARED_CONF_FACTORY
		undefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialization.
		do
			create observer_list.make (10)
			create clusters.make_default
			create overrides.make_default
			create libraries.make_default
			create assemblies.make_default
		end

feature -- Initialization

	load_tree is
			-- Load all clusters and classes.
		local
			l_target: CONF_TARGET
			l_libs: HASH_TABLE [CONF_GROUP, STRING]
		do
			l_target := universe.target
			if l_target /= Void then
				clusters := create_groups (l_target.clusters)
				overrides := create_groups (l_target.overrides)
				l_libs := l_target.libraries
				if l_target.precompile /= Void then
					l_libs.force (l_target.precompile, l_target.precompile.name)
				end
				libraries := create_groups (l_libs)
				assemblies := create_groups (l_target.assemblies)
			end
		end

feature -- Observer Pattern

	add_observer (an_observer: EB_CLUSTER_MANAGER_OBSERVER) is
		require
			an_observer_not_void: an_observer /= Void
		do
			observer_list.extend (an_observer)
		end

	remove_observer (an_observer: EB_CLUSTER_MANAGER_OBSERVER) is
		require
			an_observer_not_void: an_observer /= Void
		do
			observer_list.start
			observer_list.prune_all (an_observer)
		end

	refresh is
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

	on_cluster_added (a_cluster: CLUSTER_I) is
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


	on_class_added (a_class: CLASS_I) is
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

	on_class_removed (a_class: CLASS_I) is
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

	on_class_moved (a_class: CONF_CLASS; old_group: CONF_GROUP) is
			-- `a_class' has been moved away from `old_cluster'.
		require
			a_class_not_void: a_class /= Void
			old_group_not_void: old_group /= Void
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_class_moved (a_class, old_group)
				observer_list.forth
			end
		end

	on_cluster_changed (a_cluster: CLUSTER_I) is
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

	on_cluster_moved (a_cluster: EB_SORTED_CLUSTER; old_cluster: CLUSTER_I) is
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

	on_cluster_removed (a_group: CONF_GROUP; a_path: STRING) is
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

	on_project_loaded is
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

	on_project_unloaded is
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

	wipe_out is
			-- Erase the observer list.
		do
			observer_list.wipe_out
		end

	prune (obs: EB_CLUSTER_MANAGER_OBSERVER) is
			-- Prune an observer from the observer list.
		require
			obs_not_void: obs /= Void
		do
			observer_list.start
			observer_list.prune (obs)
		end

	extend (obs: EB_CLUSTER_MANAGER_OBSERVER) is
			-- Add an observer to the observer list.
		require
			obs_not_void: obs /= Void
		do
			observer_list.extend (obs)
		end

	remove_class (a_class: CLASS_I) is
			-- Remove `a_class' from its parent and notify observers.
		require
			a_class_not_void: a_class /= Void
		do
				-- Notify observers.
			on_class_removed (a_class)

				-- Mark `a_class' as invalid
			a_class.config_class.invalidate
				-- we need to rebuild and then the rest will be done during rebuild
			system.force_rebuild
		end

	move_class (a_class: CONF_CLASS; old_group: CONF_GROUP; new_cluster: CONF_CLUSTER; new_path: STRING) is
			-- Move `a_class' from `old_group' to `new_cluster'/`new_path'.
		require
			valid_class: a_class /= Void
			valid_clusters: old_group /= Void and new_cluster /= Void
			valid_path: new_path /= Void
		local
			old_file: RAW_FILE
			new_file: RAW_FILE
			input: STRING
			wd: EV_WARNING_DIALOG
			retried: BOOLEAN
			fname: FILE_NAME
			tdirsrc, tdirdes: KL_DIRECTORY
			l_lib_usage: ARRAYED_LIST [CONF_LIBRARY]
			l_src_path, l_dst_path: STRING
			l_classes: HASH_TABLE [CONF_CLASS, STRING]
		do
			if
				not retried
			then
				if
					not new_cluster.is_readonly and then
					not old_group.is_readonly
				then
					l_src_path := old_group.location.build_path (a_class.path, "")
					l_dst_path := new_cluster.location.build_path (new_path, "")
					create tdirsrc.make (l_src_path)
					create tdirdes.make (l_dst_path)
					if
						tdirsrc.exists and then
						tdirdes.exists
					then
						if
							not l_src_path.is_equal (l_dst_path)
						then
							create old_file.make (a_class.full_file_name)
							create fname.make_from_string (l_dst_path)
							fname.set_file_name (a_class.file_name)
							create new_file.make (fname)
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
								if old_group /= new_cluster then
										-- Remove `a_class' from the old_group
									old_group.classes.remove (a_class.name)
									l_lib_usage := old_group.target.used_in_libraries
									if l_lib_usage /= Void then
										from
											l_lib_usage.start
										until
											l_lib_usage.after
										loop
											l_lib_usage.item.classes.remove (a_class.renamed_name)
											l_lib_usage.forth
										end
									end

										-- Add `a_class' to the new cluster
									a_class.rebuild (a_class.file_name, new_cluster, new_path)
									if not new_cluster.classes_set then
										create l_classes.make (1)
										new_cluster.set_classes (l_classes)
									end
									new_cluster.classes.force (a_class, a_class.renamed_name)

										-- force a rebuild to handle the rest
									system.force_rebuild
								else
									a_class.rebuild (a_class.file_name, new_cluster, new_path)
								end

									-- Rebuild old and new folders
								folder_from_cluster (old_group).reinitialize
								folder_from_cluster (new_cluster).reinitialize

									-- Notify observers.
								on_class_moved (a_class, old_group)
							else
								create wd.make_with_text (Warning_messages.w_Cannot_move_class)
								wd.show_modal_to_window (Window_manager.last_focused_window.window)
							end
						else
							-- The source and destination are identical: do nothing.
						end
					else
						create wd.make_with_text (Warning_messages.w_Invalid_cluster)
						wd.show_modal_to_window (Window_manager.last_focused_window.window)
					end
				else
					create wd.make_with_text (Warning_messages.w_Invalid_cluster)
					wd.show_modal_to_window (Window_manager.last_focused_window.window)
				end
			else
				create wd.make_with_text (Warning_messages.w_Cannot_move_class)
				wd.show_modal_to_window (Window_manager.last_focused_window.window)
			end
		rescue
			retried := True
			retry
		end

	add_class_to_cluster (a_class: STRING; a_cluster: CONF_CLUSTER; a_path: STRING) is
			-- Add class with file name `a_class' to `a_cluster' under `a_path' and notify observers.
		require
			a_class_not_void: a_class /= Void
			a_cluster_not_void: a_cluster /= Void
			a_path_not_void: a_path /= Void
		local
			l_folder: EB_SORTED_CLUSTER
			l_new_class: EIFFEL_CLASS_I
			l_clu: CLUSTER_I
			l_classes: HASH_TABLE [EIFFEL_CLASS_I, STRING]
		do
			l_clu ?= a_cluster
			check cluster_i: l_clu /= Void end
			l_new_class := compiler_conf_factory.new_class (a_class, l_clu, a_path)
			if not l_clu.classes_set then
				create l_classes.make (1)
				l_clu.set_classes (l_classes)
			end
			l_clu.classes.force (l_new_class, l_new_class.name)

				-- update folder
			l_folder := folder_from_cluster (a_cluster)
			l_folder.reinitialize
			on_class_added (l_new_class)

				-- force rebuild
			system.force_rebuild
				-- force compilation of class
			system.add_unref_class (l_new_class)

			last_added_class := l_new_class
		ensure
			last_added_class_set: last_added_class /= Void
		end

	remove_group (a_group: CONF_GROUP; a_path: STRING) is
			-- Remove `a_group' from its parent and notify observers.
		require
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
		local
			wd: EV_WARNING_DIALOG
		do
			if not error_in_config then
				remove_group_from_config (a_group, a_path)
				on_cluster_removed (a_group, a_path)
			else
				create wd.make_with_text (Warning_messages.w_Could_not_parse_ace)
				wd.show_modal_to_window (Window_manager.last_focused_window.window)
			end
		end

	add_cluster (a_name: STRING; a_parent: CONF_GROUP; a_path: STRING) is
			-- Add new cluster with `a_name' optionally `a_parent' and `a_path'.
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
		do
			error_in_config := False
			if a_parent = Void then
				l_target := universe.target
			else
				l_target := a_parent.target
			end
			last_added_cluster := compiler_conf_factory.new_cluster (a_name, compiler_conf_factory.new_location_from_path (a_path, l_target), l_target)
			if a_parent /= Void and then a_parent.is_cluster then
				l_clu ?= a_parent
				last_added_cluster.set_parent (l_clu)
			end
			l_target.clusters.force (last_added_cluster, a_name)
			l_sys := l_target.system
			l_sys.store
			error_in_config := not l_sys.store_successful
			l_sys.set_file_date
				-- force rebuild as we know, that we changed the group layout
			system.force_rebuild

			refresh
		ensure
			last_added_cluster_set: last_added_cluster /= Void
		end

feature {NONE} -- Implementation

	create_groups (a_groups: HASH_TABLE [CONF_GROUP, STRING]): DS_ARRAYED_LIST [EB_SORTED_CLUSTER] is
			-- Create sorted groups out of `a_groups'.
		require
			a_groups_not_void: a_groups /= Void
		local
			l_grp: EB_SORTED_CLUSTER
		do
			create Result.make (a_groups.count)
			from
				a_groups.start
			until
				a_groups.after
			loop
				create l_grp.make (a_groups.item_for_iteration)
				Result.force_last (l_grp)
				a_groups.forth
			end
			Result.sort (create {DS_QUICK_SORTER [EB_SORTED_CLUSTER]}.make (create {KL_COMPARABLE_COMPARATOR [EB_SORTED_CLUSTER]}.make))
		ensure
			Result_not_void: Result /= Void
		end


	name: STRING is "Clusters"
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

	folder_from_cluster (a_group: CONF_GROUP): EB_SORTED_CLUSTER is
			-- Find a sorted cluster representing `a_cluster'.
		require
			a_cluster_not_void: a_group /= Void
		local
			path: LINKED_LIST [CONF_GROUP]
		do
			path := cluster_parents (a_group)
			from
				path.start
			until
				path.after
			loop
				Result := find_cluster_in (path.item, Result)
				path.forth
			end
		end

	cluster_parents (a_group: CONF_GROUP): LINKED_LIST [CONF_GROUP] is
			-- List of parent groups of `group', from the root to `group', `cluster' included.
		local
			l_group, l_next_group: CONF_GROUP
			l_cluster: CONF_CLUSTER
			l_libuse: ARRAYED_LIST [CONF_LIBRARY]
		do
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
				l_libuse := l_group.target.used_in_libraries
				if l_next_group = Void and l_libuse /= Void and then not l_libuse.is_empty then
						-- if one of the libraries is used in the application target use this one, else just take one
					from
						l_libuse.start
					until
						l_next_group /= Void or l_libuse.after
					loop
						if l_libuse.item.target = universe.target then
							l_next_group := l_libuse.item
						end
						l_libuse.forth
					end
					if l_next_group = Void then
						l_next_group := l_libuse.first
					end
				end
				l_group := l_next_group
			end
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end

	find_cluster_in (clusteri: CONF_GROUP; parent_cluster: EB_SORTED_CLUSTER): EB_SORTED_CLUSTER is
			-- Find the sorted cluster associated to `clusteri' in `parent_cluster'.
		require
			clusteri_not_void: clusteri /= Void
		local
			parent_cluster_sons: DS_LIST [EB_SORTED_CLUSTER]
		do
			if parent_cluster = Void then
				if clusteri.is_cluster then
					parent_cluster_sons := clusters
				elseif clusteri.is_assembly then
					parent_cluster_sons := assemblies
				elseif clusteri.is_library then
					parent_cluster_sons := libraries
				elseif clusteri.is_override then
					parent_cluster_sons := overrides
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
					elseif clusteri.is_assembly then
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

	remove_group_from_config (a_group: CONF_GROUP; a_path: STRING) is
			-- Remove the entry corresponding to `a_group' from the config file.
			-- If `a_group' is a recursive cluster and a_path is not empty, add a file rule excluding `a_path'.
		require
			valid_group: a_group /= Void
			not_readonly: not a_group.is_readonly
			valid_path: a_path /= Void
			path_implies_cluster: not a_path.is_empty implies is_recursive_cluster (a_group)
			config_up_to_date: not a_group.target.system.date_has_changed
		local
			retried: BOOLEAN
			l_cl: CONF_CLUSTER
			l_sys: CONF_SYSTEM
			l_fr: CONF_FILE_RULE
		do
			error_in_config := False
			if not retried then
				l_sys := a_group.target.system
					-- update config
				if a_path.is_empty then
					if a_group.is_cluster then
						a_group.target.clusters.remove (a_group.name)
					elseif a_group.is_library then
						a_group.target.libraries.remove (a_group.name)
					elseif a_group.is_assembly then
						a_group.target.assemblies.remove (a_group.name)
					elseif a_group.is_override then
						a_group.target.overrides.remove (a_group.name)
					else
						check should_not_reach: False end
					end
					a_group.invalidate
				else
					l_cl ?= a_group
					l_fr := l_cl.internal_file_rule
					if l_fr = Void then
						create l_fr.make
					end
					l_fr.add_exclude (build_pattern (a_path))
					l_cl.set_file_rule (l_fr)
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

	build_pattern (a_path: STRING): STRING is
			-- Build a regular expression for `a_path'.
		require
			a_path_ok: a_path /= Void and then not a_path.is_empty
		do
			Result := a_path.twin
			Result.prepend_character ('^')
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Contracts

	is_recursive_cluster (a_group: CONF_GROUP): BOOLEAN is
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
