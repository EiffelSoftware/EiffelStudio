-- Internal representation of the Eiffel universe

class UNIVERSE_I

inherit

	SHARED_ERROR_HANDLER
		redefine
			twin
		end;
	SHARED_WORKBENCH
		redefine
			twin
		end;

creation

	make

feature -- Attributes

	clusters: LINKED_LIST [CLUSTER_I];
			-- Clusters of the universe

	last_class: CLASS_I;
			-- Last class subject to a query

feature

	make is
			-- Create the hash table.
		do
			!!clusters.make;
		end;

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
			clusters.add_front (c);
		end;

	cluster_changed: BOOLEAN is
			-- Has the time stamps of the present clusters changed ?
		local
			a_cluster: CLUSTER_I;
			new_date: INTEGER;
			ptr: ANY;
			local_cursor: LINKABLE [CLUSTER_I];
		do
			from
				local_cursor := clusters.first_element;
			until
				local_cursor = Void or else Result
			loop
				a_cluster := local_cursor.item;
				ptr := a_cluster.path.to_c;
				new_date := eif_date ($ptr);
				Result := a_cluster.date /= new_date;
				local_cursor := local_cursor.right;
			end;
		end;

	twin: like Current is
			-- Twin universe
		local
			local_cursor: LINKABLE [CLUSTER_I]
		do
			!!Result.make;
			from
				local_cursor := clusters.first_element
			until
				local_cursor = Void
			loop
				Result.insert_cluster (local_cursor.item);
				local_cursor := local_cursor.right
			end
		end;

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
				-- Check sum error
			Error_handler.checksum;
		end;

	unique_class (class_name: STRING): CLASS_I is
			-- Universe checking
		require
			good_argument: class_name /= Void;
		local
			cluster: CLUSTER_I;
			vd23: VD23;
			vd24: VD24;
			local_cursor: LINKABLE [CLUSTER_I];
		do
			from
				local_cursor := clusters.first_element;
			until
				local_cursor = Void
			loop
				cluster := local_cursor.item;
				compute_last_class (class_name, cluster);
				if last_class = Void then
					!!vd23;
					vd23.set_cluster (cluster);
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

				local_cursor := local_cursor.right;
			end;
		end;
				
	cluster_of_path (cluster_path: STRING): CLUSTER_I is
			-- Cluster which path is `cluster_path' (Void if none)
		require
			good_argument: cluster_path /= Void;
		local
			stop: BOOLEAN;
			local_cursor: LINKABLE [CLUSTER_I];
		do
			from
				local_cursor := clusters.first_element;
			until
				local_cursor = Void or else stop
			loop
				stop := local_cursor.item.path.is_equal (cluster_path);
				if not stop then
					local_cursor := local_cursor.right
				end;
			end;
			if stop then
				Result := local_cursor.item
			end;
		end;

	has_cluster_of_path (cluster_path: STRING): BOOLEAN is
			-- Does `clusters' have a cluster which path is `cluster_path' ?
		do
			Result := cluster_of_path (cluster_path) /= Void;
		end;

	cluster_of_name (cluster_name: STRING): CLUSTER_I is
			-- Cluster which name is `cluster_name' (Void if none)
		require
			good_argument: cluster_name /= Void;
		local
			local_cursor: LINKABLE [CLUSTER_I];
			stop: BOOLEAN;
		do
			from
				local_cursor := clusters.first_element
			until
				local_cursor = Void or else stop
			loop
				stop := cluster_name.is_equal (local_cursor.item.cluster_name);
				if not stop then
					local_cursor := local_cursor.right;
				end;
			end;
			if stop then
				Result := local_cursor.item
			end;
		end;

	has_cluster_of_name (cluster_name: STRING): BOOLEAN is
			-- Does `clusters' have a cluster which name is `cluster_name' ?
		do
			Result := cluster_of_name (cluster_name) /= Void;
		end;

	duplicate: like Current is
			-- Duplication of universe
		local
			pos: INTEGER;
		do
			pos := clusters.position;

			!!Result.make;
			clusters.start;
			Result.set_clusters (clusters.duplicate (clusters.count));

			clusters.go (pos);
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
			local_cursor: LINKABLE [CLUSTER_I];
		do
			last_class := Void;

				-- First look for a renamed class in `cluster'
			cluster.compute_last_class (class_name);

			from
				ignore := cluster.ignore;
				local_cursor := clusters.first_element;
			until
				local_cursor = Void
			loop
				a_cluster := local_cursor.item;
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
				local_cursor := local_cursor.right;
			end;
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
			local_cursor: LINKABLE [CLUSTER_I];
		do
				-- First look for a renamed class in `cluster'
			Result := cluster.renamed_class (class_name);

			if Result = Void then
				from
					ignore := cluster.ignore;
					local_cursor := clusters.first_element;
				until
					local_cursor = Void or else Result /= Void
				loop
					a_cluster := local_cursor.item;
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
					local_cursor := local_cursor.right;
				end;
			end;
		end;

	is_ambiguous_name (class_name: STRING): BOOLEAN is
			-- Is the raw class name `class_name' ambiguous for the
			-- universe ?
		require
			good_argument: class_name /= Void;
		local
			found, one_found: BOOLEAN;
			local_cursor: LINKABLE [CLUSTER_I];
		do
			from
				local_cursor := clusters.first_element;
			until
				local_cursor = Void or else Result
			loop
				found := local_cursor.item.classes.has (class_name);
				Result := found and then one_found;
				one_found := one_found or else found;
				local_cursor := local_cursor.right;
			end;
		end;

feature {NONE} -- Externals

	eif_date (s: ANY): INTEGER is
			-- External time stamp primitive
		external
			"C"
		end;

end
