indexing

	description:
		"Precompilation options";
	date: "$Date$";
	revision: "$Revision $"

class D_PRECOMPILED_SD

inherit

	D_OPTION_SD
		rename
			initialize as d_initialize
		redefine
			set
		end;

	EIFFEL_ENV

feature {LACE_AST_FACTORY} -- Initialization

	initialize (o: like option; v: like value; r: like renamings) is
			-- Create a new D_PRECOMPILED AST node.
		require
			o_not_void: o /= Void
		do
			option := o
			value := v
			renamings := r
		ensure
			option_set: option = o
			value_set: value = v
			renamings_set: renamings = r
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization.
		do
			option ?= yacc_arg (0);
			value ?= yacc_arg (1);
			renamings ?= yacc_arg (2)
		end

feature {COMPILER_EXPORTER} -- Initialization

	set_default_base_location is
			-- For the melt_only version, if no precompiled project is
			-- specified, set precomp to $EIFFEL4/precomp/spec/$PLATFORM/base.
		local
			id_sd: ID_SD
		do
			!PRECOMPILED_SD! option;
			!NAME_SD! value;
			!! id_sd.make (50);
			id_sd.append (Default_precompiled_base_location);
			value.set_value (id_sd);
			renamings := Void
		end

feature -- Access

	renamings: LACE_LIST [TWO_NAME_SD];
			-- Cluster renaming list

feature {COMPILER_EXPORTER} -- Renaming

	rename_clusters (univ: UNIVERSE_I) is
			-- Rename clusters according to `renamings' specification.
		require
			univ_not_void: univ /= Void
		local
			cluster, other_cluster: CLUSTER_I;
			old_name, new_name: STRING;
			cluster_list: LINKED_LIST [CLUSTER_I];
			renamed_clusters: HASH_TABLE [CLUSTER_I, STRING];
			vdcn: VDCN;
			vd48: VD48;
			vd49: VD49;
			vd50: VD50
		do
			if renamings /= Void and then not renamings.empty then
				!! renamed_clusters.make (renamings.count);
				from renamings.start until renamings.after loop
					!! old_name.make (10);
					old_name.append (renamings.item.old_name);
					old_name.to_lower;
					!! new_name.make (10);
					new_name.append (renamings.item.new_name);
					new_name.to_lower;
					cluster := univ.cluster_of_name (old_name);
					if cluster = Void then
							-- `old_name': unknown cluster
						!! vd48;
						vd48.set_path (value.value);
						vd48.set_cluster_name (renamings.item.old_name);
						Error_handler.insert_error (vd48);
						Error_handler.raise_error
					elseif renamed_clusters.has (new_name) then
							-- `new_name' listed twice in the rename list
						!! vd49;
						vd49.set_path (value.value);
						vd49.set_new_name (renamings.item.new_name);
						Error_handler.insert_error (vd49);
						Error_handler.raise_error
					elseif renamed_clusters.has_item (cluster) then
							-- `old_name' listed twice in the rename list
						!! vd50;
						vd50.set_path (value.value);
						vd50.set_old_name (renamings.item.old_name);
						Error_handler.insert_error (vd50);
						Error_handler.raise_error
					else
						renamed_clusters.put (cluster, new_name)
					end;
					renamings.forth
				end;
					-- Rename clusters.
				from renamed_clusters.start until renamed_clusters.after loop
					renamed_clusters.item_for_iteration.set_cluster_name (renamed_clusters.key_for_iteration);
					renamed_clusters.forth
				end;
					-- Check for new name clashes.
				cluster_list := univ.clusters;
				from cluster_list.start until cluster_list.after loop
					cluster := cluster_list.item;
					other_cluster := renamed_clusters.item (cluster.cluster_name);
					if
						other_cluster /= Void and then
						other_cluster /= cluster
					then
							-- Two clusters with the same name:
							-- `cluster' and `other_cluster'.
						!! vdcn;
						vdcn.set_cluster (cluster);
						Error_handler.insert_error (vdcn);
						Error_handler.raise_error
					end;
					cluster_list.forth
				end
			end
		end

end -- class D_PRECOMPILED_SD
