indexing
	description: "";
	date: "$Date$";
	revision: "$Revision $"

class ACE_SD

inherit

	AST_LACE
		redefine
			adapt
		end;
	SHARED_USE;
	EIFFEL_ENV;
	SHARED_EIFFEL_PROJECT

feature {NONE} -- Initialization

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

feature -- Properties

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

feature {COMPILER_EXPORTER} -- Lace compilation

	build_universe is
			-- Analysis in order to build the universe
		do

			System.set_system_name (system_name);

				-- Initialization
			Use_properties.clear_all;
			Eiffel_system.wipe_out_sub_clusters;

				-- First re-insert the precompiled clusters into the
				-- universe.
			build_precompiled

				-- Then build the clusters with the files *.e found
				-- in the clusters
			build_clusters;
				-- Reset the options of the CLASS_I
			reset_options;

				-- Second adaptation of Use files
			adapt_use;

			update_clusters;
				-- Remove inexistant clusters from the system
			process_removed_clusters

			Degree_output.put_end_degree_6;

			process_system_level_options;

			process_defaults_and_options;

				-- Process root clause
			root.adapt;
				-- Process external clause

			process_external_clause;
			System.reset_generate_clause;
			if Generation /= Void then
				Generation.adapt
			end;

			if Compilation_modes.is_precompiling then
				update_document_path
			end
		end;

	process_external_clause is
		local
			c_file_names, include_paths: FIXED_LIST [STRING]
			object_file_names, makefile_names: FIXED_LIST [STRING]
			no_change: BOOLEAN
		do
				-- Incrementality on external clause
			c_file_names := System.c_file_names
			include_paths := System.include_paths
			object_file_names := System.object_file_names
			makefile_names := System.makefile_names

			System.reset_external_clause;
			if Externals /= Void then
				Externals.adapt;
			end;

			no_change := is_subset (c_file_names, System.c_file_names) and
							is_subset (include_paths, System.include_paths) and
							is_subset (object_file_names, System.object_file_names) and
							is_subset (makefile_names, System.makefile_names)
			if not no_change then
				System.set_freeze
			end
		end

	process_defaults_and_options is
		do
			process_defaults;

				-- Thid general adaptation
			adapt;

				-- Finaly process options
			process_options;
		end;

	precomp_project_names: LINKED_LIST [STRING] is
		local
			d_option: D_OPTION_SD;
			value: OPT_VAL_SD;
		do
			!! Result.make;
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					d_option := defaults.item;
					if d_option.option.is_precompiled then
						value := d_option.value;
						if value.is_name then
								-- If it is not a NAME_SD, the normal
								-- adapt will trigger the error
							Result.extend (value.value)
						end
					end;
					defaults.forth
				end
			end;
				-- Do not call the once function `System' directly since it's
				-- value may be replaced during the first compilation (as soon
				-- as we figured out whether the system describes a Dynamic
				-- Class Set or not).
		ensure
			precomp_project_names_not_void: Result /=  Void
		end;

	precompiled_options: HASH_TABLE [D_PRECOMPILED_SD, STRING] is
			-- Precompilation options, as specified in the
			-- default clause in the Ace file
		local
			d_precompiled_option: D_PRECOMPILED_SD;
			value: OPT_VAL_SD
		do
			!! Result.make (5);
			if defaults /= Void then
				from defaults.start until defaults.after loop
					d_precompiled_option ?= defaults.item;
					if d_precompiled_option /= Void then
						value := d_precompiled_option.value;
						if value.is_name then
								-- If it is not a NAME_SD, the normal
								-- adapt will trigger the error
							Result.force (d_precompiled_option, value.value)
						end
					end;
					defaults.forth
				end
			end;
				-- Do not call the once function `System' directly since it's
				-- value may be replaced during the first compilation (as soon
				-- as we figured out whether the system describes a Dynamic
				-- Class Set or not).
		ensure
			precompiled_options_not_void: precompiled_options /= Void
		end;

	process_system_level_options is
				-- Process the system level options
		do
			System.reset_system_level_options;
			Universe.set_override_cluster_name (Void)
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
			Universe.process_override_cluster
		end;

	build_clusters is
			-- Analysis of the AS description of the SDF in order to 
			-- build the clusters
		do
			if clusters /= Void then
				Degree_output.put_start_degree_6 (clusters.count);
				from
					clusters.start
				until
					clusters.after
				loop
					clusters.item.build;
					clusters.forth;
				end;
			else
				Degree_output.put_start_degree_6 (0)
			end;
		end;

	build_precompiled is
			-- Re-insert the precompiled clusters into
			-- the universe.
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
					!!cluster.make_from_old_cluster (old_cluster);
					Universe.insert_cluster (cluster);
					update_sub_clusters (cluster, old_cluster);
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
			-- Check cluster adaptation.
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

	update_document_path is
			-- Update the document path for each cluster.
			-- This is required so when the precompile is read in, it
			-- will use the default documentation path used during
			-- precompilation.
		require
			is_precompiling: Compilation_modes.is_precompiling;
		local
			cluster_list: LINKED_LIST [CLUSTER_I];
		do
			from
				cluster_list := Universe.clusters;
				cluster_list.start;
			until
				cluster_list.after
			loop
				cluster_list.item.update_document_path;
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
			-- ignore and rename clauses.
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

feature {NONE} -- Incrementality

	is_subset (original_list, new_list: LIST [STRING]): BOOLEAN is
			-- Is `new_list' a subset of `original_list'?
			--| allows Void arguments
			--| Used for incrementality on externals
		do
			if original_list = Void then
				Result := new_list = Void
			elseif new_list = Void then
				Result := True
			else
				from
					Result := True
					new_list.compare_objects
					new_list.start
				until
					new_list.after or else not Result
				loop
					Result := original_list.has (new_list.item)
					new_list.forth
				end
			end
		end

	update_sub_clusters (new_cluster, old_cluster: CLUSTER_I) is
			-- Update the subcluster for `new_cluster' using
			-- `old_cluster'
		require
			non_void_args: new_cluster /= Void and then old_cluster /= Void;
			valid_clusters: equal (new_cluster.cluster_name,
								old_cluster.cluster_name)
		local
			parent_cluster: CLUSTER_I	
		do
			parent_cluster := old_cluster.parent_cluster;
			if parent_cluster = Void then
				Eiffel_system.add_sub_cluster (new_cluster)
			else
					-- Get the real parent.
				parent_cluster := 
					Universe.cluster_of_name 
							(parent_cluster.cluster_name);
				if parent_cluster = Void then
					-- This implies that the parent is different in the
					-- current system than in the precompile which means
					-- this cluster will be processed later. But for now,
					-- just add it to the system.
					Eiffel_system.add_sub_cluster (new_cluster)
				else
					parent_cluster.add_sub_cluster (new_cluster)
				end
			end
		end;

end -- class ACE_SD
