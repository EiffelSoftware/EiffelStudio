indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class CLUSTER_SD

inherit

	AST_LACE
		redefine
			adapt
		end;
	SHARED_ENV;
	SHARED_EIFFEL_PROJECT

feature {LACE_AST_FACTORY} -- Initialization

	initialize (cn: like cluster_name; pn: like parent_name;
		dn: like directory_name; cp: like cluster_properties; is_recursive: BOOLEAN) is
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
			process_subclusters := is_recursive
		ensure
			cluster_name_set: cluster_name = cn
			parent_name_set: parent_name = pn
			directory_name_set: directory_name = dn
			cluster_properties_set: cluster_properties = cp
		end

feature {NONE} -- Initialization 

	set is
			-- Yacc initialization
		do
			cluster_name ?= yacc_arg (0);
			cluster_name.to_lower;
			directory_name ?= yacc_arg (1);
			cluster_properties ?= yacc_arg (2)
			parent_name ?= yacc_arg (3)
			if parent_name /= Void then
				parent_name.to_lower
			end

			-- NOTE: Here is the place to set the
			--       attribute `process_subclusters'
			--       to True, iff 'ALL' was specified.
			-- FIXME: Not implemented in the C parser
		ensure then
			directory_name_exists: directory_name /= Void;
			cluster_name_exists: cluster_name /= Void;
		end;

feature -- Properties

	cluster_name: ID_SD;
			-- Cluster name

	directory_name: ID_SD;
			-- Path to the cluster

	cluster_properties: CLUST_PROP_SD;
			-- Cluster properties

	parent_name: ID_SD;
			-- Name of the parent cluster

	process_subclusters: BOOLEAN
			-- Must subclusters be processed (keyword `all')?

feature {COMPILER_EXPORTER} -- Lace recompilation

	build is
			-- Build the cluster. Also, update the `directory_name'.
		local
			d_name, full_d_name: ID_SD;
			parent_cluster: CLUSTER_I;
			vd51: VD51;
			char: CHARACTER
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
						if 		
							d_name.item (1) = '$' and then	
							not (char.is_alpha or else char.is_digit) and then
							char /= '_'
						then
								-- Substitue $ with the parent directory path
							!! full_d_name.make (20);
							full_d_name.append (d_name);
							!! d_name.make (0);
							d_name.append (parent_cluster.dollar_path);
							full_d_name.replace_substring (d_name, 1, 1);
						else
							full_d_name := d_name
						end;
						directory_name := full_d_name
						-- Note: The first time it encounters $/ it is
						-- replaced by the parent directory. Each subsequent
						-- compilation it will skip this.
					end;
				end
			end;
			build_cluster (parent_cluster)
		end;

	build_cluster (parent_cluster: CLUSTER_I) is
			-- Build the cluster_i.
		local
			cluster, old_cluster: CLUSTER_I;
			cluster_of_name, cluster_of_path: CLUSTER_I;
			clusters: LINKED_LIST [CLUSTER_I];
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
						if cluster.is_precompiled then
							--| Need to clean up sub_cluster info on precompiled 
							--| since it was recorded before call `build'.
							--| This information will be updated at the end
							--| of this routine.
							cluster.wipe_out_cluster_info
						end
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
				!!cluster.make (directory_name);
				cluster.set_cluster_name (cluster_name);
				cluster.set_is_recursive (process_subclusters)
				Universe.insert_cluster (cluster);
debug ("REMOVE_CLASS")
	io.error.putstring ("CLUSTER_SD calling fill%N");
end;
				cluster.fill (exclude_list, include_list);
			else
				cluster := old_cluster.new_cluster (cluster_name, 
													exclude_list, 
													include_list,
													process_subclusters);
			end;
			check
				cluster_exists: cluster /= Void
			end;
			if parent_cluster = Void then
				Eiffel_system.add_sub_cluster (cluster)
			else
				parent_cluster.add_sub_cluster (cluster)
			end;
		end;

	include_list: LACE_LIST [FILE_NAME_SD] is
		local
			i: INTEGER
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
		do
			if cluster_properties /= Void then 
				cluster := Universe.cluster_of_path
						(Environ.interpreted_string (directory_name));
				context.set_current_cluster (cluster);
				cluster_properties.adapt_use;
			end;
		end;

	adapt is
			-- Adapt cluster with the cluster properties including
			-- the heirarchy information.
		require else
			Universe.has_cluster_of_path
				(Environ.interpreted_string (directory_name));
		local
			cluster: CLUSTER_I;
		do
			if cluster_properties /= Void then
				cluster := Universe.cluster_of_path
						(Environ.interpreted_string (directory_name));
				context.set_current_cluster (cluster);
				cluster_properties.adapt;
			end;
		end;

	process_options is
			-- Process use options declated in a use file of the current
			-- cluster description
		require
			Universe.has_cluster_of_path
				(Environ.interpreted_string (directory_name));
		local
			cluster: CLUSTER_I;
		do
			if cluster_properties /= Void then
				cluster := Universe.cluster_of_path
					(Environ.interpreted_string (directory_name));
				context.set_current_cluster (cluster);
				cluster_properties.process_options;
			end;
		end;

end -- class CLUSTER_SD
