note
	description: "Internal representation of the Eiffel universe."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class UNIVERSE_I

inherit
	SHARED_ERROR_HANDLER
		export
			{COMPILER_EXPORTER} all
		end

	SHARED_WORKBENCH
		export
			{COMPILER_EXPORTER} all
		end

	COMPILER_EXPORTER

	PROJECT_CONTEXT

	SYSTEM_CONSTANTS

	REFACTORING_HELPER

	CONF_VALIDITY

	SHARED_COMPILER_PROFILE

create {COMPILER_EXPORTER}
	make

feature {NONE} -- Initialization

	make
			-- Create.
		do
		end

feature -- Status report

	eiffel_system_defined: BOOLEAN
			-- Is Eiffel system defined?
		do
			Result := workbench.system_defined
		end

feature -- Properties

	target_name: READABLE_STRING_32
			-- Name of the universe target.
		require
			target_not_void: target /= Void
		do
			Result := target.name
		ensure
			Result_ok: Result /= Void and then not Result.is_empty
		end

	target: CONF_TARGET
			-- Universe target.

	new_target: CONF_TARGET
			-- Newly loaded target from configuration file, will become `target' after successful degree 6.

	conf_system: CONF_SYSTEM
			-- Complete configuration system.

	conf_state: detachable CONF_STATE
			-- Current state, needed for conditioning.
		require
			target_not_void: target /= Void
		do
			if eiffel_system_defined then
				Result := conf_state_from_target (target)
			end
		end

	conf_state_from_target (a_target: CONF_TARGET): CONF_STATE
			-- Current state, according to `a_target', needed for conditioning.
		require
			a_target_not_void: a_target /= Void
			eiffel_system_defined: eiffel_system_defined
		local
			l_version: STRING_TABLE [CONF_VERSION]
			l_ver: STRING_32
			l_clr_version: CONF_VERSION
		do
			create l_version.make (1)
			l_version.force (compiler_version_number, v_compiler)
			if system.il_generation then
				l_ver := system.clr_runtime_version.twin
				l_ver.prune_all_leading ('v')
				create l_clr_version.make_from_string (l_ver)
				check
					valid_clr_version: not l_clr_version.is_error
				end
				l_version.force (l_clr_version, v_msil_clr)
			end
			create Result.make (platform, build, concurrency, void_safety, system.il_generation, system.has_dynamic_runtime, a_target.variables, l_version)
		end

	concurrency: INTEGER
			-- Type of Concurrency (none, thread, scoop).
		do
			if
				workbench.system_defined and then
				{CONF_TARGET_OPTION}.is_concurrency_index (system.concurrency_index)
			then
				Result := {CONF_TARGET_OPTION}.concurrency_mode_from_index (system.concurrency_index)
			else
					-- Default if none is specified or system is not defined.
				Result := concurrency_none
			end
		end

	void_safety: INTEGER
			-- Type of void_safety (none, conformance, initialization, transitional, all).
		do
			if
				workbench.system_defined and then
				{CONF_TARGET_OPTION}.is_void_safety_index (system.void_safety_index)
			then
				Result := {CONF_TARGET_OPTION}.void_safety_mode_from_index (system.void_safety_index)
			else
					-- Default if none is specified or system is not defined.
				Result := void_safety_all
			end
		end

	platform: INTEGER
			-- Universe type of platform.
		do
				-- If platform is set from the command line, we use this.
				-- Otherwise we use the one set in the ECF if set,
				-- otherwise we use the current running platform.
			if compiler_profile.is_platform_set then
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
					Result := pf_unix
				end
			else
				if workbench.system_defined and then system.platform /= 0 then
					Result := system.platform
				else
					Result := current_platform
				end
			end
		end

	build: INTEGER
			-- Universe type of build.
		do
			if compilation_modes.is_finalizing then
				Result := build_finalize
			else
				Result := build_workbench
			end
		end

	groups: ARRAYED_LIST [CONF_GROUP]
			-- Groups of the universe (not including groups of libraries/precompiles).
		do
			Result := target.groups.linear_representation
		end

	all_classes: SEARCH_TABLE [CLASS_I]
			-- All classes in the system, including uncompiled classes.
		local
			l_vis: CONF_ALL_CLASSES_VISITOR
			l_classes: ARRAYED_LIST [CONF_CLASS]
		do
			create l_vis.make
			create Result.make_map (1000)
			if target /= Void then
				target.process (l_vis)
			end
			from
				l_classes := l_vis.classes
				l_classes.start
			until
				l_classes.after
			loop
				if attached {CLASS_I} l_classes.item as l_cl then
					Result.force (l_cl)
				else
					check is_class_i: False end
				end

				l_classes.forth
			end
		end

	all_possible_client_classes (a_class: CLASS_I): SEARCH_TABLE [CLASS_I]
			-- Retrieves all classes that can reach `a_class' in the Universe. It is a subset of `all_classes'.
		require
			a_class_attached: a_class /= Void
			is_eiffel_class: attached {EIFFEL_CLASS_I} a_class
		local
			l_clusters: ARRAYED_LIST [CONF_CLUSTER]
			l_cluster_classes: ARRAYED_LIST [CONF_CLASS]
			l_apt_targets: ARRAYED_LIST [CONF_TARGET]
			l_target_system: CONF_SYSTEM
			l_class_target: CONF_TARGET
			l_targets: ARRAYED_LIST [CONF_TARGET]
			l_target: CONF_TARGET
			l_libraries: ARRAYED_LIST [CONF_LIBRARY]
			l_sub_libraries: ARRAYED_LIST [CONF_LIBRARY]
			l_apt_library_targets: HASH_TABLE [detachable CONF_TARGET, UUID]
			l_uuid: UUID
			l_cursor: CURSOR
		do
				-- Step #1
				-- Retrieve class target and applicable extended targets for the supplied class.
			l_class_target := a_class.target
			l_target_system := l_class_target.system

				-- Retrieve a list of targets			
			l_targets := l_target_system.targets.linear_representation
				-- Remove current class target as we know all classes in the target are reachable
			l_targets.start
			l_targets.search (l_class_target)
			check l_class_target_found: not l_targets.after end
			l_targets.remove

				-- Create a list of applicable targets for post-processing.
			create l_apt_targets.make (1)
			l_apt_targets.extend (l_class_target)

				-- Build list of applicable targets
			from
				l_targets.start
			until
				l_targets.is_empty or else l_targets.after
			loop
				l_target := l_targets.item
				if l_target.extends /= Void then
					if l_apt_targets.has (l_target.extends) then
							-- Remove applicable target and reiterate
						l_targets.remove
						l_apt_targets.extend (l_target)
					else
						l_targets.forth
					end
				else
					l_targets.forth
				end
			end

				-- Step #2
				-- Retrieve the applicable targets for a class within a library. Applicable targets are direct
				-- references of the library.
			l_class_target := l_target_system.library_target
			if l_class_target /= Void and then l_class_target /= target then
				create l_apt_library_targets.make (13)

					-- The class is from a library, we need to navigate down to find first level libraries.
				l_libraries := target.libraries.linear_representation
				from l_libraries.start until l_libraries.after loop
					l_target := l_libraries.item.library_target
					l_uuid := l_target.system.uuid
					if not l_apt_library_targets.has (l_uuid) then
						if l_target = l_class_target then
								-- The project references the library directly.
							l_apt_library_targets.put (target, l_uuid)
						end

							-- Check other libraries
						l_sub_libraries := l_target.libraries.linear_representation

							-- Iterate sub libraries to look for a matching target
						from l_sub_libraries.start until l_sub_libraries.after loop
							if l_sub_libraries.item.library_target = l_class_target then
								l_apt_library_targets.put (l_target, l_uuid)
							end
							l_sub_libraries.forth
						end
						if not l_apt_library_targets.has (l_uuid) then
								-- No target match, but add an entry so the library is not checked again.
							l_apt_library_targets.put (Void, l_uuid)

								-- There was no applicable library so add all the libraries to the list of checked
								-- libraries.
							l_cursor := l_libraries.cursor
							l_libraries.append (l_sub_libraries)
							l_libraries.go_to (l_cursor)
						end
					end
					l_libraries.forth
				end

				from l_apt_library_targets.start until l_apt_library_targets.after loop
					l_target := l_apt_library_targets.item_for_iteration
					from until l_target = Void loop
						if l_target /= Void then
								-- Add target and parent targets.
							if not l_apt_targets.has (l_target) then
								l_apt_targets.extend (l_apt_library_targets.item_for_iteration)
							end
							l_target := l_target.extends
						end
					end
					l_apt_library_targets.forth
				end
			end

				-- Analyze all targets and retrieve clusters, and then add the result classes.
			create Result.make_map (1000)
			from l_apt_targets.start until l_apt_targets.after loop
				l_target := l_apt_targets.item
				l_clusters := l_target.clusters.linear_representation
				from l_clusters.start until l_clusters.after loop
					if attached l_clusters.item.classes as l_classes then
						l_cluster_classes := l_classes.linear_representation
						from l_cluster_classes.start until l_cluster_classes.after loop
							if
								attached {CLASS_I} l_cluster_classes.item_for_iteration as l_class_i and then
								l_class_i.target = l_target and then
								not Result.has (l_class_i)
							then
								Result.force (l_class_i)
							end
							l_cluster_classes.forth
						end
					end
					l_clusters.forth
				end
				l_apt_targets.forth
			end
		ensure
			all_possible_client_classes_attached: Result /= Void
		end

feature -- Access

	classes_with_name (a_class_name: READABLE_STRING_GENERAL): LIST [CLASS_I]
			-- Classes with a local name of `class_name' found in the Universe.
			-- That means renamings on the cluster of the class itself are taken into
			-- account, but not renamings because of the use as a library.
			-- We also look at classes in libraries of libraries.
		require
			class_name_not_void: a_class_name /= Void and then not a_class_name.is_empty
			class_name_upper: a_class_name.is_equal (a_class_name.as_upper)
			target_not_void: target /= Void
		local
			l_vis: CONF_FIND_CLASS_VISITOR
			l_buffered_classes: like buffered_classes
		do
			l_buffered_classes := buffered_classes
			l_buffered_classes.search (a_class_name)
			if not l_buffered_classes.found then
				create l_vis.make (conf_state)
				l_vis.set_name (a_class_name)
				target.process (l_vis)
				Result := l_vis.found_classes
				if Result.count = 1 then
					l_buffered_classes.put (Result.first, a_class_name)
				end
			else
				Result := create {ARRAYED_LIST [CLASS_I]}.make (1)
				Result.extend (l_buffered_classes.found_item)
			end
		ensure
			classes_with_name_not_void: Result /= Void
		end

	compiled_classes_with_name (class_name: STRING): LIST [CLASS_I]
			-- Compiled classes with name `class_name' found in the Universe
		require
			class_name_not_void: class_name /= Void and then not class_name.is_empty
			class_name_upper: class_name.is_equal (class_name.as_upper)
		do
			Result := classes_with_name (class_name.as_upper)
			from
				Result.start
			until
				Result.after
			loop
				if Result.item.is_compiled then
					Result.forth
				else
					Result.remove
				end
			end
		end

	class_named (a_class_name: READABLE_STRING_8; a_group: CONF_GROUP): detachable CLASS_I
			-- Class named `a_class_name' in cluster `a_cluster'
		require
			good_argument: a_class_name /= Void
			good_group: a_group /= Void
		local
			vscn: VSCN
		do
			if attached a_group.class_by_name (a_class_name, True) as l_cl then
				if l_cl.count = 1 then
					Result := {CLASS_I} / l_cl.first
					check
						Result_not_void: Result /= Void
					end
				elseif l_cl.count > 1 then
					create vscn
					vscn.set_cluster (a_group)
					vscn.set_first (l_cl.i_th (1))
					vscn.set_second (l_cl.i_th (2))
					error_handler.insert_error (vscn)
					error_handler.raise_error
				end
			end
		end

	safe_class_named (a_class_name: READABLE_STRING_GENERAL; a_group: CONF_GROUP): detachable CLASS_I
			-- Class named `a_class_name' in cluster `a_cluster' which doesn't generate {VSCN} errors.
		require
			good_argument: a_class_name /= Void
			good_group: a_group /= Void
		do
			if
				attached a_group.class_by_name (a_class_name, True) as l_cl and then
				l_cl.count = 1
			then
				Result := {CLASS_I} / l_cl.first
				check
					Result_not_void: Result /= Void
				end
			end
		end

	cluster_of_name (cluster_name: READABLE_STRING_GENERAL): detachable CLUSTER_I
			-- Cluster whose name is `cluster_name' (Void if none)
		require
			good_argument: cluster_name /= Void
		do
			if attached {CLUSTER_I} group_of_name (cluster_name) as c then
				Result := c
			end
		end

	group_of_name (group_name: READABLE_STRING_GENERAL): detachable CONF_GROUP
			-- Group whose name is `group_name' (Void if none)
		require
			good_argument: group_name /= Void
		do
			if attached target as l_target then
				Result := l_target.clusters.item (group_name)
				if Result = Void then
					Result := l_target.libraries.item (group_name)
					if Result = Void then
						Result := l_target.assemblies.item (group_name)
						if Result = Void then
							Result := l_target.overrides.item (group_name)
						end
					end
				end
			end
		end

	group_of_name_recursive (a_group_name: STRING): ARRAYED_SET [CONF_GROUP]
			-- Group whose name is `a_group_name'.
			-- This feature will find all groups in the system recursively.
		require
			not_void: a_group_name /= Void
			a_group_name_lower: a_group_name.is_equal (a_group_name.as_lower)
		local
			l_groups: like groups
		do
			create {ARRAYED_SET [CONF_GROUP]} Result.make (10)
			if attached group_of_name (a_group_name) as l_found_item then
				Result.extend (l_found_item)
			end

			from
				create group_visited.make (groups.count)
				l_groups := groups
				l_groups.start
			until
				l_groups.after
			loop
				group_of_name_recursive_imp (a_group_name, l_groups.item_for_iteration, Result)

				l_groups.forth
			end
			group_visited := Void
		ensure
			not_void: Result /= Void
			cleared: group_visited = Void
		end

	cluster_of_location (a_directory: PATH): LIST [CONF_CLUSTER]
			-- Find cluster for `a_directory'.
		require
			a_directory_valid: a_directory /= Void and then not a_directory.is_empty
		local
			l_vis: CONF_FIND_LOCATION_VISITOR
		do
			create l_vis.make
			l_vis.set_directory (a_directory)
			l_vis.set_recursive (True)
			target.process (l_vis)
			Result := l_vis.found_clusters
		ensure
			Result_not_void: Result /= Void
		end

	class_from_assembly (an_assembly: READABLE_STRING_32; a_dotnet_name: READABLE_STRING_32): detachable EXTERNAL_CLASS_I
			-- Associated EXTERNAL_CLASS_I instance for `a_dotnet_name' external class name
			-- from given assembly `an_assembly'. If more than one assembly with
			-- `an_assembly' as name, look only in first found item.
			--| An example of usage would be:
			--|	 l_class := universe.class_from_assembly ("mscorlib", "System.IComparable", False)
			--| to get the associated `System.IComparable' from `mscorlib'.
			--|
			--| Nota: It compares assembly names in lower case
		require
			an_assembly_not_void: an_assembly /= Void
			an_assembly_not_empty: not an_assembly.is_empty
			a_dotnet_name_not_void: a_dotnet_name /= Void
			a_dotnet_name_not_empty: not a_dotnet_name.is_empty
			target_not_void: target /= Void
		local
			l_assemblies: STRING_TABLE [CONF_PHYSICAL_ASSEMBLY_INTERFACE]
			l_assembly: CONF_PHYSICAL_ASSEMBLY
		do
			from
				l_assemblies := conf_system.all_assemblies
				l_assemblies.start
			until
				l_assembly /= Void or l_assemblies.after
			loop
				l_assembly := {CONF_PHYSICAL_ASSEMBLY} / l_assemblies.item_for_iteration
				check
					physical_assembly: l_assembly /= Void
				end
				if not l_assembly.assembly_name.is_case_insensitive_equal (an_assembly) then
					l_assembly := Void
				end
				l_assemblies.forth
			end
			if l_assembly /= Void then
				l_assembly.dotnet_classes.search (a_dotnet_name)
				if l_assembly.dotnet_classes.found then
					Result := {EXTERNAL_CLASS_I} / l_assembly.dotnet_classes.found_item
				end
			end
		end

	library_of_uuid (a_uuid: UUID; a_recursive: BOOLEAN): LIST [CONF_LIBRARY]
			-- Return list of libraries identified by UUID
			--
			-- Note: Since it is possible that multiple libraries share the same UUID, a list of
			--       {CONF_LIBRARY} is returned.
			--
			-- `a_uuid': UUID of requested library.
			-- `a_recursive': If True `library_of_uuid' will also look in sub libraries.
			-- `Result': list of libraries having `a_uuid' as its UUID, empty if no library in universe with
			--           given uuid was found.
		require
			target_not_void: target /= Void
		local
			l_visitor: CONF_FIND_UUID_VISITOR
		do
			create l_visitor.make
			l_visitor.set_uuid (a_uuid)
			l_visitor.set_recursive (a_recursive)
			target.process (l_visitor)
			Result := l_visitor.found_libraries
		ensure
			results_match_uuid: Result.for_all (
				agent (a_lib: CONF_LIBRARY; a_id: UUID): BOOLEAN
					do
						Result := a_lib.library_target.system.uuid.is_equal (a_id)
					end (?, a_uuid))
			results_match_recursion: not a_recursive implies Result.for_all (
				agent (a_lib: CONF_LIBRARY): BOOLEAN
					local
						l_target: CONF_TARGET
					do
						Result := a_lib.target = target
						if not Result then
							from
								l_target := target
							until
								l_target = Void or Result
							loop
								Result := l_target = a_lib.target
								l_target := l_target.extends
							end
						end
					end)
		end

	library_at_location (a_location: PATH; a_recursive: BOOLEAN): detachable LIST [CONF_LIBRARY]
			-- List of system libraries identified by ecf file at `a_location`
			-- `a_location`:  location of the library eiffel configuration file
			-- `a_recursive': If True `library_at_location' will also look in sub libraries.
			-- note: there should be at most one library for one location.
		require
			a_location_valid: a_location /= Void and then attached a_location.extension as ext and then ext.is_case_insensitive_equal ("ecf")
		local
			l_vis: CONF_FIND_LIBRARY_BY_LOCATION_VISITOR
		do
			create l_vis.make
			l_vis.set_location (a_location)
			l_vis.set_recursive (True)
			target.process (l_vis)
			Result := l_vis.found_libraries
		end

feature -- Update

	set_new_target (a_target: like new_target)
			-- Set `new_target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			new_target := a_target
			conf_system := a_target.system
		ensure
			new_target_set: new_target = a_target
			conf_system_set: conf_system = a_target.system
		end

	set_old_target (a_target: like target)
			-- Set `target' to `a_target' and reset `new_target'.
		require
			a_target_not_void: a_target /= Void
		do
			target := a_target
			new_target := Void
			conf_system := Void
		ensure
			target_set: target = a_target
			new_target_void: new_target = Void
			conf_system_void: conf_system = Void
		end

	new_target_to_target
			-- Move `new_target' to `target'.
		require
			new_target_not_void: new_target /= Void
		do
			target := new_target
			new_target := Void
		ensure
			target_set: target /= Void and target = old new_target
			new_target_void: new_target = Void
		end

	reset_internals
			-- Should be called when a new compilation starts.
		do
			buffered_classes.wipe_out
		end

feature {COMPILER_EXPORTER} -- Implementation

	buffered_classes: STRING_TABLE [CLASS_I]
			-- Hash table that contains recent results of calls to `classes_with_name'.
		once
			create Result.make (200)
		end

	check_universe
			-- Check universe
		require
			system_exists: system /= Void
		local
			l_actions: HASH_TABLE [PROCEDURE [CLASS_I], STRING]
			l_exceptions: SEARCH_TABLE [STRING]
			l_system: like system
		do
			create l_actions.make (52)
			create l_exceptions.make (2)

			l_system := system

			if l_system.il_generation then
				l_actions.put (agent l_system.set_system_object_class, "SYSTEM_OBJECT")
				l_actions.put (agent l_system.set_system_value_type_class, "VALUE_TYPE")
				l_actions.put (agent l_system.set_system_exception_type_class, "NATIVE_EXCEPTION")
			end

			l_actions.put (agent l_system.set_any_class, "ANY")
			l_actions.put (agent l_system.set_boolean_class, "BOOLEAN")
			l_actions.put (agent l_system.set_character_class (?, 8), "CHARACTER_8")
			l_actions.put (agent l_system.set_character_class (?, 32), "CHARACTER_32")
			l_actions.put (agent l_system.set_natural_class (?, 8), "NATURAL_8")
			l_actions.put (agent l_system.set_natural_class (?, 16), "NATURAL_16")
			l_actions.put (agent l_system.set_natural_class (?, 32), "NATURAL_32")
			l_actions.put (agent l_system.set_natural_class (?, 64), "NATURAL_64")
			l_actions.put (agent l_system.set_integer_class (?, 8), "INTEGER_8")
			l_actions.put (agent l_system.set_integer_class (?, 16), "INTEGER_16")
			l_actions.put (agent l_system.set_integer_class (?, 32), "INTEGER_32")
			l_actions.put (agent l_system.set_integer_class (?, 64), "INTEGER_64")
			l_actions.put (agent l_system.set_real_class (?, 32), "REAL_32")
			l_actions.put (agent l_system.set_real_class (?, 64), "REAL_64")
			l_actions.put (agent l_system.set_pointer_class, "POINTER")
			l_actions.put (agent l_system.set_typed_pointer_class, "TYPED_POINTER")
			l_actions.put (agent l_system.set_string_class (?, 8), "STRING_8")
			l_actions.put (agent l_system.set_string_class (?, 32), "STRING_32")
			l_actions.put (agent l_system.set_immutable_string_class (?, 8), "IMMUTABLE_STRING_8")
			l_actions.put (agent l_system.set_immutable_string_class (?, 32), "IMMUTABLE_STRING_32")
			l_actions.put (agent l_system.set_array_class, "ARRAY")
			l_actions.put (agent l_system.set_special_class, "SPECIAL")
			l_actions.put (agent l_system.set_tuple_class, "TUPLE")
			l_actions.put (agent l_system.set_disposable_class, "DISPOSABLE")
			l_actions.put (agent l_system.set_routine_class, "ROUTINE")
			l_actions.put (agent l_system.set_procedure_class, "PROCEDURE")
			l_actions.put (agent l_system.set_function_class, "FUNCTION")
			l_actions.put (agent l_system.set_predicate_class, "PREDICATE")
			l_actions.put (agent l_system.set_type_class, "TYPE")

				-- RT_EXTENSION is not really needed, so when we do not find it, we simply
				-- continue as if it was not present.
			l_exceptions.put ("RT_EXTENSION")
			l_actions.put (agent l_system.set_rt_extension_class, "RT_EXTENSION")

				-- Exception manager
			l_actions.put (agent l_system.set_exception_manager_class, "ISE_EXCEPTION_MANAGER")
			l_exceptions.put ("EXCEPTION")
			l_actions.put (agent system.set_exception_class, "EXCEPTION")

			if l_system.il_generation then
				l_actions.put (agent l_system.set_system_string_class, "SYSTEM_STRING")
				l_actions.put (agent l_system.set_native_array_class, "NATIVE_ARRAY")
				l_actions.put (agent l_system.set_arguments_class, "ARGUMENTS")
				l_actions.put (agent l_system.set_system_type_class, "SYSTEM_TYPE")
			end

			check_class_unicity (l_actions, l_exceptions)

				-- TODO: Finish the tests below.
			-- if l_system.il_generation then
					-- One more check, let's find out that `system_object' and `system_string'
					-- are set with EXTERNAL_CLASS_I instances

					-- We test against Void as `system_object_class' is declared as
					-- EXTERNAL_CLASS_I.
				-- if l_system.system_object_class = Void then
				-- 		-- Report error here
				--		-- FIXME: Manu: 06/03/2003
				-- end

					-- Check it is an EXTERNAL_CLASS_I instance.
				-- if
				--	 l_system.system_string_class = Void or else
				--	 not l_system.system_string_class.is_external_class
				-- then
				-- 		-- Report error here
				-- 		-- FIXME: Manu: 06/03/2003
				-- end
			-- end

				-- Check sum error
			Error_handler.checksum
		end

	check_class_unicity (a_set: HASH_TABLE [PROCEDURE [CLASS_I], STRING]; a_except: SEARCH_TABLE [STRING])
			-- Universe checking, check all class names in `a_set' to ensure that only
			-- one instance with specified name is found in universe. If it is unique,
			-- then for each unique instance calls associated action.
			-- If not found, but present in `a_except' then compiler simply continue has if nothing
			-- was requested.
		require
			a_set_not_void: a_set /= Void
			a_except_not_void: a_except /= Void
		local
			vd23: VD23
			vd24: VD24
			l_class_name: STRING
			l_classes: LIST [CLASS_I]
			l_count: INTEGER
			l_kernel_library: CONF_LIBRARY
		do
				-- First search for the EiffelBase library whose UUID is known.
				-- Commented for the moment untill there is agreement.
--			l_kernel_library := eiffel_base_library
			if l_kernel_library /= Void then
				from
					a_set.start
				until
					a_set.after
				loop
					if not l_kernel_library.classes.has (a_set.key_for_iteration) then
						if not a_except.has (l_class_name) then
							create vd23
							vd23.set_class_name (l_class_name)
							error_handler.insert_error (vd23)
						end
					else
						if attached {CLASS_I} l_kernel_library.classes.item (a_set.key_for_iteration) as l_class_i  then
							a_set.item_for_iteration.call ([l_class_i])
						else
							check False end
						end
					end
					a_set.forth
				end
			else
				from
					a_set.start
				until
					a_set.after
				loop
					l_class_name := a_set.key_for_iteration
					l_classes := classes_with_name (l_class_name)
					l_count := l_classes.count
					if
						l_count > 1 and then
							-- Small workaround when a requested basic class also exists in the Universe
							-- in a .NET assembly. In that case we decide to ignore the .NET classes if
							-- there is at least one Eiffel class.
							-- TODO: we should use the UUID for EiffelBase and only look there for those
							-- classes. This would speed up the lookup dramatically.
						not l_classes.for_all (agent {CLASS_I}.is_external_class)
					then
						from
							l_classes.start
						until
							l_classes.after
						loop
							if l_classes.item.is_external_class then
								l_classes.remove
							else
								l_classes.forth
							end
						end
							-- Reflect possible changes to the number of classes.
						l_count := l_classes.count
					end
					if l_count = 0 then
						if not a_except.has (l_class_name) then
							create vd23
							vd23.set_class_name (l_class_name)
							error_handler.insert_error (vd23)
						end
						-- if we have two results it's possible that we got a class which is overriden and the override itself
						-- return the class that is overriden
					elseif l_count = 2 and then l_classes.i_th (1).actual_class = l_classes.i_th (2) then
						a_set.item_for_iteration.call ([l_classes.i_th (1)])
					elseif l_count = 2 and then l_classes.i_th (2).actual_class = l_classes.i_th (1) then
						a_set.item_for_iteration.call ([l_classes.i_th (2)])
					elseif l_count > 1 then
						create vd24
						vd24.set_class_name (l_class_name)
						vd24.set_cluster (l_classes.first.group)
						vd24.set_other_cluster (l_classes.i_th (2).group)
						error_handler.insert_error (vd24)
					else
						a_set.item_for_iteration.call ([l_classes.first])
					end
					a_set.forth
				end
			end
		end

feature {COMPILER_EXPORTER} -- Precompilation

	mark_precompiled
			-- Mark all the clusters of the universe as being precompiled.
		local
			precomp_ids: ARRAY [INTEGER]
			nb: INTEGER
		do
			precomp_ids := Precompilation_directories.current_keys
			nb := precomp_ids.count + 1
			precomp_ids.conservative_resize_with_default (0, 1, nb)
			precomp_ids.put (System.compilation_id, nb)
		end

feature {NONE} -- Implementation

	group_of_name_recursive_imp (a_group_name: STRING; a_group_to_search: CONF_GROUP; a_result: ARRAYED_SET [CONF_GROUP])
			-- Group whose name is `a_group_name'
		require
			not_void: a_group_name /= Void
			a_group_name_lower: a_group_name.is_equal (a_group_name.as_lower)
			not_void: a_group_to_search /= Void
			not_void: a_result /= Void
			ready: group_visited /= Void
		local
			l_found_item: CONF_GROUP
			l_groups: SEARCH_TABLE [CONF_GROUP]
		do
			group_visited.extend (a_group_to_search)
			l_found_item := a_group_to_search.sub_group_by_name (a_group_name)
			if l_found_item /= Void then
				a_result.extend (l_found_item)
			end

			-- We have to check if {CONF_GROUP}.`classes_set'
			-- For dotnet `a_group_to_search', {CONF_GROUP}.`classes_set' will be false even in classic projects
			if a_group_to_search.classes_set then
				from
					l_groups := a_group_to_search.accessible_groups
					l_groups.start
				until
					l_groups.after
				loop
					if not group_visited.has (l_groups.item_for_iteration) then
						group_of_name_recursive_imp (a_group_name, l_groups.item_for_iteration, a_result)
					end

					l_groups.forth
				end
			end

		end

	group_visited: ARRAYED_LIST [CONF_GROUP]
			-- Group visited used by `group_of_name_recursive_imp'

	eiffel_base_library: CONF_LIBRARY
			-- Search for library whose UUID matches the known one for EiffelBase. This library
			-- is the one that should include all the known classes of the compiler.
		local
			l_libraries: STRING_TABLE [CONF_LIBRARY]
			l_uuid: UUID
		do
			from
				l_libraries := target.libraries
				l_libraries.start
				create l_uuid.make_from_string ("6D7FF712-BBA5-4AC0-AABF-2D9880493A01")
			until
				l_libraries.after or Result /= Void
			loop
				if l_libraries.item_for_iteration.library_target.system.uuid ~ l_uuid then
					Result := l_libraries.item_for_iteration
				end
				l_libraries.forth
			end
		end

invariant
	new_target_in_conf_system: (conf_system /= Void and new_target /= Void) implies new_target.system = conf_system
	target_in_conf_system: (conf_system /= Void and new_target = Void) implies target.system = conf_system

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
