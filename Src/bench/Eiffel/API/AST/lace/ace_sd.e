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
	SHARED_STATUS;
	SHARED_MELT_ONLY;
	EIFFEL_ENV;
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
			if System.is_dynamic then
					-- First re-insert the static clusters into the
					-- universe (when compiling a dynamic class set).
				build_static;
					-- Then build the clusters with the files *.e found
					-- in the clusters
				build_dle_clusters
			else
					-- First re-insert the precompiled clusters into the
					-- universe.
				build_precompiled;
					-- Then build the clusters with the files *.e found
					-- in the clusters
				build_clusters
			end;
				-- Reset the options of the CLASS_I
			reset_options;

				-- Second adaptation of Use files
			adapt_use;

			if System.is_dynamic then
				update_dle_clusters;
					-- Remove inexistant clusters from the system
				process_removed_dle_clusters
			else
				update_clusters;
					-- Remove inexistant clusters from the system
				process_removed_clusters
			end;

			process_system_level_options;

			process_defaults_and_options;

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

	process_defaults_and_options is
		do
			process_defaults;

				-- Thid general adaptation
			adapt;

				-- Finaly process options
			process_options;
		end;

	precomp_project_name: STRING is
		local
			found: BOOLEAN;
			d_option: D_OPTION_SD;
			value: OPT_VAL_SD;
			vd38: VD38;
			vd44: VD44;
		do
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					d_option := defaults.item;
					if d_option.option.is_precompiled then
						if found then
							!!vd38;
							Error_handler.insert_error (vd38);
							Error_handler.raise_error;
						elseif Workbench.system.precompilation then
								-- Do not call the once function `System'
								-- directly since it's value may be replaced
								-- during the first compilation (as soon as
								-- we figured out whether the system describes
								-- a Dynamic Class Set or not).
							!!vd44;
							Error_handler.insert_error (vd44);
							Error_handler.raise_error;
						else
							found := True;
							value := d_option.value;
							if value.is_name then
									-- If it is not a NAME_SD, the normal
									-- adapt will trigger the error
								Result := value.value;
							end;
						end;
					end;
					defaults.forth
				end
			end;
				-- Do not call the once function `System' directly since it's
				-- value may be replaced during the first compilation (as soon
				-- as we figured out whether the system describes a Dynamic
				-- Class Set or not).
			if
				melt_only and then
				not Workbench.system.precompilation and then
				Result = Void
			then
					-- For the melt_only version, if no precompiled project is specified,
					-- return $EIFFEL3/precomp/spec/$PLATFORM/base
				Result := Default_precompiled_location
			end
		end;

	process_system_level_options is
				-- Process the system level options
		do
			System.reset_system_level_options;
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					defaults.item.process_system_level_options;
					defaults.forth
				end
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
					clusters.after
				loop
					clusters.item.build;
					clusters.forth;
				end;
			end;
		end;

	build_precompiled is
			-- Re-insert the precompiled clusters into
			-- the unverse.
		local
			old_clusters: LINKED_LIST [CLUSTER_I];
			old_cluster, cluster: CLUSTER_I;
		do
			from
				old_clusters := Lace.old_universe.clusters;
				old_clusters.start
			until
				old_clusters.after
			loop
				old_cluster := old_clusters.item;
				if old_cluster.is_precompiled then
					!!cluster.make (old_cluster.dollar_path);
					cluster.copy_old_cluster (old_cluster);
					cluster.set_cluster_name (old_cluster.cluster_name);
					Universe.insert_cluster (cluster);
				end;
				old_clusters.forth
			end;
		end;

	adapt_use is
			-- Check specified Use files
		do
			if clusters /= Void then
				from
					clusters.start
				until
					clusters.after
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

	reset_options is
			-- Reset the options of the CLASS_I in the system
		local
			cluster_list: LINKED_LIST [CLUSTER_I];
		do
			from
				cluster_list := Universe.clusters;
				cluster_list.start;
			until
				cluster_list.after
			loop
				cluster_list.item.reset_options;
				cluster_list.forth;
			end;
		end;

	process_defaults is
			-- Process System-level defaults
		local
			cluster_list: LINKED_LIST [CLUSTER_I];
		do
			if defaults /= Void then
				from
					cluster_list := Universe.clusters;
					cluster_list.start;
				until
					cluster_list.after
				loop
						-- Update current cluster visible by class D_OPTION_SD
					context.set_current_cluster (cluster_list.item);

						-- Compute defaults options for current cluster
					defaults.adapt;

					cluster_list.forth;
				end;
			end;
		end;

	process_options is
			-- Process options for the universe
		do
				-- Process options in use file
			if clusters /= Void then
				from
					clusters.start;
				until
					clusters.after
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
			cluster: CLUSTER_I
		do
			from
				cluster_list := Universe.clusters;
				cluster_list.start;
			until
				cluster_list.after
			loop
				cluster := cluster_list.item;
				if not cluster.is_precompiled then
					cluster.update_cluster
				end;
				cluster_list.forth;
			end;
		end;

	process_removed_clusters is
			-- Remove the classes from the clusters removed from the system
			-- Ignore precompiled clusters.
		local
			old_clusters: LINKED_LIST [CLUSTER_I];
			old_cluster: CLUSTER_I;
		do

			old_clusters := Lace.old_universe.clusters;
			from
				old_clusters.start
			until
				old_clusters.after
			loop
				old_cluster := old_clusters.item;
				if not Universe.has_cluster_of_path (old_cluster.path) then
						-- Defensive programming test. The old cluster
						-- should never be precompiled at this stage. 
					if not old_cluster.is_precompiled then
						old_cluster.remove_cluster;
					end;
				end;
				old_clusters.forth
			end;
		end;

	compile_all_classes: BOOLEAN is
		-- Is the root class NONE, i.e. all the classes must be compiled
		do
			Result := root.compile_all_classes
		end;

feature -- DLE

	build_static is
			-- Re-insert the static clusters into the unverse.
			-- Do not insert precompiled clusters since they 
			-- already have been re-inserted.
		require
			dynamic_system: System.is_dynamic
		local
			old_clusters: LINKED_LIST [CLUSTER_I];
			old_cluster, cluster: CLUSTER_I
		do
			from
				old_clusters := Lace.old_universe.clusters;
				old_clusters.start
			until
				old_clusters.after
			loop
				old_cluster := old_clusters.item;
				if old_cluster.is_static then
					!! cluster.make (old_cluster.dollar_path);
					cluster.copy_old_cluster (old_cluster);
					cluster.set_cluster_name (old_cluster.cluster_name);
					Universe.insert_cluster (cluster)
				end;
				old_clusters.forth
			end
		end;

	update_dle_clusters is
			-- Update the dynamic clusters: remove the classes removed
			-- from the system, examine the differences in the
			-- ignore and rename clauses.
		require
			dynamic_system: System.is_dynamic
		local
			cluster_list: LINKED_LIST [CLUSTER_I];
			cluster: CLUSTER_I
		do
			from
				cluster_list := Universe.clusters;
				cluster_list.start
			until
				cluster_list.after
			loop
				cluster := cluster_list.item;
				if cluster.is_dynamic then
					cluster.update_cluster
				end;
				cluster_list.forth
			end
		end;

	process_removed_dle_clusters is
			-- Remove the classes from the clusters removed from the system
			-- Ignore static clusters.
		require
			dynamic_system: System.is_dynamic
		local
			old_clusters: LINKED_LIST [CLUSTER_I];
			old_cluster: CLUSTER_I
		do
			old_clusters := Lace.old_universe.clusters;
			from
				old_clusters.start
			until
				old_clusters.after
			loop
				old_cluster := old_clusters.item;
				if not Universe.has_cluster_of_path (old_cluster.path) then
						-- Defensive programming test. The old cluster
						-- should never be static at this stage. 
					if old_cluster.is_dynamic then
						old_cluster.remove_cluster
					end
				end;
				old_clusters.forth
			end
		end;

	build_dle_clusters is
			-- Analysis of the AS description of the SDF in order to 
			-- build the clusters.
		require
			dynamic_system: System.is_dynamic
		do
			if clusters /= Void then
				from
					clusters.start
				until
					clusters.after
				loop
					clusters.item.build_dle;
					clusters.forth
				end
			end
		end;

	extendible_project_name: STRING is
			-- Directory name of the dynamically extendible system;
			-- Check also whether the combination of options is valid
		local
			system_i: SYSTEM_I;
			precomp_found, found: BOOLEAN;
			extendible: BOOLEAN;
			d_option: D_OPTION_SD;
			value: OPT_VAL_SD;
			string_value: STRING;
			v9xc: V9XC;
			v9xq: V9XQ;
			v9xd: V9XD;
			v9xp: V9XP;
			v9dp: V9DP;
			v9cd: V9CD;
			v9cx: V9CX
		do
			system_i := Workbench.system;
				-- Do not call the once function `System'
				-- directly since it's value may be replaced
				-- during the first compilation (as soon as
				-- we figured out whether the system describes
				-- a Dynamic Class Set or not).
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					d_option := defaults.item;
					if d_option.option.is_extending then
						if found then
								-- Two `extending' options in the same Ace.
							!!v9xc;
							Error_handler.insert_error (v9xc);
							Error_handler.raise_error
						elseif system_i.precompilation then
								-- `exdending' option when precompiling.
							!!v9xq;
							Error_handler.insert_error (v9xq);
							Error_handler.raise_error
						else
							found := True;
							value := d_option.value;
							if value.is_name then
									-- If it is not a NAME_SD, the normal
									-- adapt will trigger the error
								Result := value.value
							end
						end
					elseif d_option.option.is_extendible then
						value := d_option.value;
						if value.is_no then
							extendible := false
						elseif value.is_yes then
							extendible := true
						end
					elseif d_option.option.is_precompiled then
						precomp_found := true
					end;
					defaults.forth
				end
			end;
			if Result /= Void then
				if extendible then
						-- `extendible' and `extending' options in the same Ace.
					!!v9xd;
					Error_handler.insert_error (v9xd);
					Error_handler.raise_error
				elseif precomp_found then
						-- `extending' and `precompiled' options in the same Ace
					!!v9xp;
					Error_handler.insert_error (v9xp);
					Error_handler.raise_error
				end
			end;
			if extendible and system_i.precompilation then
					-- `extendible' option when precompiling.
				!!v9dp;
				Error_handler.insert_error (v9dp);
				Error_handler.raise_error
			end;
			if Lace.not_first_parsing then
				if extendible /= system_i.extendible then
						-- Cannot change the `extendible' status between
						-- two compilations.
					!!v9cd;
					Error_handler.insert_error (v9cd);
					Error_handler.raise_error
				end;
				if Result /= Void xor system_i.is_dynamic then
						-- Cannot change the `extending' status between
						-- two compilations.
					!!v9cx;
					Error_handler.insert_error (v9cx);
					Error_handler.raise_error
				end
			end
		end;
			
end
