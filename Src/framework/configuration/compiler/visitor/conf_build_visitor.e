note
	description: "Visitor that builds the compiled informations from scratch or from old informations."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_BUILD_VISITOR

inherit
	CONF_CONDITIONED_ITERATOR
		export
			{NONE} process_system, process_assembly, process_library, process_cluster, process_override
		redefine
			last_warnings,
			process_target,
			process_assembly,
			process_library,
			process_cluster,
			process_override
		end

	SHARED_CLASSNAME_FINDER
		export
			{NONE} all
		end

	CONF_VALIDITY

	CONF_ACCESS

	CONF_SCAN_DIRECTORY
		redefine
			last_warnings,
			on_process_directory
		end

create
	make_build,
	make_build_from_old

feature {NONE} -- Initialization

	make_build (a_state: like state; an_application_target: like application_target;
		a_assembly_cach_location: READABLE_STRING_32; a_il_version: like il_version; a_partial_location: like partial_location; a_factory: like factory)
			-- Create.
		require
			a_state_not_void: a_state /= Void
			an_application_target_not_void: an_application_target /= Void
			a_factory_not_void: a_factory /= Void
		do
			create assembly_cache_folder.make_from_string (a_assembly_cach_location)
			il_version := a_il_version
			partial_location := a_partial_location
			create current_classes_by_filename.make (0)
			application_target := an_application_target
			factory := a_factory
			reset_classes
			make (a_state)
			create libraries.make (Libraries_per_target)
			create consume_assembly_observer
			create process_group_observer
			create process_directory
			create last_warnings.make (1)
			current_system := an_application_target.system
		ensure
			application_target_set: application_target = an_application_target
		end

	make_build_from_old (a_state: like state; an_application_target, an_old_target: CONF_TARGET;
		a_assembly_cach_location: READABLE_STRING_32; a_version: like il_version; a_partial_location: like partial_location; a_factory: like factory)
			-- Create.
		require
			a_state_not_void: a_state /= Void
			an_application_target_not_void: an_application_target /= Void
			an_old_target_not_void: an_old_target /= Void
			a_factory_not_void: a_factory /= Void
		do
			application_target := an_application_target
			factory := a_factory
			reset_classes
			make_build (a_state, an_application_target, a_assembly_cach_location, a_version, a_partial_location, a_factory)
			old_target := an_old_target
		ensure
			application_target_set: application_target = an_application_target
		end

feature -- Access

	is_full_class_name_analysis: BOOLEAN
			-- Will we check for the class name?

	modified_classes: SEARCH_TABLE [CONF_CLASS]
			-- The list of modified classes.

	added_classes: SEARCH_TABLE [CONF_CLASS]
			-- The list of added classes.

	removed_classes: SEARCH_TABLE [CONF_CLASS]
			-- The list of removed classes.

	removed_classes_from_override: SEARCH_TABLE [CONF_CLASS]
			-- The list of removed classes from override clusters.

	partly_removed_classes: ARRAYED_LIST [TUPLE [conf_class: CONF_CLASS; system: CONF_SYSTEM]]
			-- The list of classes that have been removed from a certain system only.
			-- (if a library that is still used somewhere else has been removed)

	new_assemblies: SEARCH_TABLE [CONF_ASSEMBLY]
			-- List of assemblies in the current configuration.

	last_warnings: ARRAYED_LIST [CONF_ERROR]
			-- <Precursor>

feature -- Update

	set_is_full_class_name_analyzis (v: like is_full_class_name_analysis)
			-- Set `is_full_class_name_analysis' with `v'.
		do
			is_full_class_name_analysis := v
		ensure
			is_full_class_name_analysis_set: is_full_class_name_analysis = v
		end

	reset_classes
			-- Reset `xxx_classes' data structures.
		do
			reset
			create modified_classes.make (modified_classes_per_system)
			create added_classes.make (added_classes_per_system)
			create removed_classes.make (removed_classes_per_system)
			create removed_classes_from_override.make (removed_classes_from_override_per_system)
			create new_assemblies.make (15)
			create partly_removed_classes.make (removed_classes_per_system)
		end

feature -- Observers

	consume_assembly_observer: ACTION_SEQUENCE [TUPLE]
			-- Observer if assemblies are consumed.

	process_group_observer: ACTION_SEQUENCE [TUPLE [CONF_GROUP]]
			-- Observer if a group is processed.

	process_directory: ACTION_SEQUENCE [TUPLE [CONF_CLUSTER, READABLE_STRING_32]]
			-- Observer if a cluster directory is processed.

feature -- Events

	on_process_group (a_group: CONF_GROUP)
			-- `A_group' is processed.
		require
			a_group_not_void: a_group /= Void
		do
			process_group_observer.call ([a_group])
		end

	on_process_directory (a_cluster: CONF_CLUSTER; a_path: READABLE_STRING_32)
			-- (Sub)directory `a_path' of `a_cluster' is processed.
		do
			process_directory.call ([a_cluster, a_path])
		end

feature -- Visit nodes

	process_target (a_target: CONF_TARGET)
			-- Visit `a_target'.
		local
			l_libraries, l_clusters, l_overrides: STRING_TABLE [CONF_GROUP]
			l_assemblies: STRING_TABLE [CONF_ASSEMBLY]
			l_old_pre: detachable CONF_PRECOMPILE
			l_old_group: CONF_GROUP
			l_consumer_manager: CONF_CONSUMER_MANAGER
			l_old_assemblies: STRING_TABLE [CONF_PHYSICAL_ASSEMBLY_INTERFACE]
			l_retried: BOOLEAN
			l_error_count: INTEGER
		do
			if not l_retried then
				if attached last_errors as l_last_errors then
					l_error_count := l_last_errors.count
				end

				current_system := a_target.system

				if attached old_target as l_old_target then
					a_target.set_environ_variables (l_old_target.environ_variables)
					l_libraries := l_old_target.libraries
					l_clusters := l_old_target.clusters
					l_overrides := l_old_target.overrides
					l_assemblies := l_old_target.assemblies
						-- if it's the application target, set the old_libraries
						-- twin, so that we can remove the libraries we have handled without
						-- modifying the old data which is still needed in case of an error
					if a_target = application_target then
						old_libraries := l_old_target.system.all_libraries.twin
					end
				end

				if a_target = application_target then
					all_libraries := a_target.system.all_libraries
				end

					-- if it is the library or application target, add the target to the libraries
				if a_target = a_target.system.library_target or a_target = application_target then
					libraries.force (a_target, a_target.system.uuid)
					if attached old_libraries as l_old_libraries then
						l_old_libraries.remove (a_target.system.uuid)
					end
				end

					-- process clusters first, because we need those information while processing libraries if we have circular dependencies
				process_with_old (a_target.clusters, l_clusters)

				if attached a_target.precompile as l_pre and then l_pre.is_enabled (state) then
					if attached old_target as l_old_target then
						l_old_pre := l_old_target.precompile
						old_group := l_old_pre
					end
						-- did any configuration in the precompile change? => error
					if
						l_old_pre = Void or else not l_old_pre.is_enabled (state) or else
						not attached l_pre.library_target as l_pre_library_target or else
						not attached l_old_pre.library_target as l_old_pre_library_target or else
						not l_pre_library_target.is_deep_group_equivalent (l_old_pre_library_target, create {SEARCH_TABLE [UUID]}.make (20))
					then
						add_and_raise_error (create {CONF_ERROR_PRE_CHANGED}.make)
					end
					process_library (l_pre)
					old_group := Void
				end

					-- process assemblies
				process_with_old (a_target.assemblies, l_assemblies)

					-- do libraries after clusters so that the clusters have already been processed
				process_with_old (a_target.libraries, l_libraries)

					-- must be done one time per system after everything is processed
				if a_target = application_target then
						-- only for .NET
					if state.is_dotnet then
						if
							attached old_target as l_old_target and then
							attached l_old_target.system.all_assemblies as a
						then
							l_old_assemblies := a.twin
						end
						create l_consumer_manager.make (factory, assembly_cache_folder, il_version, application_target, added_classes, removed_classes, modified_classes)
						l_consumer_manager.consume_assembly_observer.append (consume_assembly_observer)
						l_consumer_manager.build_assemblies (new_assemblies, l_old_assemblies)
						if attached l_consumer_manager.last_error as l_consumer_manager_error then
							add_and_raise_error (l_consumer_manager_error)
						else
							check has_no_error: not l_consumer_manager.is_error end
							a_target.system.set_all_assemblies (l_consumer_manager.assemblies)

								-- only assemblies that have not been reused remain in `old_assemblies'
							if l_old_assemblies /= Void then
								across
									l_old_assemblies as a
								loop
									l_old_group := a
									l_old_group.invalidate
									process_removed_classes (l_old_group.classes)
								end
							end
						end
					else
						a_target.system.set_all_assemblies (create {STRING_TABLE [CONF_PHYSICAL_ASSEMBLY]}.make (0))
					end

						-- overrides can only be in the application target, must be done at the very end
					process_with_old (a_target.overrides, l_overrides)
				end

					-- add the classes that are still in `old_target' to `removed_classes'
						-- needed for libraries that have been removed
						-- changes in libraries itself have already been handled
				process_removed (l_libraries)

					-- assemblies are already handled
				process_removed (l_clusters)
				process_removed (l_overrides)
			else
				check
					is_error: is_error
				end
			end
		ensure then
			all_assemblies_set: (not is_error and then a_target.system.application_target = a_target) implies a_target.system.all_assemblies /= Void
		rescue
				-- If we have added a new configuration error, we retry, otherwise we let the
				-- caller handle the exception.
			if
				attached exception_manager.last_exception as x and then
				attached {CONF_EXCEPTION} x.original as lt_ex and then
				attached last_errors  as e and then e.count /= l_error_count
			then
				l_retried := True
				retry
			end
		end

	process_assembly (an_assembly: CONF_ASSEMBLY)
			-- Visit `an_assembly'.
		local
			l_file: RAW_FILE
			l_old_assembly: CONF_ASSEMBLY
			l_cl: CONF_CLASS
			l_current_system: like current_system
		do
			if attached {CONF_ASSEMBLY} old_group as l_assembly then
				l_old_assembly := l_assembly
			end
			check
				old_group_implies_assembly: old_group /= Void implies l_old_assembly /= Void
			end

			l_current_system := current_system

				-- if it is a local assembly, check that the file exists
			if state.is_dotnet and then not an_assembly.is_non_local_assembly then
				create l_file.make_with_path (an_assembly.location.evaluated_path)
				if not l_file.exists or else not l_file.is_readable then
					add_and_raise_error (create {CONF_ERROR_FILE}.make_with_config (an_assembly.location.evaluated_path.name, an_assembly.location.original_path, l_current_system.file_name))
				end
			end
			new_assemblies.force (an_assembly)

				-- if the renaming/prefix changed, mark classes as partly removed
			if l_old_assembly /= Void and then not (l_old_assembly.name_prefix ~ an_assembly.name_prefix and l_old_assembly.renaming ~ an_assembly.renaming) then
				if attached l_old_assembly.classes as l_classes then
					across
						l_classes as c
					loop
						l_cl := c
						if l_cl.is_compiled then
							partly_removed_classes.force ([l_cl, l_current_system])
						end
					end
				else
					check classes_set: False end
				end
			end
		end

	process_library (a_library: CONF_LIBRARY)
			-- Visit `a_library'.
		local
			l_target: detachable CONF_TARGET
			l_uuid: UUID
			l_vis: like Current
			l_prefixed_classes: like current_classes
			l_old_library: CONF_LIBRARY
			l_cl: CONF_CLASS
			l_current_classes: like current_classes
			l_partly_removed_classes: like partly_removed_classes
			l_current_system: like current_system
		do
			on_process_group (a_library)
			if attached {CONF_LIBRARY} old_group as l_old_group_as_lib then
				l_old_library := l_old_group_as_lib
			end
			check
				old_group_implies_old_library: old_group /= Void implies l_old_library /= Void
			end
			l_target := a_library.library_target
			if l_target = Void then
				check library_target_set: False end
			else
				l_uuid := l_target.system.uuid
				check
					uuid_set: l_uuid /= Void
				end
				if not libraries.has (l_uuid) then
						-- get and initialize visitor
					l_vis := twin
					l_vis.reset
					if attached old_libraries as l_old_libraries and then attached l_old_libraries.item (l_uuid) as l_found_old_library then
						l_vis.set_old_target (l_found_old_library)
						l_old_libraries.remove (l_uuid)
					end
					libraries.force (l_target, l_uuid)
					l_target.process (l_vis)
					if l_vis.is_error then
						last_errors := l_vis.last_errors
						raise_error
					end
				end

				create l_current_classes.make (Classes_per_cluster)
				current_classes := l_current_classes

				l_partly_removed_classes := partly_removed_classes

				l_current_system := current_system

				l_target.clusters.linear_representation.do_if (agent merge_classes ({CONF_CLUSTER} ?), agent (a_cluster: CONF_CLUSTER): BOOLEAN
					do
						Result := a_cluster.classes_set and then not a_cluster.is_hidden
					end
				)

					-- if the renaming/prefix changed we have to add the classes to the partly_removed_classes list
				if l_old_library /= Void and then not (l_old_library.name_prefix ~ a_library.name_prefix and l_old_library.renaming ~ a_library.renaming) then
					across
						l_current_classes as c
					loop
						l_cl := c
						if l_cl.is_compiled then
							l_partly_removed_classes.force ([l_cl, l_current_system])
						end
					end
				end

					-- do renaming prefixing if necessary
				if attached a_library.renaming as l_ren then
					across
						l_ren as r
					loop
						l_current_classes.replace_key (r, @ r.key)
					end
				end
				if attached a_library.name_prefix as l_pre and then not l_pre.is_empty then
					create l_prefixed_classes.make (l_current_classes.count)
					across
						l_current_classes as c
					loop
						l_prefixed_classes.put (c, l_pre + @ c.key)
					end
					a_library.set_classes (l_prefixed_classes)
				else
					a_library.set_classes (l_current_classes)
				end

					-- update visibility
				a_library.update_visible (added_classes)
				if attached a_library.last_error as l_last_error then
					add_error (l_last_error)
					a_library.reset_error
					raise_error
				end
				if attached a_library.last_warnings as l_last_warnings then
					last_warnings.append (l_last_warnings)
				end

				current_classes := Void
			end
		ensure then
			current_classes_void: current_classes = Void
			classes_set: not is_error implies a_library.classes_set
		end

	process_cluster (a_cluster: CONF_CLUSTER)
			-- Visit `a_cluster'.
		local
			l_class: CONF_CLASS
			l_current_classes: like current_classes
			l_modified_classes: like modified_classes
			l_last_warnings: like last_warnings
		do
			on_process_group (a_cluster)
			a_cluster.wipe_class_cache
			current_cluster := a_cluster
			create l_current_classes.make (Classes_per_cluster)
			current_classes := l_current_classes

			l_modified_classes := modified_classes

			create current_classes_by_filename.make (Classes_per_cluster)
			a_cluster.set_classes (l_current_classes)
			a_cluster.set_classes_by_filename (current_classes_by_filename)

			if attached a_cluster.active_file_rule (state) as f then
				process_cluster_recursive ({STRING_32} "", a_cluster, f)
			else
				check
					from_active_file_rule_postcondition: attached a_cluster.last_error as e
				then
					add_and_raise_error (e)
				end
			end

			if partial_classes /= Void then
				process_partial_classes
				partial_classes := Void
			end

				-- if the mapping changed, mark everything in the cluster as modified
			if
				attached {CONF_CLUSTER} old_group as l_old_cluster and then
				not l_old_cluster.mapping.is_equal (a_cluster.mapping)
			then
				across
					l_current_classes as c
				loop
					l_class := c
					if l_class.is_compiled then
						l_modified_classes.force (l_class)
					end
				end
			end

				-- cluster itself has been handled
			handled_groups.force (a_cluster)

				-- process removed classes
			if attached old_group as l_old_group then
				handled_groups.force (l_old_group)
				process_removed_classes (l_old_group.classes)
			end

				-- update visibility
			a_cluster.update_visible (added_classes)
			if attached a_cluster.last_error as l_last_error then
				add_error (l_last_error)
				a_cluster.reset_error
				raise_error
			end
			if attached a_cluster.last_warnings as l_cluster_last_warnings then
				l_last_warnings := last_warnings
				if l_last_warnings = Void then
					create l_last_warnings.make (l_cluster_last_warnings.count)
					last_warnings := l_last_warnings
				end
				l_last_warnings.append (l_cluster_last_warnings)
			end

			current_classes := Void
		ensure then
			current_classes_void: current_classes = Void
			classes_set: not is_error implies a_cluster.classes_set
		end

	process_override (an_override: CONF_OVERRIDE)
			-- Visit `an_override'.
		local
			l_groups: detachable ARRAYED_LIST [CONF_GROUP]
			l_overridee: CONF_GROUP
		do
			process_cluster (an_override)
			if attached an_override.override as l_override then
				l_groups := l_override
			else
				create l_groups.make (application_target.libraries.count + application_target.clusters.count)
				l_groups.append (application_target.libraries.linear_representation)
				l_groups.append (application_target.clusters.linear_representation)
			end
			from
				l_groups.start
			until
				is_error or l_groups.after
			loop
				l_overridee := l_groups.item
				if l_overridee.is_enabled (state) then
					check
						group_processed: l_overridee.classes_set
					end
					l_overridee.add_overriders (an_override, added_classes, modified_classes, removed_classes)
					if attached l_overridee.last_error as l_last_error then
						add_error (l_last_error)
						l_overridee.reset_error
						raise_error
					else
						check has_no_error: not l_overridee.is_error end
					end
				end

				l_groups.forth
			end
		ensure then
			classes_set: not is_error implies an_override.classes_set
		end

feature {CONF_BUILD_VISITOR} -- Implementation, needed for get_visitor

	reset
			-- Reset the values for the new visitor.
		do
			current_classes := Void
			current_cluster := Void
			current_system := application_target.system
			old_group := Void
			old_target := Void
			partial_classes := Void
			create reused_classes.make (classes_per_system)
			create handled_groups.make (groups_per_system)
		end

	set_old_target (a_target: like old_target)
			-- Set `old_target' to `a_target'.
		do
			old_target := a_target
		end

feature {NONE} -- Implementation

	factory: CONF_FACTORY
			-- Factory to use for creation of new nodes.

	reused_classes: SEARCH_TABLE [CONF_CLASS]
			-- List of classes that are reused (and therefore should not be added to `removed_classes').

	handled_groups: SEARCH_TABLE [CONF_GROUP]
			-- List of groups that have been handled (and therefore don't need to be checked for removed classes).

	assembly_cache_folder: PATH
			-- Assembly cache folder.

	il_version: STRING_32
			-- Version of il to use. (If not set, use latest)

	application_target: CONF_TARGET
			-- The application target of the system.

	libraries: HASH_TABLE [CONF_TARGET, UUID]
			-- Mapping of processed library targets, mapped with their uuid.

	all_libraries: detachable HASH_TABLE [CONF_TARGET, UUID]
			-- Mapping of all library targets (processed and unprocessed) that are in the new target, mapped with their uuid.

	old_libraries: detachable HASH_TABLE [CONF_TARGET, UUID]
			-- Mapping of processed library targets of the old target, mapped with their uuid.

	current_classes: detachable STRING_TABLE [CONF_CLASS]
			-- The classes of the group we are currently processing.

	current_classes_by_filename: HASH_TABLE [CONF_CLASS, PATH]
			-- Classes of the group we are currently processing indexed by filename.

	current_cluster: detachable CONF_CLUSTER
			-- The cluster we are currently processing.

	current_system: CONF_SYSTEM
			-- The system we are currently processing.

	old_target: detachable CONF_TARGET
			-- The old target that corresponds to the current target.

	old_group: detachable CONF_GROUP
			-- The old group that corresponds to `current_group'.

	partial_classes: detachable HASH_TABLE [ARRAYED_LIST [READABLE_STRING_GENERAL], READABLE_STRING_32]
			-- The partial classes in the current string mapped to their class name.

	partial_location: CONF_DIRECTORY_LOCATION
			-- Location where the merged partial classes will be stored (normally somewhere inside eifgen)

	handle_class (a_file, a_path: READABLE_STRING_32; a_cluster: CONF_CLUSTER)
			-- Put the class in `a_path' `a_file' into `current_classes'.
		local
			l_file: KL_BINARY_INPUT_FILE_32
			l_class: CONF_CLASS
			l_name: STRING_32
			l_full_file: PATH
			l_pc: ARRAYED_LIST [READABLE_STRING_GENERAL]
			l_file_path: PATH
			l_suggested_filename: STRING_32
			l_current_classes: like current_classes
			l_old_group: detachable like old_group
			l_old_group_classes_by_filename: like old_group.classes_by_filename
			l_classname_finder: like classname_finder
			p: like partial_classes
		do
			l_current_classes := current_classes
			l_old_group := old_group
			if l_old_group /= Void then
				l_old_group_classes_by_filename := l_old_group.classes_by_filename
			end
			check
				old_group_classes_set: l_old_group /= Void implies l_old_group.classes_set
			end
			if
				attached l_current_classes and then
				valid_eiffel_extension (a_file)
			then
				create l_file_path.make_from_string (a_path)
				l_file_path := l_file_path.extended (a_file)
					-- try to get it directly from old_group by filename
				if
					attached l_old_group_classes_by_filename and then
					attached l_old_group_classes_by_filename.item (l_file_path) as l_old_class
				then
					l_class := l_old_class
						-- update class
					l_class.rebuild (a_file, a_cluster, a_path)
					if attached l_class.last_error as l_class_error then
						add_and_raise_error (l_class_error)
							-- don't update renamed classes, instead handle them on the class name basis
					elseif not l_class.is_renamed then
						l_name := l_class.name
						if l_class.is_compiled and l_class.is_modified then
							modified_classes.force (l_class)
						end
							-- add it to `reused_classes'
						reused_classes.force (l_class)
						if attached l_current_classes.item (l_name) as l_found_class then
							add_error (create {CONF_ERROR_CLASSDBL}.make (l_name, l_found_class.full_file_name.name, l_class.full_file_name.name, a_cluster.target.system.file_name))
						else
							l_current_classes.force (l_class, l_name)
							current_classes_by_filename.force (l_class, l_file_path)
						end
					elseif attached l_class.last_class_name as l_last_class_name then
							-- Class was renamed. This fixes eweasel test#incr051.
						l_name := l_last_class_name
						if l_name.is_case_insensitive_equal ("NONE") then
							add_and_raise_error (create {CONF_ERROR_CLASSNONE}.make (a_file, a_cluster.target.system.file_name))
						else
							l_class := factory.new_class (a_file, a_cluster, a_path, l_name)
							if attached l_class.last_error as l_class_error then
								add_and_raise_error (l_class_error)
							end
							added_classes.force (l_class)
							if attached l_current_classes.item (l_name) as l_found_class then
								add_error (create {CONF_ERROR_CLASSDBL}.make (l_name, l_found_class.full_file_name.name,
									l_class.full_file_name.name, a_cluster.target.system.file_name))
							else
								l_current_classes.force (l_class, l_name)
								current_classes_by_filename.force (l_class, l_file_path)
							end
						end
					end
				end
				if not attached l_name then
						-- Because override processing is done during analyzis of the ECF file, we
						-- need to make sure that the class name we read from a class in an override
						-- cluster is really the one intended. Fixes eweasel test#incr263.
					if is_full_class_name_analysis or a_cluster.is_override then
						l_full_file := a_cluster.location.evaluated_directory.extended_path (l_file_path)
						create l_file.make_with_path (l_full_file)
						l_file.open_read
						if not l_file.is_open_read then
							add_and_raise_error (create {CONF_ERROR_FILE}.make (l_full_file.name))
						else
								-- get class name
							l_classname_finder := classname_finder
							l_classname_finder.parse (l_file)
							l_file.close
							if not attached l_classname_finder.classname as n then
								add_and_raise_error (create {CONF_ERROR_CLASSN}.make (a_file, a_cluster.target.system.file_name))
							elseif n.is_case_insensitive_equal ("NONE") then
								add_and_raise_error (create {CONF_ERROR_CLASSNONE}.make (a_file, a_cluster.target.system.file_name))
							else
								l_name := {UTF_CONVERTER}.utf_8_string_8_to_escaped_string_32 (n)
								l_name.to_upper
								if l_classname_finder.is_partial_class then
										-- partial classes	
									p := partial_classes
									if not attached p then
										create p.make (1)
										partial_classes := p
									end
									l_pc := p.item (l_name)
									if l_pc = Void then
										create l_pc.make (1)
									end
									l_pc.extend (l_full_file.name)
									p.force (l_pc, l_name)
								else
										-- normal classes
									l_class := factory.new_class (a_file, a_cluster, a_path, l_name)
									if attached l_class.last_error as l_class_error then
										add_and_raise_error (l_class_error)
									end
									added_classes.force (l_class)
									if attached l_current_classes.item (l_name) as c then
										add_error (create {CONF_ERROR_CLASSDBL}.make (l_name, c.full_file_name.name,
											l_class.full_file_name.name, a_cluster.target.system.file_name))
									else
										l_current_classes.force (l_class, l_name)
										current_classes_by_filename.force (l_class, l_file_path)
									end
								end
							end
						end
					else
						l_name := a_file.as_upper
							-- Removes the .e extension
						l_name.keep_head (a_file.count - 2)
						if l_name.is_case_insensitive_equal ("NONE") then
							add_and_raise_error (create {CONF_ERROR_CLASSNONE}.make (a_file, a_cluster.target.system.file_name))
						else
							l_class := factory.new_class (a_file, a_cluster, a_path, l_name)
							if attached l_class.last_error as l_class_error then
								add_and_raise_error (l_class_error)
							end
							added_classes.force (l_class)
							if attached l_current_classes.item (l_name) as l_found_class then
								add_error (create {CONF_ERROR_CLASSDBL}.make (l_name, l_found_class.full_file_name.name,
									l_class.full_file_name.name, a_cluster.target.system.file_name))
							else
								l_current_classes.force (l_class, l_name)
								current_classes_by_filename.force (l_class, l_file_path)
							end
						end
					end
				end
					-- Check if classname matches filename
				if
					(l_class /= Void and then l_class.options.is_warning_enabled (w_classname_filename_mismatch) or else
					application_target.options.is_warning_enabled (w_classname_filename_mismatch)) and then
						-- l_name is set by all execution paths since the ones where it is not set raise an error.
						-- Check file name against class name
					not a_file.substring (1, a_file.count - 1 - eiffel_file_extension.count).is_case_insensitive_equal_general (l_name)
				then
						-- We propose the correct file name. The file name construction follows the same schema as above
					create l_suggested_filename.make (25)
					l_suggested_filename.append_string (a_cluster.location.evaluated_directory.name)
					l_suggested_filename.append_string ({STRING_32} "/" + a_path + "/" + l_name.as_lower + "." + eiffel_file_extension)
					if l_full_file = Void then
						l_full_file := a_cluster.location.evaluated_directory.extended_path (l_file_path)
					end
					add_warning (create {CONF_ERROR_FILENAME}.make (l_full_file.name, l_name, l_suggested_filename))
				end
			end
		ensure then
				--FIXME, at the moment this doesn't cover clusters with partial classes completely
			added: not is_error implies (valid_eiffel_extension (a_file)
				implies (attached current_classes as c and then c.count = old (if attached current_classes as o then o.count else 0 end) + 1) or partial_classes /= Void)
		end

	merge_classes (a_group: CONF_GROUP)
			-- Merge the classes of `a_group' into `current_classes'.
		require
			current_classes_not_void: current_classes /= Void
			a_group_not_void: a_group /= Void
		do
			if
				attached current_classes as c and then
				attached a_group.classes as g_classes
			then
				c.merge (g_classes)
			end
		end

	process_removed (a_groups: detachable STRING_TABLE [CONF_GROUP])
			-- Add the classes that have been removed to `removed_classes'
		local
			l_done: BOOLEAN
		do
			if a_groups /= Void then
				across
					a_groups as g
				loop
					l_done := False
					if attached g as l_group then
						check
							not_assembly: not l_group.is_assembly
						end
							-- check if the group has already been handled
						if handled_groups.has (l_group) then
							l_done := True
						else
								-- if we rebuild, groups themselves aren't reused
							l_group.invalidate
						end

							-- check if it's a library that still is used and therefore is alredy done
							-- (needed if the same library is used multiple times)
						if
							not l_done and then
							attached {CONF_LIBRARY} l_group as l_library and then
								-- although the classes are still there, we have to recheck all clients
								-- of this class in `current_system' because they no longer
								-- have access to those classes.
							attached l_library.library_target as l_library_target and then
							attached all_libraries as ls and then
							ls.has (l_library_target.system.uuid)
						then
							l_done := True
							if attached l_library.classes as l_classes then
								check classes_set: l_library.classes_set end
								across
									l_classes as c
								loop
									if c.is_compiled then
										partly_removed_classes.force ([c, current_system])
									end
								end
							end
						end

						if not l_done and then l_group.classes_set then
							process_removed_classes (l_group.classes)
						end
					end
				end
			end
		end

	process_removed_classes (a_classes: detachable STRING_TABLE [CONF_CLASS])
			-- Add compiled classes from `a_classes' that are not in `reused_classes' to `removed_classes'.
		local
			l_cl: CONF_CLASS
			l_cl_over: CONF_CLASS
			l_file: RAW_FILE
		do
			if a_classes /= Void then
				across
					a_classes as c
				loop
					l_cl := c
						-- only if the class realy has been removed
					if not reused_classes.has (l_cl) then
							-- remove partial class files
						if attached {CONF_CLASS_PARTIAL} l_cl as l_partial then
							create l_file.make_with_path (l_partial.full_file_name)
							if l_file.exists then
								l_file.delete
							end
						end
							-- for override classes, mark the classes that used to be overriden as modified
						if attached l_cl.overrides as l_overrides then
							removed_classes_from_override.force (l_cl)
							across
								l_overrides as o
							loop
								l_cl_over := o
								if l_cl_over.is_compiled and then l_cl_over.is_valid then
									modified_classes.force (l_cl_over)
								end
							end
						end

						l_cl.invalidate
						if l_cl.is_compiled then
							removed_classes.force (l_cl)
						end
					end
				end
			end
		end

	process_with_old (a_new_groups: STRING_TABLE [CONF_GROUP]; an_old_groups: detachable STRING_TABLE [CONF_GROUP])
			-- Process `a_new_groups' and set `old_group' to the corresponding group of `an_old_groups'.
		require
			old_group_void: old_group = Void
		local
			l_group: CONF_GROUP
			l_old_group: detachable like old_group
		do
			across
				a_new_groups as g
			loop
				l_group := g
				if l_group.is_enabled (state) then
						-- Look for a group in old groups with the same name
						-- this should work in most situations, in the rest of
						-- the situations we don't find the old classes and have
						-- to start with them from scratch, but it works anyway.
					if an_old_groups /= Void then
						l_old_group := an_old_groups.item (l_group.name)
						if l_old_group /= Void then
							if l_old_group.classes /= Void then
								handled_groups.force (l_old_group)
								if l_old_group = l_group then
									old_group := l_old_group.twin
								else
									l_old_group.invalidate
									old_group := l_old_group
								end
							else
								old_group := Void
							end
						end
					end
					l_group.process (Current)
					old_group := Void
				end
			end
		ensure
			old_group_void: old_group = Void
		end

	process_partial_classes
			-- Process `partial_classes'.
		require
			partial_location_not_void: partial_location /= Void
			partial_classes_not_void: partial_classes /= Void
			current_classes_not_void: current_classes /= Void
			current_cluster_not_void: current_cluster /= Void
		local
			l_class: detachable CONF_CLASS_PARTIAL
			l_name: READABLE_STRING_32
			l_old_group_classes: like old_group.classes
		do
			if
				attached partial_classes as l_partial_classes and then
				attached current_cluster as l_current_cluster and then
				attached current_classes as l_current_classes
			then
				across
					l_partial_classes as ic
				loop
					l_class := Void
					l_name := @ ic.key
						-- try to get it from the old cluster
					if attached old_group as l_old_group then
						l_old_group_classes := l_old_group.classes
						if
							l_old_group_classes /= Void and then
							attached {CONF_CLASS_PARTIAL} l_old_group_classes.item (l_name) as l_class_partial
						then
							l_class := l_class_partial
							l_old_group_classes.remove (l_name)
						else
							l_class := Void
						end
					end
					if l_class /= Void then
						l_class.rebuild_partial (ic, l_current_cluster, partial_location)
						if attached l_class.last_error as l_class_error then
							add_and_raise_error (l_class_error)
						else
							check has_no_error: not l_class.is_error end
						end
						if l_class.is_compiled and l_class.is_modified then
							modified_classes.force (l_class)
						elseif l_class.is_always_compile then
							added_classes.force (l_class)
						end
					else
						l_class := factory.new_class_partial (ic, l_current_cluster, partial_location)
						if attached l_class.last_error as l_class_error then
							add_and_raise_error (l_class_error)
						else
							if l_class.is_always_compile then
								added_classes.force (l_class)
							end
						end
					end
					l_current_classes.force (l_class, l_class.name)
				end
			else
				check precondition__partial_classes_not_void: False end
			end
		ensure
			classes_added: not is_error implies attached current_classes as c and then c.count = if attached partial_classes as p then p.count else 0 end + old if attached current_classes as o then o.count else 0 end
		end

feature {NONE} -- contracts

	libraries_intersection (a, b: detachable like libraries): BOOLEAN
			-- Is there an intersection between `a' and `b'?
		local
			l1, l2: like libraries
		do
			if a /= Void and b /= Void then
				if a.count >= b.count then
					l1 := a
					l2 := b
				else
					l1 := b
					l2 := a
				end
				check
					l1_not_less_than_l2: l1.count >= l2.count
				end

				from
					l1.start
				until
					l1.after or Result
				loop
					Result := l2.has (l1.key_for_iteration)
					l1.forth
				end
			end
		end

feature {NONE} -- Size constants

	classes_per_cluster: INTEGER = 200
			-- How many classes do we have per average cluster.

	classes_per_system: INTEGER = 3000
			-- How many classes do we have per average system.

	groups_per_system: INTEGER = 100
			-- How many groups do we have per average system.

	modified_classes_per_system: INTEGER = 100
			-- How many classes do we have per average system.

	removed_classes_from_override_per_system: INTEGER = 5
			-- How many classes do we have each time they get removed from an override.

	added_classes_per_system: INTEGER = 3000
			-- How many classes do we have per average system.

	removed_classes_per_system: INTEGER = 10
			-- How many classes do we have per average system.

	libraries_per_target: INTEGER = 5
			-- How many libraries do we have per average target.

invariant
	libraries_not_void: libraries /= Void
	reused_classes_not_void: reused_classes /= Void
	modified_classes_not_void: modified_classes /= Void
	added_classes_not_void: added_classes /= Void
	removed_classes_not_void: removed_classes /= Void
	removed_classes_from_override_not_void: removed_classes_from_override /= Void
	application_target_not_void: application_target /= Void
	libraries_no_intersection: not libraries_intersection (libraries, old_libraries)
	factory_not_void: factory /= Void
	last_warnings_not_void: last_warnings /= Void

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
