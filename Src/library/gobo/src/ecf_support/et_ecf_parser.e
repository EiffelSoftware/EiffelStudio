indexing
	description: "[
		Parse an ecf system and generate a gobo universe.

		Note: Before using this class make sure the relevant environment variables are
		set up ($ISE_EIFFEL etc.). You can do this using `EIFFEL_ENV.check_environment_variable'
		and `EIFFEL_ENV.set_precompile'.
		]"
	author: "Patrick Ruckstuhl <patrick@tario.org>"
	date: "$Date$"
	revision: "$Revision$"
class
	ET_ECF_PARSER

inherit
	CONF_CONSTANTS

	CONF_VALIDITY

	KL_SHARED_FILE_SYSTEM

	UT_SHARED_ISE_VERSIONS

create
	make_standard, make, make_with_factory

feature {NONE} -- Initialization

	make_standard is
			-- Create a new Ecf parser.
			-- Error messages will be sent to standard files.
		local
			a_handler: like error_handler
		do
			create a_handler.make_standard
			make (a_handler)
		end

	make (an_error_handler: like error_handler) is
			-- Create a new Lace parser.
		require
			an_error_handler_not_void: an_error_handler /= Void
		local
			a_factory: ET_ECF_AST_FACTORY
		do
			create a_factory.make
			make_with_factory (a_factory, an_error_handler)
		ensure
			error_handler_set: error_handler = an_error_handler
		end

	make_with_factory (a_factory: like ast_factory; an_error_handler: like error_handler) is
			-- Create a new Lace parser.
		require
			a_factory_not_void: a_factory /= Void
			an_error_handler_not_void: an_error_handler /= Void
		do
			ast_factory := a_factory
			error_handler := an_error_handler
			compiler_version := ise_6_0_latest
		ensure
			ast_factory_set: ast_factory = a_factory
			error_handler_set: error_handler = an_error_handler
		end

feature -- Status

	is_error: BOOLEAN
			-- Was there an error during the last load operation?

feature -- Access

	last_system: CONF_SYSTEM
		-- Last loaded configuration system.

	last_universe: ET_ECF_SYSTEM
		-- Last loaded universe.

	error_handler: ET_ERROR_HANDLER
		-- Error handler

	ast_factory: ET_ECF_AST_FACTORY
		-- Factory

	is_workbench_build: BOOLEAN
		-- Are we doing a workbench build?

	compiler_version: UT_VERSION
		-- Version of the compiler

	target: STRING
		-- Target for building the universe.

feature -- Update

	set_workbench_build (a_bool: BOOLEAN) is
			-- Set if we do a workbench build.
		do
			is_workbench_build := a_bool
		ensure
			workbench_build_set: is_workbench_build = a_bool
		end

	set_compiler_version (a_version: like compiler_version) is
			-- Set compiler version.
		require
			a_version_not_void: a_version /= Void
		do
			compiler_version := a_version
		ensure
			compiler_version_set: compiler_version = a_version
		end

	set_target (a_target: like target) is
			-- Set target to use for building the universe.
		do
			target := a_target
		ensure
			target_set: target = a_target
		end

feature -- Basic operation

	load (a_file: STRING) is
			-- Load ecf system from a_file.
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
		local
			l_factory: CONF_PARSE_FACTORY
			l_load: CONF_LOAD
			l_parse_visitor: CONF_PARSE_VISITOR
			l_ecf_err: ET_ECF_PARSE_ERROR
			l_errors: ARRAYED_LIST [CONF_ERROR]
		do
			is_error := False

				-- Parse the "starting" ecf file
			create l_factory
			create l_load.make (l_factory)
			l_load.retrieve_configuration (file_system.absolute_pathname (a_file))
			if l_load.is_error then
				is_error := True
				create l_ecf_err.make (l_load.last_error.out)
				error_handler.report_error (l_ecf_err)
			else
				last_system := l_load.last_system
					-- If the target is not set, check if we only have one possible target, otherwise it's an error.
				if target = Void then
					if last_system.compilable_targets.count = 1 then
						application_target := last_system.compilable_targets.linear_representation.first
					else
						is_error := True
						create l_ecf_err.make ("No target specified and multiple targets in configuration.")
						error_handler.report_error (l_ecf_err)
					end
						-- If the target is set, check if the target exists, otherwise it's an error.
				elseif last_system.compilable_targets.has (target) then
					application_target := last_system.compilable_targets.item (target)
				else
					is_error := True
					create l_ecf_err.make ("Specified target does not exist in configuration.")
					error_handler.report_error (l_ecf_err)
				end

				if not is_error then
						-- Parse the whole system (parses all used libraries)
					create l_parse_visitor.make_build (state, application_target, l_factory)
					application_target.process (l_parse_visitor)
					if l_parse_visitor.is_error then
						from
							l_errors := l_parse_visitor.last_errors
							l_errors.start
						until
							l_errors.after
						loop
							is_error := True
							create l_ecf_err.make (l_errors.item.out)
							error_handler.report_error (l_ecf_err)
							l_errors.forth
						end
					end

						-- Put the targets that make up the system into last_targets
					last_targets := last_system.all_libraries.linear_representation

						-- Generate the gobo universe
					generate_universe
				end
			end
		ensure
			no_error_implies_universe: not is_error implies (last_universe /= Void and last_system /= Void)
		end

feature {NONE} -- Implementation

	application_target: CONF_TARGET
			-- The target of our application we our compiling.

	last_targets: ARRAYED_LIST [CONF_TARGET]
			-- All used targets (libraries and application target) of the last loaded system;
			-- All this targets together build the system as they include everything.

	state: CONF_STATE is
			-- Current state for the compilation based on a_target and the environment
		require
			application_target_ok: application_target /= Void
		local
			l_version: HASH_TABLE [CONF_VERSION, STRING]
			l_plat: PLATFORM
			l_platform: INTEGER
			l_build: INTEGER
		do
			create l_version.make (1)
				-- Compiler version
			l_version.force (create {CONF_VERSION}.make_from_string (compiler_version.out), v_compiler)

				-- Platform
			create l_plat
			if not application_target.setting_platform.is_empty then
				l_platform := get_platform (application_target.setting_platform)
			elseif l_plat.is_unix then
				l_platform := pf_unix
			elseif l_plat.is_vms then
				l_platform := pf_vxworks
			elseif l_plat.is_windows then
				l_platform := pf_windows
			else
				l_platform := pf_mac
			end

				-- Build
			if is_workbench_build then
				l_build := build_workbench
			else
				l_build := build_finalize
			end

				-- Build state
			create Result.make (l_platform, l_build, application_target.setting_multithreaded, application_target.setting_msil_generation, application_target.setting_dynamic_runtime, application_target.variables, l_version)
		end

	generate_universe is
			-- Generate a Gobo universe representing a flat view of the system.
		require
			last_targets_not_void: last_targets /= Void
			application_target_not_void: application_target /= Void
		local
			l_target: CONF_TARGET
			l_clusters: HASH_TABLE [CONF_CLUSTER, STRING]
			l_cluster: CONF_CLUSTER
			l_state: CONF_STATE
			l_et_clusters: ET_ECF_CLUSTERS
			l_et_cluster: ET_ECF_CLUSTER
		do
			create last_universe.make
			l_et_clusters := ast_factory.new_clusters
			l_state := state

			from
				last_targets.start
			until
				last_targets.after
			loop
				l_target := last_targets.item

					-- Loop trough all enabled clusters and create gobo clusters
				from
					l_clusters := l_target.clusters
					l_clusters.start
				until
					l_clusters.after
				loop
					l_cluster := l_clusters.item_for_iteration
					if l_cluster.is_enabled (l_state) then
						l_et_clusters.put_last (gobo_cluster (l_cluster))
					end
					l_clusters.forth
				end
				last_targets.forth
			end

				-- Add overrides from the application target
			from
				l_clusters := l_target.overrides
				l_clusters.start
			until
				l_clusters.after
			loop
				l_cluster := l_clusters.item_for_iteration
				if l_cluster.is_enabled (l_state) then
					l_et_cluster := gobo_cluster (l_cluster)
					l_et_cluster.set_override (True)
					l_et_clusters.put_last (l_et_cluster)
				end
				l_clusters.forth
			end

				-- Create a universe from the clusters
			last_universe.set_clusters (l_et_clusters)
			last_universe.set_error_handler (error_handler)
			last_universe.set_system_name (application_target.system.name)
			last_universe.set_root_class_name (application_target.root.class_type_name)
			last_universe.set_creation_procedure_name (application_target.root.feature_name)
		ensure
			last_universe_set: last_universe /= Void
		end

	gobo_cluster (a_cluster: CONF_CLUSTER): ET_ECF_CLUSTER is
			-- EiffelStudio cluster converted to a Gobo cluster
		require
			a_cluster_not_void: a_cluster /= Void
			last_universe_not_void: last_universe /= Void
		local
			l_file_rule: CONF_FILE_RULE
		do
			Result := ast_factory.new_cluster (a_cluster.name, a_cluster.location.evaluated_directory, last_universe)
			l_file_rule := a_cluster.active_file_rule (state)
			Result.set_file_rule (ast_factory.new_file_rule (l_file_rule.exclude, l_file_rule.include))
			Result.set_recursive (a_cluster.is_recursive)
			if a_cluster.is_override then
				Result.set_override (True)
			end
		end

invariant

	error_handler_set: error_handler /= Void
	compiler_version_set: compiler_version /= Void

end
