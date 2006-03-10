indexing
	description: "Internal representation of a cluster"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_I

inherit
	SHARED_ERROR_HANDLER
		export {NONE} all end

	SHARED_WORKBENCH
		export
			{NONE} all
			{ANY} compilation_modes
		end

	SHARED_EIFFEL_PROJECT
		export {NONE} all end

	SHARED_ENV
		export {NONE} all end

	SHARED_RESCUE_STATUS
		export {NONE} all end

	PROJECT_CONTEXT
		export {NONE} all end

	COMPARABLE
		undefine
			is_equal
		end

	COMPILER_EXPORTER
		export {NONE} all end

	SHARED_CONFIGURE_RESOURCES
		export {NONE} all end

	SHARED_LACE_PARSER
		export {NONE} all end

create
	make_with_parent,
	make_from_old_cluster,
	make_from_precompiled_cluster

create {CLUSTER_I}
	make

feature {COMPILER_EXPORTER} -- Initialization

	make_with_parent (p: STRING; par_clus: like Current) is
			-- Create Current as a subcluster of `par_clus'.
		require
			path_not_void: p /= Void
		do
			make (p)
			if par_clus = Void then
				Eiffel_system.add_sub_cluster (Current)
			else
				par_clus.add_sub_cluster (Current)
			end
		end

	make_from_old_cluster (old_cluster_i: like Current; par_clus: like Current) is
		require
			valid_arg: old_cluster_i /= Void
		do
			make_with_parent (old_cluster_i.dollar_path, par_clus)

			copy_old_cluster (old_cluster_i)

			parent_cluster := par_clus
			cluster_name := old_cluster_i.cluster_name
		end

	make_from_precompiled_cluster (old_cluster_i: like Current) is
		require
			valid_arg: old_cluster_i /= Void
		do
			make (old_cluster_i.dollar_path)

			copy_old_cluster (old_cluster_i)

			cluster_name := old_cluster_i.cluster_name
			parent_cluster := Void
		end

feature {CLUSTER_I} -- Internal initialization

	make (p: STRING) is
			-- Create Current with path `p'.
		do
			dollar_path := p
			update_path
			create classes.make (30)
			create overriden_classes.make (5)
			create sub_clusters.make (3)
		end

feature -- Attributes

	date: INTEGER
			-- Date for time stamp

	cluster_name: STRING
			-- Cluster name

	dollar_path: STRING
			-- Path to the cluster (with environment variables)

	path: STRING
			-- Path to the cluster (without environment variables)

	classes: HASH_TABLE [CLASS_I, STRING]
			-- Classes available in the cluster: key is the declared
			-- name and entry is the class

	overriden_classes: like classes
			-- Classes available in cluster, but not to system since overriden.
			-- Key is declared name, entry is class instance

	ignore: LINKED_LIST [CLUSTER_I]
			-- Cluster to ignore

	is_precompiled: BOOLEAN
			-- Is the cluster precompiled
			-- It won't be removed even if it is no more
			-- in the local Ace file

	is_assembly: BOOLEAN is
			-- Is current an instance of ASSEMBY_I?
		do
		end

	is_override_cluster: BOOLEAN
			-- Does this cluster override the other clusters?

	parent_cluster: CLUSTER_I
			-- Parent cluster of Current cluster
			-- (Void implies it is a top level cluster)

	sub_clusters: ARRAYED_LIST [CLUSTER_I]
			-- List of sub clusters for Current cluster

	is_recursive: BOOLEAN
			-- Are subclusters processed recursively?

	is_library: BOOLEAN
			-- Are cluster and subclusters part of a library whose classes
			-- cannot be modified?

	belongs_to_all: BOOLEAN
			-- Is cluster created because it was a subdirectory of a cluster
			-- specified with `all' specification in Ace file?

	indexes: INDEXING_CLAUSE_AS is
			-- Indexing clause located in "indexing.txt".
			--| NOTE: VB 07/03/2000 For now, not an attribute.
		do
			Result := build_indexes
		end

feature {CLUSTER_I}

	old_cluster: CLUSTER_I
			-- Old version of the cluster

	renamings: LINKED_LIST [RENAME_I]
			-- Renamings for the cluster

	precomp_id: INTEGER
			-- Id of the precompiled library to which the
			-- cluster belongs

	precomp_ids: ARRAY [INTEGER]
			-- Ids of libraries used for precompilation
			-- of current cluster; Void if not precompiled

	exclude_list: ARRAYED_LIST [STRING]
			-- List of files to exclude

	include_list: ARRAYED_LIST [STRING]
			-- List of files to include

	hide_implementation: BOOLEAN
			-- Hide the implementation code of
			-- precompiled classes?

feature -- Access

	display_name: STRING is
			-- Name of cluster without preceeding parents.
		do
			if belongs_to_all then
				Result := cluster_name.substring (
					cluster_name.last_index_of ('.', cluster_name.count) + 1, cluster_name.count)
			else
				Result := cluster_name
			end
		ensure
			Result_not_void: Result /= Void
		end

	has_base_name (b_name: STRING): BOOLEAN is
			-- Does cluster have a class with base name `b_name'?
		require
			non_void_base_name: b_name /= Void
		do
			from
				classes.start
			until
				classes.after or else Result
			loop
				Result := b_name.is_equal (classes.item_for_iteration.base_name)
				classes.forth
			end
		end

	class_with_base_name (b_name: STRING): CLASS_I is
			-- Class with base name `b_name' if any.
		require
			non_void_base_name: b_name /= Void
		do
			from
				classes.start
			until
				classes.after
			loop
				if b_name.is_equal (classes.item_for_iteration.base_name) then
					Result := classes.item_for_iteration
				end
				classes.forth
			end
		end

	class_with_name (b_name: STRING): CLASS_I is
			-- Class with name `b_name' if any.
		require
			non_void_name: b_name /= Void
		do
			from
				classes.start
			until
				classes.after
			loop
				if b_name.is_equal (classes.item_for_iteration.name) then
					Result := classes.item_for_iteration
				end
				classes.forth
			end
		end

	name_in_upper: STRING is
			-- Cluster name in upper case
		do
			Result := cluster_name.as_upper
		end

	top_of_recursive_cluster: CLUSTER_I is
			-- Top most cluster when Current is a subcluster that belongs
			-- to a recursive cluster. Otherwise `Current'.
		do
			if parent_cluster = Void then
				Result := Current
			else
				if parent_cluster.belongs_to_all then
					Result := parent_cluster.top_of_recursive_cluster
				else
					Result := parent_cluster
				end
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	add_sub_cluster (c: like Current) is
			-- Add cluster `c' to `sub_clusters.
		require
			valid_c: c /= Void
			not_added: sub_clusters /= Void
			parent_not_set: c.parent_cluster = Void
		do
			sub_clusters.extend (c)
			c.set_parent_cluster (Current)
		ensure
			has_c: sub_clusters.has (c)
			parent_cluster_set: c.parent_cluster = Current
		end

feature {COMPILER_EXPORTER} -- Conveniences

	set_parent_cluster (c: like parent_cluster) is
			-- Set `parent_cluster' to `c'.
			-- Use with c = Void to set `Current' as a root-level cluster.
--		require
--			valid_c: c /= Void
		do
			parent_cluster := c
		end

	set_date (i: INTEGER) is
			-- Assign `i' to `date'.
		do
			date := i
		end

	set_cluster_name (s: STRING) is
			-- Assign `s' to `cluster_name'.
		do
			cluster_name := s
		end

	set_old_cluster (c: like old_cluster) is
			-- Assign `c' to `old_cluster'.
		do
			old_cluster := c
		end

	set_is_precompiled (ids: ARRAY [INTEGER]) is
			-- Assign `True' to `is_precompiled'
		do
			if not is_precompiled then
				is_precompiled := True
				precomp_id := System.compilation_id
				precomp_ids := ids
			end
		end

	set_dollar_path (s: STRING) is
			-- Assign `s' to `path'.
		do
			dollar_path := s
			update_path
		end

	update_path is
		do
			if dollar_path /= Void then
				path := Environ.interpreted_string (dollar_path)
			end
		end

	set_is_override_cluster (flag: BOOLEAN) is
			-- Set `is_override_cluster' to `flag'.
		do
			is_override_cluster := flag
		end

	set_is_recursive (is_rec: BOOLEAN) is
			-- Set `is_recursive' to `is_rec'.
		do
			is_recursive := is_rec
		ensure
			set: is_recursive = is_rec
		end

	set_is_library (is_lib: BOOLEAN) is
			-- Set `is_library' to `is_lib'.
		do
			is_library := is_lib
		ensure
			set: is_library = is_lib
		end

	set_belongs_to_all (flag: BOOLEAN) is
			-- Set `belongs_to_all' to `flag'.
		do
			belongs_to_all := flag
		ensure
			set: belongs_to_all = flag
		end

feature {COMPILER_EXPORTER} -- Element change

	copy_old_cluster (old_cluster_i: like Current) is
			-- Copy all the information except the ignore
			-- and renaming clauses
		local
			cl: like classes
			c: CLASS_I
		do
			debug ("REMOVE_CLASS")
				io.error.put_string ("Copy old_cluster ")
				io.error.put_string (old_cluster_i.cluster_name)
				io.error.put_string (" path ")
				io.error.put_string (old_cluster_i.path)
				io.error.put_new_line
			end
			old_cluster := old_cluster_i
			parent_cluster := old_cluster.parent_cluster
			is_precompiled := old_cluster_i.is_precompiled
			precomp_id := old_cluster_i.precomp_id
			precomp_ids := old_cluster_i.precomp_ids
			set_date (old_cluster_i.date)
			set_is_recursive (old_cluster_i.is_recursive)
			set_is_library (old_cluster_i.is_library)
			set_belongs_to_all (old_cluster_i.belongs_to_all)
			exclude_list := old_cluster_i.exclude_list
			include_list := old_cluster_i.include_list
			renamings := old_cluster.renamings
			hide_implementation := old_cluster.hide_implementation
			from
				cl := old_cluster.classes
				cl.start
			until
				cl.after
			loop
				c := cl.item_for_iteration
				classes.put (c, cl.key_for_iteration)
				c.set_cluster (Current)
				cl.forth
			end

			from
				cl := old_cluster.overriden_classes
				cl.start
			until
				cl.after
			loop
				c := cl.item_for_iteration
				overriden_classes.put (c, cl.key_for_iteration)
				c.set_cluster (Current)
				cl.forth
			end
				-- No need to keep a reference to `old_cluster' in `old_cluster_i'
				-- as first it will not be used since now only `old_cluster_i' will be
				-- used as `old_cluster' in Current. Second because it is causing a huge
				-- memory leak when using a precompiled library.
			old_cluster_i.set_old_cluster (Void)
		end

	reset_cluster is
			-- Reset the attribute `cluster' of all the CLASS_I
			-- (copy_old_cluster may have introduced an inconsistent
			-- state)
		do
			from
				classes.start
			until
				classes.after
			loop
				classes.item_for_iteration.set_cluster (Current)
				classes.forth
			end
		end

	insert_renaming (cl: CLUSTER_I; old_name, new_name: STRING) is
			-- Insert renaming of a class of `cl' named `old_name'
			-- into `new_name'.
		require
			cl /= Void
			old_name /= Void
			new_name /= Void
			consistency: cl.classes.has (old_name)
		local
			rename_clause: RENAME_I
		do
			rename_clause := rename_clause_for (cl)
			if rename_clause = Void then
				create rename_clause.make
				rename_clause.set_cluster (cl)
				if renamings = Void then
					create renamings.make
				end
				renamings.put_front (rename_clause)
			end
			rename_clause.renamings.put (old_name, new_name)
		end

	rename_clause_for (cl: CLUSTER_I): RENAME_I is
			-- Rename clause of classes from cluster `cl'
		require
			good_argument: cl /= Void
		local
			rename_clause: RENAME_I
		do
			if renamings /= Void then
				from
					renamings.start;
				until
					renamings.after or else Result /= Void
				loop
					rename_clause := renamings.item
					if rename_clause.cluster = cl then
						Result := rename_clause
					end
					renamings.forth
				end
			end
		end

	open_directory_error (cluster_file: DIRECTORY): BOOLEAN is
			-- Does the opening of the directory file `cluster_file'
			-- trigger an error ?
		require
			good_argument: cluster_file /= Void
		do
			if not Result then
				cluster_file.open_read
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				Result := True
				retry
			end
		end

	duplicate: CLUSTER_I is
			-- Duplicate content of Current.
		do
			create Result.make (dollar_path)
			Result.copy_old_cluster (Current)
			Result.set_cluster_name (cluster_name)
		end

	new_cluster (name: STRING; ex_l, inc_l: LACE_LIST [FILE_NAME_SD]
				 process_subclusters, is_lib: BOOLEAN; par_clus: like Current): CLUSTER_I is
		local
			l_is_override: BOOLEAN
		do
			l_is_override := Universe.has_override_cluster_of_name (name)

				-- If the cluster has changed or if it is an override cluster,
				-- do a degree 6
			if
				l_is_override or
				not (is_lib and is_lib = is_library) and then
				(changed (ex_l, inc_l) or else
				process_subclusters /= is_recursive)
			then
				create Result.make_with_parent (dollar_path, par_clus)
				Result.set_cluster_name (name)
				Universe.insert_cluster (Result)

				Result.set_old_cluster (duplicate)
				debug ("REMOVE_CLASS")
					io.error.put_string ("New cluster calling fill%N")
				end
				Result.set_is_recursive (process_subclusters)
				Result.set_belongs_to_all (belongs_to_all)
				Result.fill (ex_l, inc_l)
			else
				create Result.make_from_old_cluster (Current, par_clus)
				Result.set_cluster_name (name)
				Universe.insert_cluster (Result)
			end
			Result.set_is_override_cluster (l_is_override)
		end

	fill (ex_l, inc_l: LACE_LIST [FILE_NAME_SD]) is
			-- Fill the cluster name table with what is found in the path.
		require
			table_is_empty: classes.is_empty
		local
			file_name, cl_id: STRING
			i: INTEGER
			already_done: LINKED_LIST [STRING]
		do
				-- Process the include and exclude lists
			if ex_l /= Void then
				from
					create exclude_list.make_filled (ex_l.count)
					i := 1
				until
					i > ex_l.count
				loop
					file_name := Environ.interpreted_string (ex_l.i_th (i).file__name)
					exclude_list.put_i_th (file_name, i)
					i := i + 1
				end
			end

			if inc_l /= Void then
				from
					create include_list.make_filled (inc_l.count)
					i := 1
				until
					i > inc_l.count
				loop
					file_name := Environ.interpreted_string
										(inc_l.i_th (i).file__name)
					include_list.put_i_th (file_name, i)
					i := i + 1
				end
			end
			Error_handler.checksum

				-- Set date first
			date := new_date

			if is_recursive then
				create already_done.make
				already_done.compare_objects
				cl_id := physical_id (path)
				already_done.extend (cl_id)
			end

			fill_recursively (path, "", already_done)

			Error_handler.checksum
		end

	fill_recursively (cl_path, suffix : STRING; already_done: LINKED_LIST [STRING]) is
			-- Fill the cluster name table with what is found in the path.
			-- If `is_recursive' is True process subclusters recursively.
			-- Keep track of clusters already processed in `already_done'.
			-- `cl_path' is the full path, `suffix' is the full path
			-- minus the prefix `path'.
		require
			path_exists: cl_path /= Void
			suffix_exists: suffix /= Void
			valid_list: is_recursive implies already_done /= Void
		local
			cluster_file: DIRECTORY
			file_name: STRING
			prefixed_file_name: FILE_NAME
			i, j: INTEGER
			class_path: FILE_NAME
			vd01: VD01
			vd21: VD21
			class_file: PLAIN_TEXT_FILE
			is_efile, check_dir, found: BOOLEAN
			sub_dirs: LINKED_LIST [FILE_NAME]
			suffixes: LINKED_LIST [FILE_NAME]
			sub_dir_path: FILE_NAME
			sub_dir_suffix: FILE_NAME
			sub_dir_file: DIRECTORY
			sub_dir_id: STRING
		do
			if is_recursive then
				Degree_output.put_recursive_degree_6 (Current, cl_path)
			end

			create cluster_file.make (cl_path)
			if not cluster_file.exists then
				create vd01
				vd01.set_path (cl_path)
				vd01.set_cluster_name (cluster_name)
				Error_handler.insert_error (vd01)
				Error_handler.raise_error
			end

			if open_directory_error (cluster_file) then
				create vd21
				vd21.set_cluster (Current)
				vd21.set_file_name (cluster_file.name)
				Error_handler.insert_error (vd21)
			else
				if is_recursive then
					create sub_dirs.make
					create suffixes.make
				end
				from
					cluster_file.start
					cluster_file.readentry
					file_name := cluster_file.lastentry
				until
					file_name = Void
				loop
					i := file_name.count

					-- Must we check if it is a subcluster?
					check_dir := is_recursive and then
								 not is_current_or_parent_cluster (file_name)

					-- Is it an Eiffel source file?
					is_efile := (i > 2) and then
								(file_name.item (i-1) = Dot) and then
								valid_class_file_extension (file_name.item (i))

					if check_dir or is_efile then
						-- First check if it is excluded.
						found := False

						if exclude_list /= Void then
							from
								i := 1
							until
								i > exclude_list.count or else found
							loop
								if file_name.is_equal (exclude_list.i_th (i)) then
									found := True
								end
								i := i + 1
							end
						end

						if not found then
							if check_dir then
								-- Check that it is really a directory.
								create sub_dir_path.make_from_string (cl_path)
								sub_dir_path.extend (file_name)
								create sub_dir_suffix.make_from_string (suffix)
								sub_dir_suffix.extend (file_name)
								create sub_dir_file.make (sub_dir_path)

								if sub_dir_file.exists then
									-- Add it to the list
									sub_dirs.extend (sub_dir_path)
									suffixes.extend (sub_dir_suffix)
								else
									if is_efile then
										create prefixed_file_name.make_from_string (suffix)
										prefixed_file_name.extend (file_name)
										-- It's an Eiffel source file.
										insert_class_from_file (prefixed_file_name)
									end
								end
							else
								-- It's an Eiffel source file.
								insert_class_from_file (file_name)
							end
						end
					end

					cluster_file.readentry
					file_name := cluster_file.lastentry
				end

				cluster_file.close

				if include_list /= Void then
					from
						i := 1
					until
						i >  include_list.count
					loop
						file_name := include_list.i_th (i)
						found := False
						if exclude_list /= Void then
							from
								j := 1
							until
								j > exclude_list.count or else found
							loop
								if file_name.is_equal (exclude_list.i_th (j)) then
									found := True
								end
								j := j + 1
							end
						end
						if not found then
							-- If file exists insert it.
							create class_path.make_from_string (cl_path)
							class_path.set_file_name (file_name)
							create class_file.make (class_path)
							if class_file.exists then
								if is_recursive then
									create prefixed_file_name.make_from_string(suffix)
									prefixed_file_name.extend (file_name)
									insert_class_from_file (prefixed_file_name)

								else
									insert_class_from_file (file_name)
								end
							end
						end
						i := i + 1
					end
				end
			end
			Error_handler.checksum

			if sub_dirs /= Void then
				-- Process subclusters
				from
					sub_dirs.start
					suffixes.start
				until
					sub_dirs.after
				loop
					sub_dir_path := sub_dirs.item
					sub_dir_suffix := suffixes.item
					sub_dir_id := physical_id (sub_dir_path)

					if not already_done.has (sub_dir_id) then
						already_done.extend (sub_dir_id)
						fill_recursively (sub_dir_path, sub_dir_suffix, already_done)
					end
					sub_dirs.forth
					suffixes.forth
				end
			end
		end

	force_compilation_on_class_from_file (file_name: STRING) is
			-- Insert class written in `file_name' into current
			-- cluster and make sure it will be compiled.
		require
			file_name_not_void: file_name /= Void
		local
			class_path: FILE_NAME
			class_name: STRING
			class_i: CLASS_I
		do
			create class_path.make_from_string (path)
			class_path.set_file_name (file_name)
			class_name := read_class_name_in_file (class_path)
			check
				class_name_not_void: class_name /= Void
				class_does_not_exist: classes.item (class_name) = Void
			end
			insert_class_from_file (file_name)
			class_i := classes.item (class_name)
			check
				class_i_not_void: class_i /= Void
			end
				-- Insert class to current project
			System.add_unref_class (class_i)
		end

	insert_class_from_file (file_name: STRING) is
		local
			class_path: FILE_NAME
			a_class: like class_anchor
			class_name: STRING
			vscn: VSCN
			str: ANY
		do
			create class_path.make_from_string (path)
			class_path.set_file_name (file_name)
			class_name := read_class_name_in_file (class_path)
			if class_name /= Void then
				debug ("REMOVE_CLASS")
					io.error.put_string ("Insert class from file ")
					io.error.put_string (class_name)
					io.error.put_new_line
				end
				a_class := classes.item (class_name)
				if a_class /= Void then
					-- Error
					create vscn
					vscn.set_cluster (Current)
					vscn.set_first (a_class)
					create a_class.make (class_name)
					a_class.set_base_name (file_name)
					a_class.set_cluster (Current)
					vscn.set_second (a_class)
					Error_handler.insert_error (vscn)
					Error_handler.raise_error
				end
					-- Valid eiffel class in file
				if old_cluster /= Void then
					debug ("REMOVE_CLASS")
						io.error.put_string ("Old cluster not Void%N")
					end
					a_class := old_cluster.classes.item (class_name)
					if a_class /= Void then
							-- The file name may have changed even
							-- if the class was already in this cluster
						debug ("REMOVE_CLASS")
							io.error.put_string ("Old cluster has the class%N")
						end
						a_class.set_base_name (file_name)
						a_class.set_cluster (Current)
						a_class.set_read_only (is_library)
						str := class_path.to_c
						if eif_date ($str) /= a_class.date then
							if a_class.is_compiled then
									-- The class has changed
								Workbench.change_class (a_class)
							end
							a_class.set_date
						end
					end
				end
				if a_class = Void then
					debug ("REMOVE_CLASS")
						io.error.put_string ("new class!!!%N")
					end
					create a_class.make (class_name)
					a_class.set_base_name (file_name)
					a_class.set_cluster (Current)
					a_class.set_date
					a_class.set_read_only (is_library)
				end
				if Workbench.automatic_backup then
					record_class (class_name)
				end

				classes.put (a_class, class_name)
			end
		end

	read_class_name_in_file (file_name: STRING): STRING is
			-- Read the name of a class in a file
			-- Check if there is already a class with this name
			-- in the cluster
		local
			class_file: KL_BINARY_INPUT_FILE
			vd10: VD10
			vd21: VD21
		do
			create class_file.make (file_name)
			class_file.open_read
			if not class_file.is_open_read then
					-- Error when opening file
				create vd21
				vd21.set_cluster (Current)
				vd21.set_file_name (file_name)
				Error_handler.insert_error (vd21)
			else
				Classname_finder.parse (class_file)
				Result := Classname_finder.classname
				class_file.close
				if Result /= Void then
						-- Eiffel class in file
					Result.to_upper
				else
						-- No class in file
					create vd10
					vd10.set_cluster (Current)
					vd10.set_file_name (file_name)
					Error_handler.insert_error (vd10)
				end
			end
		ensure
			read_class_name_in_file_in_upper:
				Result /= Void implies (Result.is_equal (Result.as_upper))
		end

	restore_compiled_class (new_class, old_class: CLASS_I) is
			-- Store `old_class' compiled info into `new_class' and force
			-- a syntactical recompilation of `new_class' just to be sure
			-- we will compiled it even if it did not change since last time
			-- as it might have a completely different content than `old_class'.
		require
			new_class_not_void: new_class /= Void
			new_class_not_compiled: not new_class.is_compiled
			old_class_not_void: old_class /= Void
		do
			if old_class.is_compiled then
				new_class.reset_class_c_information (old_class.compiled_class)
				workbench.change_class (new_class)
			end
			if workbench.automatic_backup then
				record_moved_class (old_class.name, old_class.file_name, new_class.file_name)
			end
		end

	remove_class (a_class: CLASS_I) is
			-- Remove a class from the cluster (Exclude clause)
			-- Remove the CLASS_C if the class was compiled before
			-- and propagate recompilation of the clients.
			-- Can only be called by compiler tools, not by compiler itself.
			-- (export status {COMPILER_EXPORTER})
		require
			has_a_class: classes.has (a_class.name)
		do
			classes.remove (a_class.name)
			internal_remove_class (a_class)
		end

	reset_options is
			-- Reset the default options for all the classes
			-- in the cluster
		do
			from
				classes.start
			until
				classes.after
			loop
					-- reset_options on CLASS_I reset the default options
				classes.item_for_iteration.reset_options
				classes.forth
			end
			if not is_precompiled then
				private_document_path := Void
			end
		end

	update_cluster is
			-- Update the clusters: remove the classes removed
			-- from the system, examine the differences in the
			-- ignore and rename clauses
		do
			if old_cluster /= Void then
				process_removed_classes

					-- Remove the reference to `old_cluster'
				old_cluster := Void
			end
		ensure
			old_cluster_void: old_cluster = Void
		end

	rebuild_override is
			-- Rebuild override cluster without going through a full recompilation.
		require
			is_override_cluster: is_override_cluster
		local
			l_classes: like classes
			l_class: CLASS_I
		do
			if is_recursive then
				l_classes := classes
				update_with_all_classes
			end

			from
				classes.start
			until
				classes.after
			loop
				l_class := classes.item_for_iteration
				if l_class.date_has_changed then
					if l_class.is_compiled then
						Workbench.change_class (l_class)
					end
					l_class.set_date
				end
				classes.forth
			end

			if is_recursive then
				reset_classes (l_classes)
			end
		end

	process_overrides (ovc: CLUSTER_I) is
			-- Check if some classes have been overriden
			-- and remove them from the system
		require
			ovc_not_void: ovc /= Void
			ovc_is_override: ovc.is_override_cluster
			not_current: ovc /= Current
		local
			a_class, ov_class: CLASS_I
			ovcc: like classes
		do
			if ovc.classes /= Void then
				from
					ovcc := ovc.classes
					ovcc.start
				until
					ovcc.after
				loop
					ov_class := ovcc.item_for_iteration
					if classes.has (ov_class.name) then
							-- Class is overridden; remove it and keep track of
							-- its previous location
						a_class := classes.found_item
							-- We only process precompiled clusters only if they contain
							-- a non-compiled class. We do not remove external classes
							-- from ASSEMBLY_I as they cannot be removed and replaced by
							-- a class from the override since we cannot change an assembly.
						if
							(not is_precompiled or else not a_class.is_compiled) and
							not a_class.is_external_class
						then
							classes.remove (a_class.name)
							overriden_classes.put (a_class, a_class.name)
							ov_class.reset_class_c_information (a_class.compiled_class)
							if a_class.is_compiled then
									-- Add class to system only if it was already part
									-- of system before.
								Workbench.change_class (ov_class)
							end
						end
					end
					ovcc.forth
				end
			end
		end

	remove_cluster is
			-- Remove all the classes from the current cluster
			-- i.e. the cluster has been removed from the system
			-- Very similar to `process_removed_classes' except that we do
			-- not play between `current' and  `old_cluster'. Here we are the
			-- old cluster.
		local
			vd40: VD40
			l_class: CLASS_I
			l_classes, l_overriden_classes: LIST [CLASS_I]
		do
			debug ("REMOVE_CLASS")
				io.error.put_string ("Removing cluster ")
				io.error.put_string (cluster_name)
				io.error.put_string (" path ")
				io.error.put_string (path)
				io.error.put_new_line
			end
			if is_override_cluster then
				from
					classes.start
				until
					classes.after
				loop
					l_class := classes.item_for_iteration
					l_overriden_classes := universe.overriden_classes_with_name (l_class.name)
					if not l_overriden_classes.is_empty then
							-- Class was previously overriden, let's check that if it is not
							-- in another override cluster.
						l_classes := universe.classes_with_name (l_class.name)
						if not l_classes.is_empty then
							check
								in_override_cluster: l_classes.first.cluster.is_override_cluster
								not_compiled: not l_classes.first.is_compiled
							end
								-- Move compiled info from one override cluster to another one
							restore_compiled_class (l_classes.first, l_class)
						else
								-- Class has only been moved to a non-override cluster.
								-- We restore the CLASS_C information only for the first one found.
							check
								not_compiled: not l_overriden_classes.first.is_compiled
							end
							restore_compiled_class (l_overriden_classes.first, l_class)
								-- Now remove all overriden classes of universe.
							from
								l_overriden_classes.start
							until
								l_overriden_classes.after
							loop
								l_class := l_overriden_classes.item
								l_class.cluster.overriden_classes.remove (l_class.name)
								l_class.cluster.classes.put (l_class, l_class.name)
								l_overriden_classes.forth
							end
						end
					else
							-- Looks like this class from the override cluster was not in any
							-- other clusters. So let's try to find it in another cluster,
							-- before really removing it from system.
						l_classes := universe.classes_with_name (l_class.name)
						if not l_classes.is_empty and then not l_classes.first.is_compiled then
								-- Class has only been moved.
							restore_compiled_class (l_classes.first, l_class)
						else
								-- Class has been removed or already replaced.
							internal_remove_class (l_class)
						end
					end
					classes.forth
				end
			else
				from
					classes.start
				until
					classes.after
				loop
					l_class := classes.item_for_iteration
					l_classes := universe.classes_with_name (l_class.name)
					if not l_classes.is_empty and then not l_classes.first.is_compiled then
							-- Class has only been moved. We restore the CLASS_C
							-- information only for the first one found.
						restore_compiled_class (l_classes.first, l_class)
					else
							-- Class has been removed or already replaced.
						internal_remove_class (l_class)
					end
					classes.forth
				end
			end
			l_classes := universe.classes_with_name ("ANY")
			if l_classes.is_empty then
					-- It means that we cannot find ANY in universe. We are in big
					-- trouble.
				create vd40
				vd40.set_cluster (Current)
				Error_handler.insert_error (vd40)
				Error_handler.raise_error
			end
		end

	insert_cluster_to_ignore (c: CLUSTER_I) is
			-- Insert `c' in `ignore'.
		require
			good_argument: c /= Void
		do
			if ignore = Void then
				create ignore.make
			end
			ignore.put_front (c)
		end

	renamed_class (class_name: STRING): CLASS_I is
			-- Class which intrinsic name is renamed into `class_name'
		require
			good_argument: class_name /= Void
		local
			old_cursor: CURSOR
			a_cluster: CLUSTER_I
			rename_clause: RENAME_I
			table: HASH_TABLE [STRING, STRING]
		do
			if renamings /= Void then
				old_cursor := renamings.cursor
				from
					renamings.start
				until
					renamings.after or else Result /= Void
				loop
					rename_clause := renamings.item
					a_cluster := rename_clause.cluster
					table := rename_clause.renamings
					if table.has (class_name) then
						Result := a_cluster.classes.item (table.found_item)
					end
					renamings.forth
				end
				renamings.go_to (old_cursor)
			end
		end

	new_date: INTEGER is
			-- Current date of the cluster directory
		local
			ptr: ANY
		do
			ptr := path.to_c
			Result := eif_date ($ptr)
		end

	changed (ex_l, inc_l: LACE_LIST [FILE_NAME_SD]): BOOLEAN is
			-- Has the cluster directory changed?
		local
			i: INTEGER
			ptr: ANY
		do
			ptr := path.to_c
			Result := date /= eif_date ($ptr) or else Lace.need_directory_lookup

--			if not Result and then not Has_smart_file_system then
					-- New Note: this comment has been previously done for Windows OS,
					-- however the described situation can also occurs on other UNIX
					-- operating systems:
					--
					-- We need to check on Windows FAT file systems the content of
					-- a non-changed directory since it can have been changed
					-- anyway (FAT is not a good file system).
					-- Problem: NTFS does not have this problem but there is no
					-- easy way to know if we are on NTFS or not, that's why we
					-- are doing this check
					--
					-- FIXME: when the only file system will be NTFS or equivalent,
					-- we should remove this test since the value returned by
					-- `eif_file_has_changed' will be coherent
					-- %%MANU

--				Result := True

--			elseif not Result then
			if not Result then

				from
					classes.start
				until
					Result or else classes.after
				loop
					Result := classes.item_for_iteration.date_has_changed
					classes.forth
				end

				if not Result then
					if inc_l = Void then
						Result := include_list /= Void
					elseif include_list = Void or else
						inc_l.count /= include_list.count
					then
						Result := True
					else
						from
							i := 1
						until
							i > inc_l.count or else Result
						loop
							include_list.start
							include_list.compare_objects
							include_list.search (inc_l.i_th (i).file__name)
							Result := include_list.after
							i := i + 1
						end
					end
				end
				if not Result then
					if ex_l = Void then
						Result := exclude_list /= Void
					elseif exclude_list = Void or else
						ex_l.count /= exclude_list.count
					then
						Result := True
					else
						from
							i := 1
						until
							i > ex_l.count or else Result
						loop
							exclude_list.start
							exclude_list.compare_objects
							exclude_list.search (ex_l.i_th (i).file__name)
							Result := exclude_list.after
							i := i + 1
						end
					end
				end
			end
		end

feature {CLUSTER_SD} -- `all' adaptation

	update_with_all_classes is
			-- Fill `classes' with all classes in subclusters.
			--| Can be called only when Current was specified as `all'
			-- or `library' in Ace file.
		local
			l_classes: like classes
		do
			if sub_clusters /= Void then
				create l_classes.make (classes.count)
				private_merge (l_classes, Current)
				classes := l_classes
			end
		end

	reset_classes (a_classes: like classes) is
			-- Assign `a_classes' into `classes'.
			-- Perform after call to `update_with_all_classes' to
			-- restore existing state
		require
			a_classes_not_void: a_classes /= Void
		do
			classes := a_classes
		ensure
			classes_set: classes = a_classes
		end

feature {NONE} -- Implementation

	private_merge (a_classes: like classes; clus: like Current) is
			-- Merge `classes' in `sub_clusters' of `clus' into `a_classes'.
		require
			a_classes_not_void: a_classes /= Void
			clus_not_void: clus /= Void
		do
			a_classes.merge (clus.classes)
			if clus.sub_clusters /= Void then
				from
					clus.sub_clusters.start
				until
					clus.sub_clusters.after
				loop
					private_merge (a_classes, clus.sub_clusters.item)
					clus.sub_clusters.forth
				end
			end
		end

	internal_remove_class (a_class: CLASS_I) is
			-- Remove a class from the cluster (Exclude clause)
			-- Remove the CLASS_C if the class was compiled before
			-- and propagate recompilation of the clients.
			-- Can only be called by compiler tools, not by compiler itself.
		do
			debug ("REMOVE_CLASS")
				io.error.put_string ("Removing class ")
				io.error.put_string (a_class.name)
				io.error.put_new_line
			end

				-- If a_class has already be compiled,
				-- all its clients must recheck their suppliers
			remove_class_from_system (a_class)

				-- Remove it from unreferenced classes of system
				-- if it was only referenced from there.
			System.remove_unref_class (a_class)

			if Workbench.automatic_backup then
				record_removed_class (a_class.name)
			end
		end

	remove_class_from_system (a_class: CLASS_I) is
			-- Remove a class_c that is not present in system any more
		require
			a_class_not_void: a_class /= Void
		local
			class_c: CLASS_C
		do
			debug ("REMOVE_CLASS")
				io.error.put_string ("Removing class from system ")
				io.error.put_string (a_class.name)
				io.error.put_new_line
			end
			class_c := a_class.compiled_class
			if class_c /= Void then
					-- Recompile all the clients
				class_c.recompile_syntactical_clients
					-- remove class_c from the system
				System.remove_class (class_c)
			end
		end

feature {COMPILER_EXPORTER}

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := path < other.path
		end

feature {COMPILER_EXPORTER} -- Automatic backup

	backup_directory: DIRECTORY_NAME is
			-- Full directory path where the changes in Current will be stored
		local
			d: DIRECTORY
			cluster: CLUSTER_I
		do
			create Result.make_from_string (Workbench.backup_subdirectory)
			create d.make (Result)
			if not d.exists then
					-- Create the backup directory again just in case the user removes it.
				d.create_dir
			end

			if belongs_to_all then
				from
					cluster := parent_cluster
				until
					not cluster.belongs_to_all
				loop
					cluster := cluster.parent_cluster
				end
				Result.extend (cluster.cluster_name)
			else
				Result.extend (cluster_name)
			end

			create d.make (Result)
			if not d.exists then
				d.create_dir
			end
		end

feature {NONE} -- Automatic backup

	backup_log_file: PLAIN_TEXT_FILE is
			-- Log file for cluster in current compilation
		local
			file_name: FILE_NAME
		do
			create file_name.make_from_string (backup_directory)
			file_name.set_file_name (Backup_info)
			create Result.make_open_append (file_name)
		end

	record_moved_class (class_name, orig, dest: STRING) is
			-- Record the classes removed since last compilation
		require
			class_name_not_void: class_name /= Void
			orig_not_void: orig /= Void
			dest_not_void: dest /= Void
		local
			file: PLAIN_TEXT_FILE
		do
			file := backup_log_file
			file.put_string ("Moved: ")
			file.put_string (class_name)
			file.put_string (" from ")
			file.put_string (orig)
			file.put_string (" to ")
			file.put_string (dest)
			file.put_new_line
			file.close
		end

	record_removed_class (class_name: STRING) is
			-- Record the classes removed since last compilation
		require
			class_name_not_void: class_name /= Void
		local
			file: PLAIN_TEXT_FILE
		do
			file := backup_log_file
			file.put_string ("Removed: ")
			file.put_string (class_name)
			file.put_new_line
			file.close
		end

	record_class (class_name: STRING) is
			-- Record the classes in the directory
		require
			class_name_not_void: class_name /= Void
		local
			file: PLAIN_TEXT_FILE
		do
			file := backup_log_file
			file.put_string ("Inserted: ")
			file.put_string (class_name)
			file.put_new_line
			file.close
		end

feature -- Document processing

	document_path: DIRECTORY_NAME is
			-- Path specified for the documents directory.
			-- Void result implies no document generation
		local
			tmp: STRING
		do
			tmp := private_document_path
			if tmp = Void then
				create Result.make_from_string (System.document_path)
				Result.extend (cluster_name)
			elseif not tmp.is_equal (No_word) then
				create Result.make_from_string (tmp)
			end
		end

	set_document_path (a_path: like document_path) is
			-- Set `document_path' to `a_path'
		do
			private_document_path := a_path
			debug ("DOCUMENT")
				io.error.put_string ("Set document path to: ")
				print (a_path)
				io.error.put_new_line
			end
		ensure
			set: document_path = a_path
		end

	update_document_path is
			-- Update the `document_path' to the default value
			-- if is has not been set yet.
		require
			is_precompiling: Compilation_modes.is_precompiling
		local
			a_path: like private_document_path
		do
			a_path := document_path
			if a_path = Void then
				a_path := No_word
			end
			private_document_path := a_path
		ensure
			document_path_not_void: document_path /= Void
		end

feature {DOCUMENTATION, TEXT_FILTER, CLASS_I, CLUSTER_I} -- Status report

	base_relative_path (sep: CHARACTER): EB_FILE_NAME is
			-- Relative path from `Current' to base path of generated documentation.
		do
			if parent_cluster /= Void then
				Result := parent_cluster.base_relative_path (sep)
				Result.extend ("..")
			else
				create Result.make_from_string ("..")
				if sep /= '%U' then
					Result.set_separator (sep)
				end
			end
		end

	relative_path (sep: CHARACTER): EB_FILE_NAME is
			-- Relative path from documentation base path to `Current'.
		local
			real_name: STRING
			pos: INTEGER
		do
			if belongs_to_all then
					-- Fake generated name due to `all' or `library' specification.
				pos := cluster_name.last_index_of ('.', cluster_name.count)
				check
					found_dummy_dot: pos > 0
				end
				real_name := cluster_name.substring (pos + 1, cluster_name.count)
			else
				real_name := cluster_name
			end
			if parent_cluster /= Void then
				Result := parent_cluster.relative_path (sep)
				Result.extend (real_name)
			else
				create Result.make_from_string (real_name)
				if sep /= '%U' then
					Result.set_separator (sep)
				end
			end
		end

	relative_file_name (sep: CHARACTER): EB_FILE_NAME is
			-- Relative path from documentation base path to `Current'.
		do
			Result := relative_path (sep)
			Result.extend ("index")
		end

feature {NONE} -- Document processing

	No_word: STRING is "no"

	private_document_path: STRING
			-- Path specified in Ace for the documents directory

feature {NONE} -- Implementation

	process_removed_classes is
			-- Check if some classes have disapeared since last compilation
			-- and remove them from the system
		require
			old_cluster_not_void: old_cluster /= Void
		local
			old_classes: like classes
			old_class, new_class: CLASS_I
			l_overriden_classes, l_classes: LIST [CLASS_I]
		do
			if is_override_cluster then
				from
					old_classes := old_cluster.classes
					old_classes.start
				until
					old_classes.after
				loop
					old_class := old_classes.item_for_iteration
					if not classes.has (old_class.name) then
							-- Class has been moved or removed
						l_overriden_classes := universe.overriden_classes_with_name (old_class.name)
						if not l_overriden_classes.is_empty then
								-- Class was previously overriden, let's check that if it is not
								-- in another override cluster.
							l_classes := universe.classes_with_name (old_class.name)
							if not l_classes.is_empty then
								check
									in_override_cluster: l_classes.first.cluster.is_override_cluster
									not_compiled: not l_classes.first.is_compiled
								end
									-- Move compiled info from one override cluster to another one
								restore_compiled_class (l_classes.first, old_class)
							else
									-- Class has only been moved to a non-override cluster.
									-- We restore the CLASS_C information only for the first
									-- one found.
								check
									not_compiled: not l_overriden_classes.first.is_compiled
								end
								restore_compiled_class (l_overriden_classes.first, old_class)
									-- Now remove all overriden classes of universe.
								from
									l_overriden_classes.start
								until
									l_overriden_classes.after
								loop
									new_class := l_overriden_classes.item
									new_class.cluster.overriden_classes.remove (new_class.name)
									new_class.cluster.classes.put (new_class, new_class.name)
									l_overriden_classes.forth
								end
							end
						else
								-- Looks like this class from the override cluster was not in any
								-- other clusters. So let's try to find it in another cluster,
								-- before really removing it from system.
							l_classes := universe.classes_with_name (old_class.name)
							if not l_classes.is_empty and then not l_classes.first.is_compiled then
									-- Class has only been moved.
								restore_compiled_class (l_classes.first, old_class)
							else
									-- Class has been removed or already replaced.
								internal_remove_class (old_class)
							end
						end
					end
					old_classes.forth
				end
			else
				from
					old_classes := old_cluster.classes
					old_classes.start
				until
					old_classes.after
				loop
					old_class := old_classes.item_for_iteration
					if
						not classes.has (old_class.name) and
						not overriden_classes.has (old_class.name)
					then
							-- Class has been moved or removed
						l_classes := universe.classes_with_name (old_class.name)
						if not l_classes.is_empty and then not l_classes.first.is_compiled then
								-- Class has only been moved. We restore the CLASS_C
								-- information only for the first one found.
							restore_compiled_class (l_classes.first, old_class)
						else
								-- Class has been removed or already replaced.
							internal_remove_class (old_class)
						end
					end
					old_classes.forth
				end
			end
		end

	valid_class_file_extension (c: CHARACTER): BOOLEAN is
			-- Is `c' a valid class file extension?
		do
			Result := c = 'e' or c = 'E'
		end

	is_current_or_parent_cluster (cl_path: STRING) : BOOLEAN is
			-- Does `cl_path' point to the current
			-- cluster or its parent?
		require
			path_exists: cl_path /= Void
		do
			-- NOTE: This code may not be correct for VMS!
			--       Perhaps we need a run-time function here.

			Result := cl_path.is_equal (".") or else
					  cl_path.is_equal ("..")
		end

	physical_id (cl_path: STRING) : STRING is
			-- Id which uniquely identifies the
			-- directory pointed to by `cl_path'.
		do
			-- NOTE: This code is not correct for UNIX (->links)!
			--       We need a run-time function which
			--       returns the inode number (UNIX).
			--       For VMS: I don't know.
			--       The point is that two different paths
			--       can point to the same physical directory,
			--       so comparing paths alone will not prevent
			--       us from running into trouble (infinite
			--       loop in the worst case).

			Result := cl_path
		end

	build_indexes: INDEXING_CLAUSE_AS is
			-- Parsing results of file "indexing.txt".
		local
			file: KL_BINARY_INPUT_FILE
			fn: FILE_NAME
			retried: BOOLEAN
		do
			if not retried then
				create fn.make_from_string (path)
				fn.extend ("indexing")
				fn.add_extension ("txt")
				create file.make (fn)
				if file.exists then
					file.open_read
					if file.is_open_read then
						Cluster_indexing_parser.parse (file)
						if cluster_indexing_parser.indexing_node /= Void then
							Result := Cluster_indexing_parser.indexing_node
						end
						file.close
					end
				else
					if parent_cluster /= Void then
						Result := parent_cluster.indexes
					end
				end
			else
					-- We got an error: most likely a syntax error
				if file /= Void and then not file.is_closed then
					file.close
				end
				Result := Void
			end
		rescue
			retried := True
			retry
		end

	Cluster_indexing_parser: EIFFEL_PARSER is
			-- Parser adapted from the Eiffel parser.
		once
			create Result.make
			Result.set_indexing_parser
		end

feature -- Formatting

	format (a_text_formatter: TEXT_FORMATTER) is
			-- Output name of Current in `a_text_formatter'.
			-- (from ASSEMBLY_INFO)
		require -- from ASSEMBLY_INFO
			st_not_void: a_text_formatter /= Void
		do
			a_text_formatter.add_string (path)
		end

feature -- Type anchors

	class_anchor: CLASS_I is
			-- Type of classes one can insert in Current
		do
		end

feature {NONE} -- Externals

	eif_date (s: POINTER): INTEGER is
			-- Date of file of name `str'.
		external
			"C"
		end

invariant
	path_not_void: path /= Void
	classes_not_void: classes /= Void
	sub_clusters_not_void: sub_clusters /= Void
	ignore_valid: ignore = Void or else not ignore.is_empty
	renamings_valid: renamings = Void or else not renamings.is_empty

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
