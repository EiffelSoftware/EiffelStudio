indexing
	description: "Generate a text representation of the configuration in xml."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_PRINT_VISITOR

inherit
	CONF_ITERATOR
		redefine
			process_system,
			process_target,
			process_assembly,
			process_library,
			process_precompile,
			process_cluster,
			process_override
		end

	CONF_VALIDITY

	CONF_FILE_CONSTANTS

	CONF_ACCESS

create
	make,
	make_1_0_0

feature {NONE} -- Initialization

	make is
			-- Create.
		do
			namespace := latest_namespace
			schema := latest_schema
		end

	make_1_0_0 is
			-- Create for EiffelStudio 5.7
		do
			namespace := namespace_1_0_0
			schema := schema_1_0_0
		end

feature -- Access

	text: STRING
			-- The text output.

	namespace: STRING
			-- Namespace to use.

	schema: STRING
			-- Schema to use.

feature -- Update

	set_namespace (a_namespace: like namespace) is
			-- Set `namespace' to `a_namespace'.
		require
			a_namespace_ok: a_namespace /= Void and then not a_namespace.is_empty
		do
			namespace := a_namespace
		ensure
			namespace_set: namespace = a_namespace
		end

	set_schema (a_schema: like schema) is
			-- Set `schema' to `a_schema'.
		require
			a_schema_ok: a_schema /= Void and then not a_schema.is_empty
		do
			schema := a_schema
		ensure
			schema_set: schema = a_schema
		end

feature -- Visit nodes

	process_system (a_system: CONF_SYSTEM) is
			-- Visit `a_system'.
		local
			l_target: CONF_TARGET
		do
			create text.make_from_string (header)
			if not text.is_empty then
				append_text ("%N")
			end
			append_text_indent ("<system")
			append_text (" xmlns=%""+Namespace+"%"")
			append_text (" xmlns:xsi=%"http://www.w3.org/2001/XMLSchema-instance%"")
			append_text (" xsi:schemaLocation=%""+Schema+"%"")
			append_text (" name=%""+escape_xml (a_system.name)+"%" uuid=%""+a_system.uuid.out+"%"")
			if not a_system.is_readonly then
				append_text (" readonly=%"false%"")
			end
			l_target := a_system.library_target
			if l_target /= Void then
				append_text (" library_target=%""+escape_xml (l_target.name)+"%"")
			end
			append_text (">%N")
			indent := indent + 1
			append_note_tag (a_system)
			append_description_tag (a_system.description)

			Precursor (a_system)

			indent := indent - 1
			append_text_indent ("</system>%N")
		ensure then
			indent_back: indent = old indent
		end

	process_target (a_target: CONF_TARGET) is
			-- Visit `a_target'.
		local
			l_root: CONF_ROOT
			l_version: CONF_VERSION
			l_settings, l_variables: HASH_TABLE [STRING, STRING]
			l_a_name, l_a_val: ARRAYED_LIST [STRING]
			l_sort_lst: DS_ARRAYED_LIST [STRING]
		do
			current_target := a_target
			append_text_indent ("<target name=%""+escape_xml (a_target.name)+"%"")
			if a_target.extends /= Void then
				text.append (" extends=%""+escape_xml (a_target.extends.name)+"%"")
			end
			if a_target.is_abstract then
				text.append (" abstract=%"true%"")
			end
			append_text (">%N")
			indent := indent + 1
			append_note_tag (a_target)
			append_description_tag (a_target.description)
			l_root := a_target.internal_root
			if l_root /= Void then
				create l_a_name.make (4)
				create l_a_val.make (4)
				if l_root.is_all_root then
					l_a_name.force ("all_classes")
					l_a_val.force (l_root.is_all_root.out.as_lower)
				else
					l_a_name.force ("cluster")
					l_a_val.force (l_root.cluster_name)
					l_a_name.force ("class")
					l_a_val.force (l_root.class_type_name)
					l_a_name.force ("feature")
					l_a_val.force (l_root.feature_name)
				end
				append_tag ("root", Void, l_a_name, l_a_val)
			end
			l_version := a_target.internal_version
			if l_version /= Void then
				create l_a_name.make (8)
				create l_a_val.make (8)
				l_a_name.force ("major")
				l_a_val.force (l_version.major.out)
				l_a_name.force ("minor")
				l_a_val.force (l_version.minor.out)
				l_a_name.force ("release")
				l_a_val.force (l_version.release.out)
				l_a_name.force ("build")
				l_a_val.force (l_version.build.out)
				l_a_name.force ("company")
				l_a_val.force (l_version.company)
				l_a_name.force ("product")
				l_a_val.force (l_version.product)
				l_a_name.force ("trademark")
				l_a_val.force (l_version.trademark)
				l_a_name.force ("copyright")
				l_a_val.force (l_version.copyright)
				append_tag ("version", Void, l_a_name, l_a_val)
			end
			append_file_rule (a_target.internal_file_rule)
			append_options (a_target.internal_options, Void)
			from
				l_settings := a_target.internal_settings
				create l_sort_lst.make_from_array (l_settings.current_keys)
				l_sort_lst.sort (create {DS_QUICK_SORTER [STRING]}.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make))
				l_sort_lst.start
			until
				l_sort_lst.after
			loop
				create l_a_name.make (2)
				l_a_name.force ("name")
				l_a_name.force ("value")
				create l_a_val.make (1)
				l_a_val.force (l_sort_lst.item_for_iteration)
				l_a_val.force (l_settings.item (l_sort_lst.item_for_iteration))
				append_tag ("setting", Void, l_a_name, l_a_val)
				l_sort_lst.forth
			end
			append_mapping (a_target.internal_mapping)
			append_externals (a_target.internal_external_include, "include")
			append_externals (a_target.internal_external_object, "object")
			append_externals (a_target.internal_external_library, "library")
			append_externals (a_target.internal_external_resource, "resource")
			append_externals (a_target.internal_external_make, "make")
			append_actions (a_target.internal_pre_compile_action, "pre")
			append_actions (a_target.internal_post_compile_action, "post")

			from
				l_variables := a_target.internal_variables
				l_variables.start
			until
				l_variables.after
			loop
				create l_a_name.make (2)
				l_a_name.force ("name")
				l_a_name.force ("value")
				create l_a_val.make (1)
				l_a_val.force (l_variables.key_for_iteration)
				l_a_val.force (l_variables.item_for_iteration)
				append_tag ("variable", Void, l_a_name, l_a_val)
				l_variables.forth
			end

			if a_target.internal_precompile /= Void then
				a_target.internal_precompile.process (Current)
			end

			process_in_alphabetic_order (a_target.internal_libraries)
			process_in_alphabetic_order (a_target.internal_assemblies)
			process_in_alphabetic_order (a_target.internal_clusters)
			process_in_alphabetic_order (a_target.internal_overrides)

			indent := indent - 1
			append_text_indent ("</target>%N")
		ensure then
			indent_back: indent = old indent
		end

	process_assembly (an_assembly: CONF_ASSEMBLY) is
			-- Visit `an_assembly'.
		local
			l_str: STRING
			l_p: STRING
		do
			l_p := an_assembly.location.original_path
			append_pre_group ("assembly", an_assembly)
			if l_p.is_empty then
				l_str := an_assembly.assembly_name
				if l_str /= Void and then not l_str.is_empty then
					append_text (" assembly_name=%""+escape_xml (l_str)+"%"")
				end
				l_str := an_assembly.assembly_version
				if l_str /= Void and then not l_str.is_empty then
					append_text (" assembly_version=%""+escape_xml (l_str)+"%"")
				end
				l_str := an_assembly.assembly_culture
				if l_str /= Void and then not l_str.is_empty then
					append_text (" assembly_culture=%""+escape_xml (l_str)+"%"")
				end
				l_str := an_assembly.assembly_public_key_token
				if l_str /= Void and then not l_str.is_empty then
					append_text (" assembly_key=%""+escape_xml (l_str)+"%"")
				end
			end
			append_val_group (an_assembly)
			append_post_group ("assembly")
		ensure then
			indent_back: indent = old indent
		end

	process_library (a_library: CONF_LIBRARY) is
			-- Visit `a_library'.
		do
			append_pre_group ("library", a_library)
			if namespace /= namespace_1_0_0 and then a_library.use_application_options then
				append_text (" use_application_options=%"true%"")
			end
			append_val_group (a_library)
			if a_library.visible /= Void then
				append_visible (a_library.visible)
			end
			append_post_group ("library")
		ensure then
			indent_back: indent = old indent
		end

	process_precompile (a_precompile: CONF_PRECOMPILE) is
			-- Visit `a_precompile'.
		do
			append_pre_group ("precompile", a_precompile)
			if a_precompile.eifgens_location /= Void then
				append_text (" eifgens_location=%""+a_precompile.eifgens_location.original_directory+"%"")
			end
			append_val_group (a_precompile)
			append_post_group ("precompile")
		ensure then
			indent_back: indent = old indent
		end

	process_cluster (a_cluster: CONF_CLUSTER) is
			-- Visit `a_cluster'.
		do
				-- ignore subclusters, except if we are handling one.
			if a_cluster.parent = Void or current_is_subcluster then
				current_is_subcluster := False
				append_pre_group ("cluster", a_cluster)
				append_attr_cluster (a_cluster)
				append_val_group (a_cluster)
				append_val_cluster (a_cluster)
				append_post_group ("cluster")
			end
		ensure then
			indent_back: indent = old indent
		end

	process_override (an_override: CONF_OVERRIDE) is
			-- Visit `an_override'.
		local
			l_overrides: ARRAYED_LIST [CONF_GROUP]
		do
				-- ignore subclusters, except if we are handling one.
			if an_override.parent = Void or current_is_subcluster then
				current_is_subcluster := False
				append_pre_group ("override", an_override)
				append_attr_cluster (an_override)
				append_val_group (an_override)
				append_val_cluster (an_override)
				l_overrides := an_override.override
				if l_overrides /= Void then
					from
						l_overrides.start
					until
						l_overrides.after
					loop
						append_text_indent ("<overrides group=%""+escape_xml (l_overrides.item.name)+"%"/>%N")
						l_overrides.forth
					end
				end
				append_post_group ("override")
			end
		ensure then
			indent_back: indent = old indent
		end

feature {NONE} -- Implementation

	indent: INTEGER
			-- The indentation level.

	last_count: INTEGER
			-- A helper counter, that is used to see if something was added.

	current_target: CONF_TARGET
			-- The target we are currently processing.

	current_is_subcluster: BOOLEAN
			-- Is the current cluster/override a subcluster?

	process_in_alphabetic_order (a_groups: HASH_TABLE [CONF_GROUP, STRING]) is
			-- Process `a_groups' in alphabetic order corresponding to their key.
		require
			a_groups_not_void: a_groups /= Void
		local
			l_sort_lst: DS_ARRAYED_LIST [STRING]
		do
			from
				create l_sort_lst.make_from_array (a_groups.current_keys)
				l_sort_lst.sort (create {DS_QUICK_SORTER [STRING]}.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make))
				l_sort_lst.start
			until
				l_sort_lst.after
			loop
				a_groups.item (l_sort_lst.item_for_iteration).process (Current)
				l_sort_lst.forth
			end
		end

	escape_xml (a_string: STRING): STRING is
			-- Escape xml entities in `a_string'.
		do
			if a_string /= Void then
				Result := a_string.twin
				Result.replace_substring_all (Amp_string, amp_entity)
				Result.replace_substring_all (Lt_string, Lt_entity)
				Result.replace_substring_all (Gt_string, Gt_entity)
				Result.replace_substring_all (Quot_string, quot_entity)
			end
		ensure
			result_void_iff_a_string_void: (Result = Void) = (a_string = Void)
		end

	append_tag (a_name, a_value: STRING; an_attribute_names, an_attribute_values: ARRAYED_LIST [STRING]) is
			-- Append a tag with `a_name', `a_value' and `an_attributes' to `text', intendend it with `indent' tabs.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			attributes_same_count: (an_attribute_names = Void and an_attribute_values = Void) or else
					(an_attribute_names /= Void and an_attribute_values /= Void and then an_attribute_names.count = an_attribute_values.count)
		local
			l_val: STRING
		do
			append_text_indent ("<"+a_name)
			if an_attribute_names /= Void and then not an_attribute_names.is_empty then
				from
					an_attribute_names.start
					an_attribute_values.start
				until
					an_attribute_names.after
				loop
					l_val := an_attribute_values.item
					if l_val /= Void and then not l_val.is_empty then
						append_text (" "+an_attribute_names.item)
						append_text ("=%""+escape_xml (l_val)+"%"")
					end
					an_attribute_names.forth
					an_attribute_values.forth
				end
			end
			if a_value /= Void and not a_value.is_empty then
				append_text (">"+escape_xml (a_value)+"</"+a_name+">%N")
			else
				append_text ("/>%N")
			end
		end

	append_text_indent (a_text: STRING) is
			-- Append `a_text' at the current `indent' intendation level.
		require
			a_text_ok: a_text /= Void and then not a_text.is_empty
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > indent
			loop
				text.append_character ('%T')
				i := i + 1
			end
			text.append (a_text)
		end

	append_text (a_text: STRING) is
			-- Append `a_text'.
		require
			a_text_not_void: a_text /= Void and then not a_text.is_empty
		do
			text.append (a_text)
		end

	append_description_tag (a_description: STRING) is
			-- Append `a_description'.
		do
			if a_description /= Void and then not a_description.is_empty then
				append_tag ("description", a_description, Void, Void)
			end
		end

	append_conditionals (a_conditions: ARRAYED_LIST [CONF_CONDITION]; is_assembly: BOOLEAN) is
			-- Append `a_conditions' ignore platform if it `is_assembly'.
		local
			l_condition: CONF_CONDITION
			l_done: BOOLEAN
			l_platforms, l_builds: ARRAYED_LIST [INTEGER]
			l_custs: HASH_TABLE [EQUALITY_TUPLE [TUPLE [value: STRING_GENERAL; invert: BOOLEAN]], STRING_GENERAL]
			l_custom: EQUALITY_TUPLE [TUPLE [value: STRING_GENERAL; invert: BOOLEAN]]
			l_versions: HASH_TABLE [EQUALITY_TUPLE [TUPLE [min: CONF_VERSION; max: CONF_VERSION]], STRING]
			l_name: STRING
			l_ver: EQUALITY_TUPLE [TUPLE [min: CONF_VERSION; max: CONF_VERSION]]
		do
			if a_conditions /= Void then
					-- assembly and only the default rule? => don't print it
				if is_assembly and then a_conditions.count = 1 then
					l_condition := a_conditions.first
					l_done := l_condition.build = Void and l_condition.platform = Void and l_condition.multithreaded = Void and l_condition.version.is_empty and l_condition.custom.is_empty
				end
				if not l_done then
					from
						a_conditions.start
					until
						a_conditions.after
					loop
						append_text_indent ("<condition>%N")
						indent := indent + 1

						l_condition := a_conditions.item
						if l_condition.platform /= Void then
							if l_condition.platform.item.invert then
								append_text_indent ("<platform excluded_value=%"")
							else
								append_text_indent ("<platform value=%"")
							end
							from
								l_platforms := l_condition.platform.item.value
								l_platforms.start
							until
								l_platforms.after
							loop
								append_text (get_platform_name (l_platforms.item).as_lower + " ")
								l_platforms.forth
							end
							text.remove_tail (1)
							append_text ("%"/>%N")
						end

						if l_condition.build /= Void then
							if l_condition.build.item.invert then
								append_text_indent ("<build excluded_value=%"")
							else
								append_text_indent ("<build value=%"")
							end
							from
								l_builds := l_condition.build.item.value
								l_builds.start
							until
								l_builds.after
							loop
								append_text (get_build_name (l_builds.item).as_lower + " ")
								l_builds.forth
							end
							text.remove_tail (1)
							append_text ("%"/>%N")
						end

						if l_condition.multithreaded /= Void then
							append_text_indent ("<multithreaded value=%""+l_condition.multithreaded.item.out.as_lower+"%"/>%N")
						end

						if l_condition.dynamic_runtime /= Void then
							append_text_indent ("<dynamic_runtime value=%""+l_condition.dynamic_runtime.item.out.as_lower+"%"/>%N")
						end

							-- don't print dotnet for assemblies
						if not is_assembly and then l_condition.dotnet /= Void then
							append_text_indent ("<dotnet value=%""+l_condition.dotnet.item.out.as_lower+"%"/>%N")
						end

						from
							l_versions := l_condition.version
							l_versions.start
						until
							l_versions.after
						loop
							l_ver := l_versions.item_for_iteration
							append_text_indent ("<version type=%""+l_versions.key_for_iteration+"%"")
							if l_ver.item.min /= Void then
								append_text (" min=%""+l_ver.item.min.version+"%"")
							end
							if l_ver.item.max /= Void then
								append_text (" max=%""+l_ver.item.max.version+"%"")
							end
							append_text ("/>%N")

							l_versions.forth
						end

						from
							l_custs := l_condition.custom
							l_custs.start
						until
							l_custs.after
						loop
							l_custom := l_custs.item_for_iteration
							if l_custom.item.invert then
								l_name := "excluded_value"
							else
								l_name := "value"
							end
							check
								is_valid_as_string_8: l_custs.key_for_iteration.is_valid_as_string_8
								is_valid_as_string_8: l_custom.item.value.is_valid_as_string_8
							end
							append_text_indent ("<custom name=%""+l_custs.key_for_iteration.as_string_8+"%" "+l_name+"=%""+l_custom.item.value.as_string_8+"%"/>%N")
							l_custs.forth
						end

						indent := indent - 1
						append_text_indent ("</condition>%N")
						a_conditions.forth
					end
				end
			end
		ensure
			indent_back: indent = old indent
		end

	append_mapping (a_mapping: EQUALITY_HASH_TABLE [STRING, STRING]) is
			-- Append `a_mapping'.
		do
			if a_mapping /= Void then
				from
					a_mapping.start
				until
					a_mapping.after
				loop
					append_text_indent ("<mapping old_name=%""+escape_xml (a_mapping.key_for_iteration)+"%" new_name=%""+escape_xml (a_mapping.item_for_iteration)+"%"/>%N")
					a_mapping.forth
				end
			end
		end

	append_externals (an_externals: ARRAYED_LIST [CONF_EXTERNAL]; a_name: STRING) is
			-- Append `an_externals'.
		require
			an_externals_not_void: an_externals /= Void
			a_name_ok: a_name /= Void and then not a_name.is_empty
		local
			l_ext: CONF_EXTERNAL
			l_desc: STRING
		do
			if not an_externals.is_empty then
				from
					an_externals.start
				until
					an_externals.after
				loop
					l_ext := an_externals.item
					append_text_indent ("<external_"+a_name)
					append_text (" location=%""+escape_xml (l_ext.internal_location)+"%">%N")
					indent := indent + 1
					last_count := text.count

					l_desc := l_ext.description
					if l_desc /= Void and not l_desc.is_empty then
						append_tag ("description", l_desc, Void, Void)
					end
					append_conditionals (l_ext.internal_conditions, False)
					indent := indent - 1

					if text.count = last_count then
						text.insert_character ('/', last_count-1)
					else
						append_text_indent ("</external_"+a_name+">%N")
					end
					an_externals.forth
				end
			end
		end

	append_actions (an_actions: ARRAYED_LIST [CONF_ACTION]; a_name: STRING) is
			-- Append `an_actions'.
		require
			an_actions_not_void: an_actions /= Void
			a_nam_ok: a_name /= Void and then not a_name.is_empty
		local
			l_action: CONF_ACTION
		do
			from
				an_actions.start
			until
				an_actions.after
			loop
				l_action := an_actions.item
				append_text_indent ("<"+a_name+"_compile_action")
				if l_action.working_directory /= Void then
					append_text (" working_directory=%""+escape_xml (l_action.working_directory.original_path)+"%"")
				end
				append_text (" command=%""+escape_xml (l_action.command) + "%"")
				if l_action.must_succeed then
					append_text (" succeed=%"true%"")
				end
				append_text (">%N")
				indent := indent + 1
				append_description_tag (l_action.description)
				append_conditionals (l_action.internal_conditions, False)
				indent := indent - 1
				append_text_indent ("</"+a_name+"_compile_action>%N")
				an_actions.forth
			end
		end

	append_file_rule (a_file_rules: ARRAYED_LIST [CONF_FILE_RULE]) is
			-- Append `a_file_rule'
		local
			l_pattern: DS_HASH_SET [STRING]
			l_rule: CONF_FILE_RULE
		do
			from
				a_file_rules.start
			until
				a_file_rules.after
			loop
				l_rule := a_file_rules.item

				if not l_rule.is_empty then
					append_text_indent ("<file_rule>%N")
					indent := indent + 1
					append_description_tag (l_rule.description)
					l_pattern := l_rule.exclude
					if l_pattern /= Void then
						from
							l_pattern.start
						until
							l_pattern.after
						loop
							append_tag ("exclude", l_pattern.item_for_iteration, Void, Void)
							l_pattern.forth
						end
					end
					l_pattern := l_rule.include
					if l_pattern /= Void then
						from
							l_pattern.start
						until
							l_pattern.after
						loop
							append_tag ("include", l_pattern.item_for_iteration, Void, Void)
							l_pattern.forth
						end
					end
					append_conditionals (l_rule.internal_conditions, False)
					indent := indent - 1
					append_text_indent ("</file_rule>%N")
				end

				a_file_rules.forth
			end
		end

	append_options (an_options: CONF_OPTION; a_class: STRING) is
			-- Append `an_options', optionally for `a_class'.
		local
			l_str: STRING
			l_debugs, l_warnings: HASH_TABLE [BOOLEAN, STRING]
			l_assertions: CONF_ASSERTIONS
			l_a_name, l_a_val: ARRAYED_LIST [STRING]
			l_sort_lst: DS_ARRAYED_LIST [STRING]
		do
			if an_options /= Void and then not an_options.is_empty then
				if a_class /= Void and then not a_class.is_empty then
					append_text_indent ("<class_option class=%""+escape_xml (a_class)+"%"")
				else
					append_text_indent ("<option")
				end

				if an_options.is_trace_configured then
					append_text (" trace=%""+an_options.is_trace.out.as_lower+"%"")
				end
				if an_options.is_profile_configured then
					append_text (" profile=%""+an_options.is_profile.out.as_lower+"%"")
				end
				if an_options.is_optimize_configured then
					append_text (" optimize=%""+an_options.is_optimize.out.as_lower+"%"")
				end
				if an_options.is_debug_configured then
					append_text (" debug=%""+an_options.is_debug.out.as_lower+"%"")
				end
				if an_options.is_warning_configured then
					append_text (" warning=%""+an_options.is_warning.out.as_lower+"%"")
				end
				if an_options.is_msil_application_optimize_configured then
					append_text (" msil_application_optimize=%""+an_options.is_msil_application_optimize.out.as_lower+"%"")
				end
				if an_options.is_full_class_checking_configured then
					append_text (" full_class_checking=%""+an_options.is_full_class_checking.out.as_lower+"%"")
				end
				if an_options.is_cat_call_detection_configured then
					append_text (" cat_call_detection=%""+an_options.is_cat_call_detection.out.as_lower+"%"")
				end
				if an_options.is_attached_by_default_configured then
					append_text (" is_attached_by_default=%""+an_options.is_attached_by_default.out.as_lower+"%"")
				end
				if an_options.is_void_safe_configured then
					append_text (" is_void_safe=%""+an_options.is_void_safe.out.as_lower+"%"")
				end
				if an_options.syntax_level.is_set then
					append_text (" syntax_level=%"" + an_options.syntax_level.out + "%"")
				end
				l_str := an_options.local_namespace
				if l_str /= Void and then not l_str.is_empty then
					append_text (" namespace=%""+escape_xml (l_str)+"%"")
				end
				append_text (">%N")

				indent := indent + 1
				append_description_tag (an_options.description)

				l_debugs := an_options.debugs
				if l_debugs /= Void and then not l_debugs.is_empty then
					create l_sort_lst.make_from_array (l_debugs.current_keys)
					l_sort_lst.sort (create {DS_QUICK_SORTER [STRING]}.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make))
					from
						l_sort_lst.start
					until
						l_sort_lst.after
					loop
						append_text_indent ("<debug name=%""+escape_xml (l_sort_lst.item_for_iteration)+"%"")
						append_text (" enabled=%""+l_debugs.item (l_sort_lst.item_for_iteration).out.as_lower+"%"/>%N")
						l_sort_lst.forth
					end
				end

				l_assertions := an_options.assertions
				if l_assertions /= Void then
					create l_a_name.make (5)
					create l_a_val.make (5)
					if l_assertions.is_precondition then
						l_a_name.extend ("precondition")
						l_a_val.extend (l_assertions.is_precondition.out.as_lower)
					end
					if l_assertions.is_postcondition then
						l_a_name.extend ("postcondition")
						l_a_val.extend (l_assertions.is_postcondition.out.as_lower)
					end
					if l_assertions.is_check then
						l_a_name.extend ("check")
						l_a_val.extend (l_assertions.is_check.out.as_lower)
					end
					if l_assertions.is_invariant then
						l_a_name.extend ("invariant")
						l_a_val.extend (l_assertions.is_invariant.out.as_lower)
					end
					if l_assertions.is_loop then
						l_a_name.extend ("loop")
						l_a_val.extend (l_assertions.is_loop.out.as_lower)
					end
					if namespace /= namespace_1_0_0 and then l_assertions.is_supplier_precondition then
						l_a_name.extend ("supplier_precondition")
						l_a_val.extend (l_assertions.is_supplier_precondition.out.as_lower)
					end

					append_tag ("assertions", Void, l_a_name, l_a_val)
				end

				l_warnings := an_options.warnings
				if l_warnings /= Void and then not l_warnings.is_empty then
					create l_sort_lst.make_from_array (l_warnings.current_keys)
					l_sort_lst.sort (create {DS_QUICK_SORTER [STRING]}.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make))
					from
						l_sort_lst.start
					until
						l_sort_lst.after
					loop
						append_text_indent ("<warning name=%""+l_sort_lst.item_for_iteration+"%"")
						append_text (" enabled=%""+l_warnings.item (l_sort_lst.item_for_iteration).out.as_lower+"%"/>%N")
						l_sort_lst.forth
					end
				end

				indent := indent - 1
				if a_class /= Void and then not a_class.is_empty then
					append_text_indent ("</class_option>%N")
				else
					append_text_indent ("</option>%N")
				end

			end
		end

	append_visible (a_visible: EQUALITY_HASH_TABLE [EQUALITY_TUPLE [TUPLE [class_renamed: STRING; features: EQUALITY_HASH_TABLE [STRING, STRING]]], STRING]) is
			-- Append visible rules.
		require
			a_visible_not_void: a_visible /= Void
		local
			l_vis_feat: EQUALITY_HASH_TABLE [STRING, STRING]
			l_class: STRING
			l_feat, l_feat_rename, l_class_rename: STRING
		do
			from
				a_visible.start
			until
				a_visible.after
			loop
				l_class := a_visible.key_for_iteration
				l_class_rename := a_visible.item_for_iteration.item.class_renamed
				l_vis_feat := a_visible.item_for_iteration.item.features
				if l_vis_feat /= Void then
					from
						l_vis_feat.start
					until
						l_vis_feat.after
					loop
						l_feat := l_vis_feat.key_for_iteration
						l_feat_rename := l_vis_feat.item_for_iteration
						if l_feat.is_equal ("*") then
							l_feat := Void
						end
						append_text_indent ("<visible class=%""+escape_xml (l_class)+"%"")
						if l_feat /= Void then
							append_text (" feature=%""+escape_xml (l_feat)+"%"")
						end
						if l_class_rename /= Void and then not l_class_rename.is_empty and then not l_class_rename.is_equal (l_class) then
							append_text (" class_rename=%""+escape_xml (l_class_rename)+"%"")
						end
						if l_feat_rename /= Void and then not l_feat_rename.is_empty and then not l_feat_rename.is_equal (l_feat) then
							append_text (" feature_rename=%""+escape_xml (l_feat_rename)+"%"")
						end
						append_text ("/>%N")
						l_vis_feat.forth
					end
				else
					append_text_indent ("<visible class=%""+escape_xml (l_class)+"%"")
					if l_class_rename /= Void and then not l_class_rename.is_empty and then not l_class_rename.is_equal (l_class) then
						append_text (" class_rename=%""+escape_xml (l_class_rename)+"%"")
					end
					append_text ("/>%N")
				end
				a_visible.forth
			end

		end

	append_pre_group (a_tag: STRING; a_group: CONF_GROUP) is
			-- Append the things that start the entry for `a_group'
		require
			a_group_not_void: a_group /= Void
			a_tag_ok: a_tag /= Void and then not a_tag.is_empty
		local
			l_str: STRING
			l_vg: CONF_VIRTUAL_GROUP
		do
			l_str := a_group.location.original_path
			if l_str.is_empty then
				l_str := "none"
			end
			append_text_indent ("<"+a_tag+" name=%""+escape_xml (a_group.name)+"%"")
			append_text (" location=%""+escape_xml (l_str)+"%"")
			if not a_group.is_library and a_group.internal_read_only then
				append_text (" readonly=%"true%"")
			elseif a_group.is_library and a_group.is_readonly_set then
				append_text (" readonly=%""+a_group.is_readonly.out.as_lower+"%"")
			end

			l_vg ?= a_group
			if l_vg /= Void then
				l_str := l_vg.name_prefix
				if l_str /= Void and then not l_str.is_empty then
					append_text (" prefix=%""+escape_xml (l_str)+"%"")
				end
			end
		end

	append_val_group (a_group: CONF_GROUP) is
			-- Append the things that come in the value part of `a_group'.
		require
			a_group_not_void: a_group /= Void
		local
			l_renaming: HASH_TABLE [STRING, STRING]
			l_c_opt: HASH_TABLE [CONF_OPTION, STRING]
			l_vg: CONF_VIRTUAL_GROUP
		do
			append_text (">%N")
			indent := indent + 1
			last_count := text.count
			append_note_tag (a_group)
			append_description_tag (a_group.description)
			append_conditionals (a_group.internal_conditions, a_group.is_assembly)
			append_options (a_group.internal_options, Void)
			l_vg ?= a_group
			if l_vg /= Void then
				l_renaming := l_vg.renaming
				if l_renaming /= Void then
					from
						l_renaming.start
					until
						l_renaming.after
					loop
						append_text_indent ("<renaming old_name=%""+escape_xml (l_renaming.key_for_iteration)+"%" new_name=%""+escape_xml (l_renaming.item_for_iteration)+"%"/>%N")
						l_renaming.forth
					end
				end
			end
			l_c_opt := a_group.internal_class_options
			if l_c_opt /= Void then
				from
					l_c_opt.start
				until
					l_c_opt.after
				loop
					append_options (l_c_opt.item_for_iteration, l_c_opt.key_for_iteration)
					l_c_opt.forth
				end
			end
		end

	append_post_group (a_tag: STRING) is
			-- Finish the the tag for the group.
		require
			a_tag_ok: a_tag /= Void and then not a_tag.is_empty
		do
				-- we didn't add anything further => change to a single tag.
			indent := indent - 1
			if text.count = last_count then
				text.insert_character ('/', last_count-1)
			else
				append_text_indent ("</"+a_tag+">%N")
			end
		end

	append_attr_cluster (a_cluster: CONF_CLUSTER) is
			-- Append the attributes for `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			if a_cluster.is_recursive then
				append_text (" recursive=%"true%"")
			end
			if namespace /= namespace_1_0_0 and then a_cluster.is_hidden then
				append_text (" hidden=%"true%"")
			end
		end

	append_val_cluster (a_cluster: CONF_CLUSTER) is
			-- Append the values for `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			l_deps: DS_HASH_SET [CONF_GROUP]
			l_visible: EQUALITY_HASH_TABLE [EQUALITY_TUPLE [TUPLE [STRING_8, EQUALITY_HASH_TABLE [STRING_8, STRING_8]]], STRING_8]
			l_clusters: ARRAYED_LIST [CONF_CLUSTER]
		do
			append_file_rule (a_cluster.internal_file_rule)
			append_mapping (a_cluster.internal_mapping)
			l_deps := a_cluster.internal_dependencies
			if l_deps /= Void then
				from
					l_deps.start
				until
					l_deps.after
				loop
					append_text_indent ("<uses group=%""+escape_xml (l_deps.item_for_iteration.name)+"%"/>%N")
					l_deps.forth
				end
			end
			l_visible := a_cluster.visible
			if l_visible /= Void then
				append_visible (l_visible)
			end
				-- process subclusters
			l_clusters := a_cluster.children
			if l_clusters /= Void then
				l_clusters.do_all (agent (ai_cluster: CONF_CLUSTER)
					do
						current_is_subcluster := True
						ai_cluster.process (Current)
					end)
			end
		end

	append_note_tag (a_notable: CONF_NOTABLE) is
			-- Append `a_notes'.
		local
			l_names, l_values: ARRAYED_LIST [STRING]
			l_note: HASH_TABLE [STRING, STRING]
			l_notes: ARRAYED_LIST [HASH_TABLE [STRING, STRING]]
		do
			l_notes := a_notable.notes
			if l_notes /= Void and then not l_notes.is_empty then
				from
					l_notes.start
				until
					l_notes.after
				loop
					l_note := l_notes.item_for_iteration
					if not l_note.is_empty then
						create l_names.make (1)
						create l_values.make (1)
						from
							l_note.start
						until
							l_note.after
						loop
							if not l_note.key_for_iteration.is_empty then
								l_names.extend (l_note.key_for_iteration)
								l_values.extend (l_note.item_for_iteration)
							end
							l_note.forth
						end
						append_tag ("note", Void, l_names, l_values)
					end
					l_notes.forth
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

