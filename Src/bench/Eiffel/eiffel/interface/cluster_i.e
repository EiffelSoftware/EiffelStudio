-- Internal representation of a cluster

class CLUSTER_I

inherit

	SHARED_ERROR_HANDLER;
	SHARED_WORKBENCH;
	SHARED_EIFFEL_PROJECT;
	SHARED_ENV;
	SHARED_RESCUE_STATUS;
	PROJECT_CONTEXT;
	COMPARABLE
		undefine
			is_equal
		end
	COMPILER_EXPORTER

creation

	make, make_from_old_cluster

feature -- Attributes

	date: INTEGER;
			-- Date for time stamp

	cluster_name: STRING;
			-- Cluster name

	dollar_path: STRING;
			-- Path to the cluster (with environment variables)

	path: STRING;
			-- Path to the cluster (without environment variables)

	classes: EXTEND_TABLE [CLASS_I, STRING];
			-- Classes available in the cluster: key is the declared
			-- name and entry is the class

	renamings: LINKED_LIST [RENAME_I];
			-- Renamings for the cluster

	ignore: LINKED_LIST [CLUSTER_I];
			-- Cluster to ignore

	old_cluster: CLUSTER_I;
			-- Old version of the cluster

	is_precompiled: BOOLEAN;
			-- Is the cluster precompiled
			-- It won't be removed even if it is no more
			-- in the local Ace file

	precomp_id: INTEGER;
			-- Id of the precompiled library to which the
			-- cluster belongs

	precomp_ids: ARRAY [INTEGER];
			-- Ids of libraries used for precompilation
			-- of current cluster; Void if not precompiled

	exclude_list: ARRAYED_LIST [STRING];
			-- List of files to exclude

	include_list: ARRAYED_LIST [STRING];
			-- List of files to include

	is_override_cluster: BOOLEAN;
			-- Does this cluster override the other clusters?

feature -- Access

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
				Result := b_name.is_equal (classes.item_for_iteration.base_name);
				classes.forth
			end
		end;

feature -- Element change

	add_new_classs (class_i: CLASS_I) is
		require
			non_void_class_i: class_i /= Void;
			name_set: class_i.class_name /= Void;
			base_name_set: class_i.base_name /= Void;
			not_in_cluster: not classes.has (class_i.class_name)
		do
			class_i.set_cluster (Current);
			class_i.set_date;
			classes.put (class_i, class_i.class_name);	
		ensure
			in_cluster: classes.has (class_i.class_name)
		end;

feature {COMPILER_EXPORTER} -- Conveniences

	set_date (i: INTEGER) is
			-- Assign `i' to `date'.
		do
			date := i;
		end;

	set_cluster_name (s: STRING) is
			-- Assign `s' to `cluster_name'.
		do
			cluster_name := s;
		end;

	set_old_cluster (c: CLUSTER_I) is
			-- Assign `c' to `old_cluster'.
		do
			old_cluster := c;
		end;

	set_is_precompiled (ids: ARRAY [INTEGER]) is
			-- Assign `True' to `is_precompiled'
		do
			if not is_precompiled then
				is_precompiled := True;
				precomp_id := System.compilation_id;
				precomp_ids := ids
			end
		end;

	set_dollar_path (s: STRING) is
			-- Assign `s' to `path'.
		do
			dollar_path := s;
			update_path
		end;

	update_path is
		do
			if dollar_path /= Void then
				path := Environ.interpreted_string (dollar_path)
			end;
		end;

	set_is_override_cluster (flag: BOOLEAN) is
			-- Set `is_override_cluster' to `flag'.
		do
			is_override_cluster := flag
		end;

feature {COMPILER_EXPORTER} -- Creation feature

	make (p: STRING) is
		do
			dollar_path := p;
			update_path;
			!!classes.make (10);
			!!renamings.make;
			!!ignore.make;
			is_dynamic := System.is_dynamic
		end;

	make_from_old_cluster (old_cluster_i: CLUSTER_I) is
		require
			valid_arg: old_cluster_i /= Void
		do
			make (old_cluster_i.dollar_path)

			copy_old_cluster (old_cluster_i)

			cluster_name := old_cluster_i.cluster_name
		end

feature {COMPILER_EXPORTER}

	clear is
			-- Empty the structure
		do
			classes.clear_all;
		end;

	copy_old_cluster (old_cluster_i: CLUSTER_I) is
			-- Copy all the information except the ignore
			-- and renaming clauses
		local
			cl: like classes;
			c: CLASS_I;
		do
debug ("REMOVE_CLASS")
	io.error.putstring ("Copy old_cluster ");
	io.error.putstring (old_cluster_i.cluster_name);
	io.error.putstring (" path ");
	io.error.putstring (old_cluster_i.path);
	io.error.new_line;
end;
			old_cluster := old_cluster_i;
			is_precompiled := old_cluster_i.is_precompiled;
			precomp_id := old_cluster_i.precomp_id;
			precomp_ids := old_cluster_i.precomp_ids;
			is_dynamic := old_cluster_i.is_dynamic;
			set_date (old_cluster_i.date);
			exclude_list := old_cluster_i.exclude_list;
			include_list := old_cluster_i.include_list;
			from
				cl := old_cluster.classes;
				cl.start;
			until
				cl.after
			loop
				c := cl.item_for_iteration;
				classes.put (c, cl.key_for_iteration);
				c.set_cluster (Current);
				cl.forth
			end;
		end;

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
				classes.item_for_iteration.set_cluster (Current);
				classes.forth
			end;
		end;

	insert_renaming (cl: CLUSTER_I; old_name, new_name: STRING) is
			-- Insert renaming of a class of `cl' named `old_name' 
			-- into `new_name'.
		require
			cl /= Void;
			old_name /= Void;
			new_name /= Void;
			consistency: cl.classes.has (old_name);
		local
			rename_clause: RENAME_I;
		do
			rename_clause := rename_clause_for (cl);
			if rename_clause = Void then
				!!rename_clause.make;
				rename_clause.set_cluster (cl);
				renamings.put_front (rename_clause);
			end;
			rename_clause.renamings.put (old_name, new_name);
		end;

	rename_clause_for (cl: CLUSTER_I): RENAME_I is
			-- Rename clause of classes from cluster `cl'
		require
			good_argument: cl /= Void;
		local
			rename_clause: RENAME_I;
		do
			from   
				renamings.start;   
			until  
				renamings.after or else Result /= Void
			loop
				rename_clause := renamings.item;
				if rename_clause.cluster = cl then
					Result := rename_clause;
				end;
				renamings.forth;
			end;
		end;

	open_directory_error (cluster_file: DIRECTORY): BOOLEAN is
			-- Does the opening of the directory file `cluster_file'
			-- trigger an error ?
		require
			good_argument: cluster_file /= Void
		do
			if not Result then
				cluster_file.open_read;
			end;
		rescue
			if Rescue_status.is_unexpected_exception then
				Result := True;
				retry;
			end
		end;

	duplicate: CLUSTER_I is
		do
			!!Result.make_from_old_cluster (Current);
		end;

	new_cluster (name: STRING; ex_l, inc_l: LACE_LIST [FILE_NAME_SD]): CLUSTER_I is
		local
			changed_classes: LINKED_LIST [CLASS_I];
			unchanged_classes: LINKED_LIST [CLASS_I];
		do
				-- If the cluster has changed,
				-- do a degree 6
			if changed (ex_l, inc_l) then
				!! Result.make (dollar_path);
				Result.set_cluster_name (name);
				Universe.insert_cluster (Result);

				Result.set_old_cluster (duplicate);
debug ("REMOVE_CLASS")
	io.error.putstring ("New cluster calling fill%N");
end;
				Result.fill (ex_l, inc_l);
			else
				Degree_output.skip_degree_6;
				!! Result.make_from_old_cluster (Current)
				Universe.insert_cluster (Result);
			end;
		end;

	fill (ex_l, inc_l: LACE_LIST [FILE_NAME_SD]) is
			-- Fill the cluster name table with what is found in the path. If 
			-- `old_cluster' exists, fill current with it.
		require
			table_is_empty: classes.empty;
		local
			cluster_file: DIRECTORY;
			file_name: STRING;
			i, j: INTEGER;
			class_path: FILE_NAME;
			vd01: VD01;
			vd07: VD07;
			vd12: VD12;
			vd22: VD22;
			class_file: EXTEND_FILE;
			found: BOOLEAN;
		do
debug ("REMOVE_CLASS")
	io.error.putstring ("Fill ");
	io.error.putstring (cluster_name);
	io.error.putstring (" path ");
	io.error.putstring (path);
	io.error.new_line;
end;				-- Check if the path is valid
			!!cluster_file.make (path);
			if not cluster_file.exists then
				!!vd01;
				vd01.set_path (path);
				vd01.set_cluster_name (cluster_name);
				Error_handler.insert_error (vd01);
				Error_handler.raise_error;
			end;

			Degree_output.put_degree_6 (Current)

				-- Process the include and exclude lists
			if ex_l /= Void then
				from
					!!exclude_list.make_filled (ex_l.count);
					i := 1;
				until
					i > ex_l.count
				loop
					file_name := Environ.interpreted_string
									(ex_l.i_th (i).file__name);
					!!class_path.make_from_string (path);
					class_path.set_file_name (file_name);
					!!class_file.make (class_path)
					if not class_file.exists then
						!!vd12;
						vd12.set_cluster (Current);
						vd12.set_file_name (file_name);
						Error_handler.insert_error (vd12);
					else
						exclude_list.put_i_th (file_name, i);
					end;
					i := i + 1;
				end;
			end;
			if inc_l /= Void then
				from
					!!include_list.make_filled (inc_l.count);
					i := 1;
				until
					i > inc_l.count
				loop
					file_name := Environ.interpreted_string
										(inc_l.i_th (i).file__name);
					!!class_path.make_from_string (path);
					class_path.set_file_name (file_name);
					!!class_file.make (class_path)
					if not class_file.exists then
						!!vd07;
						vd07.set_cluster (Current);
						vd07.set_file_name (file_name);
						Error_handler.insert_error (vd07);
					else
						include_list.put_i_th (file_name, i);
					end;
					i := i + 1;
				end;
			end;
			Error_handler.checksum;

				-- Set date first
			date := new_date;

			if open_directory_error (cluster_file) then
				!!vd22;
				vd22.set_cluster (Current);
				vd22.set_file_name (cluster_file.name);
				Error_handler.insert_error (vd22);
			else
				from
					cluster_file.start;
					cluster_file.readentry;
					file_name := cluster_file.lastentry;
				until
					file_name = Void
				loop
					i := file_name.count;
	
					if
						i > 2
					and then
						(file_name.item (i - 1) = Dot
						and
						eif_valid_class_file_extension (file_name.item (i)))
					then
						found := False;
						if exclude_list /= Void then
							from
								i := 1
							until
								i > exclude_list.count or else found
							loop
								if file_name.is_equal (exclude_list.i_th (i)) then
									found := True
								end;
								i := i + 1;
							end;
						end;
						if not found then
							insert_class_from_file (file_name);
						end;
					end;

					cluster_file.readentry;
					file_name := cluster_file.lastentry;
				end;
				cluster_file.close;
				if include_list /= Void then
					from
						i := 1
					until
						i >  include_list.count
					loop
						file_name := include_list.i_th (i);
						found := False;
						if exclude_list /= Void then
							from
								j := 1
							until
								j > exclude_list.count or else found
							loop
								if file_name.is_equal (exclude_list.i_th (j)) then
									found := True
								end;
								j := j + 1;
							end;
						end;
						if not found then
							insert_class_from_file (file_name);
						end;
						i := i + 1;
					end;
				end;
			end;
			Error_handler.checksum;
		end;

	insert_class_from_file (file_name: STRING) is
		local
			class_path: FILE_NAME;
			a_class: CLASS_I;
			class_name: STRING;
			vd11: VD11;
			cluster_file: DIRECTORY;
			str: ANY;
			file_date: INTEGER;
		do
			!!class_path.make_from_string (path);
			class_path.set_file_name (file_name);
			class_name := read_class_name_in_file (class_path);
			if class_name /= Void then
debug ("REMOVE_CLASS")
	io.error.putstring ("Insert class from file ");
	io.error.putstring (class_name);
	io.error.new_line;
end;
				a_class := classes.item (class_name);
				if a_class /= Void then
					-- Error
					!!vd11;
					vd11.set_a_class (a_class);
					vd11.set_file_name (file_name);
					vd11.set_cluster (Current);
					Error_handler.insert_error (vd11);
					Error_handler.raise_error;
				end;
					-- Valid eiffel class in file
				if old_cluster /= Void then
debug ("REMOVE_CLASS")
	io.error.putstring ("Old cluster not Void%N");
end;
					a_class := old_cluster.classes.item (class_name);
					if a_class /= Void then
							-- The file name may have changed even
							-- if the class was already in this cluster
debug ("REMOVE_CLASS")
	io.error.putstring ("Old cluster has the class%N");
end;
						a_class.set_base_name (file_name);
						a_class.set_cluster (Current);
						str := class_path.to_c;
						file_date := eif_date ($str);
						if a_class.date /= file_date then
							if a_class.compiled then
									-- The class has changed
								Workbench.change_class (a_class);
							end;
							a_class.set_date;
						end;
					end;
				end;
				if a_class = Void then
debug ("REMOVE_CLASS")
	io.error.putstring ("new class!!!%N");
end;
					!!a_class.make;
					a_class.set_class_name (class_name);
					a_class.set_base_name (file_name);
					a_class.set_cluster (Current);
					a_class.set_date;
				end;
				if Workbench.automatic_backup then
					record_class (class_name)
				end
				classes.put (a_class, class_name);
			end;
		end;

	read_class_name_in_file (file_name: STRING): STRING is
			-- Read the name of a class in a file
			-- Check if there is already a class with this name
			-- in the cluster
		local
			class_file: EXTEND_FILE;
			vd10: VD10;
			vd21: VD21;
			vd22: VD22;
		do
			!!class_file.make (file_name);
			if class_file.is_readable then
				if class_file.open_read_error then
						-- Error when opening file
					!!vd22;
					vd22.set_cluster (Current);
					vd22.set_file_name (file_name);
					Error_handler.insert_error (vd22);
				else
					Result := c_clname (class_file.file_pointer);
					class_file.close;
					if Result /= Void then
							-- Eiffel class in file
						Result.to_lower;
					else
							-- No class in file
						!!vd10;
						vd10.set_cluster (Current);
						vd10.set_file_name (file_name);
						Error_handler.insert_error (vd10);
					end;
				end;
			else
					-- Unreadable file
				!!vd21;
				vd21.set_cluster (Current);
				vd21.set_file_name (file_name);
				Error_handler.insert_error (vd21);
			end;
		end;

	remove_class (a_class: CLASS_I) is
			-- Remove a class from the cluster (Exclude clause)
			-- Remove the CLASS_C if the class was compiled before
			-- and propagate recompilation of the clients.
		do
debug ("REMOVE_CLASS")
	io.error.putstring ("Removing class ");
	io.error.putstring (a_class.class_name);
	io.error.new_line;
end;
			classes.remove (a_class.class_name);

				-- If a_class has already be compiled,
				-- all its clients must recheck their suppliers
			remove_class_from_system (a_class);
		end;

	remove_class_from_system (a_class: CLASS_I) is
			-- Remove a class_c that is not present is the system any more
		local
			class_c: CLASS_C;
			class_i: CLASS_I;
			clients: LINKED_LIST [CLASS_C];
		do
debug ("REMOVE_CLASS")
	io.error.putstring ("Removing class from system ");
	io.error.putstring (a_class.class_name);
	io.error.new_line;
end;
			class_c := a_class.compiled_class;
			if class_c /= Void then
					-- Recompile all the clients
				class_c.recompile_syntactical_clients;
					-- remove class_c from the system
				System.remove_class (class_c);
			end;
		end;

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
				classes.item_for_iteration.reset_options;
				classes.forth
			end;
			if not is_precompiled then
				private_document_path := Void
			end
		end;

	update_cluster is
			-- Update the clusters: remove the classes removed
			-- from the system, examine the differences in the
			-- ignore and rename clauses
		do
			if old_cluster /= Void then
				process_removed_classes;

					-- Remove the reference to `old_cluster'
				old_cluster := Void;
			end;
		ensure
			old_cluster_void: old_cluster = Void
		end;

	process_removed_classes is
			-- Check if some classes have disapeared since last compilation
			-- and remove them from the system
		require
			old_cluster_not_void: old_cluster /= Void
		local
			old_classes: like classes;
			old_class: CLASS_I;
		do
			from
				old_classes := old_cluster.classes;
				old_classes.start
			until
				old_classes.after
			loop
				old_class := old_classes.item_for_iteration;
				if not classes.has (old_class.class_name) then
					-- the class has been removed
					old_cluster.remove_class (old_class);
					if Workbench.automatic_backup then
						record_removed_class (old_class.class_name)
					end
				end;
				old_classes.forth;
			end;
		end;

	cluster_of_path (list: like ignore; pathname: STRING): CLUSTER_I is
		local
			found: BOOLEAN;
		do
			from
				list.start
			until
				found or else list.after
			loop
				if pathname.is_equal (list.item.path) then
					Result := list.item;
					found := True;
				end;
				list.forth;
			end;
		end;

	ignore_clauses_changed: BOOLEAN is
			--- Check the new ignore clauses and the deleted ones
		require
			old_cluster_not_void: old_cluster /= Void
		local
			old_list: like ignore;
			cluster: CLUSTER_I;
		do
			old_list := old_cluster.ignore;
				-- First the deleted clauses
			from
				old_list.start
			until
				old_list.after or else Result
			loop
				cluster := cluster_of_path (ignore, old_list.item.path);
				if cluster = Void then
					-- The ignore clause has been removed
					-- check the possible name conflicts

					cluster := Universe.cluster_of_path (old_list.item.path);
					if cluster /= Void then
							-- The cluster is in the universe
						Result := True;
					end;
				end;
				old_list.forth;
			end;

				-- Check the added clauses
			from
				ignore.start
			until
				ignore.after or else Result
			loop
				cluster := cluster_of_path (old_list, ignore.item.path);
				if cluster = Void then
					-- The clause has been added
					-- Check all the compiled classes of the cluster
					-- to see if they have clients in the ignored cluster
					Result := True;
			end;
				ignore.forth
			end;			
		end;

	renaming_clauses_changed: BOOLEAN is
			--- Check the new rename clauses and the deleted ones
		require
			old_cluster_not_void: old_cluster /= Void
		local
			old_list: like renamings;
			cluster_i: CLUSTER_I;
			rename_clause: RENAME_I;
		do
			if renamings.empty and old_cluster.renamings.empty then
				Result := False
			else
				Result := True
			end;
		end;

	is_kernel_cluster: BOOLEAN is
			-- Is the current cluster the kernel cluster
		do
			if classes.has ("any") then
				Result := True
			end;
		end;

	remove_cluster is
			-- Remove all the classes from the current cluster
			-- i.e. the cluster has been removed from the system
		local
			vd40: VD40;
		do
			if is_kernel_cluster then
				!!vd40;
				vd40.set_cluster (Current);
				Error_handler.insert_error (vd40);
				Error_handler.raise_error;
			end;
debug ("REMOVE_CLASS")
	io.error.putstring ("Removing cluster ");
	io.error.putstring (cluster_name);
	io.error.putstring (" path ");
	io.error.putstring (path);
	io.error.new_line;
end;
			from
				classes.start
			until
				classes.after
			loop
				remove_class_from_system (classes.item_for_iteration);
				classes.forth
			end;
		end;

	insert_cluster_to_ignore (c: CLUSTER_I) is
			-- Insert `c' in `ignore'.
		require
			good_argument: c /= Void;
		do
			ignore.put_front (c);
		end;

	compute_last_class (class_name: STRING) is
			-- Class which intrinsic name is renamed into `class_name' is
			-- assigned to attribute `last_class' of the universe
		require
			good_argument: class_name /= Void;
		local
			a_cluster: CLUSTER_I;
			rename_clause: RENAME_I;
			table: EXTEND_TABLE [STRING, STRING];
			found: BOOLEAN;
			vscn: VSCN;
		do
			Universe.set_last_class (Void);
			from
				renamings.start
			until
				renamings.after
			loop
				rename_clause := renamings.item;
				a_cluster := rename_clause.cluster;
				table := rename_clause.renamings;
				if table.has (class_name) then
					if not found then
						Universe.set_last_class
						(a_cluster.classes.item (table.item (class_name)));
						found := True;
					else
							-- Name clash
						!!vscn;
						vscn.set_first (Universe.last_class);
						vscn.set_second  
						(a_cluster.classes.item (table.item (class_name)));
						vscn.set_cluster (Current);
						Error_handler.insert_error (vscn);
					end
				end;
				renamings.forth;
			end;
		end;

	renamed_class (class_name: STRING): CLASS_I is
			-- Class which intrinsic name is renamed into `class_name'
		require
			good_argument: class_name /= Void;
		local
			pos: INTEGER;
			a_cluster: CLUSTER_I;
			rename_clause: RENAME_I;
			table: EXTEND_TABLE [STRING, STRING];
		do
			pos := renamings.index;
			from
				renamings.start
			until
				renamings.after or else Result /= Void
			loop
				rename_clause := renamings.item;
				a_cluster := rename_clause.cluster;
				table := rename_clause.renamings;
				if table.has (class_name) then
					Result := a_cluster.classes.item (table.item (class_name))
				end;
				renamings.forth;
			end;
			renamings.go_i_th (pos);
		end;

	new_date: INTEGER is
			-- Current date of the cluster directory
		local
			ptr: ANY
		do
			ptr := path.to_c;
			Result := eif_date ($ptr)
		end;

	changed (ex_l, inc_l: LACE_LIST [FILE_NAME_SD]): BOOLEAN is
			-- Is the cluster directory changed ?
		local
			i: INTEGER;
			ptr: ANY
		do
			ptr := path.to_c;
			Result := eif_directory_has_changed ($ptr, date);
			if Not Result then
				from
					classes.start
				until
					classes.after or else Result
				loop
					Result := classes.item_for_iteration.date_has_changed;
					classes.forth
				end;
				if not Result then
					if inc_l = Void then
						Result := include_list /= Void
					elseif include_list = Void or else
						inc_l.count /= include_list.count
					then
						Result := True
					else
						from
							i := 1;
						until
							i > inc_l.count or else result
						loop
							include_list.start;
							include_list.compare_references
							include_list.search (inc_l.i_th (i).file__name);
							Result := include_list.after
							i := i + 1;
						end
					end;
				end;
				if not Result then
					if ex_l = Void then
						Result := exclude_list /= Void
					elseif exclude_list = Void or else
						ex_l.count /= exclude_list.count
					then
						Result := True
					else
						from
							i := 1;
						until
							i > ex_l.count or else result
						loop
							exclude_list.start
							exclude_list.compare_references
							exclude_list.search (ex_l.i_th (i).file__name)
							Result := exclude_list.after
							i := i + 1
						end
					end;
				end;
			end;
		end;

	ignored (a_cluster: CLUSTER_I): BOOLEAN is
			-- Are classes from `a_cluster' ignored in current cluster?
		require
			a_cluster_not_void: a_cluster /= Void
		do
			Result := ignore.has (a_cluster);
			if not Result and precomp_ids /= Void then
				Result := not precomp_ids.has (a_cluster.precomp_id)
			end
		end

feature {COMPILER_EXPORTER}

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := path < other.path
		end;

feature {COMPILER_EXPORTER} -- Automatic backup

	backup_directory: DIRECTORY_NAME is
			-- Full directory path where the changes in Current will be stored
		local
			d: DIRECTORY
		do
			!! Result.make_from_string (Workbench.backup_subdirectory)
			Result.extend (backup_subdirectory)

			!! d.make (Result)
			if not d.exists then
				d.create
			end
		end

	backup_subdirectory: STRING is
			-- Translation of the `cluster_name' in something machine independent
		do
			if Platform_constants.is_windows_3_1 then
				Result := cluster_name.substring (1, (8).min (cluster_name.count))
			else
				Result := cluster_name
			end
		end

	backup_log_file: PLAIN_TEXT_FILE is
			-- Log file for cluster in current compilation
		local
			file_name: FILE_NAME
		do
			!! file_name.make_from_string (backup_directory)
			file_name.set_file_name (Backup_info)
			!! Result.make_open_append (file_name)
		end

	record_removed_class (class_name: STRING) is
			-- Record the classes removed since last compilation
		local
			file: PLAIN_TEXT_FILE
		do
			file := backup_log_file
			file.put_string ("Removed: ")
			file.put_string (class_name)
			file.new_line
			file.close
		end

	record_class (class_name: STRING) is
			-- Record the classes in the directory
		local
			file: PLAIN_TEXT_FILE
		do
			file := backup_log_file
			file.put_string ("Inserted: ")
			file.put_string (class_name)
			file.new_line
			file.close
		end

feature {COMPILER_EXPORTER} -- DLE

	is_static: BOOLEAN is
			-- Is the current cluster part of a Dynamic Class Set's base system?
			-- It won't be removed even if it is  no more in the local Ace file
		require
			dynamic_system: System.is_dynamic
		do
			Result := not is_dynamic
		end;

	is_dynamic: BOOLEAN;
			-- Does the current cluster contain dynamic classes?

	check_descendants_of_dynamic is
			-- Check each descendant of DYNAMIC in the DC-set is not
			-- generic and include a `make' procedure with one argument
			-- of type ANY in its creation clause.
		require
			dynamic_system: System.is_dynamic;
			dynamic_class_compiled: System.dynamic_class.compiled
		local
			class_i: CLASS_I;
			class_c, dynamic_class: CLASS_C
		do
			dynamic_class := System.dynamic_class.compiled_class;
			from
				classes.start
			until
				classes.after
			loop
				class_i := classes.item_for_iteration;
				if class_i.compiled then
					class_c := class_i.compiled_class;
					if
						class_c.is_dynamic and
						class_c.conform_to (dynamic_class)
					then
						class_c.check_dynamic_not_generic;
						class_c.check_dynamic_creators
					end
				end;
				classes.forth
			end
		end;

feature -- Document processing

	document_path: DIRECTORY_NAME is
			-- Path specified for the documents directory.
			-- Void result implies no document generation
		local
			tmp: STRING
		do
			tmp := private_document_path;
			if tmp = Void then
				Result := System.document_path
			elseif not tmp.is_equal (No_word) then
				!! Result.make_from_string (tmp)
			end;
		end;

	set_document_path (a_path: like document_path) is
			-- Set `document_path' to `a_path'
		do
			private_document_path := a_path
		ensure
			set: document_path = a_path
		end;

	update_document_path is
			-- Update the `document_path' to the default value
			-- if is has not been set yet.
		require
			is_precompiling: Compilation_modes.is_precompiling
		local
			a_path: like private_document_path
		do
			a_path := private_document_path;
			if a_path = Void then
				a_path := System.document_path;
				if a_path = Void then
					private_document_path := No_word
				else
					private_document_path := a_path
				end
			end
		ensure
			document_path_not_void: document_path /= Void
		end;

feature {NONE} -- Document processing

	No_word: STRING is "no";

	private_document_path: STRING
			-- Path specified in Ace for the documents directory

feature {NONE} -- Externals

	c_clname (file_pointer: POINTER): STRING is
			-- Class in file `file_pointer'.
		external
			"C"
		end;

	eif_date (s: POINTER): INTEGER is
			-- Date of file of name `str'.
		external
			"C"
		end;

	eif_directory_has_changed (cluster_path: POINTER; old_date: INTEGER): BOOLEAN is
			-- Does the directory have new entries?
		external
			"C"
		end;

	eif_valid_class_file_extension (c: CHARACTER): BOOLEAN is
			-- Is `c' a valid class file extension?
		external
			"C"
		end;

invariant

	path_exists: path /= Void;
	classes_exists: classes /= Void;
	dynamic_constraint: is_dynamic implies System.is_dynamic

end
