indexing
	description: "Representation of a Lace AST"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	SHARED_IL_EMITTER
		export
			{NONE} all
		end

	SHARED_OVERRIDDEN_METADATA_CACHE_PATH
		export
			{NONE} all
		end

create
	default_create,
	initialize

feature {NONE} -- Initialization

	initialize (sn: like system_name; r: like root;
		d: like defaults; c: like clusters; a: like assemblies;
		e: like externals; cl: like click_list) is
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
			assemblies := a
			externals := e
			click_list := cl
		ensure
			system_name_set: system_name = sn
			root_set: root = r
			defaults_set: defaults = d
			clusters_set: clusters = c
			assemblies_set: assemblies = a
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

	assemblies: LACE_LIST [ASSEMBLY_SD]
			-- Description of assemblies

	externals: LACE_LIST [LANG_TRIB_SD];
			-- Description of extenal clauses

	click_list: CLICK_LIST;
			-- Structure containing elements to click on AST nodes

	comment_list: ARRAYED_LIST [STRING]
			-- List of comments usually associated with `default' clause.

feature -- Status report

	is_dotnet_project: BOOLEAN is
			-- Does current Ace has the `msil_generation (yes)' option to
			-- generate IL code?
		local
			d_options: LACE_LIST [D_OPTION_SD]
			fopt: FREE_OPTION_SD
		do
			d_options := defaults
			if d_options /= Void then
				from
					d_options.start
				until
					d_options.after
				loop
					if d_options.item.option.is_free_option then
						fopt ?= d_options.item.option
						if fopt.code = {FREE_OPTION_SD}.msil_generation then
							Result := d_options.item.value.is_yes
						end
					end
					d_options.forth
				end
			end
		end

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

	set_assemblies (a: like assemblies) is
			-- Set `assemblies' with `a'.
		require
			a_not_void: a /= Void
		do
			assemblies := a
		ensure
			assemblies_set: assemblies = a
		end

	set_externals (e: like externals) is
			-- Set `externals' with `e'.
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
			create Result.initialize (system_name.duplicate, root.duplicate,
				duplicate_ast (defaults), duplicate_ast (clusters),
				duplicate_ast (assemblies), duplicate_ast (externals),
				click_list)
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
					and then same_ast (assemblies, other.assemblies)
					and then same_ast (externals, other.externals)
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			st.put_string ("system")
			st.put_new_line
			st.indent
			system_name.save (st)
			st.exdent
			st.put_new_line
			st.put_new_line

			st.put_string ("root")
			st.put_new_line
			st.indent
			root.save (st)
			st.exdent
			st.put_new_line
			st.put_new_line

			if defaults /= Void then
				st.put_string ("default")
				st.put_new_line
				st.indent
				defaults.save_with_new_line (st)
				st.exdent
				st.put_new_line
			end

			if comment_list /= Void and then not comment_list.is_empty then
					-- Saving comments
				st.put_new_line
				from
					comment_list.start
				until
					comment_list.after
				loop
					st.put_string (comment_list.item)
					st.put_new_line
					comment_list.forth
				end
			end

			st.put_new_line
			st.put_string ("cluster")
			st.put_new_line
			st.indent
			if clusters /= Void then
				clusters.save_with_new_line (st)
			end
			st.exdent

			if assemblies /= Void then
				st.put_string ("assembly")
				st.put_new_line
				st.indent
				assemblies.save_with_new_line (st)
				st.exdent
			end

			if externals /= Void then
				st.put_string ("external")
				st.put_new_line
				st.indent
				externals.save_with_new_line (st)
				st.exdent
			end

			st.put_new_line
			st.put_string ("end")
			st.put_new_line
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
			System.set_name (system_name);

				-- Initialization
			Use_properties.clear_all;
			Eiffel_system.wipe_out_sub_clusters;

				-- Initialize $ISE_LIBRARY environment
			set_ise_library_path

				-- First re-insert the precompiled clusters into the
				-- universe.
			build_precompiled

				-- Initialize override_cluster_name if any
			set_override_cluster

				-- Initialize CLR runtime version
			set_clr_runtime_version

				-- Initalize path to alternative metadata cache path
			set_metadata_cache_path

				-- Then build the clusters with the files *.e found
				-- in the clusters
			build_clusters

				-- Then build assemblies
			build_assemblies

				-- Reset the options of the CLASS_I
			reset_options

				-- Second adaptation of Use files
			adapt_use;

				-- Process override cluster first.
			Universe.process_override_clusters

				-- Update content of clusters.
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
							d_precompiled_option.process_system_level_options
							Error_handler.checksum
							value := d_precompiled_option.value
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

	build_assemblies is
			-- Read information about assemblies referenced in Ace file.
		local
			l_assembly: ASSEMBLY_SD
			l_compiled_assembly, l_old_assembly: ASSEMBLY_I
			l_precomp_assembly: ASSEMBLY_I
			l_cluster_of_name, l_cluster_of_path: CLUSTER_I
			l_new_assemblies, l_local_assemblies: ARRAYED_LIST [ASSEMBLY_I]
			l_assembly_of_name: ASSEMBLY_I
			l_emitter: like il_emitter
			vdcn: VDCN
			vd28: VD28
		do
				-- FIXME: Manu we should raise an error before processing
				-- assemblies, if we are not in a  .NET code generation
			if assemblies /= Void then
					-- Read available assemblies from Ace file.
				from
					assemblies.start
					create l_new_assemblies.make (assemblies.count)
					create l_local_assemblies.make (assemblies.count)
				until
					assemblies.after
				loop
					l_assembly := assemblies.item
					Degree_output.put_degree_6 (l_assembly.cluster_name,
						assemblies.count - assemblies.index + 1)
					create l_compiled_assembly.make_from_ast (l_assembly)
					Error_handler.checksum

					l_old_assembly ?= Lace.old_universe.
						cluster_of_name (l_compiled_assembly.cluster_name)

					l_cluster_of_name := lace.Universe.cluster_of_name (
						l_compiled_assembly.cluster_name)

					if l_compiled_assembly.path /= Void then
						l_cluster_of_path := lace.Universe.cluster_of_path (
							l_compiled_assembly.path)
					end

					if l_cluster_of_name /= Void then
						if l_cluster_of_name.is_precompiled then
							if
								(l_cluster_of_path /= Void) and then
								l_cluster_of_path /= l_cluster_of_name
							then
								create vd28
								vd28.set_cluster (l_cluster_of_name)
								vd28.set_second_cluster_name (l_cluster_of_path.cluster_name)
								Error_handler.insert_error (vd28)
								Error_handler.raise_error
							else
									-- We might need to update assembly metadata path
								l_assembly_of_name ?= l_cluster_of_name
								if l_assembly_of_name /= Void then
									l_assembly_of_name.update_cache_path
								end
							end
						else
							create vdcn
							vdcn.set_cluster (l_compiled_assembly)
							Error_handler.insert_error (vdcn)
							Error_handler.raise_error
						end
					elseif l_cluster_of_path /= Void then
						create vd28
						vd28.set_cluster (l_cluster_of_path)
						vd28.set_second_cluster_name (l_compiled_assembly.cluster_name)
						Error_handler.insert_error (vd28)
						Error_handler.raise_error
					elseif l_old_assembly = Void then
							-- Add it to top cluster list of system and to universe.
						if not l_compiled_assembly.has_gac_specification then
							l_local_assemblies.extend (l_compiled_assembly)
						end
						l_new_assemblies.extend (l_compiled_assembly)
						Eiffel_system.add_sub_cluster (l_compiled_assembly)
						Universe.insert_cluster (l_compiled_assembly)
					else
						l_precomp_assembly ?= l_cluster_of_name
						if
							l_precomp_assembly = Void or else not l_precomp_assembly.is_precompiled
						then
							Eiffel_system.add_sub_cluster (l_old_assembly)
							Universe.insert_cluster (l_old_assembly)
						end
					end
					assemblies.forth
				end

					-- Import data for newly introduced assemblies.
					-- FIXME: Manu 05/03/2002: we should do something here so that
					-- we take care of possible incremental changes in XML files.

				if not l_new_assemblies.is_empty or not l_local_assemblies.is_empty then
					degree_output.put_string ("Importing .NET metadata...")
				end

					-- Now consumes local assemblies.
				if not l_local_assemblies.is_empty then
					l_compiled_assembly := l_local_assemblies.first
					l_local_assemblies.start
					l_local_assemblies.remove
					l_compiled_assembly.consume_assemblies (l_local_assemblies)
				end

					-- Import .NET classes in assembly clusters.
				from
					l_new_assemblies.start
				until
					l_new_assemblies.after
				loop
					l_new_assemblies.item.import_data
					l_new_assemblies.forth
				end

				l_emitter := il_emitter
				if l_emitter /= Void then
						-- unload emitter used resources
					l_emitter.unload
				end
			end
		end

	build_clusters is
			-- Analysis of AS description of SDF in order to
			-- build clusters.
		local
			clus: CLUSTER_SD
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
				Degree_output.put_start_degree_6 (clusters_count);
				from
					clusters.start
				until
					clusters.after
				loop
					clus := clusters.item
					clus_name := clus.cluster_name
					if
						clus.is_recursive and then
						not Universe.has_override_cluster_of_name (clus_name)
					then
						clus.expand_recursive_clusters (clusters)
					end
					Degree_output.put_degree_6 (clus.cluster_name,
						clusters_count - clusters.index + 1)
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
			old_clusters: ARRAYED_LIST [CLUSTER_I];
			old_cluster, cluster: CLUSTER_I;
			l_assembly: ASSEMBLY_I
		do
			from
				old_clusters := Lace.old_universe.clusters;
				old_clusters.start
			until
				old_clusters.after
			loop
				old_cluster := old_clusters.item;
				if old_cluster.is_precompiled then
					l_assembly ?= old_cluster
					if l_assembly /= Void then
						create {ASSEMBLY_I} cluster.make_from_precompiled_cluster (l_assembly)
					else
						create cluster.make_from_precompiled_cluster (old_cluster);
					end
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
			cluster_list: ARRAYED_LIST [CLUSTER_I];
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
			cluster_list: ARRAYED_LIST [CLUSTER_I];
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
			cluster_list: ARRAYED_LIST [CLUSTER_I];
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
					defaults.adapt_defaults;

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
			cluster_list: ARRAYED_LIST [CLUSTER_I];
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
			old_clusters: ARRAYED_LIST [CLUSTER_I];
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
			l_val: OPT_VAL_SD
		do
			Universe.reset_override_clusters
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					free_option_sd ?= defaults.item.option
					if free_option_sd /= Void and then free_option_sd.is_override then
						l_val := defaults.item.value
						if
							not l_val.is_name or Compilation_modes.is_precompiling or
							Universe.has_override_cluster_of_name (l_val.value)
						then
							free_option_sd.error (l_val)
						else
							Universe.add_override_cluster_name (l_val.value)
						end
					end
					defaults.forth
				end
			end
		end

	set_ise_library_path is
			-- Initialize with correct value for ISE_LIBRARY environment variable.
			-- Use ISE_EIFFEL value if not user defined.
		local
			l_lib_env,
			l_ise_env: STRING
		do
			l_lib_env := execution_environment.get (once "ISE_LIBRARY")
			if l_lib_env = Void or l_lib_env.is_empty then
				l_ise_env := execution_environment.get (once "ISE_EIFFEL")
				execution_environment.put (l_ise_env, once "ISE_LIBRARY")
			end
		end

	set_clr_runtime_version is
			-- Initialize `Universe' with override_cluster_name found in Ace file
			-- if any. This name can be invalid in which case it does not matter,
			-- otherwise it helps us to build a valid override cluster during
			-- `build_clusters'.
		local
			free_option_sd: FREE_OPTION_SD
			l_val: OPT_VAL_SD
			l_has_value: BOOLEAN
			l_installed_runtimes: DS_LINEAR [STRING]
			l_il_env: IL_ENVIRONMENT
		do
			create l_il_env
			if defaults /= Void then
				from
					l_installed_runtimes := l_il_env.installed_runtimes
					defaults.start
				until
					defaults.after
				loop
					free_option_sd ?= defaults.item.option
					if
						free_option_sd /= Void and then
						free_option_sd.code = {FREE_OPTION_SD}.Msil_clr_version
					then
						l_val := defaults.item.value
						if
							l_has_value or else not l_val.is_name or else
							not l_installed_runtimes.has (l_val.value.string)
						then
							free_option_sd.error (l_val)
						else
							l_has_value := True
							System.set_clr_runtime_version (l_val.value)
						end
					end
					defaults.forth
				end
			end
			if system.clr_runtime_version = Void then
				system.set_clr_runtime_version (l_il_env.default_version)
			end
			create l_il_env.make (system.clr_runtime_version)
			l_il_env.register_environment_variable
		end

	set_metadata_cache_path is
			-- Initialize `Universe' with metadata_cache_path found in Ace file
			-- if any. This name can be invalid in which case it does not matter,
			-- otherwise it helps us to build a valid override cluster during
			-- `build_clusters'.
		local
			l_free_option_sd: FREE_OPTION_SD
			l_val: OPT_VAL_SD
			l_has_value: BOOLEAN
		do
			if overridden_metadata_cache_path /= Void then
				System.set_metadata_cache_path (overridden_metadata_cache_path)
			elseif defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					l_free_option_sd ?= defaults.item.option
					if
						l_free_option_sd /= Void and then
						l_free_option_sd.code = {FREE_OPTION_SD}.metadata_cache_path
					then
						l_val := defaults.item.value
						if l_has_value or else not l_val.is_name then
							l_free_option_sd.error (l_val)
						else
							l_has_value := True
							System.set_metadata_cache_path (l_val.value)
						end
					end
					defaults.forth
				end
			end
		end

feature {NONE} -- Incrementality

	clusters_count: INTEGER is
			-- Number of cluster and assemblies.
		do
			if clusters /= Void then
				Result := clusters.count
			end
			if assemblies /= Void then
				Result := Result + assemblies.count
			end
		end

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
			System.reset_lace_options
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ACE_SD

