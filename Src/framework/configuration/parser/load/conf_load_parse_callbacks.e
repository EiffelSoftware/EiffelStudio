﻿note
	description: "The callbacks that react on the xml parsing."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LOAD_PARSE_CALLBACKS

inherit
	CONF_LOAD_CALLBACKS
		redefine
			on_start_tag,
			on_start_tag_finish,
			on_attribute,
			on_end_tag,
			on_content,
			has_resolved_namespaces
		end

	CONF_VALIDITY

	CONF_ACCESS

	CONF_INTERFACE_CONSTANTS

	EIFFEL_SYNTAX_CHECKER
		export
			{NONE} all
		end

	CONF_LOAD_PARSE_CALLBACKS_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_factory

feature {NONE} -- Initialization

	make_with_factory (a_file: STRING_32; a_factory: like factory)
			-- Create.
		do
			file_name := a_file
			make
			create current_tag.make
			create current_attributes.make (0)
			create group_list.make (0)
			create uses_list.make (0)
			create overrides_list.make (0)
			create current_content.make_empty
			factory := a_factory
			last_undefined_tag_number := undefined_tag_start
			create current_element_under_note.make
			create current_attributes_undefined.make (0)
		ensure
			factory_set: factory = a_factory
		end

feature -- Access

	file_name: STRING_32
			-- Path of the file being parsed.

	last_system: detachable CONF_SYSTEM
			-- The last parsed system.

	last_redirection: detachable CONF_REDIRECTION
			-- Last parsed redirection if any.

feature -- Callbacks

	on_start_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- Start of start tag.
		local
			l_tag: INTEGER
			l_elem, l_parent_elem: CONF_NOTE_ELEMENT
			l_local_part: READABLE_STRING_32
		do
			if not is_error then
				l_local_part := a_local_part.as_lower

					-- check version
				check_version (a_namespace)

					-- check if it is a valid tag state transition
				if current_tag.is_empty then
					current_tag.extend (t_none)
				end

				l_tag := tag_from_state_transitions (current_tag.item, l_local_part)
					-- Record levels of note element as a flag we allow any content in note.

				if note_level = 0 and then l_tag = t_note then
						-- Root element
					create l_elem.make (l_local_part)
					current_element_under_note.extend (l_elem)
				elseif note_level > 0 then
						-- Subelements
					create l_elem.make (l_local_part)
					l_parent_elem := current_element_under_note.item
					l_parent_elem.extend (l_elem)
					l_elem.set_parent (l_parent_elem)
					current_element_under_note.extend (l_elem)
				end

				if l_tag = 0 then
					set_parse_error_message (conf_interface_names.e_parse_invalid_tag (a_local_part))
						-- Preserve a stack of tags and push an unknown tag to the top.
					l_tag := t_unknown
				end
				current_tag.extend (l_tag)
			end
		end

	on_attribute (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32; a_value: READABLE_STRING_32)
			-- Start of attribute.
		local
			l_attribute: INTEGER
			l_local: READABLE_STRING_32
		do
			if not is_error then
				if
					not a_local_part.is_case_insensitive_equal_general ("xmlns") and
					not a_local_part.is_case_insensitive_equal_general ("xsi") and
					not a_local_part.is_case_insensitive_equal_general ("schemaLocation")
				then
					l_local := a_local_part.as_lower

					if note_level = 0 then
							-- check if the attribute is valid for the current state
						if attached tag_attributes.item (current_tag.item) as l_attr then
							l_attribute := l_attr.item (l_local)
						end
						if current_attributes = Void then
							create current_attributes.make (1)
						end
						if l_attribute /= 0 and then not current_attributes.has (l_attribute) then
								-- Check and put defined attributes in `current_attributes'.
							if not a_value.is_empty then
								current_attributes.force (lt_gt_escaped_string (a_value), l_attribute)
							else
								set_parse_error_message (conf_interface_names.e_parse_invalid_value (a_local_part))
							end
						else
							report_unknown_attribute (a_local_part)
						end
					else
							-- Put undefined attributes in `current_attributes_undefined'.
						current_attributes_undefined.force (lt_gt_escaped_string (a_value), l_local)
					end
				end
			end
		end

	on_start_tag_finish
			-- End of start tag.
		local
			l_current_option: like current_option
			l_current_condition: like current_condition
		do
			if not is_error then
				inspect
					current_tag.item
				when t_redirection then
					process_redirection_attributes
				when t_system then
					process_system_attributes
				when t_target then
					process_target_attributes
				when t_root then
					process_root_attributes
				when t_version then
					process_version_attributes
				when t_setting then
					process_setting_attributes
				when t_option then
					process_option_attributes (False)
				when t_assertions then
					l_current_option := current_option
					if l_current_option /= Void then
						process_assertions_attributes (l_current_option)
					else
						check under_current_option: False end
					end
				when t_debug then
					l_current_option := current_option
					if l_current_option /= Void then
						process_debug_attributes (l_current_option)
					else
						check under_current_option: False end
					end
				when t_warning then
					l_current_option := current_option
					if l_current_option /= Void then
						process_warning_attributes (l_current_option)
					else
						check under_current_option: False end
					end
				when
					t_external_include,
					t_external_cflag,
					t_external_object,
					t_external_library,
					t_external_resource,
					t_external_linker_flag,
					t_external_make
				then
					process_external_attributes
				when t_file_rule then
					process_file_rule_attributes
				when t_pre_compile_action then
					process_action_attributes
				when t_post_compile_action then
					process_action_attributes
				when t_variable then
					process_variable_attributes
				when t_precompile then
					process_precompile_attributes
				when t_library then
					process_library_attributes
				when t_assembly then
					process_assembly_attributes
				when t_cluster then
					process_cluster_attributes (False)
				when t_test_cluster then
					process_cluster_attributes (True)
				when t_override then
					process_override_attributes
				when t_renaming then
					process_renaming_attributes
				when t_class_option then
					process_option_attributes (True)
				when t_visible then
					process_visible_attributes
				when t_uses then
					process_uses_attributes
				when t_overrides then
					process_overrides_attributes
				when t_condition then
					process_condition_attributes
				when t_platform then
					l_current_condition := current_condition
					if l_current_condition /= Void then
						process_platform_attributes (l_current_condition)
					else
						check platform_under_current_condition: False end
					end
				when t_build then
					l_current_condition := current_condition
					if l_current_condition /= Void then
						process_build_attributes (l_current_condition)
					else
						check build_under_current_condition: False end
					end
				when t_multithreaded then
					l_current_condition := current_condition
					if l_current_condition /= Void then
						process_multithreaded_attributes (l_current_condition)
					else
						check multithreaded_under_current_condition: False end
					end
				when t_concurrency then
					l_current_condition := current_condition
					if l_current_condition /= Void then
						process_concurrency_attributes (l_current_condition)
					else
						check concurrency_under_current_condition: False end
					end
				when t_dotnet then
					l_current_condition := current_condition
					if l_current_condition /= Void then
						process_dotnet_attributes (l_current_condition)
					else
						check dotnet_under_current_condition: False end
					end
				when t_dynamic_runtime then
					l_current_condition := current_condition
					if l_current_condition /= Void then
						process_dynamic_runtime_attributes (l_current_condition)
					else
						check dynamic_runtime_under_current_condition: False end
					end
				when t_version_condition then
					l_current_condition := current_condition
					if l_current_condition /= Void then
						process_version_condition_attributes (l_current_condition)
					else
						check version_condition_under_current_condition: False end
					end
				when t_custom then
					l_current_condition := current_condition
					if l_current_condition /= Void then
						process_custom_attributes (l_current_condition)
					else
						check custom_under_current_condition: False end
					end
				when t_mapping then
					process_mapping_attributes
				when t_note then
					process_element_under_note
				else
					if note_level > 0 then
						process_element_under_note
					end
				end
				current_attributes.wipe_out
				current_attributes_undefined.wipe_out
			end
		end

	on_end_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- End tag.
		local
			l_group: detachable CONF_GROUP
			l_error: CONF_ERROR_GRUNDEF
			l_e_ov: CONF_ERROR_OVERRIDE
			l_element: CONF_NOTE_ELEMENT
			l_current_target: like current_target
			l_current_cluster: like current_cluster
		do
			if not is_error then
				current_content.left_adjust
				current_content.right_adjust
				if not current_content.is_empty then
					lt_gt_escape_string (current_content)

					inspect
						current_tag.item
					when t_description then
						process_description_content
					when t_exclude then
						process_exclude_content
					when t_include then
						process_include_content
					else
						if note_level > 0 then
							l_element := current_element_under_note.item
							l_element.set_content (current_content)
						else
							set_parse_error_message (conf_interface_names.e_parse_invalid_content (current_content))
						end
					end
					create current_content.make_empty
				end

				l_current_cluster := current_cluster

				inspect
					current_tag.item
				when t_system then
					if current_library_target /= Void then
						set_error (create {CONF_ERROR_LIBTAR})
					end
				when t_target then
						-- check for overrides and precompiles in a library_target
					l_current_target := current_target
					if
						attached last_system as l_last_system and then
					 	l_current_target = l_last_system.library_target
					 then
						if l_current_target /= Void and then not l_current_target.overrides.is_empty then
							set_error (create {CONF_ERROR_LIBOVER})
						end
					end
						-- handle uses and overrides
					across uses_list as uses_ic loop
						l_group := group_list.item (uses_ic.key)
						if l_group = Void then
							create l_error
							l_error.set_group (uses_ic.key)
							set_error (l_error)
						else
							uses_ic.item.do_all (agent {CONF_CLUSTER}.add_dependency (l_group))
						end
					end
					across overrides_list as overrides_ic loop
						l_group := group_list.item (overrides_ic.key)
						if l_group = Void then
							create l_error
							l_error.set_group (overrides_ic.key)
							set_error (l_error)
						elseif l_group.is_override then
							create l_e_ov
							l_e_ov.set_group (l_group.name)
							set_error (l_e_ov)
						else
							overrides_ic.item.do_all (agent {CONF_OVERRIDE}.add_override (l_group))
						end
					end
					uses_list.wipe_out
					overrides_list.wipe_out
					group_list.wipe_out
					if l_current_target /= Void and then l_current_target.extends = Void then
							-- Set default options for the standalone target in case the old schema is being processed.
							-- Extension targets do not need it because the options are inherited from the standalone ones.
						if a_namespace /= Void then
							set_default_options (l_current_target, a_namespace)
						else
								-- FIXME: is this safe to use default_namespace?
								-- maybe: check a_namespace /= Void end
							set_default_options (l_current_target, default_namespace)
						end
					end
					l_current_target := Void
					current_target := Void
				when t_file_rule then
					current_file_rule := Void
				when t_option then
					current_option := Void
				when t_external_include then
						-- Check if any conversion from the early version of ECF is required.
					split_external (agent create_external_cflag)
					current_external := Void
				when t_external_object, t_external_library then
						-- Check if any conversion from the early version of ECF is required.
					split_external (agent create_external_linker_flag)
					current_external := Void
				when
					t_external_cflag,
					t_external_resource,
					t_external_linker_flag,
					t_external_make
				then
					current_external := Void
				when t_pre_compile_action then
					current_action := Void
				when t_post_compile_action then
					current_action := Void
				when t_precompile then
					current_group := Void
					current_library := Void
				when t_library then
					current_group := Void
					current_library := Void
				when t_assembly then
					current_group := Void
					current_assembly := Void
				when t_cluster then
					if l_current_cluster /= Void then
						current_group := l_current_cluster.parent
						l_current_cluster := l_current_cluster.parent
						current_cluster := l_current_cluster
					else
						check has_current_cluster: False end
					end
				when t_test_cluster then
					if l_current_cluster /= Void then
						current_group := l_current_cluster.parent
						l_current_cluster := l_current_cluster.parent
						current_cluster := l_current_cluster
					else
						check has_current_cluster: False end
					end
				when t_override then
					if l_current_cluster /= Void then
						current_group := l_current_cluster.parent
						l_current_cluster := l_current_cluster.parent
						current_cluster := l_current_cluster
					else
						check has_current_cluster: False end
					end
					current_override := Void
				when t_class_option then
					current_option := Void
				else
					if note_level > 0 then
						if note_level = 1 then
							process_note
						end
						current_element_under_note.remove
					end
				end
				current_tag.remove
			end
		end

	on_content (a_content: READABLE_STRING_32)
			-- Text content.
		do
			if not is_error then
				current_content.append_string (a_content)
			end
		end

feature {NONE} -- External attribute processing

	create_external_cflag (v: like {CONF_EXTERNAL}.location)
			-- Create new C flag external with value `v'
			-- and assign it to `current_external'.
		local
			e: CONF_EXTERNAL_CFLAG
		do
			if attached current_target as l_current_target then
				e := factory.new_external_cflag (v, l_current_target)
				l_current_target.add_external_cflag (e)
				current_external := e
			else
					-- If we are processing externals, we should have processed a target node before.
				set_parse_error_message (conf_interface_names.e_parse_external_outside_target_element)
				current_external := Void
			end
		end

	create_external_linker_flag (v: like {CONF_EXTERNAL}.location)
			-- Create new linker flag external with value `v'
			-- and assign it to `current_external'.
		local
			e: CONF_EXTERNAL_LINKER_FLAG
		do
			if attached current_target as l_current_target then
					-- FIXME: find out why `current_target_set' ?
				e := factory.new_external_linker_flag (v, l_current_target)
				l_current_target.add_external_linker_flag (e)
				current_external := e
			else
					-- If we are processing externals, we should have processed a target node before.
				set_parse_error_message (conf_interface_names.e_parse_external_outside_target_element)
				current_external := Void
			end
		end

feature {NONE} -- Conversion from earlier version

	split_external (c: PROCEDURE [ANY, TUPLE [like {CONF_EXTERNAL}.location]])
			-- Split `current_external' into several ones if it comes
			-- from the old ECF and consists of several parts.
		require
			c_attached: attached c
		local
			i, n: INTEGER
		do
			if
				attached current_external as e and then
				includes_this_or_before (namespace_1_9_0) and then
				attached e.internal_location as p and then
				not p.has ('%"') and then
				(p.has (' ') or else p.has ('%T'))
			then
					-- The early version of ECF did not distinguish between
					-- include paths and C compiler flags as well as
					-- object/library paths and linker flags.
				p.left_adjust
				p.right_adjust
				if e.is_include then
						-- The part before white space in include external
						-- corresponds to path, the rest - to flags.
						-- Look for the first white space.
					from
						i := 1
						n := p.count
					invariant
						no_spaces:
							across p.substring (1, i - 1) as t all not t.item.is_space end
					until
						i > n or else p [i].is_space
					loop
						i := i + 1
					end
						-- Update the original external.
					e.set_location (p.substring (1, i - 1))
						-- Use the rest of the path as a value of the C flag external.
					p.remove_head (i)
					p.left_adjust
				elseif attached current_target as l_current_target then

						-- Remove the original external because
						-- unlike "include" everything with white space
						-- in object/library external may be considered
						-- as flags. Moreover, splitting "-foo bar" into
						-- two pieces would break the code. Therefore it
						-- is preserved, but used as linker flags to make
						-- sure the old semantics is not broken by adding
						-- quotes around the path.
					if attached {CONF_EXTERNAL_OBJECT} e as o then
						l_current_target.remove_external_object (o)
					elseif attached {CONF_EXTERNAL_LIBRARY} e as l then
						l_current_target.remove_external_library (l)
					end
				else
					check current_target_set: False end
				end
					-- Create a new external with value `p'.
				c.call ([p])
				if attached current_external as s then
						-- Use description and conditions of the original.
					s.set_description (e.description)
					s.set_conditions (e.internal_conditions)
				end
			end
		end

feature {NONE} -- Implementation attribute processing

	process_redirection_attributes
			-- Process attributes of a redirection tag.
		local
			l_uuid: like current_attributes.item
			l_uu: detachable UUID
		do
			l_uuid := current_attributes.item (at_uuid)

			if l_uuid /= Void then
				if is_valid_uuid (l_uuid) then
					create l_uu.make_from_string (l_uuid)
				else
						-- Error
					set_error (create {CONF_ERROR_UUID})
				end
			end
			if not is_error then
				if attached current_attributes.item (at_location) as l_loc then
					if includes_this_or_after (namespace_1_12_0) then
						if l_loc.is_empty then
							set_parse_error_message (conf_interface_names.e_parse_invalid_attribute ("location"))
						else
							last_redirection := factory.new_redirection_with_file_name (file_name, l_loc, l_uu)
						end
					else
						report_unknown_attribute ("location")
					end
				elseif includes_this_or_after (namespace_1_12_0) then
					set_parse_error_message (conf_interface_names.e_parse_missing_attribute ("location"))
				end
			end
		ensure
			last_redirection_not_void: not is_error implies last_redirection /= Void
		end

	process_system_attributes
			-- Process attributes of a system tag.
		local
			l_name, l_lower_name,
			l_uuid: like current_attributes.item
			l_uu: detachable UUID
			l_last_system: like last_system
		do
			l_name := current_attributes.item (at_name)
			if l_name /= Void then
					-- We will use `l_lower_name' for lookup, but `l_name' for error messages.
				l_lower_name := l_name.as_lower
			end
			l_uuid := current_attributes.item (at_uuid)

			if attached current_attributes.item (at_library_target) as l_current_lib_target then
				current_library_target := l_current_lib_target.as_lower
			else
				current_library_target := Void
			end
			if l_lower_name = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_system_no_name)
			elseif l_name /= Void then -- by implementation l_lower_name /= Void implies l_name /= Void
				if not is_valid_system_name (l_lower_name) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_system_name (l_name))
				else
					if l_uuid /= Void then
						if is_valid_uuid (l_uuid) then
							create l_uu.make_from_string (l_uuid)
						else
							set_error (create {CONF_ERROR_UUID})
						end
					end
					if not is_error then
						if l_uu = Void then
							l_last_system := factory.new_system_generate_uuid_with_file_name (file_name, l_lower_name)
						else
							l_last_system := factory.new_system_with_file_name (file_name, l_lower_name, l_uu)
						end
						last_system := l_last_system
						if attached current_attributes.item (at_readonly) as l_readonly then
							if l_readonly.is_boolean then
								l_last_system.set_readonly (l_readonly.to_boolean)
							else
								set_parse_error_message (conf_interface_names.e_parse_invalid_value ("readonly"))
							end
						end
					else
						set_parse_error_message (conf_interface_names.e_parse_incorrect_system_invalid_uuid (l_name))
					end
				end
			end
		ensure
			last_system_not_void: not is_error implies last_system /= Void
		end

	process_target_attributes
			-- Process attributes of a target tag.
		require
			last_system_not_void: last_system /= Void
		local
			l_target: detachable CONF_TARGET
			l_lower_name: STRING_32
			l_current_target: like current_target
		do
			if attached last_system as l_last_system then
				if attached current_attributes.item (at_name) as l_name then
						-- We will use `l_lower_name' for lookup, but `l_name' for error messages.
					l_lower_name := l_name.as_lower
					if not is_valid_target_name (l_lower_name) then
						set_parse_error_message (conf_interface_names.e_parse_incorrect_target_invalid_name (l_name))
					end
					if l_last_system.targets.has (l_lower_name) then
						set_parse_error_message (conf_interface_names.e_parse_multiple_target_with_name (l_name))
					end

					l_current_target := factory.new_target (l_lower_name, l_last_system)
					current_target := l_current_target
					if attached current_attributes.item (at_abstract) as l_abstract then
						if l_abstract.is_boolean then
							l_current_target.set_abstract (l_abstract.to_boolean)
						else
							set_parse_error_message (conf_interface_names.e_parse_invalid_value ("abstract"))
						end
					end
					if attached current_library_target as l_current_library_target and then l_lower_name.same_string_general (l_current_library_target) then
						l_last_system.set_library_target (l_current_target)
						current_library_target := Void
					end
					l_last_system.add_target (l_current_target)
					if attached current_attributes.item (at_extends) as l_extends then
							-- Target are known internally in lower case,
							-- so we should respect this (see bug#12698).
						l_target := l_last_system.targets.item (l_extends.as_lower)
						if l_target /= Void and then l_target /= l_current_target then
							l_current_target.set_parent (l_target)
							group_list := l_target.groups
						else
							set_parse_error_message (conf_interface_names.e_parse_incorrect_target_parent (l_extends, l_name))
						end
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_target_no_name)
				end
			else
				check last_system_not_void: False end
				set_internal_error
			end
		ensure
			target_not_void: not is_error implies current_target /= Void
		end

	process_root_attributes
			-- Process attributes of a root tag.
		require
			current_target_not_void: current_target /= Void
		local
			l_cluster_lower, l_class_lower, l_feature_lower: detachable STRING_32
			l_all_b: BOOLEAN
		do
			if attached current_attributes.item (at_all_classes) as l_all then
				if l_all.is_boolean then
					l_all_b := l_all.to_boolean
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_root_all)
				end
			end
			if attached current_attributes.item (at_cluster) as l_cluster then
				l_cluster_lower := l_cluster.as_lower
				if not is_valid_group_name (l_cluster_lower) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_root_cluster)
				end
			end
			if attached current_attributes.item (at_class) as l_class then
				l_class_lower := l_class.as_lower
				if not is_valid_class_type_name (l_class_lower) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_root_class)
				end
			end
			if attached current_attributes.item (at_feature) as l_feature then
				l_feature_lower := l_feature.as_lower
				if not is_valid_feature_name (l_feature_lower) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_root_feature)
				end
			end
			if
				((l_all_b and l_cluster_lower = Void and l_class_lower = Void and l_feature_lower = Void) or else l_class_lower /= Void) and
				attached current_target as l_current_target -- implied by precondition `current_target_not_void'
			then
				l_current_target.set_root (factory.new_root (l_cluster_lower, l_class_lower, l_feature_lower, l_all_b))
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_root)
			end
		end

	process_version_attributes
			-- Process attributes of a version tag.
		require
			current_target_set: current_target /= Void
		local
			l_i_major, l_i_minor, l_i_release, l_i_build: NATURAL_16
			l_version: CONF_VERSION
		do
			if attached current_attributes.item (at_major) as l_major and then l_major.is_natural_16 then
				l_i_major := l_major.to_natural_16
			end
			if attached current_attributes.item (at_minor) as l_minor and then l_minor.is_natural_16 then
				l_i_minor := l_minor.to_natural_16
			end
			if attached current_attributes.item (at_release) as l_release  and then l_release.is_natural_16 then
				l_i_release := l_release.to_natural_16
			end
			if attached current_attributes.item (at_build) as l_build  and then l_build.is_natural_16 then
				l_i_build := l_build.to_natural_16
			end

			l_version := factory.new_version (l_i_major, l_i_minor, l_i_release, l_i_build)

			if attached current_attributes.item (at_product) as l_product then
				l_version.set_product (l_product)
			end
			if attached current_attributes.item (at_company) as l_company then
				l_version.set_company (l_company)
			end
			if attached current_attributes.item (at_copyright) as l_copyright then
				l_version.set_copyright (l_copyright)
			end
			if attached current_attributes.item (at_trademark) as l_trademark then
				l_version.set_trademark (l_trademark)
			end

			if attached current_target as l_current_target then
				l_current_target.set_version (l_version)
			else
				check precondition__current_target_set: False end
			end
		end

	process_setting_attributes
			-- Process attributes of a setting tag.
		require
			current_target_set: current_target /= Void
		do
			if attached current_attributes.item (at_name) as l_name then
				if attached current_attributes.item (at_value) as l_value then
					if not valid_setting (l_name) then
						set_parse_error_message (conf_interface_names.e_parse_incorrect_setting (l_name))
					else
						if attached current_target as l_current_target then
							if l_name.same_string (s_multithreaded) then
									-- Translate "multithreaded" setting into "concurrency" setting.
								if includes_this_or_before (namespace_1_6_0) then
										-- The setting is allowed.
									if l_value.is_boolean then
											-- SCOOP is not supported in old projects.
										if l_value.to_boolean then
											l_current_target.immediate_setting_concurrency.put_index ({CONF_TARGET}.setting_concurrency_index_thread)
										else
											l_current_target.immediate_setting_concurrency.put_index ({CONF_TARGET}.setting_concurrency_index_none)
										end
									else
											-- Boolean value is expected.
										set_parse_error_message (conf_interface_names.e_parse_incorrect_setting_value (l_name))
									end
								else
										-- The setting is not available in this XML schema.
									set_parse_error_message (conf_interface_names.e_parse_incorrect_setting (l_name))
								end
							elseif l_name.same_string (s_concurrency) then
									-- Process "concurrency" setting.
								if includes_this_or_after (namespace_1_7_0) then
										-- The setting is allowed.
									if l_current_target.immediate_setting_concurrency.is_valid_item (l_value) then
											-- Update setting with this value.
										l_current_target.immediate_setting_concurrency.put (l_value)
									else
											-- The value is invalid.
										set_parse_error_message (conf_interface_names.e_parse_incorrect_setting_value (l_name))
									end
								else
										-- The setting is not available in this XML schema.
									set_parse_error_message (conf_interface_names.e_parse_incorrect_setting (l_name))
								end
							else
								l_current_target.add_setting (l_name, l_value)
							end
						else
							check precondition__current_target_set: False end
						end
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_setting_value (l_name))
				end
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_setting_no_name)
			end
		end

	process_file_rule_attributes
			-- Process attributes of a file_rule tag.
		require
			target_or_cluster: current_target /= Void or current_cluster /= Void
		local
			l_current_file_rule: like current_file_rule
		do
			l_current_file_rule := factory.new_file_rule
			current_file_rule := l_current_file_rule
			if attached current_cluster as l_cluster then
				l_cluster.add_file_rule (l_current_file_rule)
			elseif attached current_target as l_target then
				l_target.add_file_rule (l_current_file_rule)
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_file_rule)
			end
		ensure
			current_file_rule_not_void: current_file_rule /= Void
		end

	process_external_attributes
			-- Process attributes of external_(include|object|library|resource|make) tags.
		require
			current_target_not_void: current_target /= Void
		local
			l_location: detachable like current_attributes.item
			l_inc: CONF_EXTERNAL_INCLUDE
			l_obj: CONF_EXTERNAL_OBJECT
			l_lib: CONF_EXTERNAL_LIBRARY
			l_res: CONF_EXTERNAL_RESOURCE
			l_make: CONF_EXTERNAL_MAKE
		do
				-- Retrieve external value from the attribute "location".
			l_location := current_attributes.item (at_location)
			if l_location = Void then
					-- C compiler and linker flags are specified
					-- by the attribute "value" rather than "location".
				l_location := current_attributes.item (at_value)
			end
			if
				l_location /= Void and
				attached current_target as l_current_target -- implied by precondition `current_target_not_void'
			then
				inspect
					current_tag.item
				when t_external_include then
					l_inc := factory.new_external_include (l_location, l_current_target)
					l_current_target.add_external_include (l_inc)
					current_external := l_inc
				when t_external_cflag then
					create_external_cflag (l_location)
				when t_external_object then
					l_obj := factory.new_external_object (l_location, l_current_target)
					l_current_target.add_external_object (l_obj)
					current_external := l_obj
				when t_external_library then
					l_lib := factory.new_external_library (l_location, l_current_target)
					l_current_target.add_external_library (l_lib)
					current_external := l_lib
				when t_external_resource then
					l_res := factory.new_external_resource (l_location, l_current_target)
					l_current_target.add_external_resource (l_res)
					current_external := l_res
				when t_external_linker_flag then
					create_external_linker_flag (l_location)
				when t_external_make then
					l_make := factory.new_external_make (l_location, l_current_target)
					l_current_target.add_external_make (l_make)
					current_external := l_make
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_external)
				end
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_external)
			end
		ensure
			current_external_not_void: not is_error implies current_external /= Void
		end

	process_action_attributes
			-- Process attributes of (pre|post)_compile_action tags.
		require
			current_target_not_void: current_target /= Void
		local
			l_succeed: detachable like current_attributes.item
			l_current_action: like current_action
		do
			l_succeed := current_attributes.item (at_succeed)
			if l_succeed = Void then
				l_succeed := "false"
			end
			if
				attached current_attributes.item (at_command) as l_command and
				attached current_target as l_current_target -- implied by precondition `current_target_not_void'
			then
				if l_succeed.is_boolean then
					if attached current_attributes.item (at_working_directory) as l_wd then
						l_current_action := factory.new_action (l_command, l_succeed.to_boolean, factory.new_location_from_path (l_wd, l_current_target))
					else
						l_current_action := factory.new_action (l_command, l_succeed.to_boolean, Void)
					end
					current_action := l_current_action

					inspect
						current_tag.item
					when t_pre_compile_action then
						l_current_target.add_pre_compile (l_current_action)
					when t_post_compile_action then
						l_current_target.add_post_compile (l_current_action)
					else
						set_parse_error_message (conf_interface_names.e_parse_incorrect_action_invalid (l_command))
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_action_succeed (l_command))
				end
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_action_no_command)
			end
		ensure
			current_action_not_void: not is_error implies current_action /= Void
		end

	process_variable_attributes
			-- Process attributes of a variable tag.
		require
			current_target_set: current_target /= Void
		local
			l_value: detachable like current_attributes.item
		do
			l_value := current_attributes.item (at_value)
			if l_value = Void then
				l_value := {STRING_32} ""
			end
			if attached current_attributes.item (at_name) as l_name then
				if attached current_target as l_target then
					l_target.add_variable (l_name, l_value)
				else
					check precondition__current_target_set: False end
				end
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_variable_no_name)
			end
		end

	process_library_attributes
			-- Process attributes of a library tag.
		require
			current_target_not_void: current_target /= Void
		local
			l_lower_name: STRING_32
			l_current_library: like current_library
			l_current_group: like current_group
		do
			if attached current_attributes.item (at_name) as l_name then
				l_lower_name := l_name.as_lower
				if
					is_valid_group_name (l_lower_name) and
					attached current_attributes.item (at_location) as l_location and
					not group_list.has (l_lower_name) and
					attached current_target as l_current_target -- implied by precondition `current_target_not_void'
				then
					l_current_library := factory.new_library (l_lower_name, l_location, l_current_target)
					l_current_group := l_current_library
					current_library := l_current_library
					current_group := l_current_group
					if attached current_attributes.item (at_readonly) as l_readonly then
						if l_readonly.is_boolean then
							l_current_library.set_readonly (l_readonly.to_boolean)
						else
							set_parse_error_message (conf_interface_names.e_parse_invalid_value ("readonly"))
						end
					end
					if attached current_attributes.item (at_use_application_options) as l_app_opts then
						if l_app_opts.is_boolean then
							l_current_library.set_use_application_options (l_app_opts.to_boolean)
						else
							set_parse_error_message (conf_interface_names.e_parse_invalid_value ("use_application_options"))
						end
					end
					if attached current_attributes.item (at_prefix) as l_prefix then
						l_current_library.set_name_prefix (l_prefix)
					end
					group_list.force (l_current_group, l_lower_name)
					l_current_target.add_library (l_current_library)
				elseif not is_valid_group_name (l_lower_name) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_library_name (l_name))
				elseif group_list.has (l_lower_name) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_library_conflict (l_name))
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_library (l_name))
				end
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_library_no_name)
			end
		ensure
			library_and_group: not is_error implies current_library /= Void and current_group /= Void
		end

	process_precompile_attributes
			-- Process attributes of a precompile tag.
		require
			current_target_not_void: current_target /= Void
		local
			l_lower_name: STRING_32
			l_current_library: CONF_PRECOMPILE
			l_current_group: like current_group
		do
			if
				attached current_attributes.item (at_name) as l_name and
				attached current_target as l_current_target -- implied by precondition `current_target_not_void'
			then
				l_lower_name := l_name.as_lower
				if
					is_valid_group_name (l_lower_name) and
					attached current_attributes.item (at_location) as l_location and
					not group_list.has (l_lower_name) and
					l_current_target.precompile = Void
				then
					l_current_library := factory.new_precompile (l_lower_name, l_location, l_current_target)
					l_current_group := l_current_library
					current_library := l_current_library
					current_group := l_current_group
					if attached current_attributes.item (at_readonly) as l_readonly then
						if l_readonly.is_boolean then
							l_current_library.set_readonly (l_readonly.to_boolean)
						else
							set_parse_error_message (conf_interface_names.e_parse_invalid_value ("readonly"))
						end
					end
					if attached current_attributes.item (at_prefix) as l_prefix then
						l_current_library.set_name_prefix (l_prefix)
					end
					if attached current_attributes.item (at_eifgens_location) as l_eifgen then
						l_current_library.set_eifgens_location (factory.new_location_from_path (l_eifgen, l_current_target))
					end
					group_list.force (l_current_group, l_lower_name)
					l_current_target.set_precompile (l_current_library)
				elseif not is_valid_group_name (l_lower_name) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_precompile_name (l_name))
				elseif group_list.has (l_lower_name) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_precompile_conflict (l_name))
				elseif attached l_current_target.precompile as l_precompile then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_precompile_multiple (l_name, l_precompile.name))
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_precompile (l_name))
				end
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_precompile_no_name)
			end
		ensure
			library_and_group: not is_error implies current_library /= Void and current_group /= Void
		end

	process_assembly_attributes
			-- Process attributes of an assembly tag.
		require
			current_target_set: current_target /= Void
		local
			l_lower_name: STRING_32
			l_location: like current_attributes.item
			l_current_assembly: like current_assembly
			l_current_group: like current_group
		do
			if attached current_attributes.item (at_name) as l_name then
				l_lower_name := l_name.as_lower
				l_location := current_attributes.item (at_location)
				if
					is_valid_group_name (l_lower_name) and
					l_location /= Void and
					not group_list.has (l_lower_name) and
					attached current_target as l_current_target -- implied by precondition `current_target_not_void'
				then
					if
						l_location.same_string_general ("none") and then -- condition merged with the next 4 conditions during refactorying
						(
							attached current_attributes.item (at_assembly_name) as l_assembly_name and
							attached current_attributes.item (at_assembly_version) as l_assembly_version and
							attached current_attributes.item (at_assembly_culture) as l_assembly_culture and
							attached current_attributes.item (at_assembly_key) as l_assembly_key
						)
					then
						l_current_assembly := factory.new_assembly_from_gac (l_lower_name, l_assembly_name, l_assembly_version, l_assembly_culture, l_assembly_key, l_current_target)
					else
						l_current_assembly := factory.new_assembly (l_lower_name, l_location, l_current_target)
					end
					l_current_group := l_current_assembly
					current_assembly := l_current_assembly
					current_group := l_current_group
					if attached current_attributes.item (at_readonly) as l_readonly then
						if l_readonly.is_boolean then
							l_current_assembly.set_readonly (l_readonly.to_boolean)
						else
							set_parse_error_message (conf_interface_names.e_parse_invalid_value ("readonly"))
						end
					end
					if attached current_attributes.item (at_prefix) as l_prefix then
						l_current_assembly.set_name_prefix (l_prefix)
					end
					group_list.force (l_current_group, l_lower_name)
					l_current_target.add_assembly (l_current_assembly)
				elseif not is_valid_group_name (l_lower_name) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_assembly_name (l_name))
				elseif l_location = Void then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_assembly (l_name))
				elseif group_list.has (l_lower_name) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_assembly_conflict (l_name))
				else
					check should_not_reach: False end
				end
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_assembly_no_name)
			end
		ensure
			assembly_and_group: not is_error implies current_assembly /= Void and current_group /= Void
		end

	process_cluster_attributes (a_is_test_cluster: BOOLEAN)
			-- Process attributes of a cluster tag.
			--
			-- `a_is_test_cluster': Defines whether new cluster is a test cluster or not.
		require
			target_set: current_target /= Void
		local
			l_lower_name: STRING_32
			l_location: like current_attributes.item
			l_parent: like current_cluster
			l_current_cluster: like current_cluster
			l_current_group: like current_group
			l_loc: CONF_DIRECTORY_LOCATION
		do
			if attached current_attributes.item (at_name) as l_name then
				l_lower_name := l_name.as_lower
				l_location := current_attributes.item (at_location)
				if
					is_valid_group_name (l_lower_name) and
					l_location /= Void and
					not group_list.has (l_lower_name) and
					attached current_target as l_current_target -- implied by precondition `target_set'
				then
					l_parent := current_cluster
					l_loc := factory.new_location_from_path (l_location, l_current_target)
					if a_is_test_cluster then
						l_current_cluster := factory.new_test_cluster (l_lower_name, l_loc, l_current_target)
					else
						l_current_cluster := factory.new_cluster (l_lower_name, l_loc, l_current_target)
					end
					l_current_group := l_current_cluster
					current_cluster := l_current_cluster
					current_group := l_current_group
					if attached current_attributes.item (at_readonly) as l_readonly then
						if l_readonly.is_boolean then
							l_current_cluster.set_readonly (l_readonly.to_boolean)
						else
							set_parse_error_message (conf_interface_names.e_parse_invalid_value ("readonly"))
						end
					end
					if attached current_attributes.item (at_hidden) as l_hidden then
						if l_hidden.is_boolean then
							l_current_cluster.set_hidden (l_hidden.to_boolean)
						else
							set_parse_error_message (conf_interface_names.e_parse_invalid_value ("hidden"))
						end
					end
					if attached current_attributes.item (at_recursive) as l_recursive then
						if l_recursive.is_boolean then
							l_current_cluster.set_recursive (l_recursive.to_boolean)
						else
							set_parse_error_message (conf_interface_names.e_parse_invalid_value ("recursive"))
						end
					end
					if l_parent /= Void then
						l_parent.add_child (l_current_cluster)
						l_current_cluster.set_parent (l_parent)
						l_loc.set_parent (l_parent.location)
					end

					group_list.force (l_current_group, l_lower_name)
					l_current_target.add_cluster (l_current_cluster)
				elseif not is_valid_group_name (l_lower_name) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_cluster_name (l_name))
				elseif l_location /= Void then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_cluster_conflict (l_name))
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_cluster (l_name))
				end
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_cluster_no_name)
			end
		ensure
			cluster_and_group: not is_error implies current_cluster /= Void and current_group /= Void
		end

	process_override_attributes
			-- Process attributes of an override tag.
		require
			target_set: current_target /= Void
		local
			l_lower_name: STRING_32
			l_location: like current_attributes.item
			l_parent: detachable CONF_CLUSTER
			l_current_override: like current_override
			l_current_cluster: like current_cluster
			l_current_group: like current_group
		do
			if attached current_attributes.item (at_name) as l_name then
				l_lower_name := l_name.as_lower
				l_location := current_attributes.item (at_location)
				if
					is_valid_group_name (l_lower_name) and
					l_location /= Void and
					not group_list.has (l_lower_name) and
					attached current_target as l_current_target -- implied by precondition `target_set'
				then
					l_parent := current_cluster
					l_current_override := factory.new_override (l_lower_name, factory.new_location_from_path (l_location, l_current_target), l_current_target)
					l_current_cluster := l_current_override
					l_current_group := l_current_override

					current_override := l_current_override
					current_cluster := l_current_cluster
					current_group := l_current_group

					if attached current_attributes.item (at_readonly) as l_readonly then
						if l_readonly.is_boolean then
							l_current_cluster.set_readonly (l_readonly.to_boolean)
						else
							set_parse_error_message (conf_interface_names.e_parse_invalid_value ("readonly"))
						end
					end
					if attached current_attributes.item (at_hidden) as l_hidden then
						if l_hidden.is_boolean then
							l_current_cluster.set_hidden (l_hidden.to_boolean)
						else
							set_parse_error_message (conf_interface_names.e_parse_invalid_value ("hidden"))
						end
					end
					if attached current_attributes.item (at_recursive) as l_recursive then
						if l_recursive.is_boolean then
							l_current_cluster.set_recursive (l_recursive.to_boolean)
						else
							set_parse_error_message (conf_interface_names.e_parse_invalid_value ("recursive"))
						end
					end
					if l_parent /= Void then
						l_parent.add_child (l_current_cluster)
						l_current_cluster.set_parent (l_parent)
					end
					group_list.force (l_current_group, l_lower_name)
					l_current_target.add_override (l_current_override)
				elseif not is_valid_group_name (l_lower_name) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_override_name (l_name))
				elseif group_list.has (l_lower_name) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_override_conflict (l_name))
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_override (l_name))
				end
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_override_no_name)
			end
		ensure
			override_and_cluster_and_group: current_override /= Void and current_cluster /= Void and current_group /= Void
		end

	process_debug_attributes (a_current_option: attached like current_option)
			-- Process attributes of a debug tag.
		require
			current_option_not_void: a_current_option /= Void
		local
			l_lower_name: STRING_32
		do
			if attached current_attributes.item (at_name) as l_name then
				l_lower_name := l_name.as_lower
				if attached current_attributes.item (at_enabled) as l_enabled then
					if l_enabled.is_boolean then
						a_current_option.add_debug (l_lower_name, l_enabled.to_boolean)
					elseif not l_enabled.is_boolean then
						set_parse_error_message (conf_interface_names.e_parse_invalid_value (at_enabled_string))
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_debug (l_name))
				end
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_debug_no_name)
			end
		end

	process_warning_attributes (a_current_option: attached like current_option)
			-- Process attributes of a warning tag.
		require
			current_option_not_void: a_current_option /= Void
		local
			l_lower_name: STRING_32
			l_enabled: like current_attributes.item
		do
			if attached current_attributes.item (at_name) as l_name then
				l_lower_name := l_name.as_lower
				l_enabled := current_attributes.item (at_enabled)
				if l_enabled = Void then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_warning (l_name))
				elseif not l_enabled.is_boolean then
					set_parse_error_message (conf_interface_names.e_parse_invalid_value (at_enabled_string))
				elseif valid_warning (l_lower_name, current_namespace) then
					a_current_option.add_warning (l_lower_name, l_enabled.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_warning (l_name))
				end
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_warning_no_name)
			end
		end

	process_assertions_attributes (a_current_option: attached like current_option)
			-- Process attributes of a assertions tag.
		require
			current_option_set: a_current_option /= Void
		local
			l_assert: CONF_ASSERTIONS
		do
			l_assert := factory.new_assertions
			if attached current_attributes.item (at_precondition) as l_pre then
				if l_pre.is_boolean then
					if l_pre.to_boolean then
						l_assert.enable_precondition
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("precondition"))
				end
			end
			if attached current_attributes.item (at_postcondition) as l_post then
				if l_post.is_boolean then
					if l_post.to_boolean then
						l_assert.enable_postcondition
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("postcondition"))
				end
			end
			if attached current_attributes.item (at_check) as l_chk then
				if l_chk.is_boolean then
					if l_chk.to_boolean then
						l_assert.enable_check
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("check"))
				end
			end
			if attached current_attributes.item (at_invariant) as l_inv then
				if l_inv.is_boolean then
					if l_inv.to_boolean then
						l_assert.enable_invariant
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("invariant"))
				end
			end
			if attached current_attributes.item (at_loop) as l_loop then
				if l_loop.is_boolean then
					if l_loop.to_boolean then
						l_assert.enable_loop
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("loop"))
				end
			end
			if attached current_attributes.item (at_supplier_precondition) as l_sup_pre then
				if l_sup_pre.is_boolean then
					if l_sup_pre.to_boolean then
						l_assert.enable_supplier_precondition
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("supplier_precondition"))
				end
			end
			a_current_option.set_assertions (l_assert)
		end

	process_renaming_attributes
			-- Process attributes of a renaming tag.
		require
			group: current_group /= Void
		local
			l_old_name, l_new_name: like current_attributes.item
		do
			l_old_name := current_attributes.item (at_old_name)
			l_new_name := current_attributes.item (at_new_name)
			if l_old_name /= Void and l_new_name /= Void then
				if attached {CONF_VIRTUAL_GROUP} current_group as l_virtual_group then
					l_virtual_group.add_renaming (l_old_name.as_upper, l_new_name.as_upper)
				else
					check
						virtual_group: False
					end
				end
			elseif l_old_name /= Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_renaming_no_new (l_old_name))
			elseif l_new_name /= Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_renaming_no_old (l_new_name))
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_renaming_no_name)
			end
		end

	process_option_attributes (a_class_option: BOOLEAN)
			-- Process attributes of a (class) option tag.
		require
			group: a_class_option implies current_group /= Void
			target_set: current_target /= Void
		local
			l_current_option: like current_option
		do
			l_current_option := factory.new_option
			current_option := l_current_option
			if attached current_attributes.item (at_trace) as l_trace then
				if l_trace.is_boolean then
					l_current_option.set_trace (l_trace.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("trace"))
				end
			end
			if attached current_attributes.item (at_profile) as l_profile then
				if l_profile.is_boolean then
					l_current_option.set_profile (l_profile.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("profile"))
				end
			end
			if attached current_attributes.item (at_optimize) as l_optimize then
				if l_optimize.is_boolean then
					l_current_option.set_optimize (l_optimize.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("optimize"))
				end
			end
			if attached current_attributes.item (at_debug) as l_debug then
				if l_debug.is_boolean then
					l_current_option.set_debug (l_debug.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("debug"))
				end
			end
			if attached current_attributes.item (at_warning) as l_warning then
				if l_warning.is_boolean then
					l_current_option.set_warning (l_warning.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("warning"))
				end
			end
			if
				attached current_attributes.item (at_msil_application_optimize) as l_msil_application_optimize and then
				l_msil_application_optimize.is_boolean
			then
				l_current_option.set_msil_application_optimize (l_msil_application_optimize.to_boolean)
			end
			if attached current_attributes.item (at_namespace) as l_namespace then
				l_current_option.set_local_namespace (l_namespace)
			end
			if attached current_attributes.item (at_full_class_checking) as l_full_class_checking then
				if l_full_class_checking.is_boolean then
					l_current_option.set_full_class_checking (l_full_class_checking.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("full_class_checking"))
				end
			end
			if attached current_attributes.item (at_cat_call_detection) as l_cat_call_detection then
				if l_cat_call_detection.is_boolean then
					l_current_option.set_cat_call_detection (l_cat_call_detection.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("cat_call_detection"))
				end
			end
			if attached current_attributes.item (at_is_attached_by_default) as l_is_attached_by_default then
				if l_is_attached_by_default.is_boolean then
					l_current_option.set_is_attached_by_default (l_is_attached_by_default.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("is_attached_by_default"))
				end
			end
			if attached current_attributes.item (at_void_safety) as l_void_safety then
				if includes_this_or_after (namespace_1_5_0) then
					if l_current_option.void_safety.is_valid_item (l_void_safety) then
						l_current_option.void_safety.put (l_void_safety)
						if includes_this_or_before (namespace_1_10_0) then
								-- Adapt indexes to earlier namespace.
							inspect
								l_current_option.void_safety.index
							when
								{CONF_OPTION}.void_safety_index_none,
								{CONF_OPTION}.void_safety_index_initialization
							then
									-- Use as is.
							when {CONF_OPTION}.void_safety_index_all then
									-- Use lower void-safety setting.
								l_current_option.void_safety.put_index ({CONF_OPTION}.void_safety_index_transitional)
							else
									-- Report unknown value.
								set_parse_error_message (conf_interface_names.e_parse_invalid_value ("void_safety"))
							end
						end
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("void_safety"))
					end
				else
					report_unknown_attribute ("void_safety")
				end
			end
			if attached current_attributes.item (at_is_void_safe) as l_is_void_safe then
				if
					includes_this_or_before (namespace_1_4_0) or else
					(includes_this_or_after (namespace_1_9_0) and then
					includes_this_or_before (namespace_1_10_0))
				then
					if l_is_void_safe.is_boolean then
						if includes_this_or_before (namespace_1_4_0) then
							if l_is_void_safe.to_boolean then
								l_current_option.void_safety.put_index ({CONF_OPTION}.void_safety_index_transitional)
							else
								l_current_option.void_safety.put_index ({CONF_OPTION}.void_safety_index_none)
							end
						elseif l_is_void_safe.to_boolean then
							l_current_option.void_safety.put_index ({CONF_OPTION}.void_safety_index_all)
						end
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("is_void_safe"))
					end
				else
					report_unknown_attribute ("is_void_safe")
				end
			end
			if attached current_attributes.item (at_syntax_level) as l_syntax_level then
				if includes_this_or_before (namespace_1_4_0) then
					if l_syntax_level.is_natural_8 then
						inspect l_syntax_level.to_natural_8
						when 0 then
							l_current_option.syntax.put_index ({CONF_OPTION}.syntax_index_obsolete)
						when 1 then
							l_current_option.syntax.put_index ({CONF_OPTION}.syntax_index_transitional)
						when 2 then
							l_current_option.syntax.put_index ({CONF_OPTION}.syntax_index_standard)
						else
							set_parse_error_message (conf_interface_names.e_parse_invalid_value ("syntax_level"))
						end
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("syntax_level"))
					end
				else
					report_unknown_attribute ("syntax_level")
				end
			end
			if attached current_attributes.item (at_syntax) as l_syntax then
				if includes_this_or_after (namespace_1_5_0) then
					if l_current_option.syntax.is_valid_item (l_syntax) then
						l_current_option.syntax.put (l_syntax)
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("syntax"))
					end
				else
					report_unknown_attribute ("syntax")
				end
			end

			if a_class_option then
				if
					attached current_attributes.item (at_class) as l_class and then
					is_valid_class_name (l_class) and then
					attached current_group as l_current_group -- implied by precondition `group'
				then
					l_current_group.add_class_options (l_current_option, l_class.as_upper)
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_class_opt)
				end
			else
				if attached current_group as l_current_group then
					l_current_group.set_options (l_current_option)
				elseif attached current_target as l_target then
					l_target.set_options (l_current_option)
				else
					check precondition__target_set: False end
				end
			end
			if attached {CONF_LIBRARY} current_group then
				report_non_client_options
			end
			check same_current_option: l_current_option = current_option end
		ensure
			current_option_not_void: not is_error implies current_option /= Void
		end

	process_visible_attributes
			-- Process attributes of a visible tag.
		require
			cluster_or_library_set: current_cluster /= Void or current_library /= Void
		local
			l_current_cluster: like current_cluster
			l_current_library: like current_library
			l_class, l_feature, l_class_rename, l_feature_rename: detachable STRING_32
		do
			l_class := current_attributes.item (at_class)
			if l_class /= Void then
				l_class := l_class.as_lower
			end

			l_current_cluster := current_cluster
			l_current_library := current_library
			if l_class /= Void and then is_valid_class_name (l_class) then
				if attached current_attributes.item (at_feature) as f then
					l_feature := f.as_lower
					if not is_valid_feature_name (l_feature) then
						set_parse_error_message (conf_interface_names.e_parse_incorrect_visible_feature (l_feature))
					end
				end
				if attached current_attributes.item (at_class_rename) as cl_r then
					l_class_rename := cl_r.as_lower
					if not is_valid_class_name (l_class_rename) then
						set_parse_error_message (conf_interface_names.e_parse_incorrect_visible_class (l_class_rename))
					end
				end
				if attached current_attributes.item (at_feature_rename) as ft_r then
					l_feature_rename := ft_r.as_lower
					if not is_valid_feature_name (l_feature_rename) then
						set_parse_error_message (conf_interface_names.e_parse_incorrect_visible_feature (l_feature_rename))
					end
				end
				if l_current_cluster /= Void then
					l_current_cluster.add_visible (l_class, l_feature, l_class_rename, l_feature_rename)
				elseif l_current_library /= Void then
					l_current_library.add_visible (l_class, l_feature, l_class_rename, l_feature_rename)
				else
					check cluster_or_library_set: False end
				end
			else
				if l_current_cluster /= Void then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_visible (l_current_cluster.name))
				elseif l_current_library /= Void then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_visible (l_current_library.name))
				else
					check cluster_or_library_set: False end
				end
			end
		end

	process_uses_attributes
			-- Process attributes of an uses tag.
		require
			current_cluster_set: current_cluster /= Void
		local
			ll: detachable ARRAYED_LIST [CONF_CLUSTER]
		do
			if attached current_cluster as l_current_cluster then
				if attached current_attributes.item (at_group) as l_group and then is_valid_group_name (l_group) then
					if l_group.same_string_general ("none") then
						l_current_cluster.set_dependencies (create {SEARCH_TABLE [CONF_GROUP]}.make (0))
					else
						ll := uses_list.item (l_group)
						if ll = Void then
							create ll.make (1)
						end
						ll.extend (l_current_cluster)
						uses_list.force (ll, l_group)
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_uses (l_current_cluster.name))
				end
			else
				check current_cluster_set: False end
				set_internal_error
			end
		end

	process_overrides_attributes
			-- Process attributes of an overides tag.
		require
			current_override_set: current_override /= Void
		local
			ll:  detachable ARRAYED_LIST [CONF_OVERRIDE]
		do
			if attached current_override as l_current_override then
				if attached current_attributes.item (at_group) as l_group and then is_valid_group_name (l_group) then
					if l_group.same_string_general ("none") then
						l_current_override.set_override (create {ARRAYED_LIST [CONF_GROUP]}.make (0))
					else
						ll := overrides_list.item (l_group)
						if ll = Void then
							create ll.make (1)
						end
						ll.extend (l_current_override)
						overrides_list.force (ll, l_group)
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_overrides (l_current_override.name))
				end
			else
				check current_override_set: False end
				set_internal_error
			end
		end

	process_condition_attributes
			-- Process attributes of a condition tag.
		require
			external_or_action_or_group_or_file_rule: current_external /= Void or current_action /= Void or current_group /= Void or current_file_rule /= Void
		local
			l_cond: like current_condition
		do
			create l_cond.make
			current_condition := l_cond

			if not is_error then
				if attached current_file_rule as l_current_file_rule then
					l_current_file_rule.add_condition (l_cond)
				elseif attached current_external as l_current_external then
					l_current_external.add_condition (l_cond)
				elseif attached current_action as l_current_action then
					l_current_action.add_condition (l_cond)
				elseif attached current_group as l_current_group then
					l_current_group.add_condition (l_cond)
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_condition)
				end
			end
		ensure
			current_condition: not is_error implies current_condition /= Void
		end

	process_platform_attributes (a_current_condition: attached like current_condition)
			-- Process attributes of a platform tag.
		require
			current_condition_set: a_current_condition /= Void
		local
			l_value, l_excluded_value: like current_attributes.item
			l_pf: INTEGER
			l_platforms: detachable LIST [attached like current_attributes.item]
			l_invert: BOOLEAN
		do
			l_value := current_attributes.item (at_value)
			l_excluded_value := current_attributes.item (at_excluded_value)
			if a_current_condition.platform /= Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_platform_mult)
			elseif l_value /= Void and l_excluded_value /= Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_platform_conflict)
			elseif l_value = Void and l_excluded_value = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_platform_none)
			elseif l_value /= Void then
				l_platforms := l_value.split (' ')
			elseif l_excluded_value /= Void then
				l_platforms := l_excluded_value.split (' ')
				l_invert := True
			else
				check code_implies_value_or_excluded_value_attached: False end
			end

			if not is_error and then l_platforms /= Void then
					-- note that from code: not is_error implies l_platforms /= Void				
				from
					l_platforms.start
				until
					l_platforms.after or is_error
				loop
					l_pf := get_platform (l_platforms.item)
					if not valid_platform (l_pf) then
						set_parse_error_message (conf_interface_names.e_parse_incorrect_platform (l_platforms.item))
					else
						if l_invert then
							a_current_condition.exclude_platform (l_pf)
						else
							a_current_condition.add_platform (l_pf)
						end
					end
					l_platforms.forth
				end
			end
		end

	process_build_attributes (a_current_condition: attached like current_condition)
			-- Process attributes of a build tag.
		require
			current_condition_set: a_current_condition /= Void
		local
			l_value, l_excluded_value: like current_attributes.item
			l_bld: INTEGER
			l_builds: detachable LIST [attached like current_attributes.item]
			l_invert: BOOLEAN
		do
			l_value := current_attributes.item (at_value)
			l_excluded_value := current_attributes.item (at_excluded_value)
			if a_current_condition.build /= Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_build_mult)
			elseif l_value /= Void and l_excluded_value /= Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_build_conflict)
			elseif l_value = Void and l_excluded_value = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_build_none)
			elseif l_value /= Void then
				l_builds := l_value.split (' ')
			elseif l_excluded_value /= Void then
				l_builds := l_excluded_value.split (' ')
				l_invert := True
			else
				check code_implies_value_or_exclude_value_attached: False end
			end

			if not is_error and then l_builds /= Void then
					-- note that from code: not is_error implies l_builds /= Void
				from
					l_builds.start
				until
					l_builds.after or is_error
				loop
					l_bld := get_build (l_builds.item)
					if not valid_build (l_bld) then
						set_parse_error_message (conf_interface_names.e_parse_incorrect_build (l_builds.item))
					else
						if l_invert then
							a_current_condition.exclude_build (l_bld)
						else
							a_current_condition.add_build (l_bld)
						end
					end
					l_builds.forth
				end
			end
		end

	process_multithreaded_attributes (a_current_condition: attached like current_condition)
			-- Process attributes of a multithreaded tag.
		require
			current_condition_set: a_current_condition /= Void
		local
			l_value: like current_attributes.item
		do
			if includes_this_or_before (namespace_1_7_0) then
					-- Retrieve boolean value.
				l_value := current_attributes.item (at_value)
				if l_value = Void or else not l_value.is_boolean then
						-- The value is invalid.
					set_parse_error_message (conf_interface_names.e_parse_incorrect_multithreaded)
				else
						-- Convert "multithreaded" condition to "concurrency" condition.
					if l_value.to_boolean then
						a_current_condition.exclude_concurrency (concurrency_none)
					else
						a_current_condition.add_concurrency (concurrency_none)
					end
				end
			else
					-- "multithreaded" tag is not available.
				set_parse_error_message (conf_interface_names.e_parse_incorrect_condition)
			end
		end

	process_concurrency_attributes (a_current_condition: attached like current_condition)
			-- Process attributes of a concurrency tag.
		require
			current_condition_set: a_current_condition /= Void
		local
			l_name, l_value, l_excluded_value: like current_attributes.item
			l_concurrency_values: detachable LIST [attached like current_attributes.item]
			l_invert: BOOLEAN
			l_conc: INTEGER
		do
			if includes_this_or_after (namespace_1_8_0) then
				l_name := current_attributes.item (at_name)
				l_value := current_attributes.item (at_value)
				l_excluded_value := current_attributes.item (at_excluded_value)
				if l_value = Void and then l_excluded_value = Void then
						-- No value is set so we are in an invalid state.
					set_parse_error_message (conf_interface_names.e_parse_incorrect_concurrency ("(undefined)"))
				elseif l_value /= Void and then l_excluded_value /= Void then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_concurrency ("(Cannot include and exclude at the same time)"))
				elseif l_value /= Void then
					l_concurrency_values := l_value.split (' ')
					-- Check for value and exclude_value tags.
				elseif l_excluded_value /= Void then
					l_concurrency_values := l_excluded_value.split (' ')
					l_invert := True
				else
					check code_implies_value_or_excluded_value_set: False end
				end

				if
					not is_error and then
					l_concurrency_values /= Void -- note: from code: not is_error implies l_concurrency_values /= Void
				then
					from
						l_concurrency_values.start
					until
						l_concurrency_values.after or is_error
					loop
						l_conc := get_concurrency (l_concurrency_values.item)
						if not valid_concurrency (l_conc) then
							set_parse_error_message (conf_interface_names.e_parse_incorrect_concurrency (l_concurrency_values.item))
						else
							if l_invert then
								a_current_condition.exclude_concurrency (l_conc)
							else
								a_current_condition.add_concurrency (l_conc)
							end
						end
						l_concurrency_values.forth
					end
				end
			else
					-- "concurrency" tag is not available.
				set_parse_error_message (conf_interface_names.e_parse_incorrect_condition)
			end
		end

	process_dotnet_attributes (a_current_condition: attached like current_condition)
			-- Process attributes of a dotnet tag.
		require
			current_condition_set: a_current_condition /= Void
		local
			l_value: like current_attributes.item
		do
			l_value := current_attributes.item (at_value)
			if l_value = Void or else not l_value.is_boolean then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_dotnet)
			else
				a_current_condition.set_dotnet (l_value.to_boolean)
			end
		end

	process_dynamic_runtime_attributes (a_current_condition: attached like current_condition)
			-- Process attributes of a dynamic_runtime tag.
		require
			current_condition_set: a_current_condition /= Void
		local
			l_value: like current_attributes.item
		do
			l_value := current_attributes.item (at_value)
			if l_value = Void or else not l_value.is_boolean then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_dynamic_runtime)
			else
				a_current_condition.set_dynamic_runtime (l_value.to_boolean)
			end
		end

	process_version_condition_attributes (a_current_condition: attached like current_condition)
			-- Process attributes of a condition version tag.
		require
			current_condition_set: a_current_condition /= Void
		local
			l_min, l_max, l_type: like current_attributes.item
			l_vers_min, l_vers_max: detachable CONF_VERSION
		do
			l_min := current_attributes.item (at_min)
			l_max := current_attributes.item (at_max)
			l_type := current_attributes.item (at_type)
			if l_min /= Void then
				create l_vers_min.make_from_string (l_min)
				if l_vers_min.is_error then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_version_min (l_min))
				end
			end
			if l_max /= Void then
				create l_vers_max.make_from_string (l_max)
				if l_vers_max.is_error then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_version_max (l_max))
				end
			end
			if not is_error then
				if l_type = Void then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_version_no_type)
				elseif not valid_version_type (l_type) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_version_type (l_type))
				elseif l_min = Void and l_max = Void then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_version_no_version (l_type))
				elseif (l_min /= Void and l_max /= Void) and then l_min > l_max then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_version_min_max (l_type))
				elseif l_vers_min /= Void or l_vers_max /= Void then
					a_current_condition.add_version (l_vers_min, l_vers_max, l_type)
				else
					check should_not_occur: False end
				end
			end
		end

	process_custom_attributes (a_current_condition: attached like current_condition)
			-- Process attributes of a custom tag.
		require
			current_condition_set: a_current_condition /= Void
		local
			l_name, l_value, l_excluded_value: like current_attributes.item
		do
			l_name := current_attributes.item (at_name)
			if l_name = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_custom_no_name)
			else
				l_value := current_attributes.item (at_value)
				l_excluded_value := current_attributes.item (at_excluded_value)
				if l_value /= Void and l_excluded_value /= Void then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_custom_conflict (l_name))
				elseif l_value = Void and l_excluded_value = Void then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_custom_none (l_name))
				else
					if l_value /= Void then
						a_current_condition.add_custom (l_name, l_value, False)
					elseif l_excluded_value /= Void then
						a_current_condition.add_custom (l_name, l_excluded_value, True)
					else
						check
							code_implie_value_or_excluded_value_attached: False
						end
					end
				end
			end
		end

	process_mapping_attributes
			-- Process attributes of a mapping tag.
		require
			cluster_or_target: current_cluster /= Void or current_target /= Void
		local
			l_old, l_new: like current_attributes.item
		do
			l_old := current_attributes.item (at_old_name)
			l_new := current_attributes.item (at_new_name)
			if
				(l_old = Void or l_new = Void)
				or else (not is_valid_class_name (l_old) or not is_valid_class_name (l_new))
			then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_mapping)
			else
				if attached current_cluster as clu then
					clu.add_mapping (l_old, l_new)
				elseif attached current_target as tgt then
					tgt.add_mapping (l_old, l_new)
				else
					check precondition__cluster_or_target: False end -- precondition
				end
			end
		end

feature {NONE} -- Implementation content processing

	process_description_content
			-- Process content of a description tag.
		do
			if attached current_file_rule as rul then
				rul.set_description (current_content)
			elseif attached current_option as opt then
				opt.set_description (current_content)
			elseif attached current_action as act then
				act.set_description (current_content)
			elseif attached current_external as ext then
				ext.set_description (current_content)
			elseif attached current_group as grp then
				grp.set_description (current_content)
			elseif attached current_target as tgt then
				tgt.set_description (current_content)
			elseif attached last_system as sys then
				sys.set_description (current_content)
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_description)
			end
		end

	process_exclude_content
			-- Process content of an exclude tag.
		require
			file_rule: current_file_rule /= Void
		do
			if valid_regexp (current_content) then
				if attached current_file_rule as l_current_file_rule then
					l_current_file_rule.add_exclude (current_content)
				else
					check file_rule: False end
					set_internal_error
				end
			else
				set_error (create {CONF_ERROR_REGEXP}.make (current_content))
			end
		end

	process_include_content
			-- Process content of an include tag.
		require
			file_rule: current_file_rule /= Void
		do
			if valid_regexp (current_content) then
				if attached current_file_rule as l_current_file_rule then
					l_current_file_rule.add_include (current_content)
				else
					check file_rule: False end
					set_internal_error
				end
			else
				set_error (create {CONF_ERROR_REGEXP}.make (current_content))
			end
		end

feature {NONE} -- Processing of options

	set_default_options (t: attached like current_target; a_namespace: like latest_namespace)
			-- Set default options depending on the supplied schema.
		require
			t_attached: t /= Void
			a_namespace_attached: a_namespace /= Void
		local
			o: detachable CONF_OPTION
		do
			if not a_namespace.same_string (latest_namespace) then
					-- Option settings are different from the current defauls, we need to set them if they are not set yet.
				o := t.options
				if o = Void then
					o := factory.new_option
				end
				if
					a_namespace.same_string (namespace_1_13_0)
				then
						-- Use the defaults of ES 14.05.
					o.merge (default_options_14_05)
				elseif
					a_namespace.same_string (namespace_1_12_0) or
					a_namespace.same_string (namespace_1_11_0)
				then
						-- Use the defaults of ES 7.3.
					o.merge (default_options_7_3)
				elseif
					a_namespace.same_string (namespace_1_10_0) or else
					a_namespace.same_string (namespace_1_9_0)
				then
						-- Use the defaults of ES 7.0.
					o.merge (default_options_7_0)
				elseif
					a_namespace.same_string (namespace_1_8_0) or else
					a_namespace.same_string (namespace_1_7_0) or else
					a_namespace.same_string (namespace_1_6_0) or else
					a_namespace.same_string (namespace_1_5_0)
				then
						-- Use the defaults of ES 6.4.
					o.merge (default_options_6_4)
				elseif
					a_namespace.same_string (namespace_1_4_0) or else
					a_namespace.same_string (namespace_1_3_0) or else
					a_namespace.same_string (namespace_1_2_0) or else
					a_namespace.same_string (namespace_1_0_0)
				then
						-- Use the defaults of ES 6.3 and below.
					o.merge (default_options_6_3)
				else
						-- Unknown version, do not change anything just in case it is above the current one.
					o := Void
				end
				if o /= Void then
					t.set_options (o)
				end
			end
		end

	non_client_options: ARRAY [TUPLE [name: READABLE_STRING_GENERAL; id: INTEGER]]
			-- Non-client option names with their IDs
		local
			ids: like non_client_option_ids
			i: INTEGER
			o: like at_syntax
		once
			create Result.make_empty
			if attached tag_attributes.item (t_option) as a then
				ids := non_client_option_ids
				from
					i := 1
				until
					i > ids.upper
				loop
					o := ids.item (i)
					check
						a.has_item (o)
					end
					from
						a.start
					until
						a.item_for_iteration = o
					loop
						a.forth
					end
					Result.force ([a.key_for_iteration, o], i)
					i := i + 1
				end
			end
		ensure
			result_attached: Result /= Void
		end

	report_non_client_options
			-- Report options that cannot be overridden if specified in the current context (`current_attributes').
		local
			o: like non_client_options
			i: INTEGER
		do
			o := non_client_options
			from
				i := o.lower
			until
				i > o.upper
			loop
				if current_attributes.has (o [i].id) then
					set_parse_warning_message (conf_interface_names.e_parse_incorrect_option_override (o[i].name))
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	factory: CONF_PARSE_FACTORY
			-- Factory for node creation.

	current_library_target: detachable STRING_32
	current_target: detachable CONF_TARGET
	current_cluster: detachable CONF_CLUSTER
	current_override: detachable CONF_OVERRIDE
	current_library: detachable CONF_LIBRARY
	current_assembly: detachable CONF_ASSEMBLY
	current_group: detachable CONF_GROUP
	current_file_rule: detachable CONF_FILE_RULE
	current_option: detachable CONF_OPTION
	current_external: detachable CONF_EXTERNAL
	current_action: detachable CONF_ACTION
	current_content: STRING_32
	current_condition: detachable CONF_CONDITION

	uses_list: STRING_TABLE [ARRAYED_LIST [CONF_CLUSTER]]
			-- The list of classes, that have a uses clause on something.
			-- Entries will be handled at the end.

	overrides_list: STRING_TABLE [ARRAYED_LIST [CONF_OVERRIDE]]
			-- The list of classes, that have an overrides clause on something.
			-- Entries will be handled at the end.

	group_list: STRING_TABLE [CONF_GROUP]
			-- All groups of `current_target', to check for name conflicts and to compute dependencies and overrides.

	current_tag: LINKED_STACK [INTEGER]
			-- The stack of tags we are currently processing

	current_attributes: HASH_TABLE [STRING_32, INTEGER]
			-- The values of the current attributes.
			-- Defined attributes.

feature {NONE} -- Note Implementation

	process_element_under_note
			-- Process attributes of an element under note.
		require
			in_note: note_level > 0
		local
			l_element: CONF_NOTE_ELEMENT
		do
				-- All notes attributes are undefined.
			l_element := current_element_under_note.item
			if attached current_attributes_undefined as l_attrs then
				l_element.set_attributes (l_attrs.twin)
			end
		end

	process_note
			-- Process note element
		require
			group_or_target_or_system: current_group /= Void or current_target /= Void or last_system /= Void
			root_element: note_level = 1
		local
			l_note: CONF_NOTE_ELEMENT
		do
			l_note := current_element_under_note.item
			if attached current_group as g then
				if g.note_node = Void then
					g.set_note_node (l_note)
				else
					set_parse_warning_message (conf_interface_names.e_parse_more_than_one_note (g.name))
				end
			elseif attached current_target as t then
				if t.note_node = Void then
					t.set_note_node (l_note)
				else
					set_parse_warning_message (conf_interface_names.e_parse_more_than_one_note (t.name))
				end
			elseif attached last_system as sys then
				if sys.note_node = Void then
					sys.set_note_node (l_note)
				else
					set_parse_warning_message (conf_interface_names.e_parse_more_than_one_note (sys.name))
				end
			end
		end

	note_level: INTEGER
			-- Level of elements under note
		do
			Result := current_element_under_note.count
		end

	tag_from_state_transitions (a_tag: INTEGER; a_local_part: READABLE_STRING_GENERAL): INTEGER
			-- Get number presentation from current tag state transitions.
		require
			a_tag_greater_than_zero: a_tag >= 0
			a_local_part_not_void: a_local_part /= Void
		local
			l_tag: INTEGER
			l_tags_undef: like tags_undefined
		do
			if note_level = 0 then
				if attached state_transitions_tag.item (a_tag) as l_trans then
					Result := l_trans.item (a_local_part)
				end
			else
					-- In note, we allow anything.
					-- Record the tag in `tags_undefined' if not found.
				l_tags_undef := tags_undefined
				if l_tags_undef /= Void then
					l_tag := l_tags_undef.item (a_local_part.to_string_32)
				else
					create l_tags_undef.make (2)
					tags_undefined := l_tags_undef
				end
				if l_tag = 0 then
					l_tag := new_undefined_tag_number
					l_tags_undef.force (l_tag, a_local_part.to_string_32)
				end
				Result := l_tag
			end
		end

	new_undefined_tag_number: like last_undefined_tag_number
			-- Return a new number for undefined tags.
		do
			Result := last_undefined_tag_number + 1
			last_undefined_tag_number := Result
		end

	current_attributes_undefined: STRING_TABLE [STRING_32]
			-- The values of the current attributes.
			-- Undefined attributes.

	current_element_under_note: LINKED_STACK [CONF_NOTE_ELEMENT]
			-- The stack of elements under note element.

	last_undefined_tag_number: INTEGER
			-- Last number of undefined tag.

	tags_undefined: detachable HASH_TABLE [INTEGER, STRING_32]
			-- Allowed undefined tags found dynamically

feature {NONE} -- Implementation

	lt_gt_escaped_string (s: READABLE_STRING_32): STRING_32
		do
			create Result.make (s.count)
			Result.append (s)
			lt_gt_escape_string (Result)
		end

	lt_gt_escape_string (s: STRING_32)
		require
			s_attached: s /= Void
		do
			s.replace_substring_all (lt_entity, lt_string)
			s.replace_substring_all (gt_entity, gt_string)
		end

feature {NONE} -- Implementation state transitions

	state_transitions_tag: HASH_TABLE [STRING_TABLE [INTEGER], INTEGER]
			-- Mapping of possible tag state transitions from `current_tag' with the tag name to the new state.
		local
			l_trans: like state_transitions_tag.item
		once
			create Result.make (14)

				-- => system and location
			create l_trans.make (2)
			l_trans.force (t_system, "system")
			l_trans.force (t_redirection, "redirection")
			Result.force (l_trans, t_none)

				-- system
				-- => description
				-- => target
			create l_trans.make (2)
			l_trans.force (t_description, "description")
			l_trans.force (t_target, "target")
			Result.force (l_trans, t_system)

				-- target
				-- => note
				-- => description
				-- => root
				-- => version
				-- => file_rule
				-- => setting
				-- => option
				-- => mapping
				-- => external_include
				-- => external_cflag
				-- => external_object
				-- => external_library
				-- => external_rssource
				-- => external_linker_flag
				-- => external_make
				-- => pre_compile_action
				-- => post_compile_action
				-- => variable
				-- => precompile
				-- => library
				-- => assembly
				-- => cluster
				-- => override
			create l_trans.make (22)
			l_trans.force (t_note, "note")
			l_trans.force (t_description, "description")
			l_trans.force (t_root, "root")
			l_trans.force (t_version, "version")
			l_trans.force (t_file_rule, "file_rule")
			l_trans.force (t_setting, "setting")
			l_trans.force (t_option, "option")
			l_trans.force (t_mapping, "mapping")
			l_trans.force (t_external_include, "external_include")
			l_trans.force (t_external_cflag, "external_cflag")
			l_trans.force (t_external_object, "external_object")
			l_trans.force (t_external_library, "external_library")
			l_trans.force (t_external_resource, "external_resource")
			l_trans.force (t_external_linker_flag, "external_linker_flag")
			l_trans.force (t_external_make, "external_make")
			l_trans.force (t_pre_compile_action, "pre_compile_action")
			l_trans.force (t_post_compile_action, "post_compile_action")
			l_trans.force (t_variable, "variable")
			l_trans.force (t_precompile, "precompile")
			l_trans.force (t_library, "library")
			l_trans.force (t_assembly, "assembly")
			l_trans.force (t_cluster, "cluster")
			l_trans.force (t_test_cluster, "tests")
			l_trans.force (t_override, "override")
			Result.force (l_trans, t_target)

				-- file_rule
				-- => description
				-- => exclude
				-- => include
				-- => condition
			create l_trans.make (4)
			l_trans.force (t_description, "description")
			l_trans.force (t_exclude, "exclude")
			l_trans.force (t_include, "include")
			l_trans.force (t_condition, "condition")
			Result.force (l_trans, t_file_rule)

				-- option/class_option
				-- => description
				-- => debug
				-- => assertions
				-- => warning
			create l_trans.make (4)
			l_trans.force (t_description, "description")
			l_trans.force (t_debug, "debug")
			l_trans.force (t_assertions, "assertions")
			l_trans.force (t_warning, "warning")
			Result.force (l_trans, t_option)
			Result.force (l_trans, t_class_option)

				-- (pre|post)_compile_action
				-- => description
				-- => condition
			create l_trans.make (2)
			l_trans.force (t_description, "description")
			l_trans.force (t_condition, "condition")
			Result.force (l_trans, t_pre_compile_action)
			Result.force (l_trans, t_post_compile_action)

				-- external_(include|cflag|object|library|resource|linker_flag|make)
				-- => description
				-- => condition
			create l_trans.make (2)
			l_trans.force (t_description, "description")
			l_trans.force (t_condition, "condition")
			Result.force (l_trans, t_external_include)
			Result.force (l_trans, t_external_cflag)
			Result.force (l_trans, t_external_object)
			Result.force (l_trans, t_external_library)
			Result.force (l_trans, t_external_resource)
			Result.force (l_trans, t_external_linker_flag)
			Result.force (l_trans, t_external_make)

				-- assembly
				-- => note
				-- => description
				-- => option
				-- => renaming
				-- => class_option
				-- => condition
			create l_trans.make (5)
			l_trans.force (t_description, "description")
			l_trans.force (t_option, "option")
			l_trans.force (t_renaming, "renaming")
			l_trans.force (t_class_option, "class_option")
			l_trans.force (t_condition, "condition")
			Result.force (l_trans, t_assembly)

				-- library/precompile
				-- -everything from assembly
				-- => visible
			l_trans.force (t_visible, "visible")
			Result.force (l_trans, t_library)
			Result.force (l_trans, t_precompile)

				-- tests
				-- -everything from library/precompile except renaming
				-- => file_rule
				-- => mapping
				-- => uses
			l_trans := l_trans.twin
			l_trans.remove ("renaming")
			l_trans.force (t_note, "note")
			l_trans.force (t_file_rule, "file_rule")
			l_trans.force (t_mapping, "mapping")
			l_trans.force (t_uses, "uses")
			l_trans.force (t_test_cluster, "tests")
			Result.force (l_trans, t_test_cluster)

				-- cluster
				-- -everything from test cluster
				-- => cluster
			l_trans := l_trans.twin
			l_trans.force (t_cluster, "cluster")
			Result.force (l_trans, t_cluster)

				-- override
				-- -everything from cluster
				-- => overrides
			l_trans := l_trans.twin
			l_trans.remove ("cluster")
			l_trans.force (t_override, "override")
			l_trans.force (t_overrides, "overrides")
			Result.force (l_trans, t_override)

				-- condition
				-- => platform
				-- => build
				-- => multithreaded
				-- => concurrency
				-- => dotnet
				-- => dynamic_runtime
				-- => version
				-- => custom
			create l_trans.make (8)
			l_trans.force (t_platform, "platform")
			l_trans.force (t_build, "build")
			l_trans.force (t_multithreaded, "multithreaded")
			l_trans.force (t_concurrency, "concurrency")
			l_trans.force (t_dotnet, "dotnet")
			l_trans.force (t_dynamic_runtime, "dynamic_runtime")
			l_trans.force (t_version_condition, "version")
			l_trans.force (t_custom, "custom")
			Result.force (l_trans, t_condition)
		ensure
			Result_not_void: Result /= Void
		end

	tag_attributes: HASH_TABLE [STRING_TABLE [INTEGER], INTEGER]
			-- Mapping of possible attributes of tags.
		local
			l_attr: like tag_attributes.item
		once
			create Result.make (25)

				-- redirection
				-- * uuid
				-- * location

			create l_attr.make (2)
			l_attr.force (at_uuid, "uuid")
			l_attr.force (at_location, "location")
			Result.force (l_attr, t_redirection)


				-- system
				-- * name
				-- * uuid
				-- * readonly
				-- * library_target

			create l_attr.make (4)
			l_attr.force (at_name, "name")
			l_attr.force (at_uuid, "uuid")
			l_attr.force (at_readonly, "readonly")
			l_attr.force (at_library_target, "library_target")
			Result.force (l_attr, t_system)

				-- target
				-- * name
				-- * eifgen
				-- * extends
			create l_attr.make (4)
			l_attr.force (at_name, "name")
			l_attr.force (at_eifgen, "eifgen")
			l_attr.force (at_extends, "extends")
			l_attr.force (at_abstract, "abstract")
			Result.force (l_attr, t_target)

				-- note
			create l_attr.make (0)
			Result.force (l_attr, t_note)

				-- root
				-- * cluster
				-- * class
				-- * feature
				-- * all_classes
			create l_attr.make (4)
			l_attr.force (at_cluster, "cluster")
			l_attr.force (at_class, "class")
			l_attr.force (at_feature, "feature")
			l_attr.force (at_all_classes, "all_classes")
			Result.force (l_attr, t_root)

				-- version
				-- * major
				-- * minor
				-- * release
				-- * build
				-- * product
				-- * company
				-- * copyright
				-- * trademark
			create l_attr.make (8)
			l_attr.force (at_major, "major")
			l_attr.force (at_minor, "minor")
			l_attr.force (at_release, "release")
			l_attr.force (at_build, "build")
			l_attr.force (at_product, "product")
			l_attr.force (at_company, "company")
			l_attr.force (at_copyright, "copyright")
			l_attr.force (at_trademark, "trademark")
			Result.force (l_attr, t_version)

				-- setting
				-- * name
				-- * value
			create l_attr.make (2)
			l_attr.force (at_name, "name")
			l_attr.force (at_value, "value")
			Result.force (l_attr, t_setting)

				-- option
				-- * trace
				-- * profile
				-- * optimize
				-- * debug
				-- * warning
				-- * namespace
				-- * full_class_checking
				-- * cat_call_detection
				-- * is_attached_by_default
				-- * is_void_safe
			create l_attr.make (11)
			l_attr.force (at_trace, "trace")
			l_attr.force (at_profile, "profile")
			l_attr.force (at_optimize, "optimize")
			l_attr.force (at_debug, "debug")
			l_attr.force (at_warning, "warning")
			l_attr.force (at_msil_application_optimize, "msil_application_optimize")
			l_attr.force (at_namespace, "namespace")
			l_attr.force (at_full_class_checking, "full_class_checking")
			l_attr.force (at_cat_call_detection, "cat_call_detection")
			l_attr.force (at_is_attached_by_default, "is_attached_by_default")
			l_attr.force (at_is_void_safe, "is_void_safe")
			l_attr.force (at_void_safety, "void_safety")
			l_attr.force (at_syntax_level, "syntax_level")
			l_attr.force (at_syntax, "syntax")
			Result.force (l_attr, t_option)

				-- class_option
				-- -everything from option
				-- *class
			l_attr := l_attr.twin
			l_attr.force (at_class, "class")
			Result.force (l_attr, t_class_option)

				-- external_(include|object|library|resource|make)
				-- * location
			create l_attr.make (1)
			l_attr.force (at_location, "location")
			Result.force (l_attr, t_external_include)
			Result.force (l_attr, t_external_object)
			Result.force (l_attr, t_external_library)
			Result.force (l_attr, t_external_resource)
			Result.force (l_attr, t_external_make)

				-- (pre|post)_compile_action
				-- * command
				-- * working_directory
				-- * succeed
			create l_attr.make (2)
			l_attr.force (at_command, "command")
			l_attr.force (at_working_directory, "working_directory")
			l_attr.force (at_succeed, "succeed")
			Result.force (l_attr, t_pre_compile_action)
			Result.force (l_attr, t_post_compile_action)

				-- variable
				-- * name
				-- * value
			create l_attr.make (2)
			l_attr.force (at_name, "name")
			l_attr.force (at_value, "value")
			Result.force (l_attr, t_variable)

				-- library
				-- * name
				-- * location
				-- * readonly
				-- * prefix
				-- * use_application_options
			create l_attr.make (4)
			l_attr.force (at_name, "name")
			l_attr.force (at_location, "location")
			l_attr.force (at_readonly, "readonly")
			l_attr.force (at_prefix, "prefix")
			l_attr.force (at_use_application_options, "use_application_options")
			Result.force (l_attr, t_library)

				-- precompile
				-- -everything from library
				-- * eifgens_location
			create l_attr.make (5)
			l_attr.force (at_name, "name")
			l_attr.force (at_location, "location")
			l_attr.force (at_readonly, "readonly")
			l_attr.force (at_prefix, "prefix")
			l_attr.force (at_eifgens_location, "eifgens_location")
			Result.force (l_attr, t_precompile)

				-- assembly
				-- -everything from library
				-- * assembly_name
				-- * assembly_version
				-- * assembly_culture
				-- * assembly_key
			l_attr := l_attr.twin
			l_attr.force (at_assembly_name, "assembly_name")
			l_attr.force (at_assembly_version, "assembly_version")
			l_attr.force (at_assembly_culture, "assembly_culture")
			l_attr.force (at_assembly_key, "assembly_key")
			Result.force (l_attr, t_assembly)

				-- cluster/tests/override
				-- -everything from library except prefix, use_application_options
				-- * recursive
				-- * hidden
			create l_attr.make (6)
			l_attr.force (at_name, "name")
			l_attr.force (at_location, "location")
			l_attr.force (at_readonly, "readonly")
			l_attr.force (at_recursive, "recursive")
			l_attr.force (at_hidden, "hidden")
			Result.force (l_attr, t_cluster)
			Result.force (l_attr, t_test_cluster)
			Result.force (l_attr, t_override)

				-- debug/warning
				-- * name
				-- * enabled
			create l_attr.make (2)
			l_attr.force (at_name, "name")
			l_attr.force (at_enabled, at_enabled_string)
			Result.force (l_attr, t_debug)
			Result.force (l_attr, t_warning)

				-- assertions
				-- * precondition
				-- * postcondition
				-- * check
				-- * invariant
				-- * loop
				-- * supplier preconditions
			create l_attr.make (6)
			l_attr.force (at_precondition, "precondition")
			l_attr.force (at_postcondition, "postcondition")
			l_attr.force (at_check, "check")
			l_attr.force (at_invariant, "invariant")
			l_attr.force (at_loop, "loop")
			l_attr.force (at_supplier_precondition, "supplier_precondition")
			Result.force (l_attr, t_assertions)

				-- build, platform
				-- * value
				-- * excluded_value
			create l_attr.make (2)
			l_attr.force (at_value, "value")
			l_attr.force (at_excluded_value, "excluded_value")
			Result.force (l_attr, t_platform)
			Result.force (l_attr, t_build)

				-- dotnet, dynamic_runtime, external_(c|linker_)flag, multithreaded
				-- * value
			create l_attr.make (1)
			l_attr.force (at_value, "value")
			Result.force (l_attr, t_dotnet)
			Result.force (l_attr, t_dynamic_runtime)
			Result.force (l_attr, t_external_cflag)
			Result.force (l_attr, t_external_linker_flag)
			Result.force (l_attr, t_multithreaded)

				-- concurrency
				-- * value
				-- * excluded_value
			create l_attr.make (2)
			l_attr.force (at_value, "value")
			l_attr.force (at_excluded_value, "excluded_value")
			Result.force (l_attr, t_concurrency)

				-- version
			create l_attr.make (3)
			l_attr.force (at_min, "min")
			l_attr.force (at_max, "max")
			l_attr.force (at_type, "type")
			Result.force (l_attr, t_version_condition)

				-- custom
				-- * name
				-- * value
				-- * excluded_value
			create l_attr.make (3)
			l_attr.force (at_value, "value")
			l_attr.force (at_excluded_value, "excluded_value")
			l_attr.force (at_name, "name")
			Result.force (l_attr, t_custom)

				-- uses/overrides
				-- * group
			create l_attr.make (1)
			l_attr.force (at_group, "group")
			Result.force (l_attr, t_uses)
			Result.force (l_attr, t_overrides)

				-- visible
				-- * class
				-- * feature
				-- * class_rename
				-- * feature_rename
			create l_attr.make (4)
			l_attr.force (at_class, "class")
			l_attr.force (at_feature, "feature")
			l_attr.force (at_class_rename, "class_rename")
			l_attr.force (at_feature_rename, "feature_rename")
			Result.force (l_attr, t_visible)

				-- mapping, renaming
				-- * old_name
				-- * new_name
			create l_attr.make (2)
			l_attr.force (at_old_name, "old_name")
			l_attr.force (at_new_name, "new_name")
			Result.force (l_attr, t_mapping)
			Result.force (l_attr, t_renaming)
		end

	tag_with_undefined_attributes: SEARCH_TABLE [INTEGER]
			-- Tags may contain undefined attributes.
		once
			create Result.make (1)
			Result.force (t_note)
		end

	report_unknown_attribute (name: READABLE_STRING_GENERAL)
			-- Report that attributes `name' is unknown for the current element.
		require
			name_attached: name /= Void
		do
			set_parse_error_message (conf_interface_names.e_parse_invalid_attribute (name))
		end

feature {NONE} -- Default options

	default_options_14_05: CONF_OPTION
			-- Default options of 14.05.
		once
			create Result.make_14_05
		ensure
			result_attached: Result /= Void
		end

	default_options_7_3: CONF_OPTION
			-- Default options of 7.3.
		once
			create Result.make_7_3
		ensure
			result_attached: Result /= Void
		end

	default_options_7_0: CONF_OPTION
			-- Default options of 7.0.
		once
			create Result.make_7_0
		ensure
			result_attached: Result /= Void
		end

	default_options_6_4: CONF_OPTION
			-- Default options of 6.4.
		once
			create Result.make_6_4
		ensure
			result_attached: Result /= Void
		end

	default_options_6_3: CONF_OPTION
			-- Default options of 6.3.
		once
			create Result.make_6_3
		ensure
			result_attached: Result /= Void
		end

feature -- Assertions

	has_resolved_namespaces: BOOLEAN = True

invariant
	current_tag_not_void: current_tag /= Void
	current_attributes_not_void: current_attributes /= Void
	current_content_not_void: current_content /= Void
	group_list_not_void: group_list /= Void
	uses_list_not_void: uses_list /= Void
	overrides_list_not_void: overrides_list /= Void
	factory_not_void: factory /= Void

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
