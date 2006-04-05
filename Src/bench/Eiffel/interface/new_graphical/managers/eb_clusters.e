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
		do
			create observer_list.make (10)
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

	on_cluster_removed (a_cluster: CLUSTER_I) is
			-- `a_cluster' has been removed.
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
				observer_list.item.on_cluster_removed (sorted)
				observer_list.forth
			end
		end

	on_project_loaded is
			-- A new project has been loaded.
		do
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
		end

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
			class_list: SORTED_TWO_WAY_LIST [CLASS_I]
			actual_parent: CLUSTER_I
		do
				-- Notify observers.
			on_class_removed (a_class)

				-- Remove `a_class' from the universe.
			conf_todo
--			actual_parent := a_class.cluster
--			actual_parent.remove_class (a_class)
--
--				-- Remove `a_class' from the managed clusters.
--			class_list := (folder_from_cluster (actual_parent)).classes
--			class_list.start
--			class_list.prune_all (a_class)
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

	remove_cluster (a_cluster: EB_SORTED_CLUSTER) is
			-- Remove `a_cluster' from its parent and notify observers.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			cluster_list: SORTED_TWO_WAY_LIST [EB_SORTED_CLUSTER]
			actual_parent: CLUSTER_I
		do
				-- Notify observers.
--			on_cluster_removed (a_cluster.actual_cluster)

				-- Remove `a_cluster' from the universe.
--			actual_parent := a_cluster.actual_cluster.parent_cluster
--			if actual_parent /= Void then
--				actual_parent.sub_clusters.prune_all (a_cluster.actual_cluster)
--				cluster_list := a_cluster.parent.clusters
--			else
--				Eiffel_system.sub_clusters.prune_all (a_cluster.actual_cluster)
--				cluster_list := clusters
--			end
			conf_todo
--			Eiffel_universe.clusters.prune_all (a_cluster.actual_cluster)

				-- Remove `a_cluster' from the managed clusters.
			cluster_list.start
			cluster_list.prune_all (a_cluster)
		end

	remove_cluster_i (a_cluster: CLUSTER_I) is
			-- Remove `a_cluster' from its parent and notify observers.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			a_folder: EB_SORTED_CLUSTER
			wd: EV_WARNING_DIALOG
		do
			remove_group_from_config (a_cluster)
			if not error_in_config_parsing then
				a_folder := folder_from_cluster (a_cluster)
				remove_cluster (a_folder)
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
			if not error_in_config_parsing then
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
			if not error_in_config_parsing then
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

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

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

	folder_from_cluster (a_cluster: CLUSTER_I): EB_SORTED_CLUSTER is
			-- Find a sorted cluster representing `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			path: LINKED_LIST [CLUSTER_I]
		do
			path := cluster_parents (a_cluster)
			from
				path.start
			until
				path.after
			loop
				Result := find_cluster_in (path.item, Result)
				path.forth
			end
		end

	cluster_parents (cluster: CLUSTER_I): LINKED_LIST [CLUSTER_I] is
			-- list of parent clusters of `cluster', from the root to the cluster, `cluster' included.
		require
			valid_cluster: cluster /= Void
		local
			a_cluster: CLUSTER_I
		do
			from
				create Result.make
				a_cluster := cluster
			until
				a_cluster = Void -- root attained
			loop
				Result.put_front (a_cluster)
				a_cluster := a_cluster.parent_cluster
			end
		end

	class_parents (a_class: CLASS_I): LINKED_LIST [CLUSTER_I] is
			-- list of parent clusters of `a_class', from the root to the class.
		require
			a_class_not_void: a_class /= Void
		do
			conf_todo
--			Result := cluster_parents (a_class.cluster)
		end

	find_cluster_in (clusteri: CLUSTER_I; parent_cluster: EB_SORTED_CLUSTER): EB_SORTED_CLUSTER is
			-- Find the sorted cluster associated to `clusteri' in `parent_cluster'.
		require
			clusteri_not_void: clusteri /= Void
		local
			parent_cluster_sons: DS_LIST [EB_SORTED_CLUSTER]
		do
			if parent_cluster = Void then
--				parent_cluster_sons := clusters
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
			error_in_config_parsing := False
			if not retried then
				if Workbench.system_defined or else Eiffel_ace.file_name /= Void then
						-- Create a new freshly parsed AST. If there is a
						-- syntax error during parsing of chose Ace file,
						-- we open an empty window.
					conf_todo
--					root_ast := Eiffel_ace.Lace.parsed_ast
				end
			else
				error_in_config_parsing := True
			end
		rescue
			retried := True
			retry
		end

	remove_group_from_config (a_group: CONF_GROUP) is
			-- Remove the entry corresponding to `a_cluster' from the config file.
			-- If `a_cluster' belongs to a recursive cluster, add an exclude clause to its top parent.
		require
			valid_group: a_group /= Void
			not_readonly: not a_group.is_readonly
		local
			retried: BOOLEAN
			l_target: CONF_TARGET
		do
			error_in_config_parsing := False
			if not retried then
				if lace.has_changed then
					conf_todo_msg ("Inform user that configuration has changed, ask user if he wants to recompile.")
				end
				if not lace.has_changed then
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
				end
			else
				error_in_config_parsing := True
			end
		rescue
			retried := True
			retry
		end

	error_in_config_parsing: BOOLEAN
			-- Did an error occur during the last call to `add_cluster_in_ace' or `remove_group_from_config'?

feature {NONE} -- Attributes

	observer_list: ARRAYED_LIST [EB_CLUSTER_MANAGER_OBSERVER];

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
