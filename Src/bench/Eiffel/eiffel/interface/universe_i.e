-- Internal representation of the Eiffel universe

class UNIVERSE_I

inherit

	SHARED_ERROR_HANDLER
		export
			{COMPILER_EXPORTER} all
		redefine
			copy
		end
	SHARED_WORKBENCH
		export
			{COMPILER_EXPORTER} all
		redefine
			copy
		end;
	COMPILER_EXPORTER
		redefine
			copy
		end;
	
creation {COMPILER_EXPORTER}

	make

feature {NONE} -- Initialization

	make is
			-- Create the hash table.
		do
			!! clusters.make;
			!! cluster_counter;
		end;

feature -- Properties

	clusters: LINKED_LIST [CLUSTER_I];
			-- Clusters of the universe

	last_class: CLASS_I;
			-- Last class subject to a query

feature -- Access

	class_with_name (class_name: STRING): CLASS_I is
			-- Find class with name `class_name' in the Universe
			-- (Void if not found).	
		local
			cur: CURSOR;
			cname: STRING
		do
			cname := clone (class_name);
			cname.to_lower;
			cur := clusters.cursor;
			from
				clusters.start
			until
				clusters.after or else Result /= Void
			loop
				Result := class_named (cname, clusters.item);
				clusters.forth
			end;
			clusters.go_to (cur)
		end;

	class_named (class_name: STRING; cluster: CLUSTER_I): CLASS_I is
			-- Class named `class_name' in cluster `cluster'
		require
			good_argument: class_name /= Void;
			good_cluster: cluster /= Void;
		local
			a_cluster: CLUSTER_I;
			real_name: STRING;
			rename_clause: RENAME_I;
			renamings: HASH_TABLE [STRING, STRING];
			ignore: LINKED_LIST [CLUSTER_I];
			old_cursor: CURSOR
		do
				-- First look for a renamed class in `cluster'
			Result := cluster.renamed_class (class_name);

			if Result = Void then
				from
					old_cursor := clusters.cursor;
					ignore := cluster.ignore;
					clusters.start
				until
					clusters.after or else Result /= Void
				loop
					a_cluster := clusters.item;
					if not ignore.has (a_cluster) then
						real_name := class_name;
						rename_clause := cluster.rename_clause_for (a_cluster);
						if rename_clause /= Void then
								-- Evaluation of the real name of the class
							renamings := rename_clause.renamings;
							if renamings.has (class_name) then
								real_name := renamings.item (class_name);
							end;
						end;
						Result := a_cluster.classes.item (real_name);
					end;
					clusters.forth
				end;
				clusters.go_to (old_cursor)
			end;
		end;

	cluster_changed: BOOLEAN is
			-- Has the time stamps of the present clusters changed ?
		local
			a_cluster: CLUSTER_I;
			new_date: INTEGER;
			ptr: ANY;
		do
			from
				clusters.start
			until
				clusters.after or else Result
			loop
				a_cluster := clusters.item;
				ptr := a_cluster.path.to_c;
				new_date := eif_date ($ptr);
				Result := a_cluster.date /= new_date;
				clusters.forth
			end;
		end;

	cluster_of_name (cluster_name: STRING): CLUSTER_I is
			-- Cluster which name is `cluster_name' (Void if none)
		require
			good_argument: cluster_name /= Void;
		local
			stop: BOOLEAN;
		do
			from
				clusters.start
			until
				clusters.after or else stop
			loop
				stop := cluster_name.is_equal (clusters.item.cluster_name);
				if not stop then
					clusters.forth
				end;
			end;
			if stop then
				Result := clusters.item
			end;
		end;

	has_cluster_of_name (cluster_name: STRING): BOOLEAN is
			-- Does `clusters' have a cluster which name is `cluster_name' ?
		do
			Result := cluster_of_name (cluster_name) /= Void;
		end;

	cluster_of_path (cluster_path: STRING): CLUSTER_I is
			-- Cluster which path is `cluster_path' (Void if none)
		require
			good_argument: cluster_path /= Void;
		local
			stop: BOOLEAN;
		do
			from
				clusters.start
			until
				clusters.after or else stop
			loop
				stop := clusters.item.path.is_equal (cluster_path);
				if not stop then
					clusters.forth
				end;
			end;
			if stop then
				Result := clusters.item
			end;
		end;

	has_cluster_of_path (cluster_path: STRING): BOOLEAN is
			-- Does `clusters' have a cluster which path is `cluster_path' ?
		do
			Result := cluster_of_path (cluster_path) /= Void;
		end;

feature -- Update

	update_cluster_paths is
			-- Update the paths of the clusters in the universe.
			-- (Re-interpret environment variables)
			-- FIXME shouldn't be exported to all
		do
			from
				clusters.start
			until
				clusters.after
			loop
				clusters.item.update_path;
				clusters.forth
			end
		end;

feature {COMPILER_EXPORTER} -- Implementation

	cluster_counter: COUNTER;
			-- Counter of clusters

feature {COMPILER_EXPORTER} -- Implementation

	set_clusters (l: like clusters) is
			-- Assign `l' to `clusters'.
		do
			clusters := l;
		end;

	set_last_class (c: CLASS_I) is
			-- Assign `c' to `last_class'.
		do
			last_class := c;
		end;

	insert_cluster (c: CLUSTER_I) is
			-- Insert `c' in `clusters'.
		require
			good_argument: c /= Void;
			consistency: not has_cluster_of_path (c.path);
		do
			clusters.extend (c);
		end;

	copy (other: like Current) is
			-- Clone universe
		do
			make;
			from
				other.clusters.start
			until
				other.clusters.after
			loop
				insert_cluster (other.clusters.item)
				other.clusters.forth
			end
		end

	check_universe is
			-- Check universe
		require
			system_exists: system /= Void;
		do
			system.set_general_class (unique_class ("general"));
			system.set_any_class (unique_class ("any"));
			system.set_boolean_class (unique_class ("boolean"));
			system.set_character_class (unique_class ("character"));
			system.set_integer_class (unique_class ("integer"));
			system.set_real_class (unique_class ("real"));
			system.set_double_class (unique_class ("double"));
			system.set_pointer_class (unique_class ("pointer"));
			system.set_string_class (unique_class ("string"));
			system.set_array_class (unique_class ("array"));
			system.set_special_class (unique_class ("special"));
			system.set_to_special_class (unique_class ("to_special"));
			system.set_bit_class (unique_class ("bit_ref"));
			system.set_character_ref_class (unique_class ("character_ref"));
			system.set_boolean_ref_class (unique_class("boolean_ref"));
			system.set_integer_ref_class (unique_class("integer_ref"));
			system.set_real_ref_class (unique_class("real_ref"));
			system.set_double_ref_class (unique_class("double_ref"));
			system.set_pointer_ref_class (unique_class("pointer_ref"));
			if System.is_dynamic then
				System.set_dynamic_class (unique_class ("dynamic"))
			elseif System.extendible then
				System.set_dynamic_class (dle_unique_class ("dynamic"))
			end
				-- Check sum error
			Error_handler.checksum;
		end;

	reset_clusters is
			-- Reset all the clusters
		local
			a_cluster: CLUSTER_I;
		do
			from
				clusters.start
			until
				clusters.after
			loop
				a_cluster := clusters.item;
				if not a_cluster.is_precompiled then
					a_cluster.reset_cluster;
				end;
				clusters.forth
			end;
		end;

	unique_class (class_name: STRING): CLASS_I is
			-- Universe checking
		require
			good_argument: class_name /= Void;
		local
			cluster: CLUSTER_I;
			vd23: VD23;
			vd24: VD24;
			i:INTEGER
		do
			from
				clusters.start
			until
				clusters.after
			loop
				cluster := clusters.item;
				i := clusters.index
				compute_last_class (class_name, cluster);
				if last_class = Void then
					!!vd23;
					vd23.set_class_name (class_name);
					Error_handler.insert_error (vd23);
				elseif	Result /= Void 
						and then
						last_class /= Result
				then
					!!vd24;
					vd24.set_cluster (cluster);
					vd24.set_other_cluster (Result.cluster);
					vd24.set_class_name (class_name);
					Error_handler.insert_error (vd24);
				end;
				Result := last_class;
				clusters.go_i_th (i)
				clusters.forth
			end;
		end;
				
	duplicate: like Current is
			-- Duplication of universe
		local
			pos: INTEGER;
		do
			pos := clusters.index;

			!!Result.make;
			clusters.start;
			Result.set_clusters (clusters.duplicate (clusters.count));

			clusters.go_i_th (pos);
		end;

	compute_last_class (class_name: STRING; cluster: CLUSTER_I)  is
			-- Assign to `last_class' the class named `class_name'
			-- in cluster `cluster'
		require
			good_argument: class_name /= Void;
			good_cluster: cluster /= Void;
		local
			a_cluster: CLUSTER_I;
			real_name: STRING;
			rename_clause: RENAME_I;
			renamings: HASH_TABLE [STRING, STRING];
			ignore: LINKED_LIST [CLUSTER_I];
			vscn: VSCN;
		do
			last_class := Void;

				-- First look for a renamed class in `cluster'
			cluster.compute_last_class (class_name);

			from
				ignore := cluster.ignore;
				clusters.start
			until
				clusters.after
			loop
				a_cluster := clusters.item;
				if not ignore.has (a_cluster) then
					real_name := class_name;
					rename_clause := cluster.rename_clause_for (a_cluster);
					if rename_clause /= Void then
							-- Evaluation of the real name of the class
						renamings := rename_clause.renamings;
						if renamings.has (class_name) then
							real_name := renamings.item (class_name);
						end;
					end;
	
					if a_cluster.classes.has (real_name) then
						if last_class = Void then
							last_class := a_cluster.classes.item (real_name);
						else
							!!vscn;
							vscn.set_first (last_class);
							vscn.set_second
										(a_cluster.classes.item (real_name));
							vscn.set_cluster (a_cluster);
							Error_handler.insert_error (vscn);
						end;
					end;	
				end;
				clusters.forth
			end;
		end;

	is_ambiguous_name (class_name: STRING): BOOLEAN is
			-- Is the raw class name `class_name' ambiguous for the
			-- universe ?
		require
			good_argument: class_name /= Void;
		local
			found, one_found: BOOLEAN;
		do
			from
				clusters.start
			until
				clusters.after or else Result
			loop
				found := clusters.item.classes.has (class_name);
				Result := found and then one_found;
				one_found := one_found or else found;
				clusters.forth
			end;
		end;

feature {COMPILER_EXPORTER} -- Precompilation

	mark_precompiled is
			-- Mark all the clusters of the universe as being precompiled.
		do
			from
				clusters.start
			until
				clusters.after
			loop
				clusters.item.set_is_precompiled;
				clusters.forth
			end;
		end;

feature {COMPILER_EXPORTER} -- DLE Implementation

	reset_dle_clusters is
			-- Reset all the DC-set clusters.
		require
			dynamic_system: System.is_dynamic
		local
			a_cluster: CLUSTER_I
		do
			from
				clusters.start
			until
				clusters.after
			loop
				a_cluster := clusters.item;
				if a_cluster.is_dynamic then
					a_cluster.reset_cluster
				end;
				clusters.forth
			end
		end;

	check_descendants_of_dynamic is
			-- Check each descendant of DYNAMIC in the DC-set is not
			-- generic and include a `make' procedure with one argument
			-- of type ANY in its creation clause.
		require
			dynamic_system: System.is_dynamic
		do
			from
				clusters.start
			until
				clusters.after
			loop
				clusters.item.check_descendants_of_dynamic;
				clusters.forth
			end
		end;

	dle_unique_class (class_name: STRING): CLASS_I is
			-- Search for unique class `class_name' in the universe.
			-- Does not complain if this class does not exist.
		require
			good_argument: class_name /= Void
		local
			cluster: CLUSTER_I;
			vd24: VD24;
			i:INTEGER
		do
			from
				clusters.start
			until
				clusters.after
			loop
				cluster := clusters.item;
				i := clusters.index
				compute_last_class (class_name, cluster);
				if
					Result /= Void and
					last_class /= Void and
					last_class /= Result
				then
					!!vd24;
					vd24.set_cluster (cluster);
					vd24.set_other_cluster (Result.cluster);
					vd24.set_class_name (class_name);
					Error_handler.insert_error (vd24)
				end;
				Result := last_class;
				clusters.go_i_th (i)
				clusters.forth
			end
		end;
				
feature {NONE} -- Externals

	eif_date (s: POINTER): INTEGER is
			-- External time stamp primitive
		external
			"C"
		end;

end
