indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class CLUST_REN_SD

inherit

	CLUST_ADAPT_SD
		redefine
			set, adapt
		end

feature {NONE} -- Initialization 

	set is
			-- Yacc initialization
		do
			cluster_name ?= yacc_arg (0);
			cluster_name.to_lower;
			renamings ?= yacc_arg (1);
		ensure then
			cluster_name_exists: cluster_name /= Void;
		end;

feature -- Properties

	renamings: LACE_LIST [TWO_NAME_SD];
			-- Renaming list

feature {COMPILER_EXPORTER} -- Lace compilation

	adapt is
			-- Adapt current cluster
		local
			cluster: CLUSTER_I;
			renaming: TWO_NAME_SD;
			old_name, new_name: ID_SD;
			a_class: CLASS_I;
			vd04: VD04;
			ok: BOOLEAN;

		do

				-- Check first existence of cluster named `cluster_name'.
			ok := good_cluster;

			if ok and then renamings /= Void then
					-- Analyze renamings
				from
					cluster := Universe.cluster_of_name (cluster_name);
					renamings.start
				until
					renamings.after
				loop
					renaming := renamings.item;
					old_name := clone (renaming.old_name);
					new_name := clone (renaming.new_name);
					old_name.to_lower;
					new_name.to_lower;
						-- Check physical existence of class named `old_name'
						-- in cluster
					a_class := cluster.classes.item (old_name);
					if a_class = Void then
						!!vd04;
						vd04.set_old_name (renaming.old_name);
						vd04.set_cluster (cluster);
						Error_handler.insert_error (vd04);
					else
						context.current_cluster.insert_renaming
												(cluster, old_name, new_name)
					end;

					renamings.forth
				end
			end
		end;

end -- class CLUST_REN_SD
