note
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SCRIPT_COMPILATION_INDEX_BUILDER

inherit
	ANY

	CONF_ITERATOR
		export
			{NONE} all
		redefine
			process_target,
			process_library,
			process_cluster,
			process_override,
			process_group
		end

	CONF_VALIDITY

	CONF_CONSTANTS

	SHARED_COMPILER_PROFILE

	LIBRARY_INDEXER_OBSERVER
		redefine
			on_class,
			on_library
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create compilation_index.make (10)
		end

feature -- Execution

	process (a_target: CONF_TARGET)
		local
			ti: TARGET_INDEXER
			opts: detachable STRING_TABLE [detachable READABLE_STRING_GENERAL]
		do
			compilation_index.wipe_out
			create ti.make (opts)
			ti.set_is_stopping_at_library (True)
			ti.set_is_indexing_class (True)
			ti.register_observer (Current)
			ti.visit_target (a_target)
			process_target (a_target)
		end

	compilation_index: EIFFEL_SCRIPT_COMPILATION_INDEX

	on_class (a_class: CONF_CLASS)
		do
			compilation_index.record_class (a_class.full_file_name)
		end

	on_library (a_lib: CONF_LIBRARY)
		do
			compilation_index.record_library (a_lib.location.evaluated_path)
		end

feature {NONE} -- Implementation

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
			create Result.make (platform (a_target), build_finalize, a_target.concurrency_mode, a_target.void_safety_mode, a_target.setting_msil_generation, a_target.setting_dynamic_runtime, a_target.variables, l_version)
		end

	platform (a_target: CONF_TARGET): INTEGER
			-- Universe type of platform.
		local
			l_is_set: BOOLEAN
		do
				-- If platform is set from the command line, we use this.
				-- Otherwise we use the one set in the ECF if set,
				-- otherwise we use the current running platform.
			if compiler_profile.is_platform_set then
				l_is_set := True
				if compiler_profile.is_windows_platform then
					Result := pf_windows
				elseif compiler_profile.is_unix_platform then
					Result := pf_unix
				elseif compiler_profile.is_mac_platform then
					Result := pf_mac
				elseif compiler_profile.is_vxworks_platform then
					Result := pf_vxworks
				else
						-- In the event a new platform is added, we will
						-- catch the bug if we forget to add it to COMPILER_PROFILE.
					check known_platform: False end
					l_is_set := False
				end
			end
			if not l_is_set then
				Result := get_platform (a_target.setting_platform)
				if Result = 0 then
					Result := current_platform
				end
			end
		end

	ecf_conf_parse_factory: CONF_PARSE_FACTORY
		once
			create Result
		end

feature {NONE} -- Visitor

	process_target (a_target: CONF_TARGET)
		local
			l_system: CONF_SYSTEM
			retried: BOOLEAN
			vp: CONF_PARSE_VISITOR
			l_state: detachable CONF_STATE
		do
			if not retried then
				l_system := a_target.system

				l_state := conf_state_from_target (a_target)

				create vp.make_build (l_state, a_target, ecf_conf_parse_factory)
				l_system.process (vp)
				if vp.is_error then
					print ("  Error occurred.%N")
				else
					across
						a_target.libraries as ic
					loop
						process_library (ic.item)
					end
					across
						a_target.clusters as ic
					loop
						process_cluster (ic.item)
					end
					across
						a_target.overrides as ic
					loop
						process_override (ic.item)
					end
				end
			end
		rescue
			retried := True
			retry
		end

	process_library (a_library: CONF_LIBRARY)
		do
			on_library (a_library)
			Precursor (a_library)
		end

	process_cluster (a_cluster: CONF_CLUSTER)
		do
			Precursor (a_cluster)
			process_group (a_cluster)
		end

	process_override (a_override: CONF_OVERRIDE)
		do
			Precursor (a_override)
			process_group (a_override)
		end

	process_group (a_group: CONF_GROUP)
		do
			on_group (a_group)
			Precursor (a_group)
			if attached a_group.classes as l_classes then
				across
					l_classes as ic
				loop
					process_class (ic.item)
				end
			end
		end

	process_class (a_class: CONF_CLASS)
		do
			print (a_class.file_name)
			io.put_new_line
		end

end
