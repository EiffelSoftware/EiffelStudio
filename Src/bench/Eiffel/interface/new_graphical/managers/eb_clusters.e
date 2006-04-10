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

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialization.
		local
			l_target: CONF_TARGET
			l_grps: HASH_TABLE [CONF_GROUP, STRING]
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

	on_class_moved (a_class: CLASS_I; old_cluster: CLUSTER_I) is
			-- `a_class' has been moved away from `old_cluster'.
		require
			a_class_not_void: a_class /= Void
			old_cluster_not_void: old_cluster /= Void
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_class_moved (a_class, old_cluster)
				observer_list.forth
			end
		end

	on_cluster_added (a_cluster: CLUSTER_I) is
			-- `a_cluster' has been added
		require
			a_cluster_not_void: a_cluster /= Void
		local
			sorted: EB_SORTED_CLUSTER
		do
			sorted := folder_from_cluster (a_cluster)
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_cluster_added (sorted)
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
		local
			l_grp: CONF_GROUP
			l_libs: ARRAYED_LIST [CONF_LIBRARY]
		do
				-- Notify observers.
			on_class_removed (a_class)

				-- Remove `a_class' from the universe.
				-- remove it from its group
			l_grp := a_class.group
			l_grp.classes.remove (a_class.name)
				-- we need to rebuild and then the rest will be done during rebuild
			system.force_rebuild
		end

	add_class (a_class: STRING; a_cluster: EB_SORTED_CLUSTER) is
			-- Add class with file name `a_class' to `a_cluster' and notify observers.
		require
			a_class_not_void: a_class /= Void
			a_cluster_not_void: a_cluster /= Void
		local
			new_class: CLASS_I
		do
				-- Add `a_class' to the universe.
			conf_todo
--			a_cluster.actual_cluster.force_compilation_on_class_from_file (a_class)
--
--				-- Get the created CLASS_I.
--			new_class := a_cluster.actual_cluster.class_with_base_name (a_class)
--
--				-- Notify observers.
--			if new_class /= Void then
--				a_cluster.classes.extend (new_class)
--				on_class_added (new_class)
--			end
		end

	move_class (a_class: CONF_CLASS; old_group: CONF_GROUP; new_cluster: CLUSTER_I) is
			-- Move `a_class' from `old_group' to `new_cluster'.
		require
			valid_class: a_class /= Void
			valid_clusters: old_group /= Void and new_cluster /= Void
		local
			class_list: DS_LIST [CLASS_I]
			actual_parent: CLUSTER_I
			new_sorted_cluster: EB_SORTED_CLUSTER
			old_file: RAW_FILE
			new_file: RAW_FILE
			input: STRING
			wd: EV_WARNING_DIALOG
			retried: BOOLEAN
			fname: FILE_NAME
			tdirsrc, tdirdes: DIRECTORY
		do
			if
				not retried
			then
				if
					not new_cluster.is_readonly and then
					not old_group.is_readonly
				then
					create tdirsrc.make (old_group.location.evaluated_path)
					create tdirdes.make (new_cluster.path)
					if
						tdirsrc.exists and then
						tdirdes.exists
					then
						if
							not old_group.location.evaluated_path.is_equal (new_cluster.path)
						then
							create old_file.make (a_class.file_name)
							create fname.make_from_string (new_cluster.path)
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

									-- Remove `a_class' from the old_group
								old_group.classes.remove (a_class.name)

									-- Add `a_class' to the new cluster
								conf_todo
--								a_class.rebuild (a_class.file_name, new_cluster, new_path)
--								new_cluster.classes.force (a_class, a_class.name)

									-- Remove `a_class' from the managed clusters.
								class_list := (folder_from_cluster (actual_parent)).classes
								class_list.start
--								class_list.prune_all (a_class)

									-- Add `a_class' to the managed clusters.
								new_sorted_cluster := folder_from_cluster (new_cluster)
--								new_sorted_cluster.classes.extend (a_class)

									-- Notify observers.
--								on_class_moved (a_class, old_group)
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

	add_class_to_cluster_i (a_class: STRING; a_cluster: CLUSTER_I) is
			-- Add class with file name `a_class' to `a_cluster' and notify observers.
		require
			a_class_not_void: a_class /= Void
			a_cluster_not_void: a_cluster /= Void
		local
			a_folder: EB_SORTED_CLUSTER
		do
			a_folder := folder_from_cluster (a_cluster)
			add_class (a_class, a_folder)
		end

	remove_cluster_i (a_group: CONF_GROUP; a_path: STRING) is
			-- Remove `a_group' from its parent and notify observers.
		require
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
		local
			a_folder: EB_SORTED_CLUSTER
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

	move_cluster (moved_cluster: CLUSTER_I; new_cluster: CLUSTER_I) is
			-- Move `a_cluster' from `old_cluster' to `new_cluster'.
		require
			moved_cluster_not_void: moved_cluster /= Void
		local
			cluster_list: SORTED_TWO_WAY_LIST [EB_SORTED_CLUSTER]
			actual_parent: CLUSTER_I
			a_cluster: EB_SORTED_CLUSTER
			receiver: EB_SORTED_CLUSTER
			old_cluster: CLUSTER_I
			dir: DIRECTORY
			test_dir: DIRECTORY
			wd: EV_WARNING_DIALOG
			new_name: DIRECTORY_NAME
			retried: BOOLEAN
			saved_dollar_path: STRING
		do
			conf_todo
--			if not retried then
--				old_cluster := moved_cluster.parent_cluster
--				if new_cluster = Void then
--					create new_name.make_from_string ((create {EIFFEL_ENV}).Eiffel_installation_dir_name)
--					new_name.set_subdirectory ("library")
--				else
--					create new_name.make_from_string (new_cluster.path)
--				end
--				new_name.set_subdirectory (moved_cluster.display_name)
--				create test_dir.make (new_name)
--				if test_dir.exists then
--					create wd.make_with_text ("Directory with name:%N" + new_name + "already exists.")
--					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
--				else
--						-- Move the cluster directory for real.
--					create dir.make (moved_cluster.path)
--					if new_cluster = Void then
--						create new_name.make_from_string (Eiffel_project.name)
--					else
--						create new_name.make_from_string (new_cluster.dollar_path)
--					end
--					new_name.set_subdirectory (moved_cluster.display_name)
--					saved_dollar_path := moved_cluster.dollar_path.twin
--					moved_cluster.set_dollar_path (new_name)
--					move_directory (dir.name, moved_cluster.path)
--					moved_cluster.set_dollar_path (saved_dollar_path)
--
--					a_cluster := folder_from_cluster (moved_cluster)
--						-- Remove `a_cluster' from the universe.
--					actual_parent := old_cluster
--					if actual_parent /= Void then
--						actual_parent.sub_clusters.prune_all (a_cluster.actual_cluster)
--						cluster_list := a_cluster.parent.clusters
--					else
--						Eiffel_system.sub_clusters.prune_all (a_cluster.actual_cluster)
--						cluster_list := clusters
--					end
--					Eiffel_universe.clusters.prune_all (a_cluster.actual_cluster)
--
--						-- Remove `a_cluster' from the managed clusters.
--					cluster_list.start
--					cluster_list.prune_all (a_cluster)
--
--					if new_cluster = Void then
--						a_cluster.actual_cluster.set_parent_cluster (Void)
--						clusters.extend (a_cluster)
--						a_cluster.set_parent (Void)
--						Eiffel_system.sub_clusters.extend (a_cluster.actual_cluster)
--					else
--						receiver := folder_from_cluster (new_cluster)
--						a_cluster.actual_cluster.set_parent_cluster (Void)
--						receiver.actual_cluster.add_sub_cluster (a_cluster.actual_cluster)
--						receiver.clusters.extend (a_cluster)
--						a_cluster.set_parent (receiver)
--						new_cluster.sub_clusters.extend (moved_cluster)
--					end
--					Eiffel_universe.clusters.extend (a_cluster.actual_cluster)
--
--						-- Add `a_cluster' to the universe.
--					moved_cluster.set_parent_cluster (new_cluster)
--
--					moved_cluster.set_dollar_path (new_name)
--						-- Notify observers.
--					on_cluster_moved (a_cluster, old_cluster)
--				end
--			else
--					-- We could not move the cluster.
--				create wd.make_with_text ("Error: directory could not be moved.%N%
--										%Please check that files are still in their place and unique.")
--				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
--				moved_cluster.set_dollar_path (saved_dollar_path)
--			end
		rescue
			retried := True
			retry
		end

	add_cluster (a_cluster: EB_SORTED_CLUSTER; receiver: EB_SORTED_CLUSTER) is
			-- Add `a_cluster' to `receiver' and notify observers.
			-- Set `receiver' to `Void' if `a_cluster' should be at root-level.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			conf_todo
--			if receiver = Void then
--				a_cluster.actual_cluster.set_parent_cluster (Void)
--				clusters.extend (a_cluster)
--				a_cluster.set_parent (Void)
--				Eiffel_system.sub_clusters.extend (a_cluster.actual_cluster)
--			else
--				a_cluster.actual_cluster.set_parent_cluster (Void)
--				receiver.actual_cluster.add_sub_cluster (a_cluster.actual_cluster)
--				receiver.clusters.extend (a_cluster)
--				a_cluster.set_parent (receiver)
--			end
--			Eiffel_universe.clusters.extend (a_cluster.actual_cluster)
--			on_cluster_added (a_cluster.actual_cluster)
		end

	add_cluster_i (a_cluster: CLUSTER_I; receiver: CLUSTER_I; ace_path: STRING; is_recursive, is_library: BOOLEAN) is
			-- Add `a_cluster' to `receiver' and notify observers.
			-- `ace_path' is the
		require
			a_cluster_not_void: a_cluster /= Void
			receiver_not_void: receiver /= Void
			ace_path_not_void: ace_path /= Void
		local
			new_subcluster, new_supercluster: EB_SORTED_CLUSTER
			wd: EV_WARNING_DIALOG
		do
			if a_cluster.parent_cluster /= Void then
				a_cluster.parent_cluster.sub_clusters.prune_all (a_cluster)
			end
			add_cluster_in_ace (a_cluster, receiver, ace_path, is_recursive, is_library)
			if not error_in_config then
				new_subcluster := folder_from_cluster (a_cluster)
				if new_subcluster = Void then
						-- `a_cluster' was not in the system.
					create new_subcluster.make (a_cluster)
				end
				new_supercluster := folder_from_cluster (receiver)
				add_cluster (new_subcluster, new_supercluster)
			else
				create wd.make_with_text (Warning_messages.w_Could_not_parse_ace)
				wd.show_modal_to_window (Window_manager.last_focused_window.window)
			end
		end

	add_top_cluster_i (a_cluster: CLUSTER_I; ace_path: STRING; is_recursive, is_library: BOOLEAN) is
			-- Add `a_cluster' to the root of the universe and notify observers.
		require
			a_cluster_not_void: a_cluster /= Void
			ace_path_not_void: ace_path /= Void
		local
			new_subcluster: EB_SORTED_CLUSTER
			wd: EV_WARNING_DIALOG
		do
			if a_cluster.parent_cluster /= Void then
				a_cluster.parent_cluster.sub_clusters.prune_all (a_cluster)
			end
			add_top_cluster_in_ace (a_cluster, ace_path, is_recursive, is_library)
			if not error_in_config then
				new_subcluster := folder_from_cluster (a_cluster)
				if new_subcluster = Void then
						-- `a_cluster' was not in the system.
					create new_subcluster.make (a_cluster)
				end
				add_cluster (new_subcluster, Void)
			else
				create wd.make_with_text (Warning_messages.w_Could_not_parse_ace)
				wd.show_modal_to_window (Window_manager.last_focused_window.window)
			end
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

	move_directory (old_path: STRING; new_path: STRING) is
			-- Recursively move a directory from `old_path' to `new_path'.
			-- If renaming fails, copy recursively and delete.
		require
			old_path_not_void: old_path /= Void
			old_path_not_empty: not old_path.is_empty
			new_path_not_void: new_path /= Void
			new_path_not_empty: not new_path.is_empty
		local
			dir: DIRECTORY
			retried: BOOLEAN
		do
			if not retried then
				create dir.make (old_path)
				dir.change_name (new_path)
			end
		rescue
			create dir.make (new_path)
			dir_rec_copy (old_path, new_path)
			retried := True
			retry
		end

	dir_rec_copy (old_path: STRING; new_path: STRING) is
			-- Recursively move a directory from `old_path' to `new_path'.
		require
			old_path_not_void: old_path /= Void
			old_path_not_empty: not old_path.is_empty
			new_path_not_void: new_path /= Void
			new_path_not_empty: not new_path.is_empty
		local
			dir1, dir2: DIRECTORY
			tmpdir: DIRECTORY
			tmpfile: RAW_FILE
			file2: RAW_FILE
			fname1, fname2: FILE_NAME
			entry: STRING
			content: STRING
		do
			create dir1.make_open_read (old_path)
			create dir2.make (new_path)
			dir2.create_dir
			from
				dir1.start

					-- '.' and '..' must not be moved.
				dir1.readentry
				dir1.readentry

				dir1.readentry
				entry := dir1.lastentry
			until
				entry = Void
			loop
				create fname1.make_from_string (old_path)
				fname1.set_subdirectory (entry)
				create tmpdir.make (fname1)
				if tmpdir.exists then
					create fname2.make_from_string (new_path)
					fname2.set_subdirectory (entry)
					dir_rec_copy (fname1, fname2)
				else
					create tmpfile.make (fname1)
					if tmpfile.exists then
						tmpfile.open_read
						tmpfile.read_stream (tmpfile.count)
						content := tmpfile.last_string
						tmpfile.close
						create fname2.make_from_string (new_path)
						fname2.set_subdirectory (entry)
						create file2.make_create_read_write (fname2)
						file2.put_string (content)
						file2.close
						tmpfile.delete
					end
				end
				dir1.readentry
				entry := dir1.lastentry
			end
			dir1.close
			dir1.delete
--		rescue
--			io.put_string ("Cant move directory")
		end

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

	class_parents (a_class: CLASS_I): LINKED_LIST [CONF_GROUP] is
			-- list of parent clusters of `a_class', from the root to the class.
		require
			a_class_not_void: a_class /= Void
		do
			Result := cluster_parents (a_class.group)
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
				parent_cluster_sons := parent_cluster.clusters
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

	add_cluster_in_ace (a_cluster: CLUSTER_I; receiver: CLUSTER_I; ace_path: STRING; is_recursive, is_library: BOOLEAN) is
			-- Add an entry for `a_cluster' in the Ace file under `receiver'.
			-- If `receiver' is a recursive cluster, we set the flag `belongs_to_all'
			-- in `a_cluster'.
		require
			valid_new_cluster: a_cluster /= Void
--			valid_receiver: receiver /= Void and then Eiffel_universe.clusters.has (receiver)
			ace_path_not_void: ace_path /= Void
		local
			ace_clusters: LACE_LIST [CLUSTER_SD]
			cl_name: ID_SD
			retried: BOOLEAN
			found: BOOLEAN
			new_csd: CLUSTER_SD
		do
			conf_todo_msg ("precondition")
			conf_todo
--			error_in_ace_parsing := False
--			if not retried then
--				root_ast := Void
--				if Workbench.system_defined or else Eiffel_ace.file_name /= Void then
--						-- Create a new freshly parsed AST. If there is a
--						-- syntax error during parsing of chose Ace file,
--						-- we open an empty window.
--					root_ast := Eiffel_ace.Lace.parsed_ast
--				end
--				if root_ast /= Void then
--						-- We find the cluster_sd corresponding to `receiver' just because the flag
--						-- `is_recursive' in CLUSTER_I is not reliable (works only with override clusters).
--						-- Besides, we are thus ensured to be in conformance with the Ace file.
--					from
--						ace_clusters := root_ast.clusters
--						cl_name := new_id_sd (receiver.cluster_name, False)
--						ace_clusters.start
--						found := False
--					until
--						ace_clusters.after or
--						found
--					loop
--						found := ace_clusters.item.cluster_name.same_as (cl_name)
--						if found then
--							new_csd := ace_clusters.item
--						else
--							ace_clusters.forth
--						end
--					end
--					if
--							--| Useless test: found implies not receiver.belongs_to_all.
--						--|not receiver.belongs_to_all and
--						found and
--						not new_csd.is_recursive and
--						not receiver.is_library
--					then
--						ace_clusters := root_ast.clusters
--						create new_csd.initialize (new_id_sd (a_cluster.cluster_name, False),
--							new_id_sd (receiver.cluster_name, False),
--							new_id_sd (ace_path, True), Void, is_recursive, is_library)
--						ace_clusters.extend (new_csd)
--						save_content
--					else
--							-- We don't have to do anything.
--							-- Side effect: we set the correct flag to `a_cluster'.
--							-- It is the only place where the Ace is parsed, and since {CLUSTER_I}.`is_recursive'
--							-- does not work as expected, so we have to do it here.
--						a_cluster.set_belongs_to_all (True)
--							-- We didn't modify the Ace file.
--							-- However, we must perform a full degree 6 next time to keep the new cluster.
--						if root_ast.defaults = Void then
--							root_ast.set_defaults (create {LACE_LIST [D_OPTION_SD]}.make (5))
--						end
--						if not Lace.full_degree_6_needed then
--							root_ast.defaults.put_front (create {D_OPTION_SD}.initialize (
--								create {FREE_OPTION_SD}.initialize (
--									new_id_sd ("force_recompile", False)),
--									create {OPT_VAL_SD}.make_yes))
--							Lace.set_full_degree_6_needed (True)
--							save_content
--						end
--					end
--				else
--						-- We could not retrieve the `root_ast'.
--					error_in_ace_parsing := True
--				end
--			else
--				error_in_ace_parsing := True
--			end
		rescue
			retried := True
			retry
		end

	add_top_cluster_in_ace (a_cluster: CLUSTER_I; ace_path: STRING; is_recursive, is_library: BOOLEAN) is
			-- Add an entry for `a_cluster' in the Ace file at the top level.
		require
			valid_new_cluster: a_cluster /= Void
			ace_path_not_void: ace_path /= Void
		local
			ace_clusters: LACE_LIST [CLUSTER_SD]
			retried: BOOLEAN
			new_csd: CLUSTER_SD
		do
			error_in_config := False
			if not retried then
				if Workbench.system_defined or else Eiffel_ace.file_name /= Void then
						-- Create a new freshly parsed AST. If there is a
						-- syntax error during parsing of chose Ace file,
						-- we open an empty window.
					conf_todo
--					root_ast := Eiffel_ace.Lace.parsed_ast
				end
			else
				error_in_config := True
			end
		rescue
			retried := True
			retry
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
			l_target: CONF_TARGET
			l_cancel: BOOLEAN
			l_cl: CONF_CLUSTER
			l_print: CONF_PRINT_VISITOR
			l_file: PLAIN_TEXT_FILE
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
					-- force reparsing of file
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


	is_recursive_cluster (a_group: CONF_GROUP): BOOLEAN is
			-- Is `a_grp' a recursive cluster?
			-- (export status {NONE})
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
