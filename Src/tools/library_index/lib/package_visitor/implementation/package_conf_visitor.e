note
	description: "Summary description for {PACKAGE_CONF_VISITOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	PACKAGE_CONF_VISITOR

inherit
	PACKAGE_SCAN_VISITOR
		redefine
			make,
			visit_ecf_file,
			visit_system,
			visit_target,
			visit_library,
			visit_cluster,
			visit_class
		end

	CONF_ITERATOR
		redefine
			process_target,
			process_library,
			process_cluster
		end

	EIFFEL_LAYOUT

create
	make

feature {NONE} -- Initialization

	make
		do
			initialize_environment
			initialize_defaults
			Precursor
		end

	initialize_environment
			-- Initialize the environment.
			--| mainly used to have ecf redirection
			--| working with environment variable usage.
			--| see {STRING_ENVIRONMENT_EXPANDER}
		do
			if not is_eiffel_layout_defined then
				set_eiffel_layout (create {EC_EIFFEL_LAYOUT})
				eiffel_layout.check_environment_variable
			end
		end

	initialize_defaults
		do
			is_any_setting := True

			is_il_generation := False
			build := {CONF_CONSTANTS}.Build_workbench
			concurrency := {CONF_CONSTANTS}.concurrency_multithreaded
			has_dynamic_runtime := False

			if {PLATFORM}.is_dotnet then
				platform := {CONF_CONSTANTS}.pf_windows
				is_il_generation := True
			elseif {PLATFORM}.is_windows then
				platform := {CONF_CONSTANTS}.pf_windows
			elseif {PLATFORM}.is_unix then
				platform := {CONF_CONSTANTS}.pf_unix
			elseif {PLATFORM}.is_mac then
				platform := {CONF_CONSTANTS}.pf_mac
			elseif {PLATFORM}.is_vms then
				platform := {CONF_CONSTANTS}.pf_unix
			elseif {PLATFORM}.is_vxworks then
				platform := {CONF_CONSTANTS}.pf_vxworks
			else
				platform := {CONF_CONSTANTS}.pf_unix
			end
			is_platform_set := True
		end

feature -- Settings

	is_any_setting: BOOLEAN

	is_platform_set: BOOLEAN

	platform: INTEGER

	build: INTEGER

	concurrency: INTEGER

	is_il_generation: BOOLEAN

	has_dynamic_runtime: BOOLEAN

	is_stopping_at_library: BOOLEAN

feature -- Settings change

	set_is_stopping_at_library (b: BOOLEAN)
		do
			is_stopping_at_library := b
		end

feature -- Change

	set_is_any_setting (b: BOOLEAN)
			-- Ignore various ecf conditions, and include all cluster, libraries, classes.
		do
			is_any_setting := b
		end

	set_platform (a_platform: detachable READABLE_STRING_GENERAL)
		local
			p: READABLE_STRING_8
		do
			is_platform_set := True
			if a_platform = Void then
				is_platform_set := False
				platform := {CONF_CONSTANTS}.pf_unix
			else
				is_il_generation := False
				if a_platform.is_valid_as_string_8 then
					p := a_platform.as_string_8
					if p.is_case_insensitive_equal ("dotnet") then
						platform := {CONF_CONSTANTS}.pf_windows
						is_il_generation := True
					elseif p.is_case_insensitive_equal ({CONF_CONSTANTS}.pf_windows_name) then
						platform := {CONF_CONSTANTS}.pf_windows
					elseif
						p.is_case_insensitive_equal ({CONF_CONSTANTS}.pf_unix_name)
						or p.as_lower.starts_with ("linux")
					then
						platform := {CONF_CONSTANTS}.pf_unix
					elseif p.is_case_insensitive_equal ({CONF_CONSTANTS}.pf_macintosh_name) then
						platform := {CONF_CONSTANTS}.pf_mac
					else
						is_platform_set := False
						platform := {CONF_CONSTANTS}.pf_unix
					end
				else
						-- Defaulted to unix.
					is_platform_set := False
					platform := {CONF_CONSTANTS}.pf_unix
				end
			end
		end

	set_concurrency (a_concurrency: detachable READABLE_STRING_GENERAL)
		do
			if a_concurrency = Void then
				concurrency := {CONF_CONSTANTS}.concurrency_multithreaded
			else
				if a_concurrency.is_case_insensitive_equal ({CONF_CONSTANTS}.concurrency_none_name) then
					concurrency := {CONF_CONSTANTS}.concurrency_none
				elseif a_concurrency.is_case_insensitive_equal ({CONF_CONSTANTS}.concurrency_multithreaded_name) then
					concurrency := {CONF_CONSTANTS}.concurrency_multithreaded
				elseif a_concurrency.is_case_insensitive_equal ({CONF_CONSTANTS}.concurrency_scoop_name) then
					concurrency := {CONF_CONSTANTS}.concurrency_scoop
				else
					concurrency := {CONF_CONSTANTS}.concurrency_multithreaded
				end
			end
		end

	set_build (a_build: detachable READABLE_STRING_GENERAL)
		do
			if a_build = Void then
				build := {CONF_CONSTANTS}.build_finalize
			else
				if a_build.is_case_insensitive_equal ({CONF_CONSTANTS}.build_finalize_name) then
					build := {CONF_CONSTANTS}.build_finalize
				elseif a_build.is_case_insensitive_equal ({CONF_CONSTANTS}.build_workbench_name) then
					build := {CONF_CONSTANTS}.build_workbench
				else
					build := {CONF_CONSTANTS}.build_finalize
				end
			end
		end

feature -- Visitor

	visit_ecf_file (p: PATH)
		local
			f: RAW_FILE
		do
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				if attached configuration_from (p) as cfg then
					visit_system (cfg)
				end
			end
		end

	visit_system (a_system: CONF_SYSTEM)
		do
			across
				a_system.targets as ic
			loop
				visit_target (ic.item)
			end
			Precursor (a_system)
		end

	visit_target (a_target: CONF_TARGET)
		local
			l_system: CONF_SYSTEM
			retried: BOOLEAN
			vp: CONF_PARSE_VISITOR
--			vb: CONF_BUILD_VISITOR
			l_state: detachable CONF_STATE
		do
			if not retried then
				l_system := a_target.system
				last_target := a_target

				if is_any_setting then
					if is_stopping_at_library then
						across
							a_target.libraries as ic
						loop
							visit_library (ic.item)
						end
					else
						across
							a_target.clusters as ic
						loop
							visit_cluster (ic.item)
						end
						across
							a_target.libraries as ic
						loop
							visit_library (ic.item)
						end
					end
				else
					l_state := conf_state_from_target (a_target)
					last_state := l_state

					create vp.make_build (l_state, a_target, ecf_conf_parse_factory)
					l_system.process (vp)
					if vp.is_error then
						print ("  Error occurred.%N")
						if attached vp.last_errors as l_last_errors and then not l_last_errors.is_empty then
							across
								l_last_errors as ic
							loop
								print_conf_error (ic.item, "  ")
							end
						end
					else
						if is_stopping_at_library then
							across
								a_target.libraries as ic
							loop
								visit_library (ic.item)
							end
						else
							across
								a_target.clusters as ic
							loop
								visit_cluster (ic.item)
							end

--							create vb.make_build (l_state, a_target, ecf_conf_factory)
--							l_system.process (vb)
--							a_target.process (Current)
							across
								a_target.libraries as ic
							loop
								visit_library (ic.item)
							end
						end
						Precursor (a_target)
					end

					last_state := Void
				end
				last_target := Void
			end
		rescue
			retried := True
			retry
		end

	visit_library (a_library: CONF_LIBRARY)
		do
			if is_stopping_at_library then
					-- Do not visit clusters, ...
			else
				Precursor (a_library)
			end
		end

	visit_cluster (a_cluster: CONF_CLUSTER)
		do
			if attached a_cluster.classes as l_classes then
				across
					l_classes as ic
				loop
					visit_class (ic.item)
				end
			end
			Precursor (a_cluster)
		end

	visit_class (a_class: CONF_CLASS)
		do
			Precursor (a_class)
		end

feature -- Conf visitor

	process_target (a_target: CONF_TARGET)
		do
--			visit_target (a_target)
			Precursor (a_target)
		end

	process_library (a_library: CONF_LIBRARY)
		do
			visit_library (a_library)
			Precursor (a_library)
		end

	process_cluster (a_cluster: CONF_CLUSTER)
		do
			visit_cluster (a_cluster)
			Precursor (a_cluster)
		end

feature {NONE} -- Helper

	print_conf_error (err: CONF_ERROR; a_prefix: READABLE_STRING_GENERAL)
		local
			l_text: READABLE_STRING_32
			s: STRING_32
			c: CHARACTER_32
			i,n: INTEGER
		do
			l_text := err.text
			create s.make (l_text.count + 2)
			s.append_string_general (a_prefix)
			from
				i := 1
				n := l_text.count
			until
				i > n
			loop
				c := l_text[i]
				s.append_character (c)
				if c = '%N' then
					if i < n then
						s.append_string_general (a_prefix)
					end
				end
				i := i + 1
			end

			print (s)
			print ("%N")
		end

	configuration_from (a_file_name: PATH): detachable CONF_SYSTEM
			-- Loads a configuration system from `a_file_name'
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: (create {FILE_UTILITIES}).file_path_exists (a_file_name)
		local
			l_reader: like ecf_reader
			retried: BOOLEAN
		do
			if not retried then
				l_reader := ecf_reader
				l_reader.retrieve_configuration (a_file_name.name)
				if not l_reader.is_error then
					Result := l_reader.last_system
				else
--					if l_reader.is_invalid_xml then
--						error_handler.add_error (create {SCIX}.make (a_file_name, 0, Void), False)
--					else
--						error_handler.add_error (create {SCLF}.make (a_file_name, 0, Void), False)
--					end
				end
			else
--				error_handler.add_error (create {SCFE}.make (a_file_name, 0, Void), False)
			end
		rescue
			retried := True
			retry
		end

	conf_state_from_target (a_target: CONF_TARGET): CONF_STATE
			-- Current state, according to `a_target', needed for conditioning.
		require
			a_target_not_void: a_target /= Void
		local
			l_conf_version: CONF_VERSION
			l_version: STRING_TABLE [CONF_VERSION]
		do
			create l_version.make (1)
			create l_conf_version.make_version ({EIFFEL_CONSTANTS}.major_version, {EIFFEL_CONSTANTS}.minor_version, 0, 0)
			l_version.force (l_conf_version, "compiler")
			create Result.make (platform, build, concurrency, is_il_generation, has_dynamic_runtime, a_target.variables, l_version)
		end

	current_conf_state: detachable CONF_STATE
			-- Eventual conf state in the visiting context.
		do
			Result := last_state
			if Result = Void and attached last_target as l_target then
				Result := conf_state_from_target (l_target)
			end
		end

--	eiffel_class_filenames (cl: CONF_LOCATION): LIST [PATH]
--		local
--			dir: DIRECTORY
--			fp,p: PATH
--		do
--			create dir.make_with_path (cl.evaluated_directory)
--			if dir.exists and then dir.is_readable then
--				create {ARRAYED_LIST [PATH]} Result.make (0)
--				across
--					dir.entries as ic
--				loop
--					p := ic.item
--					if attached p.extension as l_ext and then l_ext.same_string ({STRING_32} "e") then
--						fp := dir.path.extended_path (p)
--						if file_system.is_file_readable (fp) then
--							Result.force (fp)
--						end
--					end
--				end
--			end
--		end

--	eiffel_class_name (fn: PATH): detachable STRING
--		local
--			parser: EIFFEL_PARSER
--			factory: AST_ROUNDTRIP_FACTORY
--			f: KL_BINARY_INPUT_FILE
--		do
--			create factory
--			create parser.make_with_factory (factory)
----			parser.set_indexing_parser
--			parser.set_has_syntax_warning (True)
--			parser.set_syntax_version (parser.provisional_syntax)
--			create f.make (fn.utf_8_name) -- FIXME: unicode !!!
--			if f.is_readable then
--				f.open_read
--				parser.parse (f)
--				if parser.error_count = 0 then
--					if attached parser.root_node as cl then
--						Result := cl.class_name.name_8
--					end
--				end
--				f.close
--			end
--		end

feature {NONE} -- Implementation

	last_target: detachable CONF_TARGET
			-- Current conf target during visiting, if any.

	last_state: detachable CONF_STATE
			-- Current conf state during visiting, if any.

	ecf_reader: CONF_LOAD
			-- Configuration loader
		once
			create Result.make (ecf_conf_parse_factory)
		ensure
			result_attached: Result /= Void
		end

	ecf_conf_parse_factory: CONF_PARSE_FACTORY
		once
			create Result
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
