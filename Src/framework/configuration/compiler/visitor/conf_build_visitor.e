indexing
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
			on_process_directory
		end

create
	make_build,
	make_build_from_old

feature {NONE} -- Initialization

	make_build (a_state: like state; an_application_target: like application_target; a_factory: like factory) is
			-- Create.
		require
			a_state_not_void: a_state /= Void
			an_application_target_not_void: an_application_target /= Void
			a_factory_not_void: a_factory /= Void
		do
			factory := a_factory
			reset_classes
			make (a_state)
			create libraries.make (Libraries_per_target)
			create consume_assembly_observer
			create process_group_observer
			create process_directory
			create last_warnings.make (1)
			application_target := an_application_target
		end

	make_build_from_old (a_state: like state; an_application_target, an_old_target: CONF_TARGET; a_factory: like factory) is
			-- Create.
		require
			a_state_not_void: a_state /= Void
			an_application_target_not_void: an_application_target /= Void
			an_old_target_not_void: an_old_target /= Void
			a_factory_not_void: a_factory /= Void
		do
			factory := a_factory
			reset_classes
			make_build (a_state, an_application_target, a_factory)
			old_target := an_old_target
		end

feature -- Access

	modified_classes: DS_HASH_SET [CONF_CLASS]
			-- The list of modified classes.

	added_classes: DS_HASH_SET [CONF_CLASS]
			-- The list of added classes.

	removed_classes: DS_HASH_SET [CONF_CLASS]
			-- The list of removed classes.

	removed_classes_from_override: DS_HASH_SET [CONF_CLASS]
			-- The list of removed classes from override clusters.

	partly_removed_classes: ARRAYED_LIST [EQUALITY_TUPLE [TUPLE [conf_class: CONF_CLASS; system: CONF_SYSTEM]]]
			-- The list of classes that have been removed from a certain system only.
			-- (if a library that is still used somewhere else has been removed)

	new_assemblies: DS_HASH_SET [CONF_ASSEMBLY]
			-- List of assemblies in the current configuration.

feature -- Update

	set_assembly_cach_folder (a_location: STRING) is
			-- Set `assembly_cache_folder'.
		require
			a_location_not_void: a_location /= Void
		do
			assembly_cache_folder := create {FILE_NAME}.make_from_string (a_location)
		end

	set_il_version (a_version: like il_version) is
			-- Set `il_version'.
			-- If `a_version' is `Void', use the latest version.
		do
			il_version := a_version
		end

	set_partial_location (a_location: like partial_location) is
			-- Set `partial_location'.
		require
			a_location_not_void: a_location /= Void
		do
			partial_location := a_location
		end

	reset_classes is
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

	consume_assembly_observer: ACTION_SEQUENCE [TUPLE []]
			-- Observer if assemblies are consumed.

	process_group_observer: ACTION_SEQUENCE [TUPLE [CONF_GROUP]]
			-- Observer if a group is processed.

	process_directory: ACTION_SEQUENCE [TUPLE [CONF_CLUSTER, STRING]]
			-- Observer if a cluster directory is processed.

feature -- Events

	on_process_group (a_group: CONF_GROUP) is
			-- `A_group' is processed.
		require
			a_group_not_void: a_group /= Void
		do
			process_group_observer.call ([a_group])
		end

	on_process_directory (a_cluster: CONF_CLUSTER; a_path: STRING) is
			-- (Sub)directory `a_path' of `a_cluster' is processed.
		do
			process_directory.call ([a_cluster, a_path])
		end

feature -- Visit nodes

	process_target (a_target: CONF_TARGET) is
			-- Visit `a_target'.
		local
			l_libraries, l_clusters, l_overrides, l_assemblies: HASH_TABLE [CONF_GROUP, STRING]
			l_pre, l_old_pre: CONF_PRECOMPILE
			l_old_group: CONF_GROUP
			l_consumer_manager: CONF_CONSUMER_MANAGER
			l_old_assemblies: HASH_TABLE [CONF_PHYSICAL_ASSEMBLY_INTERFACE, STRING]
			l_retried: BOOLEAN
			l_error_count: INTEGER
		do
			if not l_retried then
				if last_errors /= Void then
					l_error_count := last_errors.count
				end
				current_system := a_target.system

				if old_target /= Void then
					a_target.set_environ_variables (old_target.environ_variables)
					l_libraries := old_target.libraries
					l_clusters := old_target.clusters
					l_overrides := old_target.overrides
					l_assemblies := old_target.assemblies
						-- if it's the application target, set the old_libraries
						-- twin, so that we can remove the libraries we have handled without
						-- modifying the old data which is still needed in case of an error
					if a_target = application_target then
						old_libraries := old_target.system.all_libraries.twin
					end
				end

				if a_target = application_target then
					all_libraries := a_target.system.all_libraries
				end

					-- if it is the library or application target, add the target to the libraries
				if a_target = a_target.system.library_target or a_target = application_target then
					libraries.force (a_target, a_target.system.uuid)
					if old_libraries /= Void then
						old_libraries.remove (a_target.system.uuid)
					end
				end

					-- process clusters first, because we need those information while processing libraries if we have circular dependencies
				process_with_old (a_target.clusters, l_clusters)

				l_pre := a_target.precompile
				if l_pre /= Void and then l_pre.is_enabled (state) then
					if old_target /= Void then
						l_old_pre := old_target.precompile
						old_group := l_old_pre
					end
						-- did any configuration in the precompile change? => error
					if
						l_old_pre = Void or else not l_old_pre.is_enabled (state) or else
						l_pre.library_target = Void or else l_old_pre.library_target = Void or else
						not l_pre.library_target.is_deep_group_equivalent (l_old_pre.library_target, create {SEARCH_TABLE [UUID]}.make (20))
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
						if old_target /= Void then
							l_old_assemblies := old_target.system.all_assemblies.twin
						end
						create l_consumer_manager.make (factory, assembly_cache_folder, il_version, application_target, added_classes, removed_classes, modified_classes)
						l_consumer_manager.consume_assembly_observer.append (consume_assembly_observer)
						l_consumer_manager.build_assemblies (new_assemblies, l_old_assemblies)
						if l_consumer_manager.is_error then
							add_and_raise_error (l_consumer_manager.last_error)
						else
							a_target.system.set_all_assemblies (l_consumer_manager.assemblies)

								-- only assemblies that have not been reused remain in `old_assemblies'
							if l_old_assemblies /= Void then
								from
									l_old_assemblies.start
								until
									l_old_assemblies.after
								loop
									l_old_group := l_old_assemblies.item_for_iteration
									l_old_group.invalidate
									process_removed_classes (l_old_group.classes)
									l_old_assemblies.forth
								end
							end
						end
					else
						a_target.system.set_all_assemblies (create {HASH_TABLE [CONF_PHYSICAL_ASSEMBLY, STRING]}.make (0))
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
			if last_errors /= Void and then last_errors.count /= l_error_count then
				l_retried := True
				retry
			end
		end

	process_assembly (an_assembly: CONF_ASSEMBLY) is
			-- Visit `an_assembly'.
		local
			l_file: RAW_FILE
			l_old_assembly: CONF_ASSEMBLY
			l_classes: HASH_TABLE [CONF_CLASS, STRING]
			l_cl: CONF_CLASS
		do
			l_old_assembly ?= old_group
			check
				old_group_implies_assembly: old_group /= Void implies l_old_assembly /= Void
			end

				-- if it is a local assembly, check that the file exists
			if state.is_dotnet and then not an_assembly.is_non_local_assembly then
				create l_file.make (an_assembly.location.evaluated_path)
				if not l_file.exists or else not l_file.is_readable then
					add_and_raise_error (create {CONF_ERROR_FILE}.make_with_config (an_assembly.location.evaluated_path, an_assembly.location.original_path, current_system.file_name))
				end
			end
			new_assemblies.force (an_assembly)

				-- if the renaming/prefix changed, mark classes as partly removed
			if l_old_assembly /= Void and then not (equal (l_old_assembly.name_prefix, an_assembly.name_prefix) and equal (l_old_assembly.renaming, an_assembly.renaming)) then
				from
					l_classes := l_old_assembly.classes
					l_classes.start
				until
					l_classes.after
				loop
					l_cl := l_classes.item_for_iteration
					if l_cl.is_compiled then
						partly_removed_classes.force ([l_cl, current_system])
					end
					l_classes.forth
				end
			end
		end

	process_library (a_library: CONF_LIBRARY) is
			-- Visit `a_library'.
		local
			l_target: CONF_TARGET
			l_uuid: UUID
			l_vis: like Current
			l_ren: EQUALITY_HASH_TABLE [STRING, STRING]
			l_prefixed_classes: like current_classes
			l_pre: STRING
			l_old_library: CONF_LIBRARY
			l_cl: CONF_CLASS
			l_current_classes: like current_classes
			l_partly_removed_classes: like partly_removed_classes
			l_current_system: CONF_SYSTEM
		do
			on_process_group (a_library)
			l_old_library ?= old_group

			check
				old_group_implies_old_library: old_group /= Void implies l_old_library /= Void
			end
			l_uuid := a_library.library_target.system.uuid
			l_target := a_library.library_target
			check
				library_target_set: l_target /= Void
				uuid_set: l_uuid /= Void
			end
			if not libraries.has (l_uuid) then
					-- get and initialize visitor
				l_vis := twin
				l_vis.reset
				if old_libraries /= Void and then old_libraries.has_key (l_uuid) then
					l_vis.set_old_target (old_libraries.found_item)
					old_libraries.remove (l_uuid)
				end
				libraries.force (l_target, l_uuid)
				l_target.process (l_vis)
				if l_vis.is_error then
					last_errors := l_vis.last_errors
					raise_error
				end
			end

			create current_classes.make (Classes_per_cluster)

			l_current_classes := current_classes
			l_partly_removed_classes := partly_removed_classes

			l_current_system := current_system

			l_target.clusters.linear_representation.do_if (agent merge_classes ({CONF_CLUSTER} ?), agent (a_cluster: CONF_CLUSTER): BOOLEAN
				do
					Result := a_cluster.classes_set and then not a_cluster.is_hidden
				end
			)

				-- if the renaming/prefix changed we have to add the classes to the partly_removed_classes list
			if l_old_library /= Void and then not (equal (l_old_library.name_prefix, a_library.name_prefix) and equal (l_old_library.renaming, a_library.renaming)) then
				from
					l_current_classes.start
				until
					l_current_classes.after
				loop
					l_cl := l_current_classes.item_for_iteration
					if l_cl.is_compiled then
						l_partly_removed_classes.force ([l_cl, l_current_system])
					end
					l_current_classes.forth
				end
			end

				-- do renaming prefixing if necessary
			l_ren := a_library.renaming
			if l_ren /= Void then
				from
					l_ren.start
				until
					l_ren.after
				loop
					l_current_classes.replace_key (l_ren.item_for_iteration, l_ren.key_for_iteration)
					l_ren.forth
				end
			end
			l_pre := a_library.name_prefix
			if l_pre /= Void and then not l_pre.is_empty then
				create l_prefixed_classes.make (l_current_classes.count)
				from
					l_current_classes.start
				until
					l_current_classes.after
				loop
					l_prefixed_classes.put (current_classes.item_for_iteration, l_pre+l_current_classes.key_for_iteration)
					l_current_classes.forth
				end
				a_library.set_classes (l_prefixed_classes)
			else
				a_library.set_classes (l_current_classes)
			end

				-- update visibility
			a_library.update_visible (added_classes)
			if a_library.is_error then
				add_error (a_library.last_error)
				a_library.reset_error
				raise_error
			end
			if a_library.last_warnings /= Void then
				last_warnings.append (a_library.last_warnings)
			end

			current_classes := Void
		ensure then
			current_classes_void: current_classes = Void
			classes_set: not is_error implies a_library.classes_set
		end

	process_cluster (a_cluster: CONF_CLUSTER) is
			-- Visit `a_cluster'.
		local
			l_old_cluster: CONF_CLUSTER
			l_class: CONF_CLASS
			l_current_classes: like current_classes
			l_modified_classes: like modified_classes
		do
			on_process_group (a_cluster)
			a_cluster.wipe_class_cache
			current_cluster := a_cluster
			create current_classes.make (Classes_per_cluster)
			l_current_classes := current_classes

			l_modified_classes := modified_classes

			create current_classes_by_filename.make (Classes_per_cluster)
			a_cluster.set_classes (l_current_classes)
			a_cluster.set_classes_by_filename (current_classes_by_filename)

			process_cluster_recursive ("", a_cluster, a_cluster.active_file_rule (state))

			if partial_classes /= Void then
				process_partial_classes
				partial_classes := Void
			end

				-- if the mapping changed, mark everything in the cluster as modified
			l_old_cluster ?= old_group
			if l_old_cluster /= Void and then not l_old_cluster.mapping.is_equal (a_cluster.mapping) then
				from
					l_current_classes.start
				until
					l_current_classes.after
				loop
					l_class := l_current_classes.item_for_iteration
					if l_class.is_compiled then
						l_modified_classes.force (l_class)
					end
					l_current_classes.forth
				end
			end

				-- cluster itself has been handled
			handled_groups.force (a_cluster)

				-- process removed classes
			if old_group /= Void then
				handled_groups.force (old_group)
				process_removed_classes (old_group.classes)
			end

				-- update visibility
			a_cluster.update_visible (added_classes)
			if a_cluster.is_error then
				add_error (a_cluster.last_error)
				a_cluster.reset_error
				raise_error
			end
			if a_cluster.last_warnings /= Void then
				last_warnings.append (a_cluster.last_warnings)
			end

			current_classes := Void
		ensure then
			current_classes_void: current_classes = Void
			classes_set: not is_error implies a_cluster.classes_set
		end

	process_override (an_override: CONF_OVERRIDE) is
			-- Visit `an_override'.
		local
			l_groups: ARRAYED_LIST [CONF_GROUP]
			l_overridee: CONF_GROUP
		do
			process_cluster (an_override)
			if an_override.override = Void then
				create l_groups.make (application_target.libraries.count + application_target.clusters.count)
				l_groups.merge_right (application_target.libraries.linear_representation)
				l_groups.merge_right (application_target.clusters.linear_representation)
			else
				l_groups := an_override.override
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
					if l_overridee.is_error then
						add_error (l_overridee.last_error)
						l_overridee.reset_error
						raise_error
					end
				end

				l_groups.forth
			end
		ensure then
			classes_set: not is_error implies an_override.classes_set
		end

feature {CONF_BUILD_VISITOR} -- Implementation, needed for get_visitor

	reset is
			-- Reset the values for the new visitor.
		do
			current_classes := Void
			current_cluster := Void
			current_system := Void
			old_group := Void
			old_target := Void
			partial_classes := Void
			create reused_classes.make (classes_per_system)
			create handled_groups.make (groups_per_system)
		end

	set_old_target (a_target: like old_target) is
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

	assembly_cache_folder: PATH_NAME
			-- Assembly cache folder.

	il_version: STRING
			-- Version of il to use. (If not set, use latest)

	application_target: CONF_TARGET
			-- The application target of the system.

	libraries: HASH_TABLE [CONF_TARGET, UUID]
			-- Mapping of processed library targets, mapped with their uuid.

	all_libraries: HASH_TABLE [CONF_TARGET, UUID]
			-- Mapping of all library targets (processed and unprocessed) that are in the new target, mapped with their uuid.

	old_libraries: HASH_TABLE [CONF_TARGET, UUID]
			-- Mapping of processed library targets of the old target, mapped with their uuid.

	current_classes: HASH_TABLE [CONF_CLASS, STRING]
			-- The classes of the group we are currently processing.

	current_classes_by_filename: HASH_TABLE [CONF_CLASS, STRING]
			-- Classes of the group we are currently processing indexed by filename.

	current_cluster: CONF_CLUSTER
			-- The cluster we are currently processing.

	current_system: CONF_SYSTEM
			-- The system we are currently processing.

	old_target: CONF_TARGET
			-- The old target that corresponds to the current target.

	old_group: CONF_GROUP
			-- The old group that corresponds to `current_group'.

	partial_classes: HASH_TABLE [ARRAYED_LIST [STRING], STRING]
			-- The partial classes in the current string mapped to their class name.

	partial_location: CONF_DIRECTORY_LOCATION
			-- Location where the merged partial classes will be stored (normally somewhere inside eifgen)

	handle_class (a_file, a_path: STRING; a_cluster: CONF_CLUSTER) is
			-- Put the class in `a_path' `a_file' into `current_classes'.
		local
			l_file: KL_BINARY_INPUT_FILE
			l_class: CONF_CLASS
			l_name: STRING
			l_full_file: STRING
			l_pc: ARRAYED_LIST [STRING]
			l_file_name: STRING
			l_done: BOOLEAN
			l_suggested_filename: STRING
			l_current_classes: like current_classes
			l_old_group: like old_group
			l_old_group_classes_by_filename: HASH_TABLE [CONF_CLASS, STRING_8]
			l_classname_finder: like classname_finder
		do
			l_current_classes := current_classes
			l_old_group := old_group
			if l_old_group /= Void then
				l_old_group_classes_by_filename := l_old_group.classes_by_filename
			end
			l_classname_finder := classname_finder
			check
				current_classes_not_void: l_current_classes /= Void
				old_group_classes_set: l_old_group /= Void implies l_old_group.classes_set
			end
			if valid_eiffel_extension (a_file) then
				create l_file_name.make (a_path.count + 1 + a_file.count)
				l_file_name.append (a_path)
				l_file_name.append (once "/")
				l_file_name.append (a_file)
					-- try to get it directly from old_group by filename
				if
					l_old_group /= Void and then l_old_group_classes_by_filename.has_key (l_file_name)
				then
					l_class := l_old_group_classes_by_filename.found_item
						-- update class
					l_class.rebuild (a_file, a_cluster, a_path)
					if l_class.is_error then
						add_and_raise_error (l_class.last_error)
						-- don't update renamed classes, instead handle them on the class name basis
					elseif not l_class.is_renamed then
						l_name := l_class.name
						if l_class.is_compiled and l_class.is_modified then
							modified_classes.force (l_class)
						end
							-- add it to `reused_classes'
						reused_classes.force (l_class)
						if l_current_classes.has_key (l_name) then
							add_error (create {CONF_ERROR_CLASSDBL}.make (l_name, l_current_classes.found_item.full_file_name, l_class.full_file_name, a_cluster.target.system.file_name))
						else
							l_current_classes.force (l_class, l_name)
							current_classes_by_filename.force (l_class, l_file_name)
						end
						l_done := True
					end
				end
				if not l_done then
					l_full_file := a_cluster.location.evaluated_directory
					l_full_file.append (l_file_name)
					create l_file.make (l_full_file)
					l_file.open_read
					if not l_file.is_open_read then
						add_and_raise_error (create {CONF_ERROR_FILE}.make (l_full_file))
					else
							-- get class name
						l_classname_finder := classname_finder
						l_classname_finder.parse (l_file)
						l_file.close
						l_name := l_classname_finder.classname
						if l_name = Void then
							add_and_raise_error (create {CONF_ERROR_CLASSN}.make (a_file, a_cluster.target.system.file_name))
						elseif l_name.is_case_insensitive_equal ("NONE") then
							add_and_raise_error (create {CONF_ERROR_CLASSNONE}.make (a_file, a_cluster.target.system.file_name))
						else
							l_name.to_upper

								-- partial classes					
							if l_classname_finder.is_partial_class then
								if partial_classes = Void then
									create partial_classes.make (1)
								end
								l_pc := partial_classes.item (l_name)
								if l_pc = Void then
									create l_pc.make (1)
								end
								l_pc.extend (l_full_file)
								partial_classes.force (l_pc, l_name)
								-- normal classes
							else
									-- not found => new class
								l_class := factory.new_class (a_file, a_cluster, a_path)
								if l_class.is_error then
									add_and_raise_error (l_class.last_error)
								end
								added_classes.force (l_class)
								if l_current_classes.has_key (l_name) then
									add_error (create {CONF_ERROR_CLASSDBL}.make (l_name, l_current_classes.found_item.full_file_name, l_class.full_file_name, a_cluster.target.system.file_name))
								else
									l_current_classes.force (l_class, l_name)
									current_classes_by_filename.force (l_class, l_file_name)
								end
							end
						end
					end
				end
					-- Check if classname matches filename
				if
					(l_class /= Void and then l_class.options.is_warning_enabled (w_classname_filename_mismatch)) or else
					 application_target.options.is_warning_enabled (w_classname_filename_mismatch)
				then
						-- l_name is set by all execution paths since the ones where it is not set raise an error.
					check l_name /= Void end
						-- Check file name against class name
					if not a_file.substring (1, a_file.count - 1 - eiffel_file_extension.count).is_case_insensitive_equal (l_name) then
							-- We propose the correct file name. The file name construction follows the same schema as above
						l_suggested_filename := a_path + "/" + l_name.as_lower + "." + eiffel_file_extension
						if l_full_file /= Void then
							l_suggested_filename := a_cluster.location.evaluated_directory + l_suggested_filename
							add_warning (create {CONF_ERROR_FILENAME}.make (l_full_file, l_name, l_suggested_filename))
						elseif a_path /= Void then
							add_warning (create {CONF_ERROR_FILENAME}.make (l_file_name, l_name, l_suggested_filename))
						else
							add_warning (create {CONF_ERROR_FILENAME}.make (a_file, l_name, l_name.as_lower + "." + eiffel_file_extension))
						end
					end
				end
			end
		ensure then
				--FIXME, at the moment this doesn't cover clusters with partial classes completely
			added: not is_error implies (valid_eiffel_extension (a_file)
				implies (current_classes.count = old current_classes.count + 1) or partial_classes /= Void)
		end

	merge_classes (a_group: CONF_GROUP) is
			-- Merge the classes of `a_group' into `current_classes'.
		require
			current_classes_not_void: current_classes /= Void
			a_group_not_void: a_group /= Void
		do
			current_classes.merge (a_group.classes)
		end

	process_removed (a_groups: HASH_TABLE [CONF_GROUP, STRING]) is
			-- Add the classes that have been removed to `removed_classes'
		local
			l_group: CONF_GROUP
			l_library: CONF_LIBRARY
			l_done: BOOLEAN
		do
			if a_groups /= Void then
				from
					a_groups.start
				until
					a_groups.after
				loop
					l_done := False
					l_group := a_groups.item_for_iteration
					check
						not_assembly: not l_group.is_assembly
					end
					if l_group /= Void then
							-- check if the group has already been handled
						if handled_groups.has (l_group) then
							l_done := True
						else
								-- if we rebuild, groups themselves aren't reused
							l_group.invalidate
						end

							-- check if it's a library that still is used and therefore is alredy done
							-- (needed if the same library is used multiple times)
						if not l_done and then l_group.is_library then
							l_library ?= l_group
							check
								library: l_library /= Void
							end
								-- although the classes are still there, we have to recheck all clients
								-- of this class in `current_system' because they no longer
								-- have access to those classes.
							if l_library.library_target /= Void and then all_libraries.has (l_library.library_target.system.uuid) then
								l_done := True
								if l_library.classes_set then
									l_library.classes.linear_representation.do_if (agent (a_class: CONF_CLASS)
										do
											partly_removed_classes.force ([a_class, current_system])
										end
									, agent {CONF_CLASS}.is_compiled)
								end
							end
						end

						if not l_done and then l_group.classes_set then
							process_removed_classes (l_group.classes)
						end
					end
					a_groups.forth
				end
			end
		end

	process_removed_classes (a_classes: HASH_TABLE [CONF_CLASS, STRING]) is
			-- Add compiled classes from `a_classes' that are not in `reused_classes' to `removed_classes'.
		local
			l_overrides: ARRAYED_LIST [CONF_CLASS]
			l_cl: CONF_CLASS
			l_cl_over: CONF_CLASS
			l_partial: CONF_CLASS_PARTIAL
			l_file: RAW_FILE
		do
			if a_classes /= Void then
				from
					a_classes.start
				until
					a_classes.after
				loop
					l_cl := a_classes.item_for_iteration
						-- only if the class realy has been removed
					if not reused_classes.has (l_cl) then
							-- remove partial class files
						l_partial ?= l_cl
						if l_partial /= Void then
							create l_file.make (l_partial.full_file_name)
							if l_file.exists then
								l_file.delete
							end
						end
							-- for override classes, mark the classes that used to be overriden as modified
						l_overrides := l_cl.overrides
						if l_overrides /= Void then
							removed_classes_from_override.force (l_cl)
							from
								l_overrides.start
							until
								l_overrides.after
							loop
								l_cl_over := l_overrides.item
								if l_cl_over.is_compiled and then l_cl_over.is_valid then
									modified_classes.force (l_cl_over)
								end
								l_overrides.forth
							end
						end

						l_cl.invalidate
						if l_cl.is_compiled then
							removed_classes.force (l_cl)
						end
					end
					a_classes.forth
				end
			end
		end

	process_with_old (a_new_groups, an_old_groups: HASH_TABLE [CONF_GROUP, STRING]) is
			-- Process `a_new_groups' and set `old_group' to the corresponding group of `an_old_groups'.
		require
			old_group_void: old_group = Void
		local
			l_group: CONF_GROUP
			l_old_group: like old_group
		do
			from
				a_new_groups.start
			until
				a_new_groups.after
			loop
				l_group := a_new_groups.item_for_iteration
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
								if l_old_group /= l_group then
									l_old_group.invalidate
									old_group := l_old_group
								else
									old_group := l_old_group.twin
								end
							else
								old_group := Void
							end
						end
					end
					l_group.process (Current)
					old_group := Void
				end

				a_new_groups.forth
			end
		ensure
			old_group_void: old_group = Void
		end

	process_partial_classes is
			-- Process `partial_classes'.
		require
			partial_location_not_void: partial_location /= Void
			partial_classes_not_void: partial_classes /= Void
			current_classes_not_void: current_classes /= Void
			current_cluster_not_void: current_cluster /= Void
		local
			l_class: CONF_CLASS_PARTIAL
			l_name: STRING
		do
			from
				partial_classes.start
			until
				partial_classes.after
			loop
				l_class := Void
				l_name := partial_classes.key_for_iteration
					-- try to get it from the old cluster
				if old_group /= Void and then old_group.classes_set then
					l_class ?= old_group.classes.item (l_name)
				end
				if l_class /= Void then
					old_group.classes.remove (l_name)
					l_class.rebuild_partial (partial_classes.item_for_iteration, current_cluster, partial_location)
					if l_class.is_error then
						add_and_raise_error (l_class.last_error)
					end
					if l_class.is_compiled and l_class.is_modified then
						modified_classes.force (l_class)
					elseif l_class.is_always_compile then
						added_classes.force (l_class)
					end
				else
					l_class := factory.new_class_partial (partial_classes.item_for_iteration, current_cluster, partial_location)
					if l_class.is_error then
						add_and_raise_error (l_class.last_error)
					else
						if l_class.is_always_compile then
							added_classes.force (l_class)
						end
					end
				end
				current_classes.force (l_class, l_class.name)

				partial_classes.forth
			end
		ensure
			classes_added: not is_error implies current_classes.count = old current_classes.count + partial_classes.count
		end

feature {NONE} -- contracts

	libraries_intersection (a, b: like libraries): BOOLEAN is
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

	classes_per_cluster: INTEGER is 200
			-- How many classes do we have per average cluster.

	classes_per_system: INTEGER is 3000
			-- How many classes do we have per average system.

	groups_per_system: INTEGER is 100
			-- How many groups do we have per average system.

	modified_classes_per_system: INTEGER is 100
			-- How many classes do we have per average system.

	removed_classes_from_override_per_system: INTEGER is 5
			-- How many classes do we have each time they get removed from an override.

	added_classes_per_system: INTEGER is 3000
			-- How many classes do we have per average system.

	removed_classes_per_system: INTEGER is 10
			-- How many classes do we have per average system.

	libraries_per_target: INTEGER is 5
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
end
