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
			{NONE} process_system
		redefine
			process_target,
			process_assembly,
			process_library,
			process_cluster,
			process_override,
			process_group
		end

	SHARED_CONF_FACTORY

	SHARED_CLASSNAME_FINDER
		export
			{NONE} all
		end

	CONF_ACCESS


create
	make_build,
	make_build_from_old

feature {NONE} -- Initialization

	make_build (a_platform, a_build: INTEGER; an_application_target: like application_target) is
			-- Create.
		require
			valid_platform: valid_platform (a_platform)
			valid_build: valid_build (a_build)
			an_application_target_not_void: an_application_target /= Void
		do
			reset_classes
			make (a_platform, a_build)
			create libraries.make (Libraries_per_target)
			create assemblies.make (1)
			create old_assemblies_handled.make (1)
			create consume_assembly_observer.make (1)
			create process_group_observer.make (1)
			create process_directory.make (1)
			application_target := an_application_target
		end

	make_build_from_old (a_platform, a_build: INTEGER; an_application_target, an_old_target: CONF_TARGET) is
			-- Create.
		require
			valid_platform: valid_platform (a_platform)
			valid_build: valid_build (a_build)
			an_application_target_not_void: an_application_target /= Void
			an_old_target_not_void: an_old_target /= Void
		do
			reset_classes
			make_build (a_platform, a_build, an_application_target)
			old_target := an_old_target
		end

feature -- Status

	is_assembly_cache_folder_set: BOOLEAN is
			-- Has `assembly_cache_folder' been set?
		do
			Result := assembly_cache_folder /= Void
		end

feature -- Access

	modified_classes: DS_HASH_SET [CONF_CLASS]
			-- The list of modified classes.

	added_classes: DS_HASH_SET [CONF_CLASS]
			-- The list of added classes.

	removed_classes: DS_HASH_SET [CONF_CLASS]
			-- The list of removed classes.

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
			-- Reset `modified_classes', `added_classes' and `removed_classes'.
		do
			reset
			create modified_classes.make (modified_classes_per_system)
			create added_classes.make (added_classes_per_system)
			create removed_classes.make (removed_classes_per_system)
		end

feature -- Observers

	consume_assembly_observer: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [CONF_TARGET]]]
			-- Observer if assemblies are consumed.

	process_group_observer: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [CONF_GROUP]]]
			-- Observer if a group is processed.

	process_directory: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [CONF_CLUSTER, STRING]]]
			-- Observer if a cluster directory is processed.

feature -- Events

	on_consume_assemblies (a_target: CONF_TARGET) is
			-- Assemblies of `a_target' are consumed.
		require
			a_target_not_void: a_target /= Void
		do
			from
				consume_assembly_observer.start
			until
				consume_assembly_observer.after
			loop
				consume_assembly_observer.item.call ([a_target])
				consume_assembly_observer.forth
			end
		end

	on_process_group (a_group: CONF_GROUP) is
			-- `A_group' is processed.
		require
			a_group_not_void: a_group /= Void
		do
			from
				process_group_observer.start
			until
				process_group_observer.after
			loop
				process_group_observer.item.call ([a_group])
				process_group_observer.forth
			end
		end

	on_process_directory (a_cluster: CONF_CLUSTER; a_path: STRING) is
			-- (Sub)directory `a_path' of `a_cluster' is processed.
		require
			a_cluster_not_void: a_cluster /= Void
			a_path_not_void: a_path /= Void
		do
			from
				process_directory.start
			until
				process_directory.after
			loop
				process_directory.item.call ([a_cluster, a_path])
				process_directory.forth
			end
		end



feature -- Visit nodes

	process_target (a_target: CONF_TARGET) is
			-- Visit `a_target'.
		local
			l_assemblies, l_libraries, l_clusters, l_overrides: HASH_TABLE [CONF_GROUP, STRING]
			l_pre, l_old_pre: CONF_PRECOMPILE
			l_old_group: CONF_GROUP
		do
			if not is_error then
					-- set application target
				a_target.system.set_application_target (application_target)

				if old_target /= Void then
					a_target.set_environ_variables (old_target.environ_variables)
					l_assemblies := old_target.assemblies
					l_libraries := old_target.libraries
					l_clusters := old_target.clusters
					l_overrides := old_target.overrides
					l_old_pre := old_target.precompile
						-- if it's the application target, set the old_libraries and old_assemblies
						-- twin, so that we can remove the libraries/assemblies we have handled without
						-- modifying the old data which is still needed in case of an error
					if a_target = application_target then
						old_libraries := old_target.all_libraries.twin
						old_assemblies := old_target.all_assemblies.twin
					end
				end
					-- add the target to the libraries
				libraries.force (a_target, a_target.system.uuid)
				if old_libraries /= Void then
					old_libraries.remove (a_target.system.uuid)
				end

				l_pre := a_target.precompile
				if l_pre /= Void then
					process_library (l_pre)
				end

				if not a_target.assemblies.is_empty and platform = pf_dotnet then
					consume_assemblies (a_target)
					process_with_old (a_target.assemblies, Void)
				end

				if not is_error then
						-- do libraries after assemblies, so that the assemblies is already filled with the assemblies defined in the application configuration itself
					process_with_old (a_target.libraries, Void)
					process_with_old (a_target.clusters, l_clusters)
						-- must be done at the end
					process_with_old (a_target.overrides, l_overrides)


						-- must be done one time per system after everything is processed
					if a_target = application_target then
						handle_assembly_dependencies
							-- only assemblies that have not been reused remain in `old_assemblies'
						if old_assemblies /= Void then
							from
								old_assemblies.start
							until
								old_assemblies.after
							loop
								l_old_group := old_assemblies.item_for_iteration
								l_old_group.invalidate
								process_removed_classes (l_old_group.classes)
								old_assemblies.forth
							end
						end
					end

						-- add the classes that are still in `old_target' to `removed_classes'
							-- needed for libraries that have been removed
							-- changes in libraries itself have already been handled
					process_removed (l_libraries)

						-- assemblies are already handled
					process_removed (l_clusters)
					process_removed (l_overrides)

						-- set all libraries, all assemblies
					a_target.set_all_libraries (libraries)
					a_target.set_all_assemblies (assemblies)
				end
			end
		ensure then
			all_libraries_set: not is_error implies a_target.all_libraries /= Void
			all_assemblies_set: not is_error implies a_target.all_assemblies /= Void
		end

	process_group (a_group: CONF_GROUP) is
			-- Visit `a_group'.
		do
			on_process_group (a_group)
		end

	process_assembly (an_assembly: CONF_ASSEMBLY) is
			-- Visit `an_assembly'.
		do
			if platform /= pf_dotnet then
				add_error (create {CONF_ERROR_DOTNET})
			end
			if not is_error then
				check
					is_assembly_cache_folder_set: is_assembly_cache_folder_set
				end
				current_assembly := an_assembly
				process_assembly_implementation (an_assembly)
					-- dependencies will be handled after all assemblies have been processed
					-- because then we can get the correct assembly if the assembly is also used
					-- directly
			end
		ensure then
			guid_set: not is_error implies an_assembly.guid /= Void
			consumed: not is_error implies an_assembly.consumed_path /= Void and then not an_assembly.consumed_path.is_empty
			classes_set: not is_error implies an_assembly.classes_set
		end

	process_library (a_library: CONF_LIBRARY) is
			-- Visit `a_library'.
		local
			l_target: CONF_TARGET
			l_load: CONF_LOAD
			l_uuid: UUID
			l_vis: like Current
			l_path: STRING
			l_ren: CONF_HASH_TABLE [STRING, STRING]
			l_prefixed_classes: like current_classes
			l_pre: STRING
		do
			if not is_error then
				l_path := a_library.location.evaluated_path
				create l_load
				l_load.retrieve_uuid (l_path)
				if l_load.is_error then
					add_error (l_load.last_error)
				else
					l_uuid := l_load.last_uuid
					l_target := libraries.item (l_uuid)
					if l_target /= Void then
						a_library.set_library_target (l_target)
						a_library.set_uuid (l_uuid)
					else
						l_load.retrieve_configuration (l_path)
						if l_load.is_error then
							add_error (l_load.last_error)
						else
							l_load.last_system.set_application_target (application_target)
							l_target := l_load.last_system.library_target

								-- set environment to our global environment
							l_target.set_environ_variables (application_target.environ_variables)

							if l_target = Void then
								add_error (create {CONF_ERROR_NOLIB}.make (a_library.name))
							else
								check
									uuid_correct: l_uuid.is_equal (l_target.system.uuid)
								end
									-- get and initialize visitor
								l_vis := twin
								l_vis.reset
								if old_libraries /= Void and then old_libraries.has (l_uuid) then
									l_vis.set_old_target (old_libraries.found_item)
									old_libraries.remove (l_uuid)
								end
								libraries.force (l_target, l_uuid)

								l_target.process (l_vis)
								if l_vis.is_error then
									is_error := True
									last_errors := l_vis.last_errors
								else
									a_library.set_library_target (l_target)
									a_library.set_uuid (l_uuid)
								end
							end
						end
					end
					if not is_error then
						create current_classes.make (Classes_per_cluster)
						l_target.clusters.linear_representation.do_if (agent merge_classes ({CONF_CLUSTER} ?), agent {CONF_CLUSTER}.is_enabled (platform, build))
							-- do renaming prefixing if necessary
						l_ren := a_library.renaming
						if l_ren /= Void then
							from
								l_ren.start
							until
								l_ren.after
							loop
								current_classes.replace_key (l_ren.item_for_iteration, l_ren.key_for_iteration)
								l_ren.forth
							end
						end
						l_pre := a_library.name_prefix
						if l_pre /= Void and then not l_pre.is_empty then
							create l_prefixed_classes.make (current_classes.count)
							from
								current_classes.start
							until
								current_classes.after
							loop
								l_prefixed_classes.put (current_classes.item_for_iteration, l_pre+current_classes.key_for_iteration)
								current_classes.forth
							end
							a_library.set_classes (l_prefixed_classes)
						else
							a_library.set_classes (current_classes)
						end
					end
				end
			end
		ensure then
			classes_set: not is_error implies a_library.classes_set
			uuid_set: not is_error implies a_library.uuid /= Void
		end

	process_cluster (a_cluster: CONF_CLUSTER) is
			-- Visit `a_cluster'.
		do
			if not is_error then
				current_cluster := a_cluster
				current_file_rule := a_cluster.file_rule
				create current_classes.make (Classes_per_cluster)
				create current_classes_by_filename.make (Classes_per_cluster)
				process_cluster_recursive ("")

				if partial_classes /= Void then
					process_partial_classes
					partial_classes := Void
				end

					-- process removed classes
				if old_group /= Void then
					process_removed_classes (old_group.classes)
				end

				a_cluster.set_classes (current_classes)
				a_cluster.set_classes_by_filename (current_classes_by_filename)
			end
		ensure then
			classes_set: not is_error implies a_cluster.classes_set
		end

	process_override (an_override: CONF_OVERRIDE) is
			-- Visit `an_override'.
		local
			l_groups: ARRAYED_LIST [CONF_GROUP]
			l_overridee: CONF_GROUP
		do
			process_cluster (an_override)
			if not is_error then
				if an_override.override = Void then
					l_groups := application_target.assemblies.linear_representation
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
					if l_overridee.is_enabled (platform, build) then
						l_overridee.add_overriders (an_override, modified_classes)
						if l_overridee.is_error then
							add_error (l_overridee.last_error)
						end
					end

					l_groups.forth
				end
			end
		ensure then
			classes_set: not is_error implies an_override.classes_set
		end

feature {CONF_BUILD_VISITOR} -- Implementation, needed for get_visitor

	reset is
			-- Reset the values for the new visitor.
		do
			current_assembly := Void
			current_classes := Void
			current_cluster := Void
			current_dotnet_classes := Void
			current_system := Void
			old_assembly := Void
			old_group := Void
			old_target := Void
			partial_classes := Void
			create reused_classes.make (classes_per_system)
			create reused_groups.make (groups_per_system)
		end

	set_old_target (a_target: like old_target) is
			-- Set `old_target' to `a_target'.
		do
			old_target := a_target
		end

feature {NONE} -- Implementation

	reused_classes: SEARCH_TABLE [CONF_CLASS]
			-- List of classes that are reused (and therefore should not be added to `removed_classes').

	reused_groups: SEARCH_TABLE [CONF_GROUP]
			-- List of groups that are reused (and therefore their removed classes have already been handled).

	old_assemblies_handled: SEARCH_TABLE [STRING]
			-- Old assemblies where their removed classes have been handled.

	assembly_cache_folder: PATH_NAME
			-- Assembly cache folder.

	il_version: STRING
			-- Version of il to use. (If not set, use latest)

	application_target: CONF_TARGET
			-- The application target of the system.

	libraries: HASH_TABLE [CONF_TARGET, UUID]
			-- Mapping of processed library targets, mapped with their uuid.

	old_libraries: HASH_TABLE [CONF_TARGET, UUID]
			-- Mapping of processed library targets of the old target, mapped with their uuid.

	assemblies: HASH_TABLE [CONF_ASSEMBLY, STRING]
			-- Mapping of processed assemblies, mapped with their guid.

	old_assemblies: HASH_TABLE [CONF_ASSEMBLY, STRING]
			-- Mapping of processed assemblies of the old target, mapped with their guid.

	current_classes: HASH_TABLE [CONF_CLASS, STRING]
			-- The classes of the group we are currently processing.

	current_classes_by_filename: HASH_TABLE [CONF_CLASS, STRING]
			-- Classes of the group we are currently processing indexed by filename.

	current_dotnet_classes: HASH_TABLE [CONF_CLASS, STRING]
			-- Same as `current_classes' but indexed by dotnet name.

	current_cluster: CONF_CLUSTER
			-- The cluster we are currently processing.

	current_file_rule: CONF_FILE_RULE
			-- File rule of `current_cluster'.

	current_assembly: CONF_ASSEMBLY
			-- The assembly we are currently processing.

	current_system: CONF_SYSTEM
			-- The system we are currently processing.

	old_target: CONF_TARGET
			-- The old target that corresponds to the current target.

	old_group: CONF_GROUP
			-- The old group that corresponds to `current_group'.

	old_assembly: CONF_ASSEMBLY
			-- The old assembly that corresponds to `current_assembly'.

	partial_classes: HASH_TABLE [ARRAYED_LIST [STRING], STRING]
			-- The partial classes in the current string mapped to their class name.

	partial_location: CONF_LOCATION
			-- Location where the merged partial classes will be stored (normally somewhere inside eifgen)

	process_cluster_recursive (a_path: STRING) is
			-- Recursively process `a_path'.
		require
			current_file_rule_not_void: current_file_rule /= Void
			current_cluster_not_void: current_cluster /= Void
			a_path_not_void: a_path /= Void
		local
			l_dir: KL_DIRECTORY
			l_files: ARRAY [STRING]
			l_subdirs: ARRAY [STRING]
			i, cnt: INTEGER
			l_name: STRING
			l_path: STRING
		do
			on_process_directory (current_cluster, a_path)
			l_path := current_cluster.location.build_path (a_path, "")
			create l_dir.make (l_path)

			if not l_dir.is_readable then
				add_error (create {CONF_ERROR_DIR}.make (l_path))
			else
					-- look for classes in directory itself.
				l_files := l_dir.filenames
				if l_files = Void then
					add_error (create {CONF_ERROR_DIR}.make (l_path))
				else
					from
						i := l_files.lower
						cnt := l_files.upper
					until
						i > cnt
					loop
						l_name := l_files.item (i)
						if current_file_rule.is_included (a_path+"/"+l_name) then
							put_class (l_name, a_path)
						end
						i := i + 1
					end

						-- if we check recursive
					if current_cluster.is_recursive then
						l_subdirs := l_dir.directory_names
						from
							i := 1
							cnt := l_subdirs.count
						until
							i > cnt
						loop
							l_name := l_subdirs.item (i)
							if current_file_rule.is_included (a_path+"/"+l_name) then
								process_cluster_recursive (a_path+"/"+l_name)
							end
							i := i +1
						end
					end
				end
			end
		end

	put_class (a_file, a_path: STRING) is
			-- Put the class in `a_path' `a_file' into `current_classes'.
		require
			current_classes_not_void: current_classes /= Void
			old_group_classes_set: old_group /= Void implies old_group.classes_set
		local
			l_file: KL_BINARY_INPUT_FILE
			l_class: CONF_CLASS
			l_name, l_tmp: STRING
			l_full_file: STRING
			l_pc: ARRAYED_LIST [STRING]
			l_renamings: HASH_TABLE [STRING, STRING]
			l_file_name: STRING
		do
			if valid_eiffel_extension (a_file) then
				l_file_name := a_path+"/"+a_file
					-- try to get it directly from old_group by filename
				if old_group /= Void and then old_group.classes_by_filename.has (l_file_name) then
					l_class := old_group.classes_by_filename.found_item
						-- update class
					l_class.rebuild (a_file, current_cluster, a_path)
					if l_class.is_error then
						add_error (l_class.last_error)
					end
					l_name := l_class.renamed_name
					if l_class.is_compiled and l_class.is_modified then
						modified_classes.force (l_class)
					end
						-- add it to `reused_classes'
					reused_classes.force (l_class)
					if current_classes.has (l_name) then
						add_error (create {CONF_ERROR_CLASSDBL}.make (l_name))
					else
						current_classes.force (l_class, l_name)
						current_classes_by_filename.force (l_class, l_file_name)
					end
				else
					l_full_file := current_cluster.location.evaluated_directory
					l_full_file.append (l_file_name)
					create l_file.make (l_full_file)
					l_file.open_read
					if not l_file.is_open_read then
						add_error (create {CONF_ERROR_FILE}.make (l_full_file))
					else
							-- get class name
						classname_finder.parse (l_file)
						l_file.close
						l_tmp := classname_finder.classname
						if l_tmp = Void then
							add_error (create {CONF_ERROR_CLASSN}.make (a_file))
						elseif l_tmp.is_case_insensitive_equal ("NONE") then
							add_error (create {CONF_ERROR_CLASSNONE}.make (a_file))
						else
							l_tmp.to_upper
							l_renamings := current_cluster.renaming
							if l_renamings /= Void then
								l_name := l_renamings.item (l_tmp)
							else
								l_name := l_tmp.twin
							end
							if current_cluster.name_prefix /= Void then
								l_name.prepend (current_cluster.name_prefix)
							end

								-- partial classes					
							if classname_finder.is_partial_class then
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
								if old_group /= Void then
									l_class := old_group.classes.item (l_name)
								end
								if l_class /= Void then
										-- update class
									l_class.rebuild (a_file, current_cluster, a_path)
									if l_class.is_error then
										add_error (l_class.last_error)
									end
									if l_class.is_compiled and l_class.is_modified then
										modified_classes.force (l_class)
									end
										-- add it to `reused_classes'
									reused_classes.force (l_class)
								else
										-- not found => new class
									l_class := conf_factory.new_class (a_file, current_cluster, a_path)
									if l_class.is_error then
										add_error (l_class.last_error)
									end
									added_classes.force (l_class)
									l_class.set_up_to_date
								end
								check
									name_same: l_name.is_equal (l_class.renamed_name)
								end
								if current_classes.has (l_name) then
									add_error (create {CONF_ERROR_CLASSDBL}.make (l_name))
								else
									current_classes.force (l_class, l_name)
									current_classes_by_filename.force (l_class, l_file_name)
								end
							end
						end
					end
				end
			end
		ensure
				--FIXME, at the moment this doesn't cover clusters with partial classes completely
			added: not is_error implies (valid_eiffel_extension (a_file)
				implies (current_classes.count = old current_classes.count + 1) or partial_classes /= Void)
		end

	put_class_assembly (a_name, a_dotnet_name: STRING; a_position: INTEGER) is
			-- Put an class from `an_assembly' with `a_name', `a_dotnet_name' and `a_position' into `current_clases'.
		require
			name_ok: a_name /= Void and then not a_name.is_empty
			name_upper: a_name.is_equal (a_name.as_upper)
			dotnet_name_ok: a_dotnet_name /= Void and then not a_dotnet_name.is_empty
			a_position_ok: a_position >= 0
		local
			l_class: CONF_CLASS_ASSEMBLY
			l_name: STRING
		do
				-- Try to retrieve from old_assembly before creating a new one
			l_name := get_class_assembly_name (a_name)
			if old_group /= Void and then old_group.classes /= Void then
				l_class ?= old_group.classes.item (l_name)
			end
			if l_class /= Void then
				l_class.check_changed
				l_class.set_type_position (a_position)
				if l_class.is_compiled and l_class.is_modified then
					modified_classes.force (l_class)
				end
				current_classes.force (l_class, l_name)
				current_dotnet_classes.force (l_class, a_dotnet_name)

					-- add it to `reused_classes'
				reused_classes.force (l_class)
			else
				l_class := conf_factory.new_class_assembly (a_name, a_dotnet_name, current_assembly, a_position)
				current_classes.force (l_class, l_class.renamed_name)
				current_dotnet_classes.force (l_class, a_dotnet_name)
				added_classes.force (l_class)
			end
			l_class.set_up_to_date
		ensure
			added: not is_error implies (current_classes.count = old current_classes.count + 1)
		end

	merge_classes (a_group: CONF_GROUP) is
			-- Merge the classes of `a_group' into `current_classes'.
		require
			current_classes_not_void: current_classes /= Void
			a_group_not_void: a_group /= Void
		do
			current_classes.merge (a_group.classes)
		end

	valid_eiffel_extension (a_file: STRING): BOOLEAN is
			-- Does `a_file' have a correct eiffel file extension?
		do
			valid_eiffel_extension_regexp.match (a_file)
			Result := valid_eiffel_extension_regexp.has_matched
		end

	process_assembly_implementation (an_assembly: CONF_ASSEMBLY) is
			-- Process `an_assembly' (without dependencies).
			-- tries to reuse information from `libraries'
			-- or from `old_libraries'
		require
			an_assembly_not_void: an_assembly /= Void
			dotnet: platform = pf_dotnet
			old_assembly_void: old_assembly = Void
			old_group_void: old_group = Void
		local
			l_key, l_guid: STRING
			l_path: like assembly_cache_folder
			l_types_file: FILE_NAME
			l_reader: EIFFEL_DESERIALIZER
			l_types: CONSUMED_ASSEMBLY_TYPES
			i, cnt: INTEGER
			l_name, l_dotnet_name: STRING
			l_pos: INTEGER
			l_p: STRING
			l_a: CONF_ASSEMBLY
			l_classes: HASH_TABLE [CONF_CLASS, STRING]
			l_emitter: IL_EMITTER
			l_done: BOOLEAN
		do
			l_emitter := il_emitter
			if not is_error then
				l_p := an_assembly.location.evaluated_path
				l_path := assembly_cache_folder.twin

					-- get assembly info for local assemblies
				if not l_p.is_empty then
					l_emitter.retrieve_assembly_info (l_p)

					if not l_emitter.assembly_found or else not l_emitter.is_consumed then
						add_error (create {CONF_ERROR_ASOP}.make (an_assembly.name))
					else
						an_assembly.set_assembly_name (l_emitter.name)
						an_assembly.set_assembly_version (l_emitter.version)
						an_assembly.set_assembly_culture (l_emitter.culture)
						l_key := l_emitter.public_key_token
						if l_key /= Void and then not l_key.is_equal (null_key_string) then
							an_assembly.set_assembly_public_key (l_key)
						end
						l_guid := l_emitter.consumed_folder_name
						an_assembly.set_guid (l_guid)
						l_path.extend (l_emitter.relative_folder_name_from_path (l_p))
						an_assembly.set_is_in_gac (l_emitter.is_in_gac)
					end
				else
					l_emitter.retrieve_assembly_info_by_fusion_name (an_assembly.assembly_name, an_assembly.assembly_version, an_assembly.assembly_culture, an_assembly.assembly_public_key_token)
					if not l_emitter.assembly_found or else not l_emitter.is_consumed then
						add_error (create {CONF_ERROR_ASOP}.make (an_assembly.name))
					else
						l_guid := l_emitter.consumed_folder_name
						an_assembly.set_guid (l_guid)
						l_path.extend (l_emitter.relative_folder_name (an_assembly.assembly_name, an_assembly.assembly_version, an_assembly.assembly_culture, an_assembly.assembly_public_key_token))
					end
				end

				if not is_error then
					check
							-- correct path has the guid in it
						correct_path: l_path.string.has_substring (l_guid)
					end

						-- if we already have an assembly with the same guid we can directly use this classes/dependencies
						-- used if an assembly is declared in multiple libraries/application in the same configuration
					l_a := assemblies.item (l_guid)
					if l_a /= Void then
						an_assembly.set_consumed_path (l_a.consumed_path)
						an_assembly.set_classes (l_a.classes)
						an_assembly.set_dotnet_classes (l_a.dotnet_classes)
						an_assembly.set_dependencies (l_a.dependencies)
						an_assembly.set_date (l_a.date)
					else
						assemblies.force (an_assembly, l_guid)

							-- set consumed path
						an_assembly.set_consumed_path (l_path)

							-- if we have an old assembly
						if old_assemblies /= Void and then old_assemblies.has (l_guid) then
							old_assembly := old_assemblies.found_item
							old_group := old_assembly
							if old_assembly /= an_assembly then
								old_group.invalidate
							end
							old_assemblies.remove (l_guid)
							old_assembly.check_changed

								-- if it wasn't modified, directly use the old classes.
							if not old_assembly.is_modified then
								an_assembly.set_date (old_assembly.date)
								l_classes := old_assembly.classes
								an_assembly.set_classes (l_classes)
								an_assembly.set_dotnet_classes (old_assembly.dotnet_classes)
								from
									l_classes.start
								until
									l_classes.after
								loop
									reused_classes.force (l_classes.item_for_iteration)
									l_classes.forth
								end
								l_done := True
								old_assembly := Void
								old_group := Void
							end
						end
							-- (re)build
						if not l_done then
							create l_reader

								-- get classes
							create l_types_file.make_from_string (l_path)
							l_types_file.set_file_name (type_list_file_name)
							l_reader.deserialize (l_types_file, 0)
							l_types ?= l_reader.deserialized_object

								-- add classes
							an_assembly.check_changed
							create current_classes.make (classes_per_assembly)
							create current_dotnet_classes.make (classes_per_assembly)
							if l_types /= Void then
								from
									i := l_types.eiffel_names.lower
									cnt := l_types.eiffel_names.upper
									check
										same_dotnet: l_types.dotnet_names.lower = i
										same_dotnet: l_types.dotnet_names.upper = cnt
									end
								until
									i > cnt
								loop
									l_name := l_types.eiffel_names.item (i)
									l_dotnet_name := l_types.dotnet_names.item (i)
									l_pos := l_types.positions.item (i)
									if l_name /= Void and then not l_name.is_empty then
										put_class_assembly (l_name.as_upper, l_dotnet_name, l_pos)
									end
									i := i + 1
								end
							end

								-- process removed classes
							if old_group /= Void then
								process_removed_classes (old_group.classes)
							end
							old_assembly := Void
							old_group := Void

								-- set classes
							an_assembly.set_classes (current_classes)
							an_assembly.set_dotnet_classes (current_dotnet_classes)
						end

					end
				end
				l_emitter.unload
			end
		ensure
			classes_set: not is_error implies an_assembly.classes_set
			old_assembly_void: old_assembly = Void
			old_group_void: old_group = Void
		end

	process_assembly_dependencies_implementation (an_assembly: CONF_ASSEMBLY) is
			-- Process the dependencies of `an_assembly'.
		require
			an_assembly_ok: an_assembly /= Void and then an_assembly.guid /= Void
			an_assembly_consumed: an_assembly.consumed_path /= Void and then not an_assembly.consumed_path.is_empty
			dotnet: platform = pf_dotnet
		local
			l_path: STRING
			l_reference_file: FILE_NAME
			l_referenced_assemblies: CONSUMED_ASSEMBLY_MAPPING
			i, cnt: INTEGER
			l_cons_ass: CONSUMED_ASSEMBLY
			l_assembly: CONF_ASSEMBLY
			l_reader: EIFFEL_DESERIALIZER
			l_guid, l_dep_guid: STRING
		do
			l_path := an_assembly.consumed_path
			l_guid := an_assembly.guid
			create l_reader
			create l_reference_file.make_from_string (l_path)
			l_reference_file.set_file_name (referenced_assemblies_file_name)
			l_reader.deserialize (l_reference_file, 0)
			l_referenced_assemblies ?= l_reader.deserialized_object
			if l_referenced_assemblies /= Void then
				from
					i := l_referenced_assemblies.assemblies.lower
					cnt := l_referenced_assemblies.assemblies.upper
				until
					i > cnt
				loop
					l_cons_ass := l_referenced_assemblies.assemblies.item (i)
					if l_cons_ass /= Void then
						l_dep_guid := l_cons_ass.unique_id
							-- if it's not the assembly itself
						if not l_dep_guid.is_equal (l_guid) then
								-- try to retrieve the assembly
							l_assembly := assemblies.item (l_dep_guid)
							if l_assembly /= Void then
								an_assembly.add_dependency (l_assembly)
							else
									-- create new assembly and process it
								l_assembly := conf_factory.new_assembly (l_cons_ass.name.as_lower, l_cons_ass.location, application_target)

								process_assembly_implementation (l_assembly)
								process_assembly_dependencies_implementation (l_assembly)
								an_assembly.add_dependency (l_assembly)
							end
						end
					end
					i := i + 1
				end
			end
		end

	handle_assembly_dependencies is
			-- Handle the dependencies of assemblies.
		local
			l_assemblies: like assemblies
			l_a: CONF_ASSEMBLY
		do
			if not is_error then
					-- holds the list of all assemblies
				if not assemblies.is_empty then
					if platform /= pf_dotnet then
						add_error (create {CONF_ERROR_DOTNET})
					else
						from
								-- work on a copy, because the processed dependencies get added to the original assemblies
							l_assemblies := assemblies.twin
							l_assemblies.start
						until
							l_assemblies.after
						loop
							l_a := l_assemblies.item_for_iteration
								-- only process assemblies that have not yet been handled
							if l_a.dependencies = Void then
								process_assembly_dependencies_implementation (l_a)
							end
							l_assemblies.forth
						end
					end
				end
			end
		end

	consume_assemblies (a_target: CONF_TARGET) is
			-- Consume all assemblies of `a_target'.
		local
			l_assemblies: HASH_TABLE [CONF_ASSEMBLY, STRING]
			l_p, l_locals: STRING
			l_a: CONF_ASSEMBLY
			l_consumed: BOOLEAN
			l_emitter: IL_EMITTER
		do
			on_consume_assemblies (a_target)
			l_emitter := il_emitter
			if not is_error then
					-- consume all assemblies
					-- first the named ones and then the local ones
					-- this also consumes all referenced libraries
				from
					create l_locals.make_empty
					l_assemblies := a_target.assemblies
					l_assemblies.start
				until
					l_assemblies.after
				loop
					l_a := l_assemblies.item_for_iteration
					if l_a.is_enabled (platform, build) then
						if platform /= pf_dotnet then
							add_error (create {CONF_ERROR_DOTNET})
						else
							l_consumed := True
							l_p := l_a.location.evaluated_path
								-- named
							if l_p.is_empty then
								l_emitter.consume_assembly (l_a.assembly_name, l_a.assembly_version, l_a.assembly_culture, l_a.assembly_public_key_token)
								l_emitter.retrieve_assembly_info_by_fusion_name (l_a.assembly_name, l_a.assembly_version, l_a.assembly_culture, l_a.assembly_public_key_token)
								if not l_emitter.assembly_found or else not l_emitter.is_consumed then
									add_error (create {CONF_ERROR_ASOP}.make (l_a.name))
								end
								l_a.set_guid (l_emitter.consumed_folder_name)
								-- local
							else
								l_locals.append (l_p+";")
							end
						end
					end
					l_assemblies.forth
				end
				if l_locals.count > 1 then
					l_locals.remove_tail (1)
					l_emitter.consume_assembly_from_path (l_locals)
				end
				if l_consumed then
					l_emitter.unload
				end
			end
		end

	get_class_name (a_file: STRING; a_group: CONF_GROUP): STRING is
			-- Compute the renamed classname from `a_file' in `a_group'.
		local
			l_file: KL_BINARY_INPUT_FILE
			l_name: STRING
			l_renamings: HASH_TABLE [STRING, STRING]
		do
			create l_file.make (a_file)
			if l_file.exists then
				l_file.open_read
				classname_finder.parse (l_file)
				if classname_finder.classname = Void then
					add_error (create {CONF_ERROR_CLASSN}.make (a_file))
				end
				l_name := classname_finder.classname.as_upper
				l_renamings := a_group.renaming
				if l_renamings /= Void then
					Result := l_renamings.item (l_name)
				end
				if Result = Void then
					Result := l_name.twin
				end
				if a_group.name_prefix /= Void then
					Result.prepend (a_group.name_prefix)
				end
			end
		end

	get_class_assembly_name (a_name: STRING): STRING is
			-- Compute the renamed name from `a_name' in the `current_assembly'.
		require
			current_assembly_not_void: current_assembly /= Void
			a_name_ok: a_name /= Void and then not a_name.is_empty
		local
			l_renamings: HASH_TABLE [STRING, STRING]
		do
			Result := a_name.twin
			l_renamings := current_assembly.renaming
			if l_renamings /= Void and then l_renamings.has (Result) then
				Result := l_renamings.item (Result)
			end
			if current_assembly.name_prefix /= Void then
				Result.prepend (current_assembly.name_prefix)
			end
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
						if reused_groups.has (l_group) then
							l_done := True
						else
								-- if we rebuild, groups themselves aren't reused
							l_group.invalidate
						end

							-- check if it's a library that still is used and therefore is alredy done
							-- (needed if the same library is used multiple times)
						if l_group.is_library then
							l_library ?= l_group
							check
								library: l_library /= Void
							end
							if l_library.uuid /= Void and then libraries.has (l_library.uuid) then
								l_done := True
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
							from
								l_overrides.start
							until
								l_overrides.after
							loop
								l_cl_over := l_overrides.item
								if l_cl_over.is_compiled and then reused_classes.has (l_cl_over) then
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
		do
			from
				a_new_groups.start
			until
				a_new_groups.after
			loop
				l_group := a_new_groups.item_for_iteration

				if l_group.is_enabled (platform, build) then
						-- look for a group in old groups with the same name
						-- this should work in most situations, in the rest of
						-- the situations we don't find the old classes and have
						-- to start with them from scratch, but it works anyway.
					if an_old_groups /= Void then
						old_group := an_old_groups.item (l_group.name)
						if old_group /= Void and then not old_group.classes_set then
							old_group := Void
						end
						check
							old_group_computed: old_group /= Void implies old_group.classes_set
						end
						if old_group /= Void then
							if old_group /= l_group then
								old_group.invalidate
							end
							reused_groups.force (old_group)
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
						add_error (l_class.last_error)
					end
					if l_class.is_compiled and l_class.is_modified then
						modified_classes.force (l_class)
					elseif l_class.is_always_compile then
						added_classes.force (l_class)
					end
				else
					l_class := conf_factory.new_class_partial (partial_classes.item_for_iteration, current_cluster, partial_location)
					if l_class.is_error then
						add_error (l_class.last_error)
					else
						check
							correct_renamed_name: l_class.renamed_name.is_equal (l_name)
						end
						if l_class.is_always_compile then
							added_classes.force (l_class)
						end
					end
				end
				if not is_error then
					current_classes.force (l_class, l_class.renamed_name)
				end
				partial_classes.forth
			end
		ensure
			classes_added: not is_error implies current_classes.count = old current_classes.count + partial_classes.count
		end


feature {NONE} -- shared instances

	il_emitter: IL_EMITTER is
			-- Instance of IL_EMITTER
		local
			l_il_env: IL_ENVIRONMENT
		do
			Result := internal_il_emitter.item
			if Result = Void then
				if il_version /= Void then
					create Result.make (assembly_cache_folder, il_version)
				else
					create l_il_env
					create Result.make (assembly_cache_folder, l_il_env.installed_runtimes.last)
				end
				if not Result.exists then
						-- IL_EMITTER component could not be loaded.
					add_error (create {CONF_ERROR_EMITTER})
					Result := Void
				elseif not Result.is_initialized then
						-- Path to cache is not valid
					add_error (create {CONF_ERROR_EMITTER_INIT})
					Result := Void
				else
					internal_il_emitter.put (Result)
				end
			end
		ensure
			valid_result: Result /= Void implies Result.exists and then Result.is_initialized
		end

	internal_il_emitter: CELL [IL_EMITTER] is
			-- Unique instance of IL_EMITTER
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

	valid_eiffel_extension_regexp: RX_PCRE_REGULAR_EXPRESSION is
			-- Valid eiffel extension regexp.
		once
			create Result.make
			Result.compile ("\.[pP]?[eE]$")
			print ("blub")
			Result.optimize
		end

	partial_eiffel_extension_regexp: RX_PCRE_REGULAR_EXPRESSION is
			-- Valid partial extension regexp.
		once
			create Result.make
			Result.compile ("\.[pP][eE]$")
			print ("blub")
			Result.optimize
		end

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

	assemblies_intersection (a, b: like assemblies): BOOLEAN is
			-- Is there an intersection between `a' and `b'?
		local
			l1, l2: like assemblies
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


feature {NONE} -- Constants

	type_list_file_name: STRING is "types.info"
	null_key_string: STRING is "null"
	referenced_assemblies_file_name: STRING is "referenced_assemblies.info"

feature {NONE} -- Size constants

	Classes_per_cluster: INTEGER is 100
			-- How many classes do we have per average cluster.

	Classes_per_assembly: INTEGER is 100
			-- How many classes do we have per average assembly.

	Classes_per_system: INTEGER is 3000
			-- How many classes do we have per average system.

	Groups_per_system: INTEGER is 100
			-- How many groups do we have per average system.

	Modified_classes_per_system: INTEGER is 100
			-- How many classes do we have per average system.

	Added_classes_per_system: INTEGER is 3000
			-- How many classes do we have per average system.

	Removed_classes_per_system: INTEGER is 10
			-- How many classes do we have per average system.

	Libraries_per_target: INTEGER is 5
			-- How many libraries do we have per average target.

invariant
	libraries_not_void: libraries /= Void
	assemblies_not_void: assemblies /= Void
	old_assemblies_handled_not_void: old_assemblies_handled /= Void
	reused_classes_not_void: reused_classes /= Void
	modified_classes_not_void: modified_classes /= Void
	added_classes_not_void: added_classes /= Void
	removed_classes_not_void: removed_classes /= Void
	old_assembly_group: old_assembly /= Void and old_group /= Void implies old_assembly = old_group
	application_target_not_void: application_target /= Void
	libraries_no_intersection: not libraries_intersection (libraries, old_libraries)
	assemblies_no_intersection: not assemblies_intersection (assemblies, old_assemblies)
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
