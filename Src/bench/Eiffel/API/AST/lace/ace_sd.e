indexing
	description: "Representation of a Lace AST"
	date: "$Date$"
	revision: "$Revision$"

class ACE_SD

inherit
	AST_LACE
		redefine
			adapt
		end

	SHARED_USE

	EIFFEL_ENV

	SHARED_EIFFEL_PROJECT

feature {ACE_SD, LACE_AST_FACTORY} -- Initialization

	initialize (sn: like system_name; r: like root;
		d: like defaults; c: like clusters; e: like externals;
		cl: like click_list) is
			-- Create a new ACE AST node.
		require
			sn_not_void: sn /= Void
			r_not_void: r /= Void
			cl_not_void: cl /= Void
		do
			system_name := sn
			root := r
			defaults := d
			clusters := c
			externals := e
			click_list := cl
		ensure
			system_name_set: system_name = sn
			root_set: root = r
			defaults_set: defaults = d
			clusters_set: clusters = c
			externals_set: externals = e
			click_list_set: click_list = cl
		end

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

	click_list: CLICK_LIST;
			-- Structure containing elements to click on AST nodes

	comment_list: ARRAYED_LIST [STRING]
			-- List of comments usually associated with `default' clause.

feature -- Setting

	set_defaults (d: like defaults) is
			-- Set `defaults' with `d'.
		do
			defaults := d
		ensure
			defaults_set: defaults = d
		end

	set_system_name (sn: like system_name) is
			-- Set `system_name' with `sn'.
		require
			sn_not_void: sn /= Void
		do
			system_name := sn
		ensure
			system_name_set: system_name = sn
		end

	set_root (r: like root) is
			-- Set `root' with `r'.
		require
			r_not_void: r /= Void
		do
			root := r
		ensure
			root_set: root = r
		end

	set_clusters (cl: like clusters) is
			-- Set `clusters' with `cl'.
		require
			cl_not_void: cl /= Void
		do
			clusters := cl
		ensure
			clusters_set: clusters = cl
		end

	set_externals (e: like externals) is
			-- Set `externals' with `r'.
		require
			e_not_void: e /= Void
		do
			externals := e
		ensure
			externals_set: externals = e
		end

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object
		do
			create Result
			Result.initialize (system_name.duplicate, root.duplicate,
				duplicate_ast (defaults), duplicate_ast (clusters), duplicate_ast (externals), click_list)
			Result.set_comment_list (comment_list)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then system_name.same_as (other.system_name)
					and then root.same_as (other.root)
					and then same_ast (defaults, other.defaults)
					and then same_ast (clusters, other.clusters)
					and then same_ast (externals, other.externals)
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			st.putstring ("system")
			st.new_line
			st.indent
			system_name.save (st)
			st.exdent
			st.new_line
			st.new_line

			st.putstring ("root")
			st.new_line
			st.indent
			root.save (st)
			st.exdent
			st.new_line
			st.new_line

			if defaults /= Void then
				st.putstring ("default")	
				st.new_line
				st.indent
				defaults.save_with_new_line (st)
				st.exdent
				st.new_line
			end

			if comment_list /= Void and then not comment_list.is_empty then
					-- Saving comments
				st.new_line
				from
					comment_list.start
				until
					comment_list.after
				loop
					st.putstring (comment_list.item)
					st.new_line
					comment_list.forth
				end
			end
	
			st.new_line
			st.putstring ("cluster")
			st.new_line
			st.indent
			if clusters /= Void then
				clusters.save_with_new_line (st)
			end
			st.exdent

			if externals /= Void then
				st.putstring ("external")
				st.new_line
				st.indent
				externals.save_with_new_line (st)
				st.exdent
			end

			st.new_line
			st.putstring ("end")
			st.new_line
		end

feature -- Changes

	updated_ast (old_ast, new_ast: like Current): like Current is
		require
			old_ast_not_void: old_ast /= Void
			new_ast_not_void: new_ast /= Void
		do
			Result := new_ast.duplicate
		ensure
			Result_not_void: Result /= Void
		end

feature -- Setting

	set_comment_list (o: like comment_list) is
			-- Assign `o' to `comment_list'.
		do
			comment_list := o
		ensure
			comment_list_set: comment_list = o
		end

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

				-- Initialize override_cluster_name if any
			set_override_cluster

				-- Then build the clusters with the files *.e found
				-- in the clusters
			build_clusters

				-- Reset the options of the CLASS_I
			reset_options

				-- Second adaptation of Use files
			adapt_use;

			update_clusters;
				-- Remove inexistant clusters from the system
			process_removed_clusters

			Degree_output.put_end_degree_6;

			process_system_level_options

			process_defaults_and_options;

				-- Process root clause
			root.adapt;
				-- Process external clause

			process_external_clause;
			System.reset_generate_clause;

			if Compilation_modes.is_precompiling then
				update_document_path
			end
		end;

	process_external_clause is
		local
			c_file_names, include_paths: LIST [STRING]
			object_file_names, makefile_names: LIST [STRING]
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

	precompiled_project: PAIR [D_PRECOMPILED_SD, STRING] is
			-- Precompilation options, as specified in the
			-- default clause in the Ace file
		local
			d_precompiled_option: D_PRECOMPILED_SD;
			value: OPT_VAL_SD
			found: BOOLEAN
			vd38: VD38
		do
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					d_precompiled_option ?= defaults.item;
					if d_precompiled_option /= Void then
						if found then
							create vd38
							Error_handler.insert_error (vd38)
							Error_handler.raise_error
						else
							value := d_precompiled_option.value;
							if value.is_name then
								create Result
									-- If it is not a NAME_SD, the normal
									-- adapt will trigger the error
								Result.set_first (d_precompiled_option)
								Result.set_second (value.value)
							end
							found := True
						end
					end
					defaults.forth
				end
			end;
				-- Do not call the once function `System' directly since it's
				-- value may be replaced during the first compilation (as soon
				-- as we figured out whether the system describes a Dynamic
				-- Class Set or not).
		end;

	process_system_level_options is
				-- Process the system level options
		do
			reset_system_level_options;
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
			-- Analysis of AS description of SDF in order to 
			-- build clusters.
		local
			clus: CLUSTER_SD
			override_name: STRING
			clus_name: STRING
		do
			if clusters /= Void then
					-- We get all clusters from Ace file. If they have the `all' or
					-- `library' specification we expand the list of clusters by
					-- looking at the subdirectories through `expand_recursive_clusters'
					-- which has a small side effect that updates the `clusters' objects
					-- by adding new item to it.
					--
					-- Note: because we accepted in 4.5 `all' specification on `override_cluster'
					-- we cannot expand it like the other cluster with `all' because everything
					-- has been created with only one override_cluster in mind. As a consequence
					-- I (Manu) kept the previous implementation of `all' specification in
					-- CLUSTER_I, where all classes belong to the top cluster.
				Degree_output.put_start_degree_6 (clusters.count);
				from
					clusters.start
					override_name := Universe.override_cluster_name
				until
					clusters.after
				loop
					clus := clusters.item
					clus_name := clus.cluster_name
					if
						clus.is_recursive and then
						(override_name = Void or else not clus_name.is_equal (override_name))
					then
						clus.expand_recursive_clusters (clusters)
					end
					Degree_output.put_degree_6 (clus, clusters.count - clusters.index + 1)
					clus.build
					clusters.forth
				end
			else
				Degree_output.put_start_degree_6 (0)
			end
		end

	build_precompiled is
			-- Re-insert the precompiled clusters into
			-- universe.
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
					create cluster.make_from_precompiled_cluster (old_cluster);
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

	set_override_cluster is
			-- Initialize `Universe' with override_cluster_name found in Ace file
			-- if any. This name can be invalid in which case it does not matter,
			-- otherwise it helps us to build a valid override cluster during
			-- `build_clusters'.
		local
			free_option_sd: FREE_OPTION_SD
		do
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					free_option_sd ?= defaults.item.option
					if free_option_sd /= Void and then free_option_sd.is_override then
						Universe.set_override_cluster_name (defaults.item.value.value)
					end
					defaults.forth
				end
			end
		end

feature {NONE} -- Incrementality

	is_subset (original_list, new_list: LIST [STRING]): BOOLEAN is
			-- Is `new_list' a subset of `original_list'?
			--| allows Void arguments
			--| Used for incrementality on externals
		local
			comparison_criterion: BOOLEAN
		do
			if original_list = Void then
				Result := new_list = Void
			elseif new_list = Void then
				Result := True
			else
				from
					Result := True
					comparison_criterion := original_list.object_comparison
					original_list.compare_objects
					new_list.start
				until
					new_list.after or else not Result
				loop
					Result := original_list.has (new_list.item)
					new_list.forth
				end
				if not comparison_criterion then
					original_list.compare_references
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

	reset_system_level_options is
			-- Reset all system level options to their default value.
		do
			System.set_remover_off (False)
			System.set_array_optimization_on (False)
			System.set_inlining_on (False)
			System.set_inlining_size (4)			
			System.set_exception_stack_managed (False)
			System.server_controler.set_block_size (1024)
			System.set_do_not_check_vape (False)
			System.allow_address_expression (False)			
			System.set_dynamic_def_file (Void)
			System.set_ise_gc_runtime (True)
			System.set_il_verifiable (True)
		end

end -- class ACE_SD

