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
				renamings.start;
				renamings.put_right (rename_clause);
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
				renamings.offright or else Result /= Void
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

	fill (cluster_file: DIRECTORY; old_cluster: CLUSTER_I) is
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
			class_file: EXTEND_FILE;
			vd11: VD11;
			vd10: VD10;
			vd21: VD21;
			vd22: VD22;
		do
				-- Set date first
			date := new_date;

			if open_directory_error (cluster_file) then
				!!vd22;
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
							!!class_file.make (class_path);
							if class_file.is_readable then
								if class_file.open_read_error then
										-- Error when opening file
									!!vd22;
									vd22.set_file_name (class_path);
									Error_handler.insert_error (vd22);
								else
									class_name := c_clname
													(class_file.file_pointer);
									class_file.close;
									if class_name /= Void then
											-- Eiffel class in file
										class_name.to_lower;
										a_class := classes.item (class_name);
										if a_class = Void then
											if old_cluster /= Void then
												a_class :=
													old_cluster.classes.item (class_name);
											end;
											if a_class = Void then
												!!a_class.make;
												a_class.set_class_name (class_name);
												a_class.set_file_name (class_path);
											end;
											a_class.set_cluster (Current);
											classes.put (a_class, class_name);
										else
											-- Error
											!!vd11;
											vd11.set_a_class (a_class);
											vd11.set_file_name (file_name);
											vd11.set_cluster (Current);
											Error_handler.insert_error (vd11);
											Error_handler.raise_error;
										end;
									else
											-- No class in file
										!!vd10;
										vd10.set_cluster (Current);
										vd10.set_file_name (class_path);
										Error_handler.insert_error (vd10);
									end;
								end;
							else
									-- Unreadable file
								!!vd21;
								vd21.set_cluster (Current);
								vd21.set_file_name (class_path);
								Error_handler.insert_error (vd21);
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

	insert_cluster_to_ignore (c: CLUSTER_I) is
			-- Insert `c' in `ignore'.
		require
			good_argument: c /= Void;
		do
			ignore.start;
			ignore.put_right (c);
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
				renamings.offright
			loop
				rename_clause := renamings.item;
				a_cluster := rename_clause.cluster;
				from
					table := rename_clause.renamings;
					table.start;
				until
					table.offright
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
				renamings.offright or else Result /= Void
			loop
				rename_clause := renamings.item;
				a_cluster := rename_clause.cluster;
				from
					table := rename_clause.renamings;
					table.start;
				until
					table.offright
				loop
					if table.item_for_iteration.is_equal (class_name) then
						Result := a_cluster.classes.item
													(table.key_for_iteration);
					end;
					table.forth;
				end;
				renamings.forth;
			end;
			renamings.go (pos);
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
