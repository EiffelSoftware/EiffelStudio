-- Cluster_rename_clause   : Name LEX_COLUMN LEX_RENAME Class_rename_list
-- 
-- Class_rename_list       : Class_rename_pair
--                         | Class_rename_list LEX_COMMA Class_rename_pair

class CLUST_REN_SD

inherit

	CLUST_ADAPT_SD
		redefine
			set, adapt
		end

feature -- Attributes

	renamings: LACE_LIST [TWO_NAME_SD];
			-- Renaming list

feature -- Initialization

	set is
			-- Yacc initialization
		do
			cluster_name ?= yacc_arg (0);
			cluster_name.to_lower;
			renamings ?= yacc_arg (1);
		ensure then
			cluster_name_exists: cluster_name /= Void;
		end;

feature -- Lace compilation

	adapt is
			-- Adapt current cluster
		local
--			cluster: CLUSTER_I;
--			renaming: TWO_NAME_SD;
--			old_name, new_name: ID_SD;
--			a_class: CLASS_I;
--			vd04: VD04;
--			ok: BOOLEAN;
			warning: REN_WARN;

		do
			!!warning;
			warning.set_cluster (context.current_cluster);
			Error_handler.insert_error (warning);

				-- Check first existence of cluster named `cluster_name'.
--			ok := good_cluster;;
--
--			if ok and then renamings /= Void then
--					-- Analyze renamings
--				from
--					cluster := Universe.cluster_of_name (cluster_name);
--					renamings.start;
--				until
--					renamings.offright
--				loop
--					renaming := renamings.item;
--					old_name := renaming.old_name.twin;
--					new_name := renaming.new_name.twin;
--					old_name.to_lower;
--					new_name.to_lower;
--						-- Check physical existence of class named `old_name'
--						-- in cluster
--					a_class := cluster.classes.item (old_name);
--					if a_class = Void then
--						!!vd04;
--						vd04.set_old_name (renaming.old_name);
--						vd04.set_cluster (cluster);
--						Error_handler.insert_error (vd04);
--					else
--						context.current_cluster.insert_renaming
--												(cluster, old_name, new_name);
--					end;
--
--					renamings.forth;
--				end;
--			end;
		end;

end

