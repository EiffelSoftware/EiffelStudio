indexing
	description	: "Object that encapsulates all the clusters and the classes of the project%
				  %The favorites are project-wide."
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

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialization.
		do
			create observer_list.make (10)
			create clusters.make
		end

feature -- Initialization

	load_tree is
			-- Load all clusters and classes.
		local
			sub_clusters: ARRAYED_LIST [CLUSTER_I]
			sorted_clusters: SORTABLE_ARRAY [EB_SORTED_CLUSTER]
			i: INTEGER
			clusters_item: CLUSTER_I
		do
			clusters.wipe_out
			if
				Eiffel_project.initialized and then
				Workbench.is_already_compiled
			 then
				sub_clusters := Eiffel_system.sub_clusters
					-- First retrieve all clusters without a parent and put them into an array
					-- that we will sort.
				create sorted_clusters.make (1, sub_clusters.count)
				from
					sub_clusters.start
					i := 1
				until
					sub_clusters.after
				loop
					clusters_item := sub_clusters.item
					sorted_clusters.put (create {EB_SORTED_CLUSTER}.make (clusters_item), i)
					i := i + 1

					sub_clusters.forth
				end
	
					-- Sort the clusters.
				sorted_clusters.sort

					-- Build the tree.
				from
					create clusters.make
					i := sorted_clusters.count 
				until
					i = 0
				loop
					clusters.extend (sorted_clusters @ i)
					i := i - 1
				end

				is_initialized := True
			end
		end

feature -- Observer Pattern

	add_observer (an_observer: EB_CLUSTER_MANAGER_OBSERVER) is
		do
			observer_list.extend (an_observer)
		end

	remove_observer (an_observer: EB_CLUSTER_MANAGER_OBSERVER) is
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
		end

feature -- Load/Save

feature -- Measurement

feature -- Status report

	clusters: SORTED_TWO_WAY_LIST [EB_SORTED_CLUSTER]

feature -- Status setting

	is_initialized: BOOLEAN
			-- Is the class initialized?

feature -- Cursor movement

feature -- Element change

	wipe_out is
			-- Erase the observer list.
		do
			observer_list.wipe_out
		end

	prune (obs: EB_CLUSTER_MANAGER_OBSERVER) is
			-- Prune an observer from the observer list.
		do
			observer_list.start
			observer_list.prune (obs)
		end

	extend (obs: EB_CLUSTER_MANAGER_OBSERVER) is
			-- Add an observer to the observer list.
		do
			observer_list.extend (obs)
		end

	remove_class (a_class: CLASS_I) is
			-- Remove `a_class' from its parent and notify observers.
		local
			class_list: SORTED_TWO_WAY_LIST [CLASS_I]
			actual_parent: CLUSTER_I
		do
				-- Notify observers.
			on_class_removed (a_class)

				-- Remove `a_class' from the universe.
			actual_parent := a_class.cluster
			actual_parent.remove_class (a_class)

				-- Remove `a_class' from the managed clusters.
			class_list := (folder_from_cluster (actual_parent)).classes
			class_list.start
			class_list.prune_all (a_class)
		end

	add_class (a_class: STRING; a_cluster: EB_SORTED_CLUSTER) is
			-- Add class with file name `a_class' to `a_cluster' and notify observers.
		local
			new_class: CLASS_I
		do
				-- Add `a_class' to the universe.
			a_cluster.actual_cluster.insert_class_from_file (a_class)
				-- Get the created CLASS_I.
			new_class := a_cluster.actual_cluster.class_with_base_name (a_class)

				-- Notify observers.
			if new_class /= Void then
				a_cluster.classes.extend (new_class)
				on_class_added (new_class)
			end
		end

	move_class (a_class: CLASS_I; old_cluster, new_cluster: CLUSTER_I) is
			-- Move `a_class' from `old_cluster' to `new_cluster'.
		require
			valid_class: a_class /= Void
			valid_clusters: old_cluster /= Void and new_cluster /= Void
		local
			class_list: SORTED_TWO_WAY_LIST [CLASS_I]
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
					not new_cluster.is_precompiled and then
					not old_cluster.is_precompiled and then
					not new_cluster.is_library and then
					not old_cluster.is_library and then
					old_cluster.path /= Void and then
					new_cluster.path /= Void
				then
					create tdirsrc.make (old_cluster.path)
					create tdirdes.make (new_cluster.path)
					if
						tdirsrc.exists and then
						tdirdes.exists
					then
						if
							not old_cluster.path.is_equal (new_cluster.path)
						then
							create old_file.make (a_class.file_name)
							create fname.make_from_string (new_cluster.path)
							fname.set_file_name (a_class.base_name)
							create new_file.make (fname)
							if
								old_file.exists and then
								old_file.is_readable and then
								old_file.is_writable and then
								new_file.is_creatable
							then
									-- Really move `a_class'.
								old_file.open_read
								old_file.readstream (old_file.count)
								old_file.close
								input := old_file.last_string
								new_file.create_read_write
								new_file.put_string (input)
								new_file.close
								old_file.delete
				
									-- Remove `a_class' from the universe.
								actual_parent := old_cluster
								actual_parent.classes.remove (a_class.name)
				
									-- Remove `a_class' from the managed clusters.
								class_list := (folder_from_cluster (actual_parent)).classes
								class_list.start
								class_list.prune_all (a_class)	
				
									-- Add `a_class' to the universe.
								a_class.set_cluster (new_cluster)
								new_cluster.classes.put (a_class, a_class.name)
				
									-- Add `a_class' to the managed clusters.
								new_sorted_cluster := folder_from_cluster (new_cluster)
								new_sorted_cluster.classes.extend (a_class)
				
									-- Notify observers.
								on_class_moved (a_class, old_cluster)
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
		local
			a_folder: EB_SORTED_CLUSTER
		do
			a_folder := folder_from_cluster (a_cluster)
			add_class (a_class, a_folder)			
		end

	remove_cluster (a_cluster: EB_SORTED_CLUSTER) is
			-- Remove `a_cluster' from its parent and notify observers.
		local
			cluster_list: SORTED_TWO_WAY_LIST [EB_SORTED_CLUSTER]
			actual_parent: CLUSTER_I
		do
				-- Notify observers.
			on_cluster_removed (a_cluster.actual_cluster)

				-- Remove `a_cluster' from the universe.
			actual_parent := a_cluster.actual_cluster.parent_cluster
			if actual_parent /= Void then
				actual_parent.sub_clusters.prune_all (a_cluster.actual_cluster)
				cluster_list := a_cluster.parent.clusters
			else
				Eiffel_system.sub_clusters.prune_all (a_cluster.actual_cluster)
				cluster_list := clusters
			end
			Eiffel_universe.clusters.prune_all (a_cluster.actual_cluster)

				-- Remove `a_cluster' from the managed clusters.
			cluster_list.start
			cluster_list.prune_all (a_cluster)
		end

	remove_cluster_i (a_cluster: CLUSTER_I) is
			-- Remove `a_cluster' from its parent and notify observers.
		local
			a_folder: EB_SORTED_CLUSTER
			wd: EV_WARNING_DIALOG
		do
			remove_cluster_from_ace (a_cluster)
			if not error_in_ace_parsing then
				a_folder := folder_from_cluster (a_cluster)
				remove_cluster (a_folder)
			else
				create wd.make_with_text (Warning_messages.w_Could_not_parse_ace)
				wd.show_modal_to_window (Window_manager.last_focused_window.window)
			end
		end

	move_cluster (moved_cluster: CLUSTER_I; new_cluster: CLUSTER_I) is
			-- Move `a_cluster' from `old_cluster' to `new_cluster'.
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
			if not retried then
				old_cluster := moved_cluster.parent_cluster
				if new_cluster = Void then
					create new_name.make_from_string ((create {EIFFEL_ENV}).Eiffel_installation_dir_name)
					new_name.set_subdirectory ("library")
				else
					create new_name.make_from_string (new_cluster.path)
				end
				new_name.set_subdirectory (get_cluster_name (moved_cluster))
				create test_dir.make (new_name)
				if test_dir.exists then
					create wd.make_with_text ("Directory with name:%N" + new_name + "already exists.")
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				else
						-- Move the cluster directory for real.
					create dir.make (moved_cluster.path)
					if new_cluster = Void then
						create new_name.make_from_string (Eiffel_project.name)
					else
						create new_name.make_from_string (new_cluster.dollar_path)
					end
					new_name.set_subdirectory (get_cluster_name (moved_cluster))
					saved_dollar_path := clone (moved_cluster.dollar_path)
					moved_cluster.set_dollar_path (new_name)
					move_directory (dir.name, moved_cluster.path)
					moved_cluster.set_dollar_path (saved_dollar_path)
	
					a_cluster := folder_from_cluster (moved_cluster)
						-- Remove `a_cluster' from the universe.
					actual_parent := old_cluster
					if actual_parent /= Void then
						actual_parent.sub_clusters.prune_all (a_cluster.actual_cluster)
						cluster_list := a_cluster.parent.clusters
					else
						Eiffel_system.sub_clusters.prune_all (a_cluster.actual_cluster)
						cluster_list := clusters
					end
					Eiffel_universe.clusters.prune_all (a_cluster.actual_cluster)
	
						-- Remove `a_cluster' from the managed clusters.
					cluster_list.start
					cluster_list.prune_all (a_cluster)

					if new_cluster = Void then
						a_cluster.actual_cluster.set_parent_cluster (Void)
						clusters.extend (a_cluster)
						a_cluster.set_parent (Void)
						Eiffel_system.sub_clusters.extend (a_cluster.actual_cluster)
					else
						receiver := folder_from_cluster (new_cluster)
						a_cluster.actual_cluster.set_parent_cluster (Void)
						receiver.actual_cluster.add_sub_cluster (a_cluster.actual_cluster)
						receiver.clusters.extend (a_cluster)
						a_cluster.set_parent (receiver)
						new_cluster.sub_clusters.extend (moved_cluster)
					end
					Eiffel_universe.clusters.extend (a_cluster.actual_cluster)

						-- Add `a_cluster' to the universe.
					moved_cluster.set_parent_cluster (new_cluster)

					moved_cluster.set_dollar_path (new_name)
						-- Notify observers.
					on_cluster_moved (a_cluster, old_cluster)
				end
			else
					-- We could not move the cluster.
				create wd.make_with_text ("Error: directory could not be moved.%N%
										%Please check that files are still in their place and unique.")
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				moved_cluster.set_dollar_path (saved_dollar_path)
			end
		rescue
			retried := True
			retry
		end

	add_cluster (a_cluster: EB_SORTED_CLUSTER; receiver: EB_SORTED_CLUSTER) is
			-- Add `a_cluster' to `receiver' and notify observers.
			-- Set `receiver' to `Void' if `a_cluster' should be at root-level.
		do
			if receiver = Void then
				a_cluster.actual_cluster.set_parent_cluster (Void)
				clusters.extend (a_cluster)
				a_cluster.set_parent (Void)
				Eiffel_system.sub_clusters.extend (a_cluster.actual_cluster)
			else
				a_cluster.actual_cluster.set_parent_cluster (Void)
				receiver.actual_cluster.add_sub_cluster (a_cluster.actual_cluster)
				receiver.clusters.extend (a_cluster)
				a_cluster.set_parent (receiver)
			end
			Eiffel_universe.clusters.extend (a_cluster.actual_cluster)
			on_cluster_added (a_cluster.actual_cluster)
		end

	add_cluster_i (a_cluster: CLUSTER_I; receiver: CLUSTER_I; is_recursive, is_library: BOOLEAN) is
			-- Add `a_cluster' to `receiver' and notify observers.
		local
			new_subcluster, new_supercluster: EB_SORTED_CLUSTER
			wd: EV_WARNING_DIALOG
		do
			if a_cluster.parent_cluster /= Void then
				a_cluster.parent_cluster.sub_clusters.prune_all (a_cluster)
			end
			add_cluster_in_ace (a_cluster, receiver, is_recursive, is_library)
			if not error_in_ace_parsing then
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

	add_top_cluster_i (a_cluster: CLUSTER_I; is_recursive, is_library: BOOLEAN) is
			-- Add `a_cluster' to the root of the universe and notify observers.
		local
			new_subcluster: EB_SORTED_CLUSTER
			wd: EV_WARNING_DIALOG
		do
			if a_cluster.parent_cluster /= Void then
				a_cluster.parent_cluster.sub_clusters.prune_all (a_cluster)
			end
			add_top_cluster_in_ace (a_cluster, is_recursive, is_library)
			if not error_in_ace_parsing then
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

	get_cluster_name (clu: CLUSTER_I): STRING is
			-- Extract a name for `clu', be it generated by a 'all' clause or not.
		local
			str: STRING
		do
			if not clu.belongs_to_all then
				Result := clu.cluster_name
			else
				str := clone (clu.cluster_name)
				Result := str.substring (str.last_index_of ('.', 1) + 1, str.count)
			end
		end

	name: STRING is "Clusters"
			-- Name of the item.

	move_directory (old_path: STRING; new_path: STRING) is
			-- Recursively move a directory from `old_path' to `new_path'.
			-- If renaming fails, copy recursively and delete.
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
						tmpfile.readstream (tmpfile.count)
						content := tmpfile.laststring
						tmpfile.close
						create fname2.make_from_string (new_path)
						fname2.set_subdirectory (entry)
						create file2.make_create_read_write (fname2)
						file2.putstring (content)
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
--			io.putstring ("Cant move directory")
		end

	folder_from_cluster (a_cluster: CLUSTER_I): EB_SORTED_CLUSTER is
			-- Find a sorted cluster representing `a_cluster'.
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
--		require
--			valid_cluster: cluster /= Void
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
		do
			Result := cluster_parents (a_class.cluster)
		end

	find_cluster_in (clusteri: CLUSTER_I; parent_cluster: EB_SORTED_CLUSTER): EB_SORTED_CLUSTER is
			-- Find the sorted cluster associated to `clusteri' in `parent_cluster'.
		local
			parent_cluster_sons: SORTED_TWO_WAY_LIST [EB_SORTED_CLUSTER]
		do
			if parent_cluster = Void then
				parent_cluster_sons := clusters
			else
				parent_cluster_sons := parent_cluster.clusters
			end

			from
				parent_cluster_sons.start
			until
				parent_cluster_sons.after or Result /= Void
			loop
				if parent_cluster_sons.item.actual_cluster = clusteri then
					Result := parent_cluster_sons.item
				end
				parent_cluster_sons.forth
			end
		end

	add_cluster_in_ace (a_cluster: CLUSTER_I; receiver: CLUSTER_I; is_recursive, is_library: BOOLEAN) is
			-- Add an entry for `a_cluster' in the Ace file under `receiver'.
			-- If `receiver' is a recursive cluster, we set the flag `belongs_to_all'
			-- in `a_cluster'.
		require
			valid_new_cluster: a_cluster /= Void
			valid_receiver: receiver /= Void and then Eiffel_universe.clusters.has (receiver)
		local
			ace_clusters: LACE_LIST [CLUSTER_SD]
			cl_name: ID_SD
			retried: BOOLEAN
			found: BOOLEAN
			new_csd: CLUSTER_SD
		do
			error_in_ace_parsing := False
			if not retried then
				root_ast := Void
				if Workbench.system_defined or else Eiffel_ace.file_name /= Void then
						-- Create a new freshly parsed AST. If there is a
						-- syntax error during parsing of chose Ace file,
						-- we open an empty window.
					root_ast := Eiffel_ace.Lace.parsed_ast
				end
				if root_ast /= Void then
						-- We find the cluster_sd corresponding to `receiver' just because the flag
						-- `is_recursive' in CLUSTER_I is not reliable (works only with override clusters).
						-- Besides, we are thus ensured to be in conformance with the Ace file.
					from
						ace_clusters := root_ast.clusters
						cl_name := new_id_sd (receiver.cluster_name, False)
						ace_clusters.start
						found := False
					until
						ace_clusters.after or
						found
					loop
						found := ace_clusters.item.cluster_name.same_as (cl_name)
						if found then
							new_csd := ace_clusters.item
						else
							ace_clusters.forth
						end
					end
					if
							--| Useless test: found implies not receiver.belongs_to_all.
						--|not receiver.belongs_to_all and
						found and
						not new_csd.is_recursive and
						not receiver.is_library
					then
						ace_clusters := root_ast.clusters
						new_csd := new_cluster_sd (new_id_sd (a_cluster.cluster_name, False), new_id_sd (receiver.cluster_name, False), new_id_sd (a_cluster.dollar_path, True), Void, is_recursive, is_library)
						ace_clusters.extend (new_csd)
						save_content
					else
							-- We don't have to do anything.
							-- Side effect: we set the correct flag to `a_cluster'.
							-- It is the only place where the Ace is parsed, and since {CLUSTER_I}.`is_recursive'
							-- does not work as expected, so we have to do it here.
						a_cluster.set_belongs_to_all (True)
							-- We didn't modify the Ace file.
							-- However, we must perform a full degree 6 next time to keep the new cluster.
						if root_ast.defaults = Void then
							root_ast.set_defaults (new_lace_list_d_option_sd (5))
						end
						if not Lace.full_degree_6_needed then
							root_ast.defaults.put_front (new_d_option_sd (new_free_option_sd (new_id_sd ("force_recompile", False)), new_yes_sd (new_id_sd ("yes", False))))
							Lace.set_full_degree_6_needed (True)
							save_content
						end
					end
				else
						-- We could not retrieve the `root_ast'.
					error_in_ace_parsing := True
				end
			else
				error_in_ace_parsing := True
			end
		rescue
			retried := True
			retry
		end

	add_top_cluster_in_ace (a_cluster: CLUSTER_I; is_recursive, is_library: BOOLEAN) is
			-- Add an entry for `a_cluster' in the Ace file at the top level.
		require
			valid_new_cluster: a_cluster /= Void
		local
			ace_clusters: LACE_LIST [CLUSTER_SD]
			retried: BOOLEAN
			new_csd: CLUSTER_SD
		do
			error_in_ace_parsing := False
			if not retried then
				root_ast := Void
				if Workbench.system_defined or else Eiffel_ace.file_name /= Void then
						-- Create a new freshly parsed AST. If there is a
						-- syntax error during parsing of chose Ace file,
						-- we open an empty window.
					root_ast := Eiffel_ace.Lace.parsed_ast
				end
				if root_ast /= Void then
					ace_clusters := root_ast.clusters
					new_csd := new_cluster_sd (new_id_sd (a_cluster.cluster_name, False), Void, new_id_sd (a_cluster.dollar_path, True), Void, is_recursive, is_library)
					ace_clusters.extend (new_csd)
					save_content
				else
						-- We could not retrieve the `root_ast'.
					error_in_ace_parsing := True
				end
			else
				error_in_ace_parsing := True
			end
		rescue
			retried := True
			retry
		end

	remove_cluster_from_ace (a_cluster: CLUSTER_I) is
			-- Remove the entry corresponding to `a_cluster' from the Ace file.
			-- If `a_cluster' belongs to a all clause, add an exclude clause to its top parent.
		require
			valid_old_cluster: a_cluster /= Void
			not_library: not a_cluster.is_library
		local
			ace_clusters: LACE_LIST [CLUSTER_SD]
			explored: LACE_LIST [CLUSTER_SD]
			children: LACE_LIST [CLUSTER_SD]
			cl_name: ID_SD
			retried: BOOLEAN
			found: BOOLEAN
			child: BOOLEAN
			cp: CLUST_PROP_SD
			excl_sd: EXCLUDE_SD
			new_csd: CLUSTER_SD
			list_sd: LACE_LIST [EXCLUDE_SD]
		do
			error_in_ace_parsing := False
			if not retried then
				root_ast := Void
				if Workbench.system_defined or else Eiffel_ace.file_name /= Void then
						-- Create a new freshly parsed AST. If there is a
						-- syntax error during parsing of chose Ace file,
						-- we open an empty window.
					root_ast := Eiffel_ace.Lace.parsed_ast
				end
				if root_ast /= Void then
					if not a_cluster.belongs_to_all then
							-- We remove a top-level cluster from the Ace, as well as all its children.
						error_in_ace_parsing := False
						cl_name := new_id_sd (a_cluster.cluster_name, False)
						create explored.make (10)
						ace_clusters := root_ast.clusters
							-- First, we find the cluster_sd corresponding to `a_cluster'.
						from
							ace_clusters.start
						until
							found or ace_clusters.after
						loop
							found := cl_name.is_equal (ace_clusters.item.cluster_name)
							if found then
								explored.extend (ace_clusters.item)
								ace_clusters.remove
							else
								ace_clusters.forth
							end
						end
							-- Then, we remove all the children.
						from
						until
							explored.is_empty
						loop
							from
								create children.make (10)
								ace_clusters.start
							until
								ace_clusters.after
							loop
									-- We remove all the children of `explored' clusters.
								if ace_clusters.item.has_parent then
									cl_name := ace_clusters.item.parent_name
									from
										explored.start
										child := False
									until
										explored.after or child
									loop
										if explored.item.cluster_name.same_as (cl_name) then
											child := True
										else
											explored.forth
										end
									end
									if child then
											-- `ace_clusters.item' is a child of one of the explored clusters.
										children.extend (ace_clusters.item)
										ace_clusters.remove
									else
										ace_clusters.forth
									end
								else
									ace_clusters.forth
								end
							end
							explored := children
						end
						if not found then
							error_in_ace_parsing := True
						else
							save_content
						end
					else
							-- We have to add an exclude clause.
						cl_name := new_id_sd (top_parent (a_cluster).cluster_name, False)
						ace_clusters := root_ast.clusters
						from
							ace_clusters.start
						until
							ace_clusters.after or else
							found
						loop
							found := cl_name.is_equal (ace_clusters.item.cluster_name)
							if found then
									-- We add an exclude clause to the top parent.
								excl_sd := new_exclude_sd (new_id_sd (base_name (a_cluster), False))
								cp := ace_clusters.item.cluster_properties
								if cp = Void then
									list_sd := new_lace_list_exclude_sd (5)
									list_sd.extend (excl_sd)
									cp := new_clust_prop_sd (Void, Void, Void, list_sd, Void, Void, Void, Void)
								else
									if cp.exclude_option = Void then
										list_sd := new_lace_list_exclude_sd (5)
										list_sd.extend (excl_sd)
									else
										list_sd := cp.exclude_option
										list_sd.extend (excl_sd)
									end
									cp := new_clust_prop_sd (cp.dependencies, cp.use_name, cp.include_option, list_sd, cp.adapt_option, cp.default_option, cp.options, cp.visible_option)
								end
								new_csd := ace_clusters.item
								new_csd := new_cluster_sd (new_csd.cluster_name, new_csd.parent_name, new_csd.directory_name, cp, new_csd.is_recursive, new_csd.is_library)
								ace_clusters.replace (new_csd)
								save_content
							else
								ace_clusters.forth
							end
						end
						if not found then
							error_in_ace_parsing := True
						end
					end
				else
						-- We could not retrieve the `root_ast'.
					error_in_ace_parsing := True
				end
			else
				error_in_ace_parsing := True
			end
		rescue
			retried := True
			retry
		end

	save_content is
			-- Store `Ace' file with/without new cluster.
		local
			st: GENERATION_BUFFER
			ace_file: PLAIN_TEXT_FILE
			ast: like root_ast
		do
			if Eiffel_ace.file_name = Void or else root_ast = Void then
					-- Creation of AST.
				create root_ast
			end

			ast := root_ast.duplicate
			
			create st.make (2048)
			ast.save (st)
			if Eiffel_ace.file_name = Void then
				error_in_ace_parsing := True
			else
				create ace_file.make_open_write (Eiffel_ace.file_name)
				ace_file.put_string (st)
				ace_file.close
			end
		end

	root_ast: ACE_SD
			-- Current Ace representation we are working on (to add/remove clusters).

	error_in_ace_parsing: BOOLEAN
			-- Did an error occur during the last call to `add_cluster_in_ace' or `remove_cluster_from_ace'?

	top_parent (a_cluster: CLUSTER_I): CLUSTER_I is
			-- Returns the top-parent cluster of `a_cluster'.
		require
			valid_cluster: a_cluster /= Void
		local
			curclu: CLUSTER_I
			par: CLUSTER_I
		do
			from
				curclu := a_cluster
				par := a_cluster.parent_cluster
			until
				par = Void
			loop
				curclu := par
				par := curclu.parent_cluster
			end
			Result := curclu
		end

	base_name (a_cluster: CLUSTER_I): STRING is
			-- Name of `a_cluster' (belonging to all) without the leading parents.
		require
			a_cluster_not_void: a_cluster /= Void
			a_cluster_belongs_to_all: a_cluster.belongs_to_all
		do
			Result := a_cluster.cluster_name.substring (a_cluster.cluster_name.last_index_of ('.', a_cluster.cluster_name.count) + 1, a_cluster.cluster_name.count)
		end

feature {NONE} -- Attributes

	observer_list: ARRAYED_LIST [EB_CLUSTER_MANAGER_OBSERVER]

end -- class EB_CLUSTERS
