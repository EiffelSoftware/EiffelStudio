indexing

	description:
		"Precompilation options";
	date: "$Date$";
	revision: "$Revision $"

class D_PRECOMPILED_SD

inherit

	D_OPTION_SD
		redefine
			set
		end;

	EIFFEL_ENV

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
			-- specified, set precomp to $EIFFEL3/precomp/spec/$PLATFORM/base.
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
			cluster: CLUSTER_I;
			old_name, new_name: STRING
		do
			if renamings /= Void then
				from renamings.start until renamings.after loop
					!! old_name.make (10);
					old_name.append (renamings.item.old_name);
					old_name.to_lower;
					!! new_name.make (10);
					new_name.append (renamings.item.new_name);
					new_name.to_lower;
					cluster := univ.cluster_of_name (old_name);
					if cluster = Void then
-- TO DO : validity error
					else
-- TO DO : check whether `new_name' does not introduce a name clash.
						cluster.set_cluster_name (new_name)
					end;
					renamings.forth
				end
			end
		end

end -- class D_PRECOMPILED_SD
