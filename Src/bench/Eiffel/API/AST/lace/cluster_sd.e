indexing
	description: "Abstract representation of a cluster in AST for Lace"
	date: "$Date$"
	revision: "$Revision$"

class CLUSTER_SD

inherit
	AST_LACE
		redefine
			adapt
		end

	SHARED_ENV

	SHARED_EIFFEL_PROJECT

	SHARED_RESCUE_STATUS

feature {CLUSTER_SD, LACE_AST_FACTORY} -- Initialization

	initialize (cn: like cluster_name; pn: like parent_name;
		dn: like directory_name; cp: like cluster_properties;
		is_all, is_lib: BOOLEAN) is
			-- Create a new CLUSTER AST node.
		require
			cn_not_void: cn /= Void
			dn_not_void: dn /= Void
		do
			cluster_name := cn
			cluster_name.to_lower
			parent_name := pn
			if parent_name /= Void then
				parent_name.to_lower
			end
			directory_name := dn
			cluster_properties := cp
			is_recursive := is_all
			is_library := is_lib
		ensure
			cluster_name_set: cluster_name = cn
			parent_name_set: parent_name = pn
			directory_name_set: directory_name = dn
			cluster_properties_set: cluster_properties = cp
			recursive_cluster_set: is_recursive = is_all
			library_cluster_set: is_library = is_lib
		end

feature -- Properties

	cluster_name: ID_SD;
			-- Cluster name

	directory_name: ID_SD;
			-- Path to the cluster

	cluster_properties: CLUST_PROP_SD;
			-- Cluster properties

	parent_name: ID_SD;
			-- Name of the parent cluster

	is_recursive: BOOLEAN
			-- Must subclusters be processed (keyword `all')?

	is_library: BOOLEAN
			-- Is cluster part of a library and therefore not subject to changes?

feature -- Status

	has_parent: BOOLEAN is
			-- Does Current have a parent cluster
		do
			Result := parent_name /= Void			
		ensure
			has_parent: Result implies parent_name /= Void
			not_has_parent: not Result implies parent_name = Void
		end
	
feature {CLUSTER_SD, LACE_I} -- Internal Properties

	belongs_to_all: BOOLEAN
			-- Is Current cluster a generated one through the `all'/`library' specification?

feature {CLUSTER_SD} -- Internal Properties

	was_all: BOOLEAN
			-- Was Current cluster specified with `all' or `library' option?

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object
		do
			create Result
			Result.initialize (cluster_name.duplicate, duplicate_ast (parent_name),
				directory_name.duplicate, duplicate_ast (cluster_properties),
				is_recursive, is_library)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then cluster_name.same_as (other.cluster_name)
					and then same_ast (parent_name, other.parent_name)
					and then directory_name.same_as (other.directory_name)
					and then same_ast (cluster_properties, other.cluster_properties)
					and then is_recursive = other.is_recursive
					and then is_library = other.is_library
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			if is_library then
				st.putstring ("library ")
			elseif is_recursive then
				st.putstring ("all ")
			end

			cluster_name.save (st)
			if parent_name /= Void then
				st.putstring (" (")
				parent_name.save (st)
				st.putstring (")")
			end
			st.putstring (":%T%T")
			directory_name.save (st)
			st.new_line

			if cluster_properties /= Void then
				st.indent
				cluster_properties.save (st)
				st.exdent
				st.new_line
			end
		end

feature -- Setting

	set_cluster_name (name: like cluster_name) is
			-- Assgin `name' to `cluster_name'.
		require
			name_not_void: name /= Void
		do
			cluster_name := name
		ensure
			cluster_name_set: cluster_name.is_equal (name)
		end

	set_directory_name (name: like directory_name) is
			-- Assgin `name' to `directory_name'.
		require
			name_not_void: name /= Void
		do
			directory_name := name
		ensure
			directory_name_set: directory_name.is_equal (name)
		end

	set_cluster_properties (name: like cluster_properties) is
			-- Assgin `name' to `cluster_properties'.
		require
			name_not_void: name /= Void
		do
			cluster_properties := name
		ensure
			cluster_properties_set: cluster_properties.is_equal (name)
		end

	set_is_recursive (flag: BOOLEAN) is
			-- Assgin `flag' to `is_recursive'.
		do
			is_recursive := flag
		ensure
			is_recursive_set: is_recursive = flag
		end

	set_is_library (flag: BOOLEAN) is
			-- Assgin `flag' to `is_library'.
		do
			is_library := flag
		ensure
			is_library_set: is_library = flag
		end

feature {CLUSTER_SD} -- Setting

	set_parent_name (name: like parent_name) is
			-- Assgin `name' to `parent_name'.
		require
			name_not_void: name /= Void
		do
			parent_name := name
		ensure
			parent_name_set: parent_name.is_equal (name)
		end

	set_belongs_to_all (flag: BOOLEAN) is
			-- Assgin `flag' to `belongs_to_all'.
		do
			belongs_to_all := flag
		ensure
			belongs_to_all_set: belongs_to_all = flag
		end
			
feature {COMPILER_EXPORTER} -- Lace recompilation

	expand_recursive_clusters (clusters: LACE_LIST [CLUSTER_SD]) is
			-- Expand `clusters' with `all' or `library' specification
		require
			clusters_not_void: clusters /= Void
			clusters: clusters.has (Current)
			is_recursive_cluster: is_recursive
		local
			index: INTEGER
			real_path: DIRECTORY_NAME
			cluster_i: CLUSTER_I
			vd51: VD51
		do
				-- We save `index' in `clusters' because we are going to insert
				-- new clusters in it and to move its cursor for recursive insertion.
			index := clusters.index

				-- Create new clusters
			if parent_name /= Void then
					-- Parent should have been initialized and belongs to `Universe'
					-- if not ther is an error.
				cluster_i := Universe.cluster_of_name (parent_name)
				if cluster_i = Void then	
					create vd51
					vd51.set_parent_name (parent_name)
					vd51.set_cluster_name (cluster_name)
					Error_handler.insert_error (vd51)
					Error_handler.raise_error
				else
					create real_path.make_from_string (cluster_i.dollar_path)
					real_path.extend (directory_name)
				end
			else
				create real_path.make_from_string (directory_name)
			end
			internal_expand_recursive_clusters (real_path, clusters,
					create {SEARCH_TABLE [STRING]}.make (10))

				-- Remove `is_recursive' status since we modify it.
			set_is_recursive (False)
			was_all := True

				-- Restore `index'
			clusters.go_i_th (index)
		end

	build is
			-- Build the cluster. Also, update the `directory_name'.
		local
			d_name, full_d_name: ID_SD;
			parent_cluster: CLUSTER_I;
			vd51: VD51;
			char: CHARACTER
			dir_name: DIRECTORY_NAME
		do
			if parent_name /= Void then
				parent_cluster := Universe.cluster_of_name (parent_name);
				if parent_cluster = Void then	
					!! vd51;
					vd51.set_parent_name (parent_name);
					vd51.set_cluster_name (cluster_name);
					Error_handler.insert_error (vd51);
					Error_handler.raise_error
				else
					d_name := directory_name;
					if d_name.count > 1 then
						char := d_name.item (2);
						full_d_name := d_name
						if d_name.item (1) = '$' then
							if char = '|' and then d_name.count > 2 then
									-- This comes from an automatic generated sub-clusters
									-- because of the `all' or `library' qualification.
								create dir_name.make_from_string (parent_cluster.dollar_path)
								dir_name.extend (d_name.substring (3, d_name.count))
								create full_d_name.initialize (dir_name)
							elseif
								not (char.is_alpha or else char.is_digit)
								and then char /= '_'
							then
									-- Substitue $ with the parent directory path
									-- Note: The first time it encounters $/ it is
									-- replaced by the parent directory. Each subsequent
									-- compilation it will skip this.
								create full_d_name.initialize (d_name)
								create d_name.initialize (parent_cluster.dollar_path)
								full_d_name.replace_substring (d_name, 1, 1)
							end
						end
						directory_name := full_d_name
					end
				end
			end
			build_cluster (parent_cluster)
		end

	build_cluster (parent_cluster: CLUSTER_I) is
			-- Build the cluster_i.
		local
			cluster, old_cluster: CLUSTER_I;
			cluster_of_name, cluster_of_path: CLUSTER_I;
			vd28: VD28;
			vdcn: VDCN;
			path: STRING
		do
			path := Environ.interpreted_string (directory_name);
			cluster_of_name := Universe.cluster_of_name (cluster_name);
			cluster_of_path := Universe.cluster_of_path (path);
			old_cluster := Lace.old_universe.cluster_of_path (path);
			if cluster_of_name /= Void then
				if cluster_of_name.is_precompiled then
						-- Precompiled clusters may be moved without
						-- forcing a precompilation,
					if 
						(cluster_of_path /= Void) and then
						cluster_of_path /= cluster_of_name
					then
						!!vd28;
						vd28.set_cluster (cluster_of_name);
						vd28.set_second_cluster_name (cluster_of_path.cluster_name);
						Error_handler.insert_error (vd28);
						Error_handler.raise_error;
					else
						cluster_of_name.set_dollar_path (directory_name);
						cluster := cluster_of_name;
					end;
				else
					!!vdcn;
					vdcn.set_cluster (cluster_of_name);
					Error_handler.insert_error (vdcn);
					Error_handler.raise_error;
				end;
			elseif cluster_of_path /= Void then
				!!vd28;
				vd28.set_cluster (cluster_of_path);
				vd28.set_second_cluster_name (cluster_name);
				Error_handler.insert_error (vd28);
				Error_handler.raise_error;
			elseif old_cluster = Void then
					-- New cluster
				create cluster.make_with_parent (directory_name, parent_cluster)
				cluster.set_cluster_name (cluster_name)
				cluster.set_is_recursive (is_recursive)
				cluster.set_is_library (is_library)
				cluster.set_belongs_to_all (belongs_to_all)
				Universe.insert_cluster (cluster)
debug ("REMOVE_CLASS")
	io.error.putstring ("CLUSTER_SD calling fill%N");
end;
				cluster.fill (exclude_list, include_list);
			else
				cluster := old_cluster.new_cluster (cluster_name, 
													exclude_list, 
													include_list,
													is_recursive,
													is_library,
													parent_cluster);
			end;
			check
				cluster_exists: cluster /= Void
			end;
		end;

	include_list: LACE_LIST [FILE_NAME_SD] is
		do
			if cluster_properties /= Void then
				Result := cluster_properties.include_option;
			end;
		end;

	exclude_list: LACE_LIST [FILE_NAME_SD] is
		do
			if cluster_properties /= Void then
				Result := cluster_properties.exclude_option
			end;
		end;

	adapt_use is
			-- Check Use file for current cluster
		require
			Universe.has_cluster_of_path	
				(Environ.interpreted_string (directory_name));
		local
			cluster: CLUSTER_I;
			classes: EXTEND_TABLE [CLASS_I, STRING]
		do
			if not belongs_to_all and then cluster_properties /= Void then 
				cluster := Universe.cluster_of_path
						(Environ.interpreted_string (directory_name));
				context.set_current_cluster (cluster);
				if was_all then
					classes := cluster.classes
					cluster.update_with_all_classes
				end
				cluster_properties.adapt_use;
				if was_all then
					cluster.reset_classes (classes)
				end
			end;
		end;

	adapt is
			-- Adapt cluster with the cluster properties including
			-- the heirarchy information.
		require else
			Universe.has_cluster_of_path
				(Environ.interpreted_string (directory_name));
		local
			cluster: CLUSTER_I
			classes: EXTEND_TABLE [CLASS_I, STRING]
		do
			if not belongs_to_all and then cluster_properties /= Void then
				cluster := Universe.cluster_of_path
						(Environ.interpreted_string (directory_name));
				context.set_current_cluster (cluster);
				if was_all then
					classes := cluster.classes
					cluster.update_with_all_classes
				end
				cluster_properties.adapt
				if was_all then
					cluster.reset_classes (classes)
				end
			end;
		end;

	process_options is
			-- Process use options declated in a use file of the current
			-- cluster description
		require
			Universe.has_cluster_of_path
				(Environ.interpreted_string (directory_name));
		local
			cluster: CLUSTER_I
			classes: EXTEND_TABLE [CLASS_I, STRING]
		do
			if not belongs_to_all and then cluster_properties /= Void then
				cluster := Universe.cluster_of_path
					(Environ.interpreted_string (directory_name));
				context.set_current_cluster (cluster);
				if was_all then
					classes := cluster.classes
					cluster.update_with_all_classes
				end
				cluster_properties.process_options;
				if was_all then
					cluster.reset_classes (classes)
				end
			end;
		end;

feature {CLUSTER_SD} -- Implementation

	internal_expand_recursive_clusters (path_name: STRING;
				clusters: LACE_LIST [CLUSTER_SD]; already_done: SEARCH_TABLE [STRING]) is
			-- Expand `clusters' with `all' or `library' specification
		require
			clusters_not_void: clusters /= Void
			clusters: clusters.has (Current)
			already_done_not_void: already_done /= Void
		local
			new_cluster: like Current
			cluster_dir: DIRECTORY
			file_name, current_dir: STRING
			check_dir, is_efile, found: BOOLEAN
			i: INTEGER
			ex_list: like exclude_list
			clus_name: like cluster_name
			dir_name: like directory_name
			file_path: DIRECTORY_NAME
		do
				-- Interpret path_name if it contains environment variable
				-- and insert interpreted name into list of directory already analyzed.
			current_dir := Environ.interpreted_string (path_name)
			already_done.put (physical_id (current_dir))

			create cluster_dir.make (current_dir)
			if cluster_dir.exists and then not open_directory_error (cluster_dir) then
				from
					cluster_dir.start
					cluster_dir.readentry
					file_name := cluster_dir.lastentry
				until
					file_name = Void
				loop
					i := file_name.count
					is_efile := (i > 2) and then (file_name.item (i - 1) = '.')
							and then valid_class_file_extension (file_name.item (i))
					check_dir := not is_efile and then not is_current_or_parent_directory (file_name)
					create file_path.make_from_string (current_dir)
					file_path.extend (file_name)
					check_dir := check_dir and then is_real_directory (file_path)
					if check_dir then
						found := False
						ex_list := exclude_list
						if ex_list /= Void then
							from
								ex_list.start
							until
								ex_list.after or else found
							loop
								found := file_name.is_equal (ex_list.item.file__name)
								ex_list.forth
							end
						end
						if not found then
								-- Dupplicate existing cluster
							new_cluster := clone (Current)

								-- New name of cluster which is `cluster_name.file_name'.
							clus_name := clone (cluster_name)
							clus_name.append_character ('.')
							clus_name.append (file_name)
							new_cluster.set_cluster_name (clus_name)

								-- Set parent cluster to `Current' cluster.
							new_cluster.set_parent_name (cluster_name)

								-- Set directory path of cluster
								-- We preprend `file_name' with "$|" to tell that we need
								-- specification from parent.
							create dir_name.initialize ("$|")
							dir_name.append (file_name)
							new_cluster.set_directory_name (dir_name)

								-- It is not recursive anymore.
							new_cluster.set_is_recursive (False)

								-- Set `is_library' to keep the same value as parent.
							new_cluster.set_is_library (is_library)

								-- Set `belongs_to_all' since it belongs to a `all' cluster
							new_cluster.set_belongs_to_all (True)

								-- Insert in list of CLUSTER_SD at the right of current position
								-- and move cursor to right for next insertion if any
							clusters.put_right (new_cluster)
							clusters.forth

							if not already_done.has (physical_id (file_path)) then
									-- Recursive call to create new sub-clusters if there are
									-- any sub-directories.
								new_cluster.internal_expand_recursive_clusters (file_path,
										clusters, already_done)
							end
						end
					end
					cluster_dir.readentry
					file_name := cluster_dir.lastentry
				end
				cluster_dir.close
			end
		end

feature {NONE} -- Implementation

	open_directory_error (cluster_dir: DIRECTORY): BOOLEAN is
			-- Does the opening of the directory file `cluster_dir'
			-- trigger an error ?
		require
			good_argument: cluster_dir /= Void
		do
			if not Result then
				cluster_dir.open_read
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				Result := True
				retry
			end
		end

	valid_class_file_extension (c: CHARACTER): BOOLEAN is
			-- Is `c' a valid class file extension?
		do
			Result := c = 'e' or c = 'E'
		end

	is_current_or_parent_directory (cl_path: STRING) : BOOLEAN is
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

	is_real_directory (cl_path: STRING) : BOOLEAN is
			-- Does `cl_path' point to the current
			-- cluster or its parent?
		require
			path_exists: cl_path /= Void
		local
			d: DIRECTORY
		do
			create d.make (cl_path)
			Result := d.exists
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

end -- class CLUSTER_SD


