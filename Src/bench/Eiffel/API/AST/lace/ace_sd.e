-- Ace                    : System Root Defaults Clusters Externals Generation LEX_END
--
-- System                  : LEX_SYSTEM Name
--                         ;
--
-- Defaults               : /* empty */
--                        | LEX_DEFAULT D_option_clause_list
--                        ;
--
-- D_option_clause_list   : D_option_clause
--                        | D_option_clause_list LEX_SEMICOLON D_option_clause
--                        ;
--
-- Clusters               : /* empty */
--                        | LEX_CLUSTER Cluster_clause_list
--                        ;
--
-- Cluster_clause_list    : Cluster_clause
--                        | Cluster_clause_list LEX_SEMICOLON Cluster_clause
--                        ;
--
-- Externals              : LEX_EXTERNAL Language_contrib_list
--                        ;
--
-- Language_contrib_list  : Language_contrib
--                        | Language_contrib_list LEX_SEMICOLON Language_contrib
--                        ;
-- Generation             : LEX_GENERATE Language_gen_list
--                        ;
--
-- Language_gen_list      : Language_generation
--                        | Language_gen_list LEX_SEMICOLON Language_generation
--                        ;

class ACE_SD

inherit

	AST_LACE
		redefine
			adapt
		end;
	SHARED_USE;
	CLICKER

feature -- Attributes

	system_name: ID_SD;
			-- System name

	root: ROOT_SD;
			-- Decription to the root clause

	defaults: LACE_LIST [D_OPTION_SD];
			-- Description of the default clause

	clusters: LACE_LIST [CLUSTER_SD];
			-- Description of cluster clauses

	externals: LACE_LIST [LANG_TRIB_SD];
			-- Description of extenal clauses

	generation: LACE_LIST [LANG_GEN_SD];
			-- Description of the generation clause

	click_list: CLICK_LIST;
			-- Structure containing elements to click on AST nodes

feature -- Initialization

	set is
			-- Yacc initialization
		do
			system_name ?= yacc_arg (0);
			root ?= yacc_arg (1);
			defaults ?= yacc_arg (2);
			clusters ?= yacc_arg (3);
			Externals ?= yacc_arg (4);
			Generation ?= yacc_arg (5);
			click_list ?= yacc_arg (6)
		ensure then
			system_name_exists: system_name /= Void;
			root_exists: root /= Void;
		end;

feature -- Lace compilation

	build_universe is
			-- Analysis in order to build the universe
		do

			System.set_system_name (system_name);

				-- Initialization
			Use_properties.clear_all;
				-- First build the clusters with the files *.e found
				-- in the clusters
			build_clusters;
				-- Second adaptation of Use files
			adapt_use;
				-- Thid general adaptation
			adapt;

			update_clusters;

				-- Remove inexistant clusters from the system
			process_removed_clusters;

				-- Finaly process options
			process_options;

				-- Process root clause
			root.adapt;
				-- Process external clause

				-- Incrementality on external clause
			System.reset_external_clause;
			if Externals /= Void then
				Externals.adapt;
			end;
			System.reset_generate_clause;
			if Generation /= Void then
				Generation.adapt
			end;
		end;

	build_clusters is
			-- Analysis of the AS description of the SDF in order to 
			-- build the clusters
		do
			if clusters /= Void then
				from
					clusters.start
				until
					clusters.offright
				loop
					clusters.item.build;
					clusters.forth;
				end;
			end;
		end;

	adapt_use is
			-- Check specified Use files
		do
			if clusters /= Void then
				from
					clusters.start
				until
					clusters.offright
				loop
					clusters.item.adapt_use;
					clusters.forth;
				end;
			end;
		end;

	adapt is
			-- Check cluster adaptation
		do
			if clusters /= Void then
				clusters.adapt;
			end;
		end;

	process_options is
			-- Process options for the universe
		local
			cluster_list: LINKED_LIST [CLUSTER_I];
		do
				-- First Ace-level options and reset options
			from
				cluster_list := Universe.clusters;
				cluster_list.start;
			until
				cluster_list.offright
			loop
				cluster_list.item.reset_options;

				if defaults /= Void then
						-- Update current cluster visible by class D_OPTION_SD
					context.set_current_cluster (cluster_list.item);

						-- Compute defaults options for current cluster
					defaults.adapt;
				end;

				cluster_list.forth;
			end;

				-- Process options in use file
			if clusters /= Void then
				from
					clusters.start;
				until
					clusters.offright
				loop
					
					clusters.item.process_options;
					clusters.forth;
				end;
			end;
		end;

	update_clusters is
			-- Update the clusters: remove the classes removed
			-- from the system, examine the differences in the
			-- ignore and rename clauses
		local
			cluster_list: LINKED_LIST [CLUSTER_I];
		do
			from
				cluster_list := Universe.clusters;
				cluster_list.start;
			until
				cluster_list.offright
			loop
				cluster_list.item.update_cluster;
				cluster_list.forth;
			end;
		end;

	process_removed_clusters is
			-- Remove the classes from the clusters removed from the system
		local
			old_clusters: LINKED_LIST [CLUSTER_I];
			cluster: CLUSTER_I;
		do
			from
				old_clusters := Lace.old_universe.clusters;
				old_clusters.start
			until
				old_clusters.offright
			loop
				cluster := old_clusters.item;
				if not Universe.has_cluster_of_name (cluster.cluster_name) then
					cluster.remove_cluster;
				end;
				old_clusters.forth
			end;
		end;

end
