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

	CONF_LOAD_PARSE_CALLBACKS_CONSTANTS

create
	make,
	make_namespace_and_schema

feature {NONE} -- Initialization

	make
			-- Create.
		do
			make_namespace_and_schema (latest_namespace, latest_schema)
		end

	make_namespace_and_schema (a_namespace: detachable READABLE_STRING_GENERAL; a_schema: READABLE_STRING_GENERAL)
			-- Create with `a_namespace' and `a_schema'.
		require
			a_schema_set: a_schema /= Void
		do
			if a_namespace = Void then
				namespace := Void
			else
				namespace := a_namespace.as_string_32
			end
			schema := a_schema.as_string_32
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
			append_tag_open ({STRING_32} "redirection")
			append_text (" xmlns=%"")
			if attached namespace as l_namespace then
				append_text_escaped (l_namespace, False)
--Alternative:	append_text (utf.string_32_to_utf_8_string_8 (l_namespace)) -- FIXME: maybe add utf-8 BOM ...
			else
				append_text_escaped ({XML_XMLNS_CONSTANTS}.default_namespace, False)
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
			if attached a_redirection.message as msg then
				append_text_attribute ("message", msg)
			end

			append_text_attribute ("location", a_redirection.redirection_location)
			append_tag_close
			Precursor (a_redirection)
			append_end_tag ({STRING_32} "redirection")
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
			append_tag_open ({STRING_32} "system")
			append_text (" xmlns=%"")
			if attached namespace as l_namespace then
				append_text_escaped (l_namespace, False)
--Alternative:	append_text (utf.string_32_to_utf_8_string_8 (l_namespace)) -- FIXME: maybe add utf-8 BOM ...
			else
				append_text_escaped ({XML_XMLNS_CONSTANTS}.default_namespace, False)
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
				append_boolean_attribute ("readonly", False)
			end
			l_target := a_system.library_target
			if l_target /= Void then
				append_text_attribute ("library_target", l_target.name)
			end
			append_tag_close
			append_note_tag (a_system)
			append_description_tag (a_system.description)

			Precursor (a_system)

			append_end_tag ({STRING_32} "system")
		ensure then
			indent_back: indent = old indent
		end

	process_target (a_target: CONF_TARGET)
			-- Visit `a_target'.
		local
			l_version: detachable CONF_VERSION
			l_settings: like {CONF_TARGET}.settings
			l_sorted_list: ARRAYED_LIST [attached like known_settings.item]
			setting_value: like {CONF_TARGET}.settings.item
			o: CONF_TARGET_OPTION
		do
			current_target := a_target
			append_tag_open ({STRING_32} "target")
			append_text_attribute (ta_name, a_target.name)
			if attached {CONF_REMOTE_TARGET_REFERENCE} a_target.parent_reference as l_remote and then includes_this_or_after (namespace_1_18_0) then
				if attached l_remote.name as l_parent_ref_name then
					append_text_attribute (ta_extends, l_parent_ref_name)
				end
				append_text_attribute (ta_extends_location, l_remote.location)
			elseif attached a_target.extends as l_extends then
					-- Ignore the target if it is a library one (i.e. not explicitly specified in the configuration).
				append_text_attribute (ta_extends, l_extends.name)
			elseif attached {CONF_LOCAL_TARGET_REFERENCE} a_target.parent_reference as l_local then
				append_text_attribute (ta_extends, l_local.name)
			end
			if a_target.is_abstract then
				append_text_attribute (ta_abstract, configuration_value_true)
			end
			append_tag_close
			append_note_tag (a_target)
			append_description_tag (a_target.description)
			if attached a_target.internal_root as l_root then
				append_tag_open ({STRING_32} "root")
				if l_root.is_all_root then
					append_boolean_attribute ("all_classes", l_root.is_all_root)
				else
					append_optional_text_attribute ("cluster", l_root.cluster_name)
					append_optional_text_attribute ("class", l_root.class_type_name)
					append_optional_text_attribute ("feature", l_root.feature_name)
				end
				append_tag_close_empty
			end
			l_version := a_target.internal_version
			if l_version /= Void then
				append_tag_open ({STRING_32} "version")
				append_text_attribute ("major", l_version.major.out)
				append_text_attribute ("minor", l_version.minor.out)
				append_text_attribute ("release", l_version.release.out)
				append_text_attribute ("build", l_version.build.out)
				append_optional_text_attribute ("company", l_version.company)
				append_optional_text_attribute ("product", l_version.product)
				append_optional_text_attribute ("trademark", l_version.trademark)
				append_optional_text_attribute ("copyright", l_version.copyright)
				append_tag_close_empty
			end
			append_file_rule (a_target.internal_file_rule)
			o := persistent_target_options (a_target)
			append_target_options (o)

			l_settings := a_target.internal_settings
			create l_sorted_list.make_from_iterable (known_settings)
			;(create {QUICK_SORTER [like known_settings.item]}.make (create {COMPARABLE_COMPARATOR [attached like known_settings.item]})).sort (l_sorted_list)
			across
				l_sorted_list as s
			loop
				if valid_setting (s, namespace) then
					setting_value := l_settings.item (s)
					if
						not attached setting_value and then
						boolean_settings.has (s) and then
						is_boolean_setting_true (s, if attached namespace as n then n else latest_namespace end) /= is_boolean_setting_true (s, a_target.system.namespace)
					then
							-- The setting has a different default value in the current namespace.
						setting_value := configuration_boolean_value (is_boolean_setting_true (s, a_target.system.namespace))
					end
					if attached setting_value then
						append_tag_open ({STRING_32} "setting")
						append_text_attribute ("name", s)
						append_text_attribute ("value", setting_value)
						append_tag_close_empty
					end
				end
			end
				-- Add a dead code removal setting.
			if
				attached o and then
				attached o.dead_code as dead_code and then
				dead_code.is_set
			then
				append_tag_open ({STRING_32} "setting")
				append_text_attribute ("name", s_dead_code_removal)
				append_text_attribute ("value",
					if includes_this_or_after (namespace_1_20_0) then
							-- Enumeration in 19.05 and later.
						dead_code.item
					else
							-- Boolean in 18.11 and earlier.
						configuration_boolean_value (dead_code.index /= {CONF_TARGET_OPTION}.dead_code_index_none)
					end)
				append_tag_close_empty
			end
				-- Add a manifest array type setting.
			if
				attached o and then
				attached o.array_override as array_override and then
				array_override.is_set and then
				includes_this_or_after (namespace_1_18_0)
			then
				append_tag_open ({STRING_32} "setting")
				append_text_attribute ("name", s_manifest_array_type)
				append_text_attribute ("value", array_override.item)
				append_tag_close_empty
			end
			if
				attached o and then
				attached o.concurrency_capability as concurrency_capability and then
				concurrency_capability.is_root_set and then
				includes_this_or_before (namespace_1_15_0)
			then
					-- Before `namespace_1_15_0' inclusively this was a setting.
					-- In `namespace_1_16_0' and above this is a capaility that is handled elsewhere.
				append_tag_open ({STRING_32} "setting")
				if includes_this_or_after (namespace_1_7_0) then
						-- Use "concurrency" setting.
					append_text_attribute ("name", s_concurrency)
					append_text_attribute ("value", concurrency_capability.custom_root)
				else
						-- Use "multithreaded" setting.
					append_text_attribute ("name", s_multithreaded)
						-- There is no way to specify all concurrent variants,
						-- so only multithreaded variant is used.
					append_boolean_attribute ("value", concurrency_capability.custom_root_index /= {CONF_TARGET_OPTION}.concurrency_index_none)
				end
				append_tag_close_empty
			end
			if
				attached o and then
				o.has_capability and then
				includes_this_or_after (namespace_1_16_0)
			then
				append_start_tag (tag_capability)
					-- Add capabilities in alphabetical order as specified in ECF schema.
				append_ordered_capability (o.catcall_safety_capability, tag_capability_catcall_detection)
					-- TODO: append_unordered_capability (o.code_capability, tag_capability_code)
				append_ordered_capability (o.concurrency_capability, tag_capability_concurrency)
					-- TODO: append_unordered_capability (o.platform_capability, tag_capability_platform)
				append_ordered_capability (o.void_safety_capability, tag_capability_void_safety)
				append_end_tag (tag_capability)
			end
			append_mapping (a_target.internal_mapping)
			append_externals (a_target.internal_external_include, {STRING_32} "external_include", "location")
			append_externals (a_target.internal_external_cflag, {STRING_32} "external_cflag", "value")
			append_externals (a_target.internal_external_object, {STRING_32} "external_object", "location")
			append_externals (a_target.internal_external_library, {STRING_32} "external_library", "location")
			append_externals (a_target.internal_external_resource, {STRING_32} "external_resource", "location")
			append_externals (a_target.internal_external_linker_flag, {STRING_32} "external_linker_flag", "value")
			append_externals (a_target.internal_external_make, {STRING_32} "external_make", "location")
			append_actions (a_target.internal_pre_compile_action, {STRING_32} "pre_compile_action")
			append_actions (a_target.internal_post_compile_action, {STRING_32} "post_compile_action")

			across
				a_target.internal_variables as v
			loop
				append_tag_open ({STRING_32} "variable")
				append_text_attribute ("name", @ v.key)
				append_text_attribute ("value", v)
				append_tag_close_empty
			end

			if attached a_target.internal_precompile as l_pre then
				l_pre.process (Current)
			end

			process_in_alphabetic_order (a_target.internal_libraries)
			process_in_alphabetic_order (a_target.internal_assemblies)
			process_in_alphabetic_order (a_target.internal_clusters)
			process_in_alphabetic_order (a_target.internal_overrides)

			append_end_tag ({STRING_32} "target")
		ensure then
			indent_back: indent = old indent
		end

	process_assembly (an_assembly: CONF_ASSEMBLY)
			-- Visit `an_assembly'.
		local
			l_str: READABLE_STRING_GENERAL
		do
			append_pre_group ({STRING_32} "assembly", an_assembly)
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
			append_val_group (an_assembly, False, False)
			append_post_group ({STRING_32} "assembly")
		ensure then
			indent_back: indent = old indent
		end

	process_library (a_library: CONF_LIBRARY)
			-- Visit `a_library'.
		do
			append_pre_group ({STRING_32} "library", a_library)
			if namespace /= namespace_1_0_0 and then a_library.use_application_options then
				append_boolean_attribute ("use_application_options", True)
			end
			append_val_group (a_library, False, False)
			if attached a_library.visible as l_visible then
				append_visible (l_visible)
			end
			append_post_group ({STRING_32} "library")
		ensure then
			indent_back: indent = old indent
		end

	process_precompile (a_precompile: CONF_PRECOMPILE)
			-- Visit `a_precompile'.
		do
			append_pre_group ({STRING_32} "precompile", a_precompile)
			if attached a_precompile.eifgens_location as l_loc then
				append_text_attribute ("eifgens_location", l_loc.original_path)
			end
			append_val_group (a_precompile, False, False)
			append_post_group ({STRING_32} "precompile")
		ensure then
			indent_back: indent = old indent
		end

	process_cluster (a_cluster: CONF_CLUSTER)
			-- Visit `a_cluster'.
		local
			g: READABLE_STRING_32
		do
				-- ignore subclusters, except if we are handling one.
			if a_cluster.parent = Void or current_is_subcluster then
				current_is_subcluster := False
				g := if a_cluster.is_test_cluster then {STRING_32} "tests" else {STRING_32} "cluster" end
				append_pre_group (g, a_cluster)
				append_attr_cluster (a_cluster)
				append_val_group (a_cluster, True, True)
				append_val_cluster (a_cluster)
				append_post_group (g)
			end
		ensure then
			indent_back: indent = old indent
		end

	process_override (an_override: CONF_OVERRIDE)
			-- Visit `an_override'.
		do
				-- ignore subclusters, except if we are handling one.
			if an_override.parent = Void or current_is_subcluster then
				current_is_subcluster := False
				append_pre_group ({STRING_32} "override", an_override)
				append_attr_cluster (an_override)
				append_val_group (an_override, True, False)
				append_val_cluster (an_override)
				if attached an_override.override as os then
					across
						os as o
					loop
						append_tag_open ({STRING_32} "overrides")
						append_text_attribute ("group", o.name)
						append_tag_close_empty
					end
				end
				append_post_group ({STRING_32} "override")
			end
		ensure then
			indent_back: indent = old indent
		end

feature {NONE}

	options: CONF_OPTION
			-- A new instance of options corresponding to the specified `namespace`.
		do
			Result := {CONF_OPTION}.create_from_namespace_or_latest (if attached namespace as n then n else latest_namespace end)
		end

	persistent_target_options (t: CONF_TARGET): CONF_TARGET_OPTION
			-- Options of the target `t` that can be saved with the specified `namespace`.
		do
				-- Pick the default options for the specified `namespace`.
			Result := {CONF_TARGET_OPTION}.create_from_namespace_or_latest (if attached namespace as n then n else latest_namespace end)
				-- Project explicitly set options to the namespace.
			if attached t.internal_options as o then
				Result.merge (o)
			end
				-- Project default options to the namespace.
			Result.merge (t.default_options)
		end

	persistent_options (o: detachable CONF_OPTION; d: CONF_OPTION): CONF_OPTION
			-- Options `o` adapted for saving with the specified `namespace`.
			-- `d` is the default options of the item where `o` is defined.
		do
				-- Pick the default options for the specified `namespace`.
			Result := options
				-- Project explicitly set options to the namespace.
			if attached o then
				Result.merge (o)
			end
				-- Project default options to the namespace.
			Result.merge (d)
		ensure
			idempotent_for_default: Result ~ persistent_options (Result, d)
			idempotent_for_current: Result ~ persistent_options (Result, options)
			idempotent_for_explicit: attached o implies Result ~ persistent_options (Result, o)
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
		do
			create l_sorted_list.make_from_array (a_groups.current_keys)
			;(create {QUICK_SORTER [READABLE_STRING_GENERAL]}.make (create {COMPARABLE_COMPARATOR [READABLE_STRING_GENERAL]})).sort (l_sorted_list)
			across
				l_sorted_list as i
			loop
				if attached a_groups.item (i) as l_grp then
					l_grp.process (Current)
				end
			end
		end

	append_tag (a_name: READABLE_STRING_32; a_value: detachable READABLE_STRING_32)
			-- Append a tag with `a_name' and `a_value' to `text', intendend it with `indent' tabs.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		local
			u: UTF_CONVERTER
			name8: READABLE_STRING_8
		do
			append_text_indent ("<")
			name8 := u.string_32_to_utf_8_string_8 (a_name)
			append_text (name8)
			if a_value /= Void and then not a_value.is_empty then
				append_text (">")
				append_text_element (a_value)
				append_text ("</")
				append_text (name8)
				append_text (">%N")
			else
				append_tag_close_empty
			end
		end

	append_tag_open (name: READABLE_STRING_32)
			-- Append indented open tag for element of name `name` that can be used to append attributes.
			-- The tag should be closed with `append_tag_close` or `append_tag_close_empty`.
			-- See also: `append_start_tag`, `append_end_tag`.
		local
			u: UTF_CONVERTER
		do
			append_text_indent ("<")
			append_text (u.string_32_to_utf_8_string_8 (name))
		end

	append_tag_close
			-- Append a close sequence for a start tag previously open with `append_tag_open` and prepare it for adding nested elements.
		do
			indent := indent + 1
			append_text (">%N")
		end

	append_tag_close_empty
			-- Append a close sequence for an empty start tag previously open with `append_tag_open`
			-- and move to the next line.
		do
			append_text ("/>%N")
		end

	append_start_tag (name: READABLE_STRING_32)
			-- Append start tag for an element of name `name` without attributes and move to the next line.
			-- Equivalent to the sequence `append_tag_open (name); append_tag_close`.
			-- See also: `append_end_tag`.
		do
			append_tag_open (name)
			append_tag_close
		end

	append_end_tag (name: READABLE_STRING_32)
			-- Append end tag for a previously started element of name `name` and move to the next line.
			-- See also: `append_start_tag`, `append_tag_close`.
		local
			u: UTF_CONVERTER
		do
			indent := indent - 1
			append_text_indent ("</")
			append_text (u.string_32_to_utf_8_string_8 (name))
			append_text (">%N")
		end

	append_text_indent (a_text: STRING)
			-- Append `a_text' at the current `indent' intendation level.
		require
			a_text_ok: a_text /= Void and then not a_text.is_empty
		local
			i: INTEGER
		do
			from
				i := indent
			until
				i <= 0
			loop
				text.append_character ('%T')
				i := i - 1
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
				when '<' then text.append_string_general ({XML_MARKUP_CONSTANTS}.lt_entity)
				when '>' then text.append_string_general ({XML_MARKUP_CONSTANTS}.gt_entity)
				when '&' then text.append_string_general ({XML_MARKUP_CONSTANTS}.amp_entity)
				when '"' then text.append_string_general ({XML_MARKUP_CONSTANTS}.quot_entity)
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

	append_text_element (v: READABLE_STRING_GENERAL)
			-- Append `v', in a tag element, replacing special characters by character references,
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
				when '<' then text.append_string_general ({XML_MARKUP_CONSTANTS}.lt_entity)
				when '&' then text.append_string_general ({XML_MARKUP_CONSTANTS}.amp_entity)
				else
					if
						'%N' = c or else
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

	append_optional_text_attribute (n: READABLE_STRING_GENERAL; v: detachable READABLE_STRING_GENERAL)
			-- Append XML attribute of name `n` with value `v` in the form ' n="v"' if `v` is a non-empty value.
		require
			n_attached: attached n
		do
			if attached v and then not v.is_empty then
				append_text_attribute (n, v)
			end
		end

	append_boolean_attribute (n: READABLE_STRING_GENERAL; v: BOOLEAN)
			-- Append XML attribute of name `n' with a boolean value `v' in the form ' n="v"'.
		require
			n_attached: attached n
		do
			text.append_character (' ')
			text.append_string_general (n)
			text.append (if v then once "=%"true%"" else once "=%"false%"" end)
		end

	append_description_tag (a_description: detachable READABLE_STRING_32)
			-- Append `a_description'.
		do
			if a_description /= Void and then not a_description.is_empty then
				append_tag ({STRING_32} "description", a_description)
			end
		end

	append_condition_list (condition: attached like {CONF_CONDITION}.platform; get_name: FUNCTION [INTEGER, STRING]; name: READABLE_STRING_32)
			-- Append condition of name `name' with values specified by `condition' with printable elements that can be obtained using `get_name'.
		require
			condition_attached: attached condition
			get_name_attached: attached get_name
			name_attached: attached name
		do
			if attached condition.value as v then
				append_tag_open (name)
				if condition.invert then
					append_text (" excluded_value=%"")
				else
					append_text (" value=%"")
				end
				across
					v as i
				loop
					if not @ i.is_first then
							-- The first item is not preceded with any delimiter.
							-- The second and next ones are preceded with a space.
						append_text (once " ")
					end
					append_text_escaped (get_name.item ([i]).as_lower, False)
				end
				append_text ("%"")
				append_tag_close_empty
			end
		end


	append_conditionals (a_conditions: detachable ARRAYED_LIST [CONF_CONDITION]; is_assembly: BOOLEAN)
			-- Append `a_conditions' ignore platform if it `is_assembly'.
		local
			l_condition: CONF_CONDITION
			l_done: BOOLEAN
			l_ver: like {CONF_CONDITION}.version.item
			flag: CONF_CONDITION_CUSTOM_ATTRIBUTES
		do
			if a_conditions /= Void then
					-- assembly and only the default rule? => don't print it
				if is_assembly and then a_conditions.count = 1 then
					l_condition := a_conditions.first
					l_done :=
						l_condition.build = Void and
						l_condition.platform = Void and
						l_condition.concurrency = Void and
						l_condition.void_safety = Void and
						l_condition.version.is_empty and
						l_condition.custom.is_empty
				end
				if not l_done then
					across
						a_conditions as c
					loop
						append_tag_open ({STRING_32} "condition")
						append_tag_close

						l_condition := c
						if attached l_condition.platform as p then
							append_condition_list (p, agent get_platform_name, {STRING_32} "platform")
						end
						if attached l_condition.build as b then
							append_condition_list (b, agent get_build_name, {STRING_32} "build")
						end
						if attached l_condition.concurrency as concurrency then
							if includes_this_or_after (namespace_1_8_0) then
									-- Use "concurrency" condition.
								append_condition_list (concurrency, agent get_concurrency_name, {STRING_32} "concurrency")
							else
									-- Use "multithreaded" condition.
								append_tag_open ({STRING_32} "multithreaded")
								append_boolean_attribute ("value", concurrency.value.has (concurrency_none) = concurrency.invert)
								append_tag_close_empty
							end
						end
						if attached l_condition.void_safety as v and then includes_this_or_after (namespace_1_19_0) then
								-- Add "void_safety" condition.
							append_condition_list (v, agent get_void_safety_name, {STRING_32} "void_safety")
						end

							-- Don't print dotnet for assemblies.
						if not is_assembly and then attached l_condition.dotnet as l_dotnet then
							append_tag_open ({STRING_32} "dotnet")
							append_boolean_attribute ("value", l_dotnet.item)
							append_tag_close_empty
						end

						if attached l_condition.dynamic_runtime as l_dyn_runtime then
							append_tag_open ({STRING_32} "dynamic_runtime")
							append_boolean_attribute ("value", l_dyn_runtime.item)
							append_tag_close_empty
						end

						across
							l_condition.version as ic_versons
						loop
							l_ver := ic_versons
							append_tag_open ({STRING_32} "version")
							append_text_attribute ("type", @ ic_versons.key)
							if attached l_ver.min as l_ver_min then
								append_text_attribute ("min", l_ver_min.version)
							end
							if attached l_ver.max as l_ver_max then
								append_text_attribute ("max", l_ver_max.version)
							end
							append_tag_close_empty
						end

						across
							l_condition.custom as cc
						loop
							across
								cc as value
							loop
								append_tag_open (tag_custom)
								append_text_attribute (att_name, @ cc.key)
								flag := value
								append_text_attribute (if flag.inverted then att_excluded_value else att_value end, @ value.key)
								if flag.is_match_set and then includes_this_or_after (namespace_1_18_0) then
									append_text_attribute (att_match, match_value (flag.match_kind))
								end
								append_tag_close_empty
							end
						end

						append_end_tag ({STRING_32} "condition")
					end
				end
			end
		ensure
			indent_back: indent = old indent
		end

	append_mapping (a_mapping: detachable STRING_TABLE [READABLE_STRING_32])
			-- Append `a_mapping'.
		do
			if attached a_mapping then
				across
					a_mapping as m
				loop
					append_tag_open ({STRING_32} "mapping")
					append_text_attribute ("old_name", @ m.key)
					append_text_attribute ("new_name", m)
					append_tag_close_empty
				end
			end
		end

	append_externals (an_externals: ARRAYED_LIST [CONF_EXTERNAL]; a_name: READABLE_STRING_32; a_value: STRING)
			-- Append `an_externals'.
		require
			an_externals_not_void: an_externals /= Void
			a_name_ok: a_name /= Void and then not a_name.is_empty
			valid_a_value: attached a_value and then not a_value.is_empty
		local
			l_ext: CONF_EXTERNAL
		do
			if not an_externals.is_empty then
				across
					an_externals as e
				loop
					l_ext := e
					append_tag_open (a_name)
					append_text_attribute (a_value, l_ext.internal_location)
					append_tag_close
					last_count := text.count

					append_description_tag (l_ext.description)
					append_conditionals (l_ext.internal_conditions, False)

					if text.count = last_count then
						indent := indent - 1
						text.insert_character ('/', last_count-1)
					else
						append_end_tag (a_name)
					end
				end
			end
		end

	append_actions (an_actions: ARRAYED_LIST [CONF_ACTION]; a_name: READABLE_STRING_32)
			-- Append `an_actions'.
		require
			an_actions_not_void: an_actions /= Void
			a_nam_ok: a_name /= Void and then not a_name.is_empty
		local
			l_action: CONF_ACTION
		do
			across
				an_actions as a
			loop
				l_action := a
				append_tag_open (a_name)
				if attached l_action.working_directory as l_wdir then
					append_text_attribute ("working_directory", l_wdir.original_path)
				end
				append_text_attribute ("command", l_action.command)
				if l_action.must_succeed then
					append_boolean_attribute ("succeed", True)
				end
				append_tag_close
				append_description_tag (l_action.description)
				append_conditionals (l_action.internal_conditions, False)
				append_end_tag (a_name)
			end
		end

	append_file_rule (a_file_rules: ARRAYED_LIST [CONF_FILE_RULE])
			-- Append `a_file_rule'
		local
			l_rule: CONF_FILE_RULE
		do
			across
				a_file_rules as r
			loop
				l_rule := r
				if not l_rule.is_empty then
					append_tag_open ({STRING_32} "file_rule")
					append_tag_close
					append_description_tag (l_rule.description)
						-- Save patterns lexicographically ordered.
					if attached l_rule.ordered_exclude as p then
						⟳ i: p ¦ append_tag ({STRING_32} "exclude", i) ⟲
					end
					if attached l_rule.ordered_include as p then
						⟳ i: p ¦ append_tag ({STRING_32} "include", i) ⟲
					end
					append_conditionals (l_rule.internal_conditions, False)
					append_end_tag ({STRING_32} "file_rule")
				end
			end
		end

	append_target_options (o: CONF_TARGET_OPTION)
			-- Append target options `o' (if any).
		do
			append_group_options (o, True, True)
		end

	append_class_options (o: CONF_OPTION; c: READABLE_STRING_GENERAL; is_own_source, is_own_capability: BOOLEAN)
			-- Append class options `o' (if any) for a calss `c'.
			--
			-- • `is_own_source` tells whether the options control the source code (i.e. not a library, a precompile, etc.)
			-- • `is_own_capability` tells whether the options control the capabilities (i.e. not an override, a library, etc.)
		do
			if not o.is_empty_for (namespace) then
				append_tag_open ({STRING_32} "class_option")
				append_text_attribute ("class", c)
				append_general_options (o, is_own_source, is_own_capability)
				append_end_tag ({STRING_32} "class_option")
			end
		end

	append_group_options (o: CONF_OPTION; is_own_source, is_own_capability: BOOLEAN)
			-- Append group options `o' (if any).
			--
			-- • `is_own_source` tells whether the options control the source code (i.e. not a library, a precompile, etc.)
			-- • `is_own_capability` tells whether the options control the capabilities (i.e. not an override, a library, etc.)
		do
			if not o.is_empty_for (namespace) then
				append_tag_open ({STRING_32} "option")
				append_general_options (o, is_own_source, is_own_capability)
				append_end_tag ({STRING_32} "option")
			end
		end

	append_general_options (an_options: CONF_OPTION; is_own_source, is_own_capability: BOOLEAN)
			-- Append `an_options' in an already open option element.
			--
			-- • `is_own_source` tells whether the options control the source code (i.e. not a library, a precompile, etc.)
			-- • `is_own_capability` tells whether the options control the capabilities (i.e. not an override, a library, etc.)
		local
			l_str: detachable READABLE_STRING_32
			l_debugs, l_warnings: detachable STRING_TABLE [BOOLEAN]
			l_sorted_list: ARRAYED_LIST [READABLE_STRING_GENERAL]
			w: READABLE_STRING_GENERAL
		do
			if an_options.is_trace_configured then
				check not is_supplier_option (at_trace) end
				append_boolean_attribute (o_is_trace, an_options.is_trace)
			end
			if an_options.is_profile_configured then
				check not is_supplier_option (at_profile) end
				append_boolean_attribute (o_is_profile, an_options.is_profile)
			end
			if an_options.is_optimize_configured then
				check not is_supplier_option (at_optimize) end
				append_boolean_attribute (o_is_optimize, an_options.is_optimize)
			end
			if an_options.is_debug_configured then
				check not is_supplier_option (at_debug) end
				append_boolean_attribute (o_is_debug, an_options.is_debug)
			end
			if an_options.warning.is_set then
				check not is_supplier_option (at_warning) end
				if is_after_or_equal (namespace, namespace_1_21_0) then
						-- The option is an enumeration starting from `namespace_1_21_0`.
					append_text_attribute (o_warning, an_options.warning.item)
				else
						-- The option is a boolean value before `namespace_1_21_0`.
					append_boolean_attribute (o_warning, an_options.warning.index /= {CONF_OPTION}.warning_index_none)
				end
			end
			if an_options.is_msil_application_optimize_configured then
				check not is_supplier_option (at_msil_application_optimize) end
				append_boolean_attribute (o_is_msil_application_optimize, an_options.is_msil_application_optimize)
			end
			if is_own_source and an_options.is_full_class_checking_configured then
				check is_supplier_option (at_full_class_checking) end
				append_boolean_attribute (o_is_full_class_checking, an_options.is_full_class_checking)
			end
			if
				is_own_capability and
				an_options.catcall_detection.is_set and then
				is_before_or_equal (namespace, namespace_1_15_0)
			then
				check is_supplier_option (at_catcall_detection) end
					-- Starting from `namespace_1_16_0` the option is treated as capability.
				append_text_attribute (o_catcall_detection, an_options.catcall_detection.item)
			end
			if is_own_source and an_options.is_attached_by_default_configured then
				check is_supplier_option (at_is_attached_by_default) end
				append_boolean_attribute (o_is_attached_by_default, an_options.is_attached_by_default)
			end
			if
				is_own_source and
				(an_options.is_obsolete_iteration_configured or an_options.is_obsolete_iteration) and then
				is_after_or_equal (namespace, namespace_1_22_0)
			then
				check is_supplier_option (at_is_obsolete_iteration) end
				append_boolean_attribute (o_is_obsolete_iteration, an_options.is_obsolete_iteration)
			end
			if
				is_own_source and then
				(an_options.is_obsolete_routine_type_configured or else an_options.is_obsolete_routine_type) and then
				is_after_or_equal (namespace, namespace_1_15_0)
			then
				check is_supplier_option (at_is_obsolete_routine_type) end
				append_boolean_attribute (o_is_obsolete_routine_type, an_options.is_obsolete_routine_type)
			end
			if
				is_own_capability and then
				is_before_or_equal (namespace, namespace_1_15_0) and then
				an_options.void_safety.is_set
			then
				check is_supplier_option (at_is_void_safe) end
				check is_supplier_option (at_void_safety) end
					-- Starting from `namespace_1_16_0` the option is treated as capability.
				if is_after_or_equal (namespace, namespace_1_11_0) then
						-- Current namespace.
					l_str := an_options.void_safety.item
				else
						-- Earlier namespaces with less void-safety levels.
					l_str :=
						inspect
							an_options.void_safety.index
						when {CONF_OPTION}.void_safety_index_none then
							{STRING_32} "none"
						when
							{CONF_OPTION}.void_safety_index_conformance,
							{CONF_OPTION}.void_safety_index_initialization
						then
							{STRING_32} "initialization"
						else
							{STRING_32} "all"
						end
					if is_after_or_equal (namespace, namespace_1_9_0) then
						append_boolean_attribute ("is_void_safe", an_options.void_safety.index = {CONF_OPTION}.void_safety_index_all)
					end
				end
				append_text_attribute (o_void_safety, l_str)
			end
			if is_own_source and an_options.syntax.is_set then
				check is_supplier_option (at_syntax) end
				append_text_attribute (o_syntax, an_options.syntax.item)
			end
			if
				is_own_source and
				an_options.array.is_set and then
				is_after_or_equal (namespace, namespace_1_18_0)
			then
				check is_supplier_option (at_manifest_array_type) end
					-- The option is available only starting from `namespace_1_18_0`.
				append_text_attribute (o_manifest_array_type, an_options.array.item)
			end
			l_str := an_options.local_namespace
			if l_str /= Void and then not l_str.is_empty then
				append_text_attribute (o_namespace, l_str)
			end
			append_tag_close

			append_description_tag (an_options.description)

			l_debugs := an_options.debugs
			if l_debugs /= Void and then not l_debugs.is_empty then
				create l_sorted_list.make_from_array (l_debugs.current_keys)
				;(create {QUICK_SORTER [READABLE_STRING_GENERAL]}.make
					(create {STRING_COMPARATOR}.make)).sort (l_sorted_list)
				across
					l_sorted_list as d
				loop
					append_tag_open ({STRING_32} "debug")
					append_text_attribute ("name", d)
					append_boolean_attribute ("enabled", l_debugs.item (d))
					append_tag_close_empty
				end
			end

			if attached an_options.assertions as l_assertions then
				append_tag_open ({STRING_32} "assertions")
				if l_assertions.is_precondition then
					append_boolean_attribute ("precondition", l_assertions.is_precondition)
				end
				if l_assertions.is_postcondition then
					append_boolean_attribute ("postcondition", l_assertions.is_postcondition)
				end
				if l_assertions.is_check then
					append_boolean_attribute ("check", l_assertions.is_check)
				end
				if l_assertions.is_invariant then
					append_boolean_attribute ("invariant", l_assertions.is_invariant)
				end
				if l_assertions.is_loop then
					append_boolean_attribute ("loop", l_assertions.is_loop)
				end
				if namespace /= namespace_1_0_0 and then l_assertions.is_supplier_precondition then
					append_boolean_attribute ("supplier_precondition", l_assertions.is_supplier_precondition)
				end
				append_tag_close_empty
			end

			l_warnings := an_options.warnings
			if not attached l_warnings then
				create l_warnings.make (0)
			end
			if an_options.warning_obsolete_call.is_set then
				l_warnings.force (an_options.warning_obsolete_call.index /= {CONF_OPTION}.warning_term_index_none, w_obsolete_feature)
			end
			create l_sorted_list.make_from_array (l_warnings.current_keys)
			;(create {QUICK_SORTER [READABLE_STRING_GENERAL]}.make
				(create {STRING_COMPARATOR}.make)).sort (l_sorted_list)
			across
				l_sorted_list as i
			loop
				w := i
				if is_after_or_equal (namespace, namespace_1_21_0) and then w.same_string (w_obsolete_feature) then
					append_tag_open ({STRING_32} "warning")
					append_text_attribute (wa_name, w)
					append_text_attribute (wa_value, an_options.warning_obsolete_call.item)
					append_tag_close_empty
				elseif valid_warning (w, namespace) then
					append_tag_open ({STRING_32} "warning")
					append_text_attribute (wa_name, w)
					append_boolean_attribute (wa_enabled, l_warnings.item (w))
					append_tag_close_empty
				end
			end
		end

	append_ordered_capability (capability: CONF_ORDERED_CAPABILITY; name: READABLE_STRING_32)
			-- Append capability element of name `name` for capability `capability`.
		local
			is_support_set: BOOLEAN
			is_use_set: BOOLEAN
		do
			is_support_set := capability.value.is_set
			is_use_set := capability.is_root_set
			if is_support_set or else is_use_set then
				append_tag_open (name)
				if is_support_set then
					append_text_attribute (ca_support, capability.value.item)
				end
				if is_use_set then
					append_text_attribute (ca_use, capability.custom_root)
				end
				append_tag_close_empty
			end
		end

	append_visible (a_visible: STRING_TABLE [TUPLE [class_renamed: READABLE_STRING_32; features: detachable STRING_TABLE [READABLE_STRING_32]]])
			-- Append visible rules.
		require
			a_visible_not_void: a_visible /= Void
		local
			l_class: READABLE_STRING_GENERAL
			l_feat: detachable READABLE_STRING_GENERAL
			l_feat_rename, l_class_rename: detachable READABLE_STRING_32
		do
			across
				a_visible as v
			loop
				l_class := @ v.key
				l_class_rename := v.class_renamed
				if attached v.features as l_vis_feat then
					across
						l_vis_feat as f
					loop
						l_feat := @ f.key
						l_feat_rename := f
						if l_feat.same_string ("*") then
							l_feat := Void
						end
						append_tag_open ({STRING_32} "visible")
						append_text_attribute ("class", l_class)
						if l_feat /= Void then
							append_text_attribute ("feature", l_feat)
						end
						if not l_class_rename.is_empty and then not l_class_rename.same_string_general (l_class) then
							append_text_attribute ("class_rename", l_class_rename)
						end
						if
							not l_feat_rename.is_empty and then
							(l_feat = Void or else not l_feat_rename.same_string_general (l_feat))
						then
							append_text_attribute ("feature_rename", l_feat_rename)
						end
						append_tag_close_empty
					end
				else
					append_tag_open ({STRING_32} "visible")
					append_text_attribute ("class", l_class)
					if not l_class_rename.is_empty and then not l_class_rename.same_string_general (l_class) then
						append_text_attribute ("class_rename", l_class_rename)
					end
					append_tag_close_empty
				end
			end
		end

	append_pre_group (a_tag: READABLE_STRING_32; a_group: CONF_GROUP)
			-- Append the things that start the entry for `a_group'
		require
			a_group_not_void: a_group /= Void
			a_tag_ok: a_tag /= Void and then not a_tag.is_empty
		local
			l_str: READABLE_STRING_32
		do
			l_str := a_group.location.original_path
			if l_str.is_empty then
				l_str := {STRING_32} "none"
			end
			append_tag_open (a_tag)
			append_text_attribute ("name", a_group.name)
			append_text_attribute ("location", l_str)
			if not a_group.is_library and a_group.internal_read_only then
				append_boolean_attribute ("readonly", True)
			elseif a_group.is_library and a_group.is_readonly_set then
				append_boolean_attribute ("readonly", a_group.is_readonly)
			end
			if
				attached {CONF_VIRTUAL_GROUP} a_group as l_vg and then
				attached l_vg.name_prefix as s and then not s.is_empty
			then
				append_text_attribute ("prefix", s)
			end
		end

	append_val_group (a_group: CONF_GROUP; is_own_source, is_own_capability: BOOLEAN)
			-- Append the things that come in the value part of `a_group'.
			--
			-- • `is_own_source` tells whether the options control the source code (i.e. not a library, a precompile, etc.)
			-- • `is_own_capability` tells whether the options control the capabilities (i.e. not an override, a library, etc.)
		require
			a_group_not_void: a_group /= Void
		local
			default_options: CONF_OPTION
		do
			append_tag_close
			last_count := text.count
			append_note_tag (a_group)
			append_description_tag (a_group.description)
			append_conditionals (a_group.internal_conditions, a_group.is_assembly)
				-- Skip writing options for assemblies.
			if not a_group.is_assembly then
				default_options := a_group.default_options
				append_group_options (persistent_options (a_group.internal_options, default_options), is_own_source, is_own_capability)
			end
			if
				attached {CONF_VIRTUAL_GROUP} a_group as l_vg and then
				attached l_vg.renaming as l_renaming
			then
				across
					l_renaming as r
				loop
					append_tag_open ({STRING_32} "renaming")
					append_text_attribute ("old_name", @ r.key)
					append_text_attribute ("new_name", r)
					append_tag_close_empty
				end
			end
			if
				attached default_options and then
				attached a_group.internal_class_options as l_c_opt
			then
				across
					l_c_opt as o
				loop
					append_class_options (persistent_options (o, default_options), @ o.key, is_own_source, is_own_capability)
				end
			end
		end

	append_post_group (a_tag: READABLE_STRING_32)
			-- Finish the the tag for the group.
		require
			a_tag_ok: a_tag /= Void and then not a_tag.is_empty
		do
				-- we didn't add anything further => change to a single tag.
			if text.count = last_count then
				indent := indent - 1
				text.insert_character ('/', last_count - 1)
			else
				append_end_tag (a_tag)
			end
		end

	append_attr_cluster (a_cluster: CONF_CLUSTER)
			-- Append the attributes for `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			if a_cluster.is_recursive then
				append_boolean_attribute ("recursive", True)
			end
			if namespace /= namespace_1_0_0 and then a_cluster.is_hidden then
				append_boolean_attribute ("hidden", True)
			end
		end

	append_val_cluster (a_cluster: CONF_CLUSTER)
			-- Append the values for `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			l_visible: detachable STRING_TABLE [TUPLE [READABLE_STRING_32, detachable STRING_TABLE [READABLE_STRING_32]]]
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
					append_tag_open ({STRING_32} "uses")
					append_text_attribute ("group", gc.name)
					append_tag_close_empty
				end
			end
			l_visible := a_cluster.visible
			if l_visible /= Void then
				append_visible (l_visible)
			end
				-- process subclusters
			if attached a_cluster.children as l_clusters then
				across
					l_clusters as c
				loop
					current_is_subcluster := True
					c.process (Current)
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
		do
			if not a_note.element_name.is_empty then
				append_tag_open (a_note.element_name)
				across
					a_note.attributes as a
				loop
					if attached @ a.key as n and then not n.is_empty then
						append_text_attribute (n, if attached a as v then v else once {STRING_32} "" end)
					end
				end
				if a_note.is_empty then
					append_tag_close_empty
				else
					append_tag_close
					⟳ i: a_note ¦ append_note_recursive (i) ⟲
					append_end_tag (a_note.element_name)
				end
			end
		end

feature {NONE} -- Match attribute

	match_value (match_kind: like {CONF_CONDITION_CUSTOM_ATTRIBUTES}.match_kind): READABLE_STRING_32
			-- A configuration representation of a match attribute value `match_kind` of a custom condition.
		require
			is_match_kind_known:
				match_kind = {CONF_CONDITION_CUSTOM_ATTRIBUTES}.case_sensitive_matching or
				match_kind = {CONF_CONDITION_CUSTOM_ATTRIBUTES}.case_insensitive_matching or
				match_kind = {CONF_CONDITION_CUSTOM_ATTRIBUTES}.regexp_matching or
				match_kind = {CONF_CONDITION_CUSTOM_ATTRIBUTES}.wildcard_matching
		do
			inspect match_kind
			when {CONF_CONDITION_CUSTOM_ATTRIBUTES}.case_sensitive_matching then
				Result := val_match_case_sensitive
			when {CONF_CONDITION_CUSTOM_ATTRIBUTES}.case_insensitive_matching then
				Result := val_match_case_insensitive
			when {CONF_CONDITION_CUSTOM_ATTRIBUTES}.regexp_matching then
				Result := val_match_regexp
			when {CONF_CONDITION_CUSTOM_ATTRIBUTES}.wildcard_matching then
				Result := val_match_wildcard
			end
		end

note
	ca_ignore: "CA033", "CA033 — very long class"
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
