-- Internal representation of a cluster

class CLUSTER_I

inherit

	SHARED_ERROR_HANDLER;
	SHARED_WORKBENCH;

creation

	make

feature -- Attributes

	date: INTEGER;
			-- Date for time stamp

	cluster_name: STRING;
			-- Cluster name

	path: STRING;
			-- Path to the cluster

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

feature -- Conveniences

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

	set_is_precompiled is
			-- Assign `True' to `is_precompiled'
		do
			is_precompiled := True;
		end;

feature -- Creation feature

	make (p: STRING) is
		do
			path := p;
			!!classes.make (10);
			!!renamings.make;
			!!ignore.make;
		end;

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
			old_cluster := old_cluster_i;
			is_precompiled := old_cluster_i.is_precompiled;
			set_date (old_cluster_i.date);
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

	insert_renaming (cl: CLUSTER_I; old_name,new_name: STRING) is
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
				renamings.add_front (rename_clause);
			end;
			rename_clause.renamings.put (new_name, old_name);
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
			-- FIXME
				Result := True;
				retry;
		end;

	fill (cluster_file: DIRECTORY) is
			-- Fill the cluster name table with what is found in the path. If 
			-- `old_cluster' exists, fill current with it.
		require
			table_is_empty: classes.empty;
			cluster_file_exists: cluster_file.exists;
			cluster_file_is_closed: cluster_file.is_closed;
		local
			file_name: STRING;
			i: INTEGER;
			a_class: CLASS_I;
			class_path, class_name: STRING;
			vd11: VD11;
			vd22: VD22;
		do
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
	
					if i > 2 then
						if
							file_name.item (i - 1) = '.'
							and
							file_name.item (i) = 'e'
						then
							!!class_path.make
											(path.count + file_name.count + 1);
							class_path.append (path);
							class_path.append ("/");
							class_path.append (file_name);
							class_name := read_class_name_in_file (class_path);
							if class_name /= Void then
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
									a_class := old_cluster.classes.item (class_name);
								end;
								if a_class = Void then
									!!a_class.make;
									a_class.set_class_name (class_name);
								end;
									-- The file name may have changed even
									-- if the class was already in this cluster
								a_class.set_file_name (class_path);
								a_class.set_cluster (Current);
								classes.put (a_class, class_name);
							end;
						end;
					end;

					cluster_file.readentry;
					file_name := cluster_file.lastentry;
				end;
				cluster_file.close;
			end;
			Error_handler.checksum;
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
			class_c := a_class.compiled_class;
			if class_c /= Void then
				clients := class_c.syntactical_clients;
				from
					clients.start
				until
					clients.after
				loop
						-- recompile the client
					class_i := clients.item.lace_class;
					Workbench.add_class_to_recompile (class_i);
					class_i.set_changed (True);
					clients.forth;
				end;

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
		end;

	update_cluster is
			-- Update the clusters: remove the classes removed
			-- from the system, examine the differences in the
			-- ignore and rename clauses
		local
			class_i: CLASS_I;
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

	remove_cluster is
			-- Remove all the classes from the current cluster
			-- i.e. the cluster has been removed from the system
		do
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
			ignore.add_front (c);
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
				from
					table := rename_clause.renamings;
					table.start;
				until
					table.after
				loop
					if table.item_for_iteration.is_equal (class_name) then
						if not found then
							Universe.set_last_class
							(a_cluster.classes.item (table.key_for_iteration));
							found := True;
						else
								-- Name clash
							!!vscn;
							vscn.set_first (Universe.last_class);
							vscn.set_second  
							(a_cluster.classes.item (table.key_for_iteration));
							vscn.set_cluster (Current);
							Error_handler.insert_error (vscn);
						end;
					end;
					table.forth;
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
			pos := renamings.position;
			from
				renamings.start
			until
				renamings.after or else Result /= Void
			loop
				rename_clause := renamings.item;
				a_cluster := rename_clause.cluster;
				from
					table := rename_clause.renamings;
					table.start;
				until
					table.after
				loop
					if table.item_for_iteration.is_equal (class_name) then
						Result := a_cluster.classes.item
													(table.key_for_iteration);
					end;
					table.forth;
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

	changed: BOOLEAN is
			-- Is the cluster directory changed ?
		do
			Result := date /= new_date;
		end;

feature {NONE} -- Externals

	c_clname (file_pointer: POINTER): STRING is
			-- Class in file `file_pointer'.
		external
			"C"
		end;

	eif_date (s: ANY): INTEGER is
			-- Date of file of name `str'.
		external
			"C"
		end;

invariant

	path_exists: path /= Void;
	classes_exists: classes /= Void;

end
