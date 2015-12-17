note
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
			process_redirection,
			process_system,
			process_target,
			process_assembly,
			process_library,
			process_precompile,
			process_cluster,
			process_override
		end

	CONF_VALIDITY

	CONF_NAMESPACE_TESTER

	CONF_ACCESS

create
	make,
	make_1_0_0,
	make_namespace_and_schema

feature {NONE} -- Initialization

	make
			-- Create.
		do
			make_namespace_and_schema (latest_namespace, latest_schema)
		end

	make_1_0_0
			-- Create for EiffelStudio 5.7
		do
			make_namespace_and_schema (namespace_1_0_0, schema_1_0_0)
		end

	make_namespace_and_schema (a_namespace: like namespace; a_schema: like schema)
			-- Create with `a_namespace' and `a_schema'.
		do
			namespace := a_namespace
			schema := a_schema
			create text.make_empty
		end

feature -- Access

	text: STRING
			-- The text output.

	schema: STRING_32
			-- Schema to use.

feature -- Update

	set_namespace (a_namespace: like namespace)
			-- Set `namespace' to `a_namespace'.
		require
			a_namespace_ok: a_namespace /= Void and then not a_namespace.is_empty
			known_namespace: is_namespace_known (a_namespace)
			normalized_namespace: normalized_namespace (a_namespace) = a_namespace
		do
			namespace := a_namespace
		ensure
			namespace_set: namespace = a_namespace
		end

	set_schema (a_schema: like schema)
			-- Set `schema' to `a_schema'.
		require
			a_schema_ok: a_schema /= Void and then not a_schema.is_empty
		do
			debug ("to_implement")
				(create {REFACTORING_HELPER}).to_implement ("Set schema from a namespace.")
			end
			schema := a_schema
		ensure
			schema_set: schema = a_schema
		end

feature -- Visit nodes

	process_redirection (a_redirection: CONF_REDIRECTION)
			-- Visit `a_redirection'.
		do
			create text.make_from_string (header)
			if not text.is_empty then
				append_text ("%N")
			end
			append_text_indent ("<redirection")
			append_text (" xmlns=%"")
			if attached namespace as l_namespace then
				append_text_escaped (l_namespace, False)
--Alternative:	append_text (utf.string_32_to_utf_8_string_8 (l_namespace)) -- FIXME: maybe add utf-8 BOM ...
			else
				append_text_escaped (default_namespace, False)
				check has_namespace: False end
			end
			append_text ("%"")

			append_text (" xmlns:xsi=%"http://www.w3.org/2001/XMLSchema-instance%"")
			append_text (" xsi:schemaLocation=%"")
			append_text_escaped (Schema, False)
			append_text ("%"")
			if attached a_redirection.uuid as l_uuid then
				append_text (" uuid=%"" + l_uuid.out + "%"")
			end
			append_text_attribute ("location", a_redirection.redirection_location)
			append_text (">%N")
			Precursor (a_redirection)
			append_text_indent ("</redirection>%N")
		ensure then
			indent_back: indent = old indent
		end

	process_system (a_system: CONF_SYSTEM)
			-- Visit `a_system'.
		local
			l_target: detachable CONF_TARGET
		do
			create text.make_from_string (header)
			if not text.is_empty then
				append_text ("%N")
			end
			append_text_indent ("<system")
			append_text (" xmlns=%"")
			if attached namespace as l_namespace then
				append_text_escaped (l_namespace, False)
--Alternative:	append_text (utf.string_32_to_utf_8_string_8 (l_namespace)) -- FIXME: maybe add utf-8 BOM ...
			else
				append_text_escaped (default_namespace, False)
				check has_namespace: False end
			end
			append_text ("%"")
			append_text (" xmlns:xsi=%"http://www.w3.org/2001/XMLSchema-instance%"")
			append_text (" xsi:schemaLocation=%"")
			append_text_escaped (Schema, False)
			append_text ("%"")
			append_text_attribute ("name", a_system.name)
			append_text (" uuid=%"" + a_system.uuid.out + "%"")
			if not a_system.is_readonly then
				append_text (" readonly=%"false%"")
			end
			l_target := a_system.library_target
			if l_target /= Void then
				append_text_attribute ("library_target", l_target.name)
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

	process_target (a_target: CONF_TARGET)
			-- Visit `a_target'.
		local
			l_root: detachable CONF_ROOT
			l_version: detachable CONF_VERSION
			l_settings: like {CONF_TARGET}.settings
			l_variables: like {CONF_TARGET}.internal_variables
			l_name: ARRAYED_LIST [READABLE_STRING_8]
			l_val: ARRAYED_LIST [detachable READABLE_STRING_GENERAL]
			l_sorted_list: ARRAYED_LIST [STRING_32]
			l_sorter: QUICK_SORTER [STRING_32]
		do
			current_target := a_target
			append_text_indent ("<target")
			append_text_attribute ("name", a_target.name)
			if attached a_target.extends as l_extends then
				append_text_attribute ("extends", l_extends.name)
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
				create l_name.make (4)
				create l_val.make (4)
				if l_root.is_all_root then
					l_name.force ("all_classes")
					l_val.force (l_root.is_all_root.out.as_lower)
				else
					l_name.force ("cluster")
					l_val.force (l_root.cluster_name)
					l_name.force ("class")
					l_val.force (l_root.class_type_name)
					l_name.force ("feature")
					l_val.force (l_root.feature_name)
				end
				append_tag ("root", Void, l_name, l_val)
			end
			l_version := a_target.internal_version
			if l_version /= Void then
				create l_name.make (8)
				create l_val.make (8)
				l_name.force ("major")
				l_val.force (l_version.major.out)
				l_name.force ("minor")
				l_val.force (l_version.minor.out)
				l_name.force ("release")
				l_val.force (l_version.release.out)
				l_name.force ("build")
				l_val.force (l_version.build.out)
				l_name.force ("company")
				l_val.force (l_version.company)
				l_name.force ("product")
				l_val.force (l_version.product)
				l_name.force ("trademark")
				l_val.force (l_version.trademark)
				l_name.force ("copyright")
				l_val.force (l_version.copyright)
				append_tag ("version", Void, l_name, l_val)
			end
			append_file_rule (a_target.internal_file_rule)
			append_options (a_target.internal_options, Void)
			from
				create l_name.make (2)
				l_name.force ("name")
				l_name.force ("value")
				create l_val.make (2)
				l_settings := a_target.internal_settings
				create l_sorted_list.make_from_array (l_settings.current_keys)
				create l_sorter.make (create {COMPARABLE_COMPARATOR [STRING_32]})
				l_sorter.sort (l_sorted_list)
				l_sorted_list.start
			until
				l_sorted_list.after
			loop
				l_val.wipe_out
				l_val.force (l_sorted_list.item_for_iteration)
				if attached l_settings.item (l_sorted_list.item_for_iteration) as l_setting_item then
						-- l_sorted_list is built from l_settings.current_keys, then l_settings has related item
					l_val.force (l_setting_item)
				end
				append_tag ("setting", Void, l_name, l_val)
				l_sorted_list.forth
			end
			if a_target.immediate_setting_concurrency.is_set then
				if includes_this_or_after (namespace_1_7_0) then
						-- Use "concurrency" setting.
					l_val.wipe_out
					l_val.force (s_concurrency)
					l_val.force (a_target.immediate_setting_concurrency.item)
				else
						-- Use "multithreaded" setting.
					l_val.wipe_out
					l_val.force (s_multithreaded)
					if a_target.immediate_setting_concurrency.index = {CONF_TARGET}.setting_concurrency_index_none then
						l_val.force ("false")
					else
							-- There is no way to specify all concurrent variants,
							-- so only multithreaded variant is used.
						l_val.force ("true")
					end
				end
				append_tag ("setting", Void, l_name, l_val)
			end
			append_mapping (a_target.internal_mapping)
			append_externals (a_target.internal_external_include, "include", "location")
			append_externals (a_target.internal_external_cflag, "cflag", "value")
			append_externals (a_target.internal_external_object, "object", "location")
			append_externals (a_target.internal_external_library, "library", "location")
			append_externals (a_target.internal_external_resource, "resource", "location")
			append_externals (a_target.internal_external_linker_flag, "linker_flag", "value")
			append_externals (a_target.internal_external_make, "make", "location")
			append_actions (a_target.internal_pre_compile_action, "pre")
			append_actions (a_target.internal_post_compile_action, "post")

			from
				l_variables := a_target.internal_variables
				l_variables.start
			until
				l_variables.after
			loop
				l_val.wipe_out
				l_val.force (l_variables.key_for_iteration)
				l_val.force (l_variables.item_for_iteration)
				append_tag ("variable", Void, l_name, l_val)
				l_variables.forth
			end

			if attached a_target.internal_precompile as l_pre then
				l_pre.process (Current)
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

	process_assembly (an_assembly: CONF_ASSEMBLY)
			-- Visit `an_assembly'.
		local
			l_str: detachable READABLE_STRING_GENERAL
		do
			append_pre_group ("assembly", an_assembly)
			if an_assembly.location.original_path.is_empty then
				l_str := an_assembly.assembly_name
				if l_str /= Void and then not l_str.is_empty then
					append_text_attribute ("assembly_name", l_str)
				end
				l_str := an_assembly.assembly_version
				if l_str /= Void and then not l_str.is_empty then
					append_text_attribute ("assembly_version", l_str)
				end
				l_str := an_assembly.assembly_culture
				if l_str /= Void and then not l_str.is_empty then
					append_text_attribute ("assembly_culture", l_str)
				end
				l_str := an_assembly.assembly_public_key_token
				if l_str /= Void and then not l_str.is_empty then
					append_text_attribute ("assembly_key", l_str)
				end
			end
			append_val_group (an_assembly)
			append_post_group ("assembly")
		ensure then
			indent_back: indent = old indent
		end

	process_library (a_library: CONF_LIBRARY)
			-- Visit `a_library'.
		do
			append_pre_group ("library", a_library)
			if namespace /= namespace_1_0_0 and then a_library.use_application_options then
				append_text (" use_application_options=%"true%"")
			end
			append_val_group (a_library)
			if attached a_library.visible as l_visible then
				append_visible (l_visible)
			end
			append_post_group ("library")
		ensure then
			indent_back: indent = old indent
		end

	process_precompile (a_precompile: CONF_PRECOMPILE)
			-- Visit `a_precompile'.
		do
			append_pre_group ("precompile", a_precompile)
			if attached a_precompile.eifgens_location as l_loc then
				append_text_attribute ("eifgens_location", l_loc.original_path)
			end
			append_val_group (a_precompile)
			append_post_group ("precompile")
		ensure then
			indent_back: indent = old indent
		end

	process_cluster (a_cluster: CONF_CLUSTER)
			-- Visit `a_cluster'.
		do
				-- ignore subclusters, except if we are handling one.
			if (a_cluster.parent = Void or current_is_subcluster) then
				current_is_subcluster := False
				if a_cluster.is_test_cluster then
					append_pre_group ("tests", a_cluster)
				else
					append_pre_group ("cluster", a_cluster)
				end
				append_attr_cluster (a_cluster)
				append_val_group (a_cluster)
				append_val_cluster (a_cluster)
				if a_cluster.is_test_cluster then
					append_post_group ("tests")
				else
					append_post_group ("cluster")
				end
			end
		ensure then
			indent_back: indent = old indent
		end

	process_override (an_override: CONF_OVERRIDE)
			-- Visit `an_override'.
		local
			l_overrides: detachable LIST [CONF_GROUP]
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
						append_text_indent ("<overrides")
						append_text_attribute ("group", l_overrides.item.name)
						append_text ("/>%N")
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

	current_target: detachable CONF_TARGET
			-- The target we are currently processing.

	current_is_subcluster: BOOLEAN
			-- Is the current cluster/override a subcluster?

	process_in_alphabetic_order (a_groups: STRING_TABLE [CONF_GROUP])
			-- Process `a_groups' in alphabetic order corresponding to their key.
		require
			a_groups_not_void: a_groups /= Void
		local
			l_sorted_list: ARRAYED_LIST [READABLE_STRING_GENERAL]
			l_sorter: QUICK_SORTER [READABLE_STRING_GENERAL]
		do
			from
				create l_sorted_list.make_from_array (a_groups.current_keys)
				create l_sorter.make (create {COMPARABLE_COMPARATOR [READABLE_STRING_GENERAL]})
				l_sorter.sort (l_sorted_list)
				l_sorted_list.start
			until
				l_sorted_list.after
			loop
				if attached a_groups.item (l_sorted_list.item_for_iteration) as l_grp then
					l_grp.process (Current)
				end
				l_sorted_list.forth
			end
		end

	append_tag (a_name: READABLE_STRING_8; a_value: detachable READABLE_STRING_32; an_attribute_names: detachable ARRAYED_LIST [READABLE_STRING_8]; an_attribute_values: detachable ARRAYED_LIST [detachable READABLE_STRING_GENERAL])
			-- Append a tag with `a_name', `a_value' and `an_attributes' to `text', intendend it with `indent' tabs.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			attributes_same_count: (an_attribute_names = Void and an_attribute_values = Void) or else
					((an_attribute_names /= Void and an_attribute_values /= Void) and then an_attribute_names.count = an_attribute_values.count)
		local
			l_val: detachable READABLE_STRING_GENERAL
			u: UTF_CONVERTER
		do
			append_text_indent ("<")
			append_text (u.string_32_to_utf_8_string_8 (a_name))
			if (an_attribute_names /= Void and an_attribute_values /= Void) and then not an_attribute_names.is_empty then
				from
					an_attribute_names.start
					an_attribute_values.start
				until
					an_attribute_names.after
				loop
					l_val := an_attribute_values.item
					if l_val /= Void and then not l_val.is_empty then
						append_text_attribute (an_attribute_names.item, l_val.as_string_32)
					end
					an_attribute_names.forth
					an_attribute_values.forth
				end
			end
			if a_value /= Void and then not a_value.is_empty then
				append_text (">")
				append_text_escaped (a_value, True)
				append_text ("</")
				append_text (u.string_32_to_utf_8_string_8 (a_name))
				append_text (">%N")
			else
				append_text ("/>%N")
			end
		end

	append_text_indent (a_text: STRING)
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

	append_text (a_text: READABLE_STRING_8)
			-- Append `a_text'.
		require
			a_text_not_void: a_text /= Void and then not a_text.is_empty
			a_text_valid: -- `a_text' is a valid ASCII
		do
			text.append (a_text)
		end

	append_text_escaped (v: READABLE_STRING_GENERAL; multiline: BOOLEAN)
			-- Append `v' replacing special characters by character references,
			-- if `multiline' is False, also escape any New Line.
		require
			attached_v: v /= Void
		local
			i: like {STRING_32}.count
			m: like {STRING_32}.count
			c: CHARACTER_32
		do
			from
				m := v.count
			until
				i >= m
			loop
				i := i + 1
				c := v [i]
					-- Replace special markup characters with character entities
					-- and control or non-ASCII characters with character references.
				inspect c
				when '<' then text.append_string_general (lt_entity)
				when '>' then text.append_string_general (gt_entity)
				when '&' then text.append_string_general (amp_entity)
				when '"' then text.append_string_general (quot_entity)
				else
					if multiline and then c = '%N' then
						text.append_character ('%N')
					else
						if
							'%T' = c or else
							(' ' <= c and then c <= '%/127/')
						then
							text.append_character (c.to_character_8)
						else
							text.append_character ('&')
							text.append_character ('#')
							text.append_natural_32 (c.code.as_natural_32)
							text.append_character (';')
						end
					end
				end
			end
		end

	append_text_attribute (n: READABLE_STRING_GENERAL; v: READABLE_STRING_GENERAL)
			-- Append XML attribute of name `n' with value `v'
			-- in the form ' n="v"'.
		require
			n_attached: attached n
			v_attached: attached v
			valid_n: -- n is a valid Name in ASCII
		do
			text.append_character (' ')
			text.append_string_general (n)
			text.append_character ('=')
			text.append_character ('"')
			append_text_escaped (v, False)
			text.append_character ('"')
		end

	append_description_tag (a_description: detachable READABLE_STRING_32)
			-- Append `a_description'.
		do
			if a_description /= Void and then not a_description.is_empty then
				append_tag ("description", a_description, Void, Void)
			end
		end

	append_condition_list (condition: attached like {CONF_CONDITION}.platform; get_name: FUNCTION [INTEGER, STRING]; name: READABLE_STRING_8)
			-- Append condition of name `name' with values specified by `condition' with printable elements that can be obtained using `get_name'.
		require
			condition_attached: attached condition
			get_name_attached: attached get_name
			name_attached: attached name
		local
			space_delimiter: STRING
		do
			if attached condition.item as i and then attached i.value as v then
				append_text_indent ("<")
				append_text (name)
				if i.invert then
					append_text (" excluded_value=%"")
				else
					append_text (" value=%"")
				end
				from
						-- The first item is not preceded with any delimiter.
						-- The second and next ones are preceded with a space
						-- that is assigned to `space_delimiter' in the loop.
					space_delimiter := ""
					v.start
				until
					v.after
				loop
					if not space_delimiter.is_empty then
						append_text (space_delimiter)
					end
					append_text_escaped (get_name.item ([v.item]).as_lower, False)
					space_delimiter := once " "
					v.forth
				end
				append_text ("%"/>%N")
			end
		end


	append_conditionals (a_conditions: detachable ARRAYED_LIST [CONF_CONDITION]; is_assembly: BOOLEAN)
			-- Append `a_conditions' ignore platform if it `is_assembly'.
		local
			l_condition: CONF_CONDITION
			l_done: BOOLEAN
			l_custs: like {CONF_CONDITION}.custom
			l_custom: STRING_TABLE [BOOLEAN]
			l_name: STRING
			l_ver: like {CONF_CONDITION}.version.item
		do
			if a_conditions /= Void then
					-- assembly and only the default rule? => don't print it
				if is_assembly and then a_conditions.count = 1 then
					l_condition := a_conditions.first
					l_done := l_condition.build = Void and l_condition.platform = Void and l_condition.concurrency = Void and l_condition.version.is_empty and l_condition.custom.is_empty
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
						if attached l_condition.platform as p then
							append_condition_list (p, agent get_platform_name, "platform")
						end
						if attached l_condition.build as b then
							append_condition_list (b, agent get_build_name, "build")
						end
						if attached l_condition.concurrency as c then
							if includes_this_or_after (namespace_1_8_0) then
									-- Use "concurrency" condition.
								append_condition_list (c, agent get_concurrency_name, "concurrency")
							else
									-- Use "multithreaded" condition.
								append_text_indent ("<multithreaded value=%""+ (c.item.value.has (concurrency_none) = c.item.invert).out.as_lower+"%"/>%N")
							end
						end

						if attached l_condition.dynamic_runtime as l_dyn_runtime then
							append_text_indent ("<dynamic_runtime value=%""+ l_dyn_runtime.item.out.as_lower +"%"/>%N")
						end

							-- don't print dotnet for assemblies
						if not is_assembly and then attached l_condition.dotnet as l_dotnet then
							append_text_indent ("<dotnet value=%""+ l_dotnet.item.out.as_lower +"%"/>%N")
						end

						across
							l_condition.version as ic_versons
						loop
							l_ver := ic_versons.item
							append_text_indent ("<version type=%""+ ic_versons.key +"%"")
							if attached l_ver.item.min as l_ver_min then
								append_text (" min=%""+ l_ver_min.version+"%"")
							end
							if attached l_ver.item.max as l_ver_max then
								append_text (" max=%""+ l_ver_max.version +"%"")
							end
							append_text ("/>%N")
						end

						from
							l_custs := l_condition.custom
							l_custs.start
						until
							l_custs.after
						loop
							l_custom := l_custs.item_for_iteration
							from
								l_custom.start
							until
								l_custom.after
							loop
								if l_custom.item_for_iteration then
									l_name := "excluded_value"
								else
									l_name := "value"
								end
								append_text_indent ("<custom")
								append_text_attribute ("name", l_custs.key_for_iteration)
								append_text_attribute (l_name, l_custom.key_for_iteration)
								append_text ("/>%N")
								l_custom.forth
							end
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

	append_mapping (a_mapping: detachable STRING_TABLE [STRING_32])
			-- Append `a_mapping'.
		do
			if a_mapping /= Void then
				from
					a_mapping.start
				until
					a_mapping.after
				loop
					append_text_indent ("<mapping")
					append_text_attribute ("old_name", a_mapping.key_for_iteration)
					append_text_attribute ("new_name", a_mapping.item_for_iteration)
					append_text ("/>%N")
					a_mapping.forth
				end
			end
		end

	append_externals (an_externals: ARRAYED_LIST [CONF_EXTERNAL]; a_name: STRING; a_value: STRING)
			-- Append `an_externals'.
		require
			an_externals_not_void: an_externals /= Void
			a_name_ok: a_name /= Void and then not a_name.is_empty
			valid_a_value: attached a_value and then not a_value.is_empty
		local
			l_ext: CONF_EXTERNAL
		do
			if not an_externals.is_empty then
				from
					an_externals.start
				until
					an_externals.after
				loop
					l_ext := an_externals.item
					append_text_indent ("<external_")
					append_text (a_name)
					append_text_attribute (a_value, l_ext.internal_location)
					append_text (">%N")
					indent := indent + 1
					last_count := text.count

					append_description_tag (l_ext.description)
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

	append_actions (an_actions: ARRAYED_LIST [CONF_ACTION]; a_name: STRING)
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
				if attached l_action.working_directory as l_wdir then
					append_text_attribute ("working_directory", l_wdir.original_path)
				end
				append_text_attribute ("command", l_action.command)
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

	append_file_rule (a_file_rules: ARRAYED_LIST [CONF_FILE_RULE])
			-- Append `a_file_rule'
		local
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
						-- Save patterns lexicographically ordered.
					if attached l_rule.ordered_exclude as p then
						across p as pc loop
							append_tag ("exclude", pc.item, Void, Void)
						end
					end
					if attached l_rule.ordered_include as p then
						across p as pc loop
							append_tag ("include", pc.item, Void, Void)
						end
					end
					append_conditionals (l_rule.internal_conditions, False)
					indent := indent - 1
					append_text_indent ("</file_rule>%N")
				end

				a_file_rules.forth
			end
		end

	append_options (an_options: detachable CONF_OPTION; a_class: detachable READABLE_STRING_GENERAL)
			-- Append `an_options', optionally for `a_class'.
		local
			l_str: detachable STRING_32
			l_debugs, l_warnings: detachable STRING_TABLE [BOOLEAN]
			l_assertions: detachable CONF_ASSERTIONS
			l_a_name: ARRAYED_LIST [STRING]
			l_a_val: ARRAYED_LIST [STRING_32]
			l_sorted_list: ARRAYED_LIST [READABLE_STRING_GENERAL]
			l_sorter: QUICK_SORTER [READABLE_STRING_GENERAL]
		do
			if an_options /= Void and then not an_options.is_empty then
				if a_class /= Void and then not a_class.is_empty then
					append_text_indent ("<class_option")
					append_text_attribute ("class", a_class)
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
				if an_options.catcall_detection.is_set then
					append_text (" cat_call_detection=%""+an_options.catcall_detection.out+"%"")
				end
				if an_options.is_attached_by_default_configured then
					append_text (" is_attached_by_default=%""+an_options.is_attached_by_default.out.as_lower+"%"")
				end
				if an_options.is_obsolete_routine_type_configured or else an_options.is_obsolete_routine_type and then is_after_or_equal (namespace, namespace_1_15_0) then
					append_text (" is_obsolete_routine_type=%""+an_options.is_obsolete_routine_type.out.as_lower+"%"")
				end
				if an_options.void_safety.is_set then
					if is_after_or_equal (namespace, namespace_1_11_0) then
							-- Current namespace.
						l_str := an_options.void_safety.out
					else
							-- Earlier namespaces with less void-safety levels.
						inspect
							an_options.void_safety.index
						when {CONF_OPTION}.void_safety_index_none then
							l_str := "none"
						when
							{CONF_OPTION}.void_safety_index_conformance,
							{CONF_OPTION}.void_safety_index_initialization
						then
							l_str := "initialization"
						else
							l_str := "all"
						end
						if is_after_or_equal (namespace, namespace_1_9_0) then
							if an_options.void_safety.index = {CONF_OPTION}.void_safety_index_all then
								append_text (" is_void_safe=%"true%"")
							else
								append_text (" is_void_safe=%"false%"")
							end
						end
					end
					append_text (" void_safety=%"" + l_str + "%"")
				end
				if an_options.syntax.is_set then
					append_text (" syntax=%"" + an_options.syntax.out + "%"")
				end
				l_str := an_options.local_namespace
				if l_str /= Void and then not l_str.is_empty then
					append_text_attribute ("namespace", l_str)
				end
				append_text (">%N")

				indent := indent + 1
				append_description_tag (an_options.description)

				l_debugs := an_options.debugs
				if l_debugs /= Void and then not l_debugs.is_empty then
					create l_sorted_list.make_from_array (l_debugs.current_keys)
					create l_sorter.make (create {STRING_COMPARATOR}.make)
					l_sorter.sort (l_sorted_list)
					from
						l_sorted_list.start
					until
						l_sorted_list.after
					loop
						append_text_indent ("<debug")
						append_text_attribute ("name", l_sorted_list.item_for_iteration)
						append_text (" enabled=%""+l_debugs.item (l_sorted_list.item_for_iteration).out.as_lower+"%"/>%N")
						l_sorted_list.forth
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
					create l_sorted_list.make_from_array (l_warnings.current_keys)
					create l_sorter.make (create {STRING_COMPARATOR}.make)
					l_sorter.sort (l_sorted_list)
					from
						l_sorted_list.start
					until
						l_sorted_list.after
					loop
						append_text_indent ("<warning name=%""+l_sorted_list.item_for_iteration+"%"")
						append_text (" enabled=%""+l_warnings.item (l_sorted_list.item_for_iteration).out.as_lower+"%"/>%N")
						l_sorted_list.forth
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

	append_visible (a_visible: STRING_TABLE [EQUALITY_TUPLE [TUPLE [class_renamed: STRING_32; features: detachable STRING_TABLE [STRING_32]]]])
			-- Append visible rules.
		require
			a_visible_not_void: a_visible /= Void
		local
			l_vis_feat: detachable STRING_TABLE [STRING_32]
			l_class: READABLE_STRING_GENERAL
			l_feat: detachable READABLE_STRING_GENERAL
			l_feat_rename, l_class_rename: detachable STRING_32
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
						if l_feat.same_string ("*") then
							l_feat := Void
						end
						append_text_indent ("<visible")
						append_text_attribute ("class", l_class)
						if l_feat /= Void then
							append_text_attribute ("feature", l_feat)
						end
						if l_class_rename /= Void and then not l_class_rename.is_empty and then not l_class_rename.same_string_general (l_class) then
							append_text_attribute ("class_rename", l_class_rename)
						end
						if
							l_feat_rename /= Void and then
							not l_feat_rename.is_empty and then
							(l_feat = Void or else not l_feat_rename.same_string_general (l_feat))
						then
							append_text_attribute ("feature_rename", l_feat_rename)
						end
						append_text ("/>%N")
						l_vis_feat.forth
					end
				else
					append_text_indent ("<visible")
					append_text_attribute ("class", l_class)
					if l_class_rename /= Void and then not l_class_rename.is_empty and then not l_class_rename.same_string_general (l_class) then
						append_text_attribute ("class_rename", l_class_rename)
					end
					append_text ("/>%N")
				end
				a_visible.forth
			end

		end

	append_pre_group (a_tag: STRING; a_group: CONF_GROUP)
			-- Append the things that start the entry for `a_group'
		require
			a_group_not_void: a_group /= Void
			a_tag_ok: a_tag /= Void and then not a_tag.is_empty
		local
			l_str: STRING_32
		do
			l_str := a_group.location.original_path
			if l_str.is_empty then
				l_str := "none"
			end
			append_text_indent ("<"+a_tag)
			append_text_attribute ("name", a_group.name)
			append_text_attribute ("location", l_str)
			if not a_group.is_library and a_group.internal_read_only then
				append_text_attribute ("readonly", {STRING_32} "true")
			elseif a_group.is_library and a_group.is_readonly_set then
				append_text_attribute ("readonly", a_group.is_readonly.out.as_lower)
			end
			if
				attached {CONF_VIRTUAL_GROUP} a_group as l_vg and then
				attached l_vg.name_prefix as s and then not s.is_empty
			then
				append_text_attribute ("prefix", s)
			end
		end

	append_val_group (a_group: CONF_GROUP)
			-- Append the things that come in the value part of `a_group'.
		require
			a_group_not_void: a_group /= Void
		do
			append_text (">%N")
			indent := indent + 1
			last_count := text.count
			append_note_tag (a_group)
			append_description_tag (a_group.description)
			append_conditionals (a_group.internal_conditions, a_group.is_assembly)
			append_options (a_group.internal_options, Void)
			if
				attached {CONF_VIRTUAL_GROUP} a_group as l_vg and then
				attached l_vg.renaming as l_renaming
			then
				from
					l_renaming.start
				until
					l_renaming.after
				loop
					append_text_indent ("<renaming")
					append_text_attribute ("old_name", l_renaming.key_for_iteration)
					append_text_attribute ("new_name", l_renaming.item_for_iteration)
					append_text ("/>%N")
					l_renaming.forth
				end
			end
			if attached a_group.internal_class_options as l_c_opt then
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

	append_post_group (a_tag: STRING)
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

	append_attr_cluster (a_cluster: CONF_CLUSTER)
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

	append_val_cluster (a_cluster: CONF_CLUSTER)
			-- Append the values for `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			l_visible: detachable STRING_TABLE [EQUALITY_TUPLE [TUPLE [STRING_32, detachable STRING_TABLE [STRING_32]]]]
		do
			append_file_rule (a_cluster.internal_file_rule)
			append_mapping (a_cluster.internal_mapping)
			if
				attached a_cluster.internal_dependencies as l_deps and then
				attached l_deps.linear_representation as g
			then
					-- Save group names lexicographically ordered.
				(create {QUICK_SORTER [CONF_GROUP]}.make (create {COMPARABLE_COMPARATOR [CONF_GROUP]})).sort (g)
				across
					g as gc
				loop
					append_text_indent ("<uses")
					append_text_attribute ("group", gc.item.name)
					append_text ("/>%N")
				end
			end
			l_visible := a_cluster.visible
			if l_visible /= Void then
				append_visible (l_visible)
			end
				-- process subclusters
			if attached a_cluster.children as l_clusters then
				from
					l_clusters.start
				until
					l_clusters.after
				loop
					current_is_subcluster := True
					l_clusters.item.process (Current)
					l_clusters.forth
				end
			end
		end

	append_note_tag (a_notable: CONF_NOTABLE)
			-- Append `a_notes'.
		require
			a_notable_not_void: a_notable /= Void
		local
			l_note: detachable CONF_NOTE_ELEMENT
		do
			l_note := a_notable.note_node
			if l_note /= Void then
				append_note_recursive (l_note)
			end
		end

	append_note_recursive (a_note: CONF_NOTE_ELEMENT)
			-- Append `a_note' recursively.
		require
			a_note_not_void: a_note /= Void
		local
			l_name: READABLE_STRING_GENERAL
			l_value: STRING_32
			l_attr: like {CONF_NOTE_ELEMENT}.attributes
		do
			if not a_note.element_name.is_empty then
				append_text_indent ("<")
				append_text_escaped (a_note.element_name, False)
				indent := indent + 1
				l_attr := a_note.attributes
				from
					l_attr.start
				until
					l_attr.after
				loop
					l_name := l_attr.key_for_iteration
					l_value := l_attr.item_for_iteration
					if l_value = Void then
						l_value := once {STRING_32} ""
					end
					if l_name /= Void and then not l_name.is_empty then
						append_text_attribute (l_name, l_value)
					end
					l_attr.forth
				end

				if not a_note.is_empty then
					append_text (">%N")
					across
						a_note as ic
					loop
						append_note_recursive (ic.item)
					end
					indent := indent - 1
					append_text_indent ("</" + a_note.element_name +">%N")
				else
					indent := indent - 1
					append_text ("/>%N")
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
