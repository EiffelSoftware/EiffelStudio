indexing
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

create
	make_with_factory

feature {NONE} -- Initialization

	make_with_factory (a_factory: like factory) is
			-- Create.
		do
			make
			create current_tag.make
			create current_attributes.make (0)
			create group_list.make (0)
			create uses_list.make (0)
			create overrides_list.make (0)
			create current_content.make_empty
			factory := a_factory
		ensure
			factory_set: factory = a_factory
		end

feature -- Access

	last_system: CONF_SYSTEM
			-- The last parsed system.

feature -- Callbacks

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Start of start tag.
		local
			l_trans: HASH_TABLE [INTEGER, STRING]
			l_tag: INTEGER
		do
			if not is_error then
				a_local_part.to_lower

					-- check version
				check_version (a_namespace)

					-- check if it is a valid tag state transition
				if current_tag.is_empty then
					current_tag.extend (t_none)
				end
				l_trans := state_transitions_tag.item (current_tag.item)
				if l_trans /= Void then
					l_tag := l_trans.item (a_local_part)
				end

				if l_tag = 0 then
					if is_unknown_version then
							-- unknown version, just add a warning
						set_parse_warning_message (conf_interface_names.e_parse_invalid_tag (a_local_part))
					else
							-- known version, this is an error
						set_parse_error_message (conf_interface_names.e_parse_invalid_tag (a_local_part))
					end
				else
					current_tag.extend (l_tag)
				end
			end
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING) is
			-- Start of attribute.
		local
			l_attr: HASH_TABLE [INTEGER, STRING]
			l_attribute: INTEGER
		do
			if not is_error then
				if
					not a_local_part.is_case_insensitive_equal ("xmlns") and not
					a_local_part.is_case_insensitive_equal ("xsi") and not
					a_local_part.is_case_insensitive_equal ("schemaLocation")
				then
					a_local_part.to_lower
						-- check if the attribute is valid for the current state
					l_attr := tag_attributes.item (current_tag.item)
					if l_attr /= Void then
						l_attribute := l_attr.item (a_local_part)
					end
					if current_attributes = Void then
						create current_attributes.make (1)
					end
					if current_attributes_undefined = Void then
						create current_attributes_undefined.make (1)
					end
					if l_attribute /= 0 and then not current_attributes.has (l_attribute) then
							-- Check and put defined attributes in `current_attributes'.
						if not a_value.is_empty then
							a_value.replace_substring_all (lt_entity, lt_string)
							a_value.replace_substring_all (gt_entity, gt_string)
							current_attributes.force (a_value, l_attribute)
						else
							set_parse_error_message (conf_interface_names.e_parse_invalid_value (a_local_part))
						end
					elseif tag_with_undefined_attributes.has (current_tag.item) and then not current_attributes_undefined.has (a_local_part) then
							-- Put undefined attributes in `current_attributes_undefined'.
						a_value.replace_substring_all (lt_entity, lt_string)
						a_value.replace_substring_all (gt_entity, gt_string)
						current_attributes_undefined.force (a_value, a_local_part)
					else
						if is_unknown_version then
								-- unknown version, just add a warning
							set_parse_warning_message (conf_interface_names.e_parse_invalid_attribute (a_local_part))
						else
								-- known version, this is an error
							set_parse_error_message (conf_interface_names.e_parse_invalid_attribute (a_local_part))
						end
					end
				end
			end
		end

	on_start_tag_finish is
			-- End of start tag.
		do
			if not is_error then
				inspect
					current_tag.item
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
				when t_external_include then
					process_external_attributes
				when t_external_object then
					process_external_attributes
				when t_external_library then
					process_external_attributes
				when t_external_resource then
					process_external_attributes
				when t_external_make then
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
				when t_debug then
					process_debug_attributes
				when t_assertions then
					process_assertions_attributes
				when t_warning then
					process_warning_attributes
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
					process_platform_attributes
				when t_build then
					process_build_attributes
				when t_multithreaded then
					process_multithreaded_attributes
				when t_dotnet then
					process_dotnet_attributes
				when t_dynamic_runtime then
					process_dynamic_runtime_attributes
				when t_version_condition then
					process_version_condition_attributes
				when t_custom then
					process_custom_attributes
				when t_mapping then
					process_mapping_attributes
				when t_note then
					process_note_attributes
				else
				end
				current_attributes.clear_all
				current_attributes_undefined.clear_all
			end
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- End tag.
		local
			l_group: CONF_GROUP
			l_error: CONF_ERROR_GRUNDEF
			l_e_ov: CONF_ERROR_OVERRIDE
		do
			if not is_error then
				current_content.left_adjust
				current_content.right_adjust
				if not current_content.is_empty then
					current_content.replace_substring_all (lt_entity, lt_string)
					current_content.replace_substring_all (gt_entity, gt_string)

					inspect
						current_tag.item
					when t_description then
						process_description_content
					when t_exclude then
						process_exclude_content
					when t_include then
						process_include_content
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_content (current_content))
					end
					create current_content.make_empty
				end

				inspect
					current_tag.item
				when t_system then
					if current_library_target /= Void then
						set_error (create {CONF_ERROR_LIBTAR})
					end
				when t_target then
						-- check for overrides and precompiles in a library_target
					if current_target = last_system.library_target then
						if not current_target.overrides.is_empty then
							set_error (create {CONF_ERROR_LIBOVER})
						end
					end
						-- handle uses and overrides
					if uses_list /= Void then
						from
							uses_list.start
						until
							uses_list.after
						loop
							l_group := group_list.item (uses_list.key_for_iteration)
							if l_group = Void then
								create l_error
								l_error.set_group (uses_list.key_for_iteration)
								set_error (l_error)
							else
								uses_list.item_for_iteration.do_all (agent {CONF_CLUSTER}.add_dependency (l_group))
							end
							uses_list.forth
						end
					end
					if overrides_list /= Void then
						from
							overrides_list.start
						until
							overrides_list.after
						loop
							l_group := group_list.item (overrides_list.key_for_iteration)
							if l_group = Void then
								create l_error
								l_error.set_group (overrides_list.key_for_iteration)
								set_error (l_error)
							elseif l_group.is_override then
								create l_e_ov
								l_e_ov.set_group (l_group.name)
								set_error (l_e_ov)
							else
								overrides_list.item_for_iteration.do_all (agent {CONF_OVERRIDE}.add_override (l_group))
							end
							overrides_list.forth
						end
					end
					uses_list.clear_all
					overrides_list.clear_all
					group_list.clear_all
					current_target := Void
				when t_file_rule then
					current_file_rule := Void
				when t_option then
					current_option := Void
				when t_external_include then
					current_external := Void
				when t_external_object then
					current_external := Void
				when t_external_library then
					current_external := Void
				when t_external_resource then
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
					current_group := current_cluster.parent
					current_cluster := current_cluster.parent
				when t_test_cluster then
					current_group := current_cluster.parent
					current_cluster := current_cluster.parent
				when t_override then
					current_group := current_cluster.parent
					current_cluster := current_cluster.parent
					current_override := Void
				when t_class_option then
					current_option := Void
				else
				end
				current_tag.remove
			end
		end

	on_content (a_content: STRING) is
			-- Text content.
		do
			if not is_error then
				current_content.append (a_content)
			end
		end

feature {NONE} -- Implementation attribute processing

	process_system_attributes is
			-- Process attributes of a system tag.
		local
			l_name, l_uuid, l_readonly: STRING
			l_uu: UUID
		do
			l_name := current_attributes.item (at_name)
			l_uuid := current_attributes.item (at_uuid)
			l_readonly := current_attributes.item (at_readonly)
			current_library_target := current_attributes.item (at_library_target)
			if current_library_target /= Void then
				current_library_target.to_lower
			end
			if is_valid_system_name (l_name) and then (l_uuid = Void or else check_uuid (l_uuid)) then
				if l_uuid /= Void then
					create l_uu.make_from_string (l_uuid)
				else
					l_uu := factory.uuid_generator.generate_uuid
				end
				last_system := factory.new_system (l_name.as_lower, l_uu)
				if l_readonly /= Void then
					if l_readonly.is_boolean then
						last_system.set_readonly (l_readonly.to_boolean)
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("readonly"))
					end
				end
			elseif l_name = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_system_no_name)
			elseif not is_valid_system_name (l_name) then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_system_name (l_name))
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_system_invalid_uuid (l_name))
			end
		ensure
			last_system_not_void: not is_error implies last_system /= Void
		end

	process_target_attributes is
			-- Process attributes of a target tag.
		require
			last_system_not_void: last_system /= Void
		local
			l_target: CONF_TARGET
			l_name, l_eifgen, l_extends, l_abstract: STRING
		do
			l_name := current_attributes.item (at_name)
			l_eifgen := current_attributes.item (at_eifgen)
			l_extends := current_attributes.item (at_extends)
			l_abstract := current_attributes.item (at_abstract)
			if l_name /= Void then
				l_name.to_lower
				if not is_valid_target_name (l_name) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_target_invalid_name (l_name))
				end
				if last_system.targets.has (l_name) then
					set_parse_error_message (conf_interface_names.e_parse_multiple_target_with_name (l_name))
				end
				current_target := factory.new_target (l_name, last_system)
				if l_abstract /= Void then
					if l_abstract.is_boolean then
						current_target.set_abstract (l_abstract.to_boolean)
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("abstract"))
					end
				end
				if current_library_target /= Void and then l_name.is_equal (current_library_target) then
					last_system.set_library_target (current_target)
					current_library_target := Void
				end
				last_system.add_target (current_target)
				if l_extends /= Void then
						-- Target are known internally in lower case,
						-- so we should respect this (see bug#12698).
					l_extends := l_extends.as_lower
					l_target := last_system.targets.item (l_extends)
					if l_target /= Void and then l_target /= current_target then
						current_target.set_parent (l_target)
						group_list := l_target.groups
					else
						set_parse_error_message (conf_interface_names.e_parse_incorrect_target_parent (l_extends, l_name))
					end
				end
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_target_no_name)
			end
		ensure
			target_not_void: not is_error implies current_target /= Void
		end

	process_root_attributes is
			-- Process attributes of a root tag.
		require
			current_target_not_void: current_target /= Void
		local
			l_all, l_cluster, l_class, l_feature: STRING
			l_all_b: BOOLEAN
		do
			l_all := current_attributes.item (at_all_classes)
			if l_all /= Void then
				if l_all.is_boolean then
					l_all_b := l_all.to_boolean
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_root_all)
				end
			end
			l_cluster := current_attributes.item (at_cluster)
			if l_cluster /= Void then
				l_cluster.to_lower
				if not is_valid_group_name (l_cluster) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_root_cluster)
				end
			end
			l_class := current_attributes.item (at_class)
			if l_class /= Void then
				l_class.to_upper
				if not is_valid_class_type_name (l_class) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_root_class)
				end
			end
			l_feature := current_attributes.item (at_feature)
			if l_feature /= Void then
				l_feature.to_lower
				if not is_valid_feature_name (l_feature) then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_root_feature)
				end
			end
			if (l_all_b and l_cluster = Void and l_class = Void and l_feature = Void) or else l_class /= Void then
				current_target.set_root (factory.new_root (l_cluster, l_class, l_feature, l_all_b))
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_root)
			end
	end

	process_version_attributes is
			-- Process attributes of a version tag.
		require
			current_target_not_void: current_target /= Void
		local
			l_major, l_minor, l_release, l_build: STRING
			l_i_major, l_i_minor, l_i_release, l_i_build: NATURAL_16
			l_product, l_company, l_copyright, l_trademark: STRING
			l_version: CONF_VERSION
		do
			l_major := current_attributes.item (at_major)
			l_minor := current_attributes.item (at_minor)
			l_release := current_attributes.item (at_release)
			l_build := current_attributes.item (at_build)
			l_product := current_attributes.item (at_product)
			l_company := current_attributes.item (at_company)
			l_copyright := current_attributes.item (at_copyright)
			l_trademark := current_attributes.item (at_trademark)
			if l_major /= Void and then l_major.is_natural_16 then
				l_i_major := l_major.to_natural_16
			end
			if l_minor /= Void and then l_minor.is_natural_16 then
				l_i_minor := l_minor.to_natural_16
			end
			if l_release /= Void and then l_release.is_natural_16 then
				l_i_release := l_release.to_natural_16
			end
			if l_build /= Void and then l_build.is_natural_16 then
				l_i_build := l_build.to_natural_16
			end
			l_version := factory.new_version (l_i_major, l_i_minor, l_i_release, l_i_build)
			if l_product /= Void then
				l_version.set_product (l_product)
			end
			if l_company /= Void then
				l_version.set_company (l_company)
			end
			if l_copyright /= Void then
				l_version.set_copyright (l_copyright)
			end
			if l_trademark /= Void then
				l_version.set_trademark (l_trademark)
			end
			current_target.set_version (l_version)
		end

	process_setting_attributes is
			-- Process attributes of a setting tag.
		require
			current_target_not_void: current_target /= Void
		local
			l_name, l_value: STRING
		do
			l_name := current_attributes.item (at_name)
			if l_name /= Void then
				l_name.to_lower
			end
			l_value := current_attributes.item (at_value)
			if l_name /= Void and l_value /= Void then
				if valid_setting (l_name) then
					current_target.add_setting (l_name, l_value)
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_setting (l_name))
				end
			elseif l_name = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_setting_no_name)
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_setting_value (l_name))
			end
		end

	process_file_rule_attributes is
			-- Process attributes of a file_rule tag.
		require
			target_or_cluster: current_target /= Void or current_cluster /= Void
		do
			current_file_rule := factory.new_file_rule
			if current_cluster /= Void then
				current_cluster.add_file_rule (current_file_rule)
			elseif current_target /= Void then
				current_target.add_file_rule (current_file_rule)
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_file_rule)
			end
		ensure
			current_file_rule_not_void: current_file_rule /= Void
		end

	process_external_attributes is
			-- Process attributes of external_(include|object|resource) tags.
		require
			current_target_not_void: current_target /= Void
		local
			l_location: STRING
			l_inc: CONF_EXTERNAL_INCLUDE
			l_obj: CONF_EXTERNAL_OBJECT
			l_lib: CONF_EXTERNAL_LIBRARY
			l_res: CONF_EXTERNAL_RESOURCE
			l_make: CONF_EXTERNAL_MAKE
		do
			l_location := current_attributes.item (at_location)
			if l_location /= Void then
				inspect
					current_tag.item
				when t_external_include then
					l_inc := factory.new_external_include (l_location, current_target)
					current_target.add_external_include (l_inc)
					current_external := l_inc
				when t_external_object then
					l_obj := factory.new_external_object (l_location, current_target)
					current_target.add_external_object (l_obj)
					current_external := l_obj
				when t_external_library then
					l_lib := factory.new_external_library (l_location, current_target)
					current_target.add_external_library (l_lib)
					current_external := l_lib
				when t_external_resource then
					l_res := factory.new_external_resource (l_location, current_target)
					current_target.add_external_resource (l_res)
					current_external := l_res
				when t_external_make then
					l_make := factory.new_external_make (l_location, current_target)
					current_target.add_external_make (l_make)
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

	process_action_attributes is
			-- Process attributes of (pre|post)_compile_action tags.
		require
			current_target_not_void: current_target /= Void
		local
			l_command, l_succeed, l_wd: STRING
		do
			l_command := current_attributes.item (at_command)
			l_succeed := current_attributes.item (at_succeed)
			l_wd := current_attributes.item (at_working_directory)
			if l_succeed = Void then
				l_succeed := "false"
			end
			if l_command /= Void then
				if l_succeed.is_boolean then
					if l_wd = Void then
						current_action :=  factory.new_action (l_command, l_succeed.to_boolean, Void)
					else
						current_action :=  factory.new_action (l_command, l_succeed.to_boolean, factory.new_location_from_path (l_wd, current_target))
					end

					inspect
						current_tag.item
					when t_pre_compile_action then
						current_target.add_pre_compile (current_action)
					when t_post_compile_action then
						current_target.add_post_compile (current_action)
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

	process_variable_attributes is
			-- Process attributes of a variable tag.
		require
			current_target_not_void: current_target /= Void
		local
			l_name, l_value: STRING
		do
			l_name := current_attributes.item (at_name)
			l_value := current_attributes.item (at_value)
			if l_value = Void then
				l_value := ""
			end
			if l_name /= Void then
				current_target.add_variable (l_name, l_value)
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_variable_no_name)
			end
		end

	process_library_attributes is
			-- Process attributes of a library tag.
		require
			current_target_not_void: current_target /= Void
		local
			l_name, l_location, l_readonly, l_prefix, l_app_opts: STRING
		do
			l_name := current_attributes.item (at_name)
			l_location := current_attributes.item (at_location)
			l_readonly := current_attributes.item (at_readonly)
			l_prefix := current_attributes.item (at_prefix)
			l_app_opts := current_attributes.item (at_use_application_options)
			if l_name /= Void then
				l_name.to_lower
			end
			if is_valid_group_name (l_name) and l_location /= Void and not group_list.has (l_name) then
				current_library := factory.new_library (l_name, factory.new_location_from_full_path (l_location, current_target), current_target)
				current_group := current_library
				if l_readonly /= Void then
					if l_readonly.is_boolean then
						current_library.set_readonly (l_readonly.to_boolean)
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("readonly"))
					end
				end
				if l_app_opts /= Void then
					if l_app_opts.is_boolean then
						current_library.set_use_application_options (l_app_opts.to_boolean)
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("use_application_options"))
					end
				end
				if l_prefix /= Void then
					current_library.set_name_prefix (l_prefix)
				end
				group_list.force (current_group, l_name)
				current_target.add_library (current_library)
			elseif l_name = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_library_no_name)
			elseif not is_valid_group_name (l_name) then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_library_name (l_name))
			elseif group_list.has (l_name) then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_library_conflict (l_name))
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_library (l_name))
			end
		ensure
			library_and_group: not is_error implies current_library /= Void and current_group /= Void
		end

	process_precompile_attributes is
			-- Process attributes of a precompile tag.
		require
			current_target_not_void: current_target /= Void
		local
			l_name, l_location, l_readonly, l_prefix, l_target: STRING
			l_eifgen: STRING
			l_pre: CONF_PRECOMPILE
		do
			l_name := current_attributes.item (at_name)
			l_location := current_attributes.item (at_location)
			l_readonly := current_attributes.item (at_readonly)
			l_prefix := current_attributes.item (at_prefix)
			l_target := current_attributes.item (at_target)
			l_eifgen := current_attributes.item (at_eifgens_location)
			if l_name /= Void then
				l_name.to_lower
			end
			if is_valid_group_name (l_name) and l_location /= Void and not group_list.has (l_name) and current_target.precompile = Void then
				l_pre := factory.new_precompile (l_name, l_location, current_target)
				current_library := l_pre
				current_group := current_library
				if l_readonly /= Void then
					if l_readonly.is_boolean then
						current_library.set_readonly (l_readonly.to_boolean)
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("readonly"))
					end
				end
				if l_prefix /= Void then
					current_library.set_name_prefix (l_prefix)
				end
				if l_eifgen /= Void then
					l_pre.set_eifgens_location (factory.new_location_from_path (l_eifgen, current_target))
				end
				group_list.force (current_group, l_name)
				current_target.set_precompile (l_pre)
			elseif l_name = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_precompile_no_name)
			elseif not is_valid_group_name (l_name) then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_precompile_name (l_name))
			elseif group_list.has (l_name) then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_precompile_conflict (l_name))
			elseif current_target.precompile /= Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_precompile_multiple (l_name, current_target.precompile.name))
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_precompile (l_name))
			end
		ensure
			library_and_group: not is_error implies current_library /= Void and current_group /= Void
		end

	process_assembly_attributes is
			-- Process attributes of an assembly tag.
		require
			current_target_not_void: current_target /= Void
		local
			l_name, l_location, l_readonly, l_prefix: STRING
			l_assembly_name, l_assembly_version, l_assembly_culture, l_assembly_key: STRING
		do
			l_name := current_attributes.item (at_name)
			l_location := current_attributes.item (at_location)
			l_readonly := current_attributes.item (at_readonly)
			l_prefix := current_attributes.item (at_prefix)
			l_assembly_name := current_attributes.item (at_assembly_name)
			l_assembly_version := current_attributes.item (at_assembly_version)
			l_assembly_culture := current_attributes.item (at_assembly_culture)
			l_assembly_key := current_attributes.item (at_assembly_key)
			if l_name /= Void then
				l_name.to_lower
			end
			if is_valid_group_name (l_name) and l_location /= Void and not group_list.has (l_name) then
				if l_location.is_equal ("none") then
					if l_assembly_name /= Void and l_assembly_version /= Void and l_assembly_culture /= Void and l_assembly_key /= Void then
						current_assembly := factory.new_assembly_from_gac (l_name,l_assembly_name, l_assembly_version, l_assembly_culture, l_assembly_key, current_target )
					end
				else
					current_assembly := factory.new_assembly (l_name, l_location, current_target)
				end
				current_group := current_assembly
				if l_readonly /= Void then
					if l_readonly.is_boolean then
						current_assembly.set_readonly (l_readonly.to_boolean)
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("readonly"))
					end
				end
				if l_prefix /= Void then
					current_assembly.set_name_prefix (l_prefix)
				end
				group_list.force (current_group, l_name)
				current_target.add_assembly (current_assembly)
			elseif l_name = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_assembly_no_name)
			elseif not is_valid_group_name (l_name) then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_assembly_name (l_name))
			elseif l_location = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_assembly (l_name))
			elseif group_list.has (l_name) then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_assembly_conflict (l_name))
			else
				check should_not_reach: False end
			end
		ensure
			assembly_and_group: not is_error implies current_assembly /= Void and current_group /= Void
		end

	process_cluster_attributes (a_is_test_cluster: BOOLEAN) is
			-- Process attributes of a cluster tag.
			--
			-- `a_is_test_cluster': Defines whether new cluster is a test cluster or not.
		require
			target: current_target /= Void
		local
			l_name, l_location, l_readonly, l_recursive, l_hidden: STRING
			l_parent: CONF_CLUSTER
			l_loc: CONF_DIRECTORY_LOCATION
		do
			l_name := current_attributes.item (at_name)
			l_location := current_attributes.item (at_location)
			l_readonly := current_attributes.item (at_readonly)
			l_recursive := current_attributes.item (at_recursive)
			l_hidden := current_attributes.item (at_hidden)
			if l_name /= Void then
				l_name.to_lower
			end
			if is_valid_group_name (l_name) and l_location /= Void and not group_list.has (l_name) then
				l_parent := current_cluster
				l_loc := factory.new_location_from_path (l_location, current_target)
				if a_is_test_cluster then
					current_cluster := factory.new_test_cluster (l_name.as_lower, l_loc, current_target)
				else
					current_cluster := factory.new_cluster (l_name.as_lower, l_loc, current_target)
				end
				current_group := current_cluster
				if l_readonly /= Void then
					if l_readonly.is_boolean then
						current_cluster.set_readonly (l_readonly.to_boolean)
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("readonly"))
					end
				end
				if l_hidden /= Void then
					if l_hidden.is_boolean then
						current_cluster.set_hidden (l_hidden.to_boolean)
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("hidden"))
					end
				end
				if l_recursive /= Void then
					if l_recursive.is_boolean then
						current_cluster.set_recursive (l_recursive.to_boolean)
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("recursive"))
					end
				end
				if l_parent /= Void then
					l_parent.add_child (current_cluster)
					current_cluster.set_parent (l_parent)
					l_loc.set_parent (l_parent.location)
				end

				group_list.force (current_group, l_name)
				current_target.add_cluster (current_cluster)
			elseif l_name = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_cluster_no_name)
			elseif not is_valid_group_name (l_name) then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_cluster_name (l_name))
			elseif l_location /= Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_cluster_conflict (l_name))
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_cluster (l_name))
			end
		ensure
			cluster_and_group: not is_error implies current_cluster /= Void and current_group /= Void
		end

	process_override_attributes is
			-- Process attributes of an override tag.
		require
			target: current_target /= Void
		local
			l_name, l_location, l_readonly, l_prefix, l_recursive, l_hidden: STRING
			l_parent: CONF_CLUSTER
		do
			l_name := current_attributes.item (at_name)
			l_location := current_attributes.item (at_location)
			l_readonly := current_attributes.item (at_readonly)
			l_prefix := current_attributes.item (at_prefix)
			l_recursive := current_attributes.item (at_recursive)
			l_hidden := current_attributes.item (at_hidden)
			if l_name /= Void then
				l_name.to_lower
			end
			if is_valid_group_name (l_name) and l_location /= Void and not group_list.has (l_name) then
				l_parent := current_cluster
				current_override := factory.new_override (l_name, factory.new_location_from_path (l_location, current_target), current_target)
				current_cluster := current_override
				current_group := current_cluster
				if l_readonly /= Void then
					if l_readonly.is_boolean then
						current_cluster.set_readonly (l_readonly.to_boolean)
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("readonly"))
					end
				end
				if l_hidden /= Void then
					if l_hidden.is_boolean then
						current_cluster.set_hidden (l_hidden.to_boolean)
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("hidden"))
					end
				end
				if l_recursive /= Void then
					if l_recursive.is_boolean then
						current_cluster.set_recursive (l_recursive.to_boolean)
					else
						set_parse_error_message (conf_interface_names.e_parse_invalid_value ("recursive"))
					end
				end
				if l_parent /= Void then
					l_parent.add_child (current_cluster)
					current_cluster.set_parent (l_parent)
				end
				group_list.force (current_group, l_name)
				current_target.add_override (current_override)
			elseif l_name = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_override_no_name)
			elseif not is_valid_group_name (l_name) then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_override_name (l_name))
			elseif group_list.has (l_name) then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_override_conflict (l_name))
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_override (l_name))
			end
		ensure
			override_and_cluster_and_group: current_override /= Void and current_cluster /= Void and current_group /= Void
		end

	process_debug_attributes is
			-- Process attributes of a debug tag.
		require
			current_option_not_void: current_option /= Void
		local
			l_name, l_enabled: STRING
		do
			l_name := current_attributes.item (at_name)
			l_enabled := current_attributes.item (at_enabled)
			if l_name /= Void and l_enabled /= Void and then l_enabled.is_boolean then
				current_option.add_debug (l_name.as_lower, l_enabled.to_boolean)
			elseif l_name = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_debug_no_name)
			elseif l_enabled /= Void and then not l_enabled.is_boolean then
				set_parse_error_message (conf_interface_names.e_parse_invalid_value ("enabled"))
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_debug (l_name))
			end
		end

	process_warning_attributes is
			-- Process attributes of a warning tag.
		require
			current_option_not_void: current_option /= Void
		local
			l_name, l_enabled: STRING
		do
			l_name := current_attributes.item (at_name)
			l_enabled := current_attributes.item (at_enabled)
			if l_name /= Void and then l_enabled /= Void and then l_enabled.is_boolean then
				if valid_warning (l_name) then
					current_option.add_warning (l_name, l_enabled.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_warning (l_name))
				end
			elseif l_name = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_warning_no_name)
			elseif l_enabled /= Void and then not l_enabled.is_boolean then
				set_parse_error_message (conf_interface_names.e_parse_invalid_value ("enabled"))
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_warning (l_name))
			end
		end

	process_assertions_attributes is
			-- Process attributes of a assertions tag.
		require
			current_option_not_void: current_option /= Void
		local
			l_pre, l_post, l_chk, l_inv, l_loop, l_sup_pre: STRING
			l_assert: CONF_ASSERTIONS
		do
			l_pre := current_attributes.item (at_precondition)
			l_post := current_attributes.item (at_postcondition)
			l_chk := current_attributes.item (at_check)
			l_inv := current_attributes.item (at_invariant)
			l_loop := current_attributes.item (at_loop)
			l_sup_pre := current_attributes.item (at_supplier_precondition)
			l_assert := factory.new_assertions
			if l_pre /= Void then
				if l_pre.is_boolean then
					if l_pre.to_boolean then
						l_assert.enable_precondition
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("precondition"))
				end
			end
			if l_post /= Void then
				if l_post.is_boolean then
					if l_post.to_boolean then
						l_assert.enable_postcondition
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("postcondition"))
				end
			end
			if l_chk /= Void then
				if l_chk.is_boolean then
					if l_chk.to_boolean then
						l_assert.enable_check
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("check"))
				end
			end
			if l_inv /= Void then
				if l_inv.is_boolean then
					if l_inv.to_boolean then
						l_assert.enable_invariant
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("invariant"))
				end
			end
			if l_loop /= Void then
				if l_loop.is_boolean then
					if l_loop.to_boolean then
						l_assert.enable_loop
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("loop"))
				end
			end
			if l_sup_pre /= Void then
				if l_sup_pre.is_boolean then
					if l_sup_pre.to_boolean then
						l_assert.enable_supplier_precondition
					end
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("supplier_precondition"))
				end
			end
			current_option.set_assertions (l_assert)
		end

	process_renaming_attributes is
			-- Process attributes of a renaming tag.
		require
			group: current_group /= Void
		local
			l_old_name, l_new_name: STRING
			l_virtual_group: CONF_VIRTUAL_GROUP
		do
			l_virtual_group ?= current_group
			check
				virtual_group: l_virtual_group /= Void
			end
			l_old_name := current_attributes.item (at_old_name)
			l_new_name := current_attributes.item (at_new_name)
			if l_old_name /= Void and l_new_name /= Void then
				l_virtual_group.add_renaming (l_old_name.as_upper, l_new_name.as_upper)
			elseif l_old_name /= Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_renaming_no_new (l_old_name))
			elseif l_new_name /= Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_renaming_no_old (l_new_name))
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_renaming_no_name)
			end
		end

	process_option_attributes (a_class_option: BOOLEAN) is
			-- Process attributes of a (class) option tag.
		require
			group: a_class_option implies current_group /= Void
			target: current_target /= Void
		local
			l_trace, l_profile, l_optimize, l_debug, l_namespace, l_class,
			l_warning, l_msil_application_optimize, l_full_class_checking,
			l_cat_call_detection, l_is_attached_by_default, l_is_void_safe,
			l_syntax_level: STRING
		do
			l_trace := current_attributes.item (at_trace)
			l_profile := current_attributes.item (at_profile)
			l_optimize := current_attributes.item (at_optimize)
			l_debug := current_attributes.item (at_debug)
			l_warning := current_attributes.item (at_warning)
			l_msil_application_optimize := current_attributes.item (at_msil_application_optimize)
			l_namespace := current_attributes.item (at_namespace)
			l_class := current_attributes.item (at_class)
			l_full_class_checking := current_attributes.item (at_full_class_checking)
			l_cat_call_detection := current_attributes.item (at_cat_call_detection)
			l_is_attached_by_default := current_attributes.item (at_is_attached_by_default)
			l_is_void_safe := current_attributes.item (at_is_void_safe)
			l_syntax_level := current_attributes.item (at_syntax_level)

			current_option := factory.new_option
			if l_trace /= Void then
				if l_trace.is_boolean then
					current_option.set_trace (l_trace.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("trace"))
				end
			end
			if l_profile /= Void then
				if l_profile.is_boolean then
					current_option.set_profile (l_profile.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("profile"))
				end
			end
			if l_optimize /= Void then
				if l_optimize.is_boolean then
					current_option.set_optimize (l_optimize.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("optimize"))
				end
			end
			if l_debug /= Void then
				if l_debug.is_boolean then
					current_option.set_debug (l_debug.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("debug"))
				end
			end
			if l_warning /= Void then
				if l_warning.is_boolean then
					current_option.set_warning (l_warning.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("warning"))
				end
			end
			if l_msil_application_optimize /= Void and then l_msil_application_optimize.is_boolean then
				current_option.set_msil_application_optimize (l_msil_application_optimize.to_boolean)
			end
			if l_namespace /= Void then
				current_option.set_local_namespace (l_namespace)
			end
			if l_full_class_checking /= Void then
				if l_full_class_checking.is_boolean then
					current_option.set_full_class_checking (l_full_class_checking.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("full_class_checking"))
				end
			end
			if l_cat_call_detection /= Void then
				if l_cat_call_detection.is_boolean then
					current_option.set_cat_call_detection (l_cat_call_detection.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("cat_call_detection"))
				end
			end
			if l_is_attached_by_default /= Void then
				if l_is_attached_by_default.is_boolean then
					current_option.set_is_attached_by_default (l_is_attached_by_default.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("is_attached_by_default"))
				end
			end
			if l_is_void_safe /= Void then
				if l_is_void_safe.is_boolean then
					current_option.set_is_void_safe (l_is_void_safe.to_boolean)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("is_void_safe"))
				end
			end
			if l_syntax_level /= Void then
				if l_syntax_level.is_natural_8 and then current_option.is_valid_syntax_level (l_syntax_level.to_natural_8) then
					current_option.syntax_level.put (l_syntax_level.to_natural_8)
				else
					set_parse_error_message (conf_interface_names.e_parse_invalid_value ("syntax_level"))
				end
			end

			if a_class_option then
				if is_valid_class_name (l_class) then
					current_group.add_class_options (current_option, l_class.as_upper)
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_class_opt)
				end
			else
				if current_group /= Void then
					current_group.set_options (current_option)
				else
					current_target.set_options (current_option)
				end
			end
		ensure
			current_option_not_void: not is_error implies current_option /= Void
		end

	process_visible_attributes is
			-- Process attributes of a visible tag.
		require
			cluster_or_library: current_cluster /= Void or current_library /= Void
		local
			l_class, l_feature, l_class_rename, l_feature_rename: STRING
		do
			l_class := current_attributes.item (at_class)
			l_feature := current_attributes.item (at_feature)
			l_class_rename := current_attributes.item (at_class_rename)
			l_feature_rename := current_attributes.item (at_feature_rename)
			if is_valid_class_name (l_class) then
				l_class.to_upper
				if l_feature /= Void then
					l_feature.to_lower
					if not is_valid_feature_name (l_feature) then
						set_parse_error_message (conf_interface_names.e_parse_incorrect_visible_feature (l_feature))
					end
				end
				if l_class_rename /= Void then
					l_class_rename.to_upper
					if not is_valid_class_name (l_class_rename) then
						set_parse_error_message (conf_interface_names.e_parse_incorrect_visible_class (l_class_rename))
					end
				end
				if l_feature_rename /= Void then
					l_feature_rename.to_lower
					if not is_valid_feature_name (l_feature_rename) then
						set_parse_error_message (conf_interface_names.e_parse_incorrect_visible_feature (l_feature_rename))
					end
				end
				if current_cluster /= Void then
					current_cluster.add_visible (l_class, l_feature, l_class_rename, l_feature_rename)
				else
					current_library.add_visible (l_class, l_feature, l_class_rename, l_feature_rename)
				end
			else
				if current_cluster /= Void then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_visible (current_cluster.name))
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_visible (current_library.name))
				end
			end
		end

	process_uses_attributes is
			-- Process attributes of an uses tag.
		require
			cluster: current_cluster /= Void
		local
			l_group: STRING
			ll: ARRAYED_LIST [CONF_CLUSTER]
		do
			l_group := current_attributes.item (at_group)
			if is_valid_group_name (l_group) then
				if l_group.is_equal ("none") then
					current_cluster.set_dependencies (create {DS_HASH_SET [CONF_GROUP]}.make (0))
				else
					ll := uses_list.item (l_group)
					if ll = Void then
						create ll.make (1)
					end
					ll.extend (current_cluster)
					uses_list.force (ll, l_group)
				end
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_uses (current_cluster.name))
			end
		end

	process_overrides_attributes is
			-- Process attributes of an overides tag.
		require
			override: current_override /= Void
		local
			l_group: STRING
			ll: ARRAYED_LIST [CONF_OVERRIDE]
		do
			l_group := current_attributes.item (at_group)
			if is_valid_group_name (l_group) then
				if l_group.is_equal ("none") then
					current_override.set_override (create {ARRAYED_LIST [CONF_GROUP]}.make (0))
				else
					ll := overrides_list.item (l_group)
					if ll = Void then
						create ll.make (1)
					end
					ll.extend (current_override)
					overrides_list.force (ll, l_group)
				end
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_overrides (current_override.name))
			end
		end

	process_condition_attributes is
			-- Process attributes of a condition tag.
		require
			external_or_action_or_group_or_file_rule: current_external /= Void or current_action /= Void or current_group /= Void or current_file_rule /= Void
		do
			create current_condition.make

			if not is_error then
				if current_file_rule /= Void then
					current_file_rule.add_condition (current_condition)
				elseif current_external /= Void then
					current_external.add_condition (current_condition)
				elseif current_action /= Void then
					current_action.add_condition (current_condition)
				elseif current_group /= Void then
					current_group.add_condition (current_condition)
				else
					set_parse_error_message (conf_interface_names.e_parse_incorrect_condition)
				end
			end
		ensure
			current_condition: not is_error implies current_condition /= Void
		end

	process_platform_attributes is
			-- Process attributes of a platform tag.
		require
			current_condition: current_condition /= Void
		local
			l_value, l_excluded_value: STRING
			l_pf: INTEGER
			l_platforms: LIST [STRING]
			l_invert: BOOLEAN
		do
			l_value := current_attributes.item (at_value)
			l_excluded_value := current_attributes.item (at_excluded_value)
			if current_condition.platform /= Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_platform_mult)
			elseif l_value /= Void and l_excluded_value /= Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_platform_conflict)
			elseif l_value = Void and l_excluded_value = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_platform_none)
			elseif l_value /= Void then
				l_platforms := l_value.split (' ')
			else
				l_platforms := l_excluded_value.split (' ')
				l_invert := True
			end

			if not is_error then
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
							current_condition.exclude_platform (l_pf)
						else
							current_condition.add_platform (l_pf)
						end
					end
					l_platforms.forth
				end
			end
		end

	process_build_attributes is
			-- Process attributes of a build tag.
		require
			current_condition: current_condition /= Void
		local
			l_value, l_excluded_value: STRING
			l_bld: INTEGER
			l_builds: LIST [STRING]
			l_invert: BOOLEAN
		do
			l_value := current_attributes.item (at_value)
			l_excluded_value := current_attributes.item (at_excluded_value)
			if current_condition.build /= Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_build_mult)
			elseif l_value /= Void and l_excluded_value /= Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_build_conflict)
			elseif l_value = Void and l_excluded_value = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_build_none)
			elseif l_value /= Void then
				l_builds := l_value.split (' ')
			else
				l_builds := l_excluded_value.split (' ')
				l_invert := True
			end

			if not is_error then
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
							current_condition.exclude_build (l_bld)
						else
							current_condition.add_build (l_bld)
						end
					end
					l_builds.forth
				end
			end
		end

	process_multithreaded_attributes is
			-- Process attributes of a multithreaded tag.
		require
			current_condition: current_condition /= Void
		local
			l_value: STRING
		do
			l_value := current_attributes.item (at_value)
			if l_value = Void or else not l_value.is_boolean then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_multithreaded)
			else
				current_condition.set_multithreaded (l_value.to_boolean)
			end
		end

	process_dotnet_attributes is
			-- Process attributes of a dotnet tag.
		require
			current_condition: current_condition /= Void
		local
			l_value: STRING
		do
			l_value := current_attributes.item (at_value)
			if l_value = Void or else not l_value.is_boolean then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_dotnet)
			else
				current_condition.set_dotnet (l_value.to_boolean)
			end
		end

	process_dynamic_runtime_attributes is
			-- Process attributes of a dynamic_runtime tag.
		require
			current_condition: current_condition /= Void
		local
			l_value: STRING
		do
			l_value := current_attributes.item (at_value)
			if l_value = Void or else not l_value.is_boolean then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_dynamic_runtime)
			else
				current_condition.set_dynamic_runtime (l_value.to_boolean)
			end
		end

	process_version_condition_attributes is
			-- Process attributes of a condition version tag.
		require
			current_condition: current_condition /= Void
		local
			l_min, l_max, l_type: STRING
			l_vers_min, l_vers_max: CONF_VERSION
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
				elseif l_min /= Void and l_max /= Void and then l_min > l_max then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_version_min_max (l_type))
				else
					current_condition.add_version (l_vers_min, l_vers_max, l_type)
				end
			end
		end

	process_custom_attributes is
			-- Process attributes of a custom tag.
		require
			current_condition: current_condition /= Void
		local
			l_name, l_value, l_excluded_value: STRING
		do
			l_name := current_attributes.item (at_name)
			l_value := current_attributes.item (at_value)
			l_excluded_value := current_attributes.item (at_excluded_value)
			if l_name = Void then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_custom_no_name)
			else
				if l_value /= Void and l_excluded_value /= Void then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_custom_conflict (l_name))
				elseif l_value = Void and l_excluded_value = Void then
					set_parse_error_message (conf_interface_names.e_parse_incorrect_custom_none (l_name))
				elseif l_value /= Void then
					current_condition.add_custom (l_name, l_value)
				else
					check l_excluded_value /= Void end
					current_condition.exclude_custom (l_name, l_excluded_value)
				end
			end
		end

	process_mapping_attributes is
			-- Process attributes of a mapping tag.
		require
			cluster_or_target: current_cluster /= Void or current_target /= Void
		local
			l_old, l_new: STRING
		do
			l_old := current_attributes.item (at_old_name)
			l_new := current_attributes.item (at_new_name)
			if not is_valid_class_name (l_old) or not is_valid_class_name (l_new) then
				set_parse_error_message (conf_interface_names.e_parse_incorrect_mapping)
			else
				if current_cluster /= Void then
					current_cluster.add_mapping (l_old, l_new)
				else
					current_target.add_mapping (l_old, l_new)
				end
			end
		end

	process_note_attributes is
			-- Process attributes of note tag.
		require
			system_or_group_or_target: last_system /= Void or current_group /= Void or current_target /= Void
		local
			l_attrs: like current_attributes_undefined
		do
				-- All notes attributes are undefined.
			l_attrs := current_attributes_undefined
			if l_attrs /= Void then
				if current_group /= Void then
					current_group.add_note (l_attrs.twin)
				elseif current_target /= Void then
					current_target.add_note (l_attrs.twin)
				elseif last_system /= Void then
					last_system.add_note (l_attrs.twin)
				end
			end
		end

feature {NONE} -- Implementation content processing

	process_description_content is
			-- Process content of a description tag.
		do
			if current_file_rule /= Void then
				current_file_rule.set_description (current_content)
			elseif current_option /= Void then
				current_option.set_description (current_content)
			elseif current_action /= Void then
				current_action.set_description (current_content)
			elseif current_external /= Void then
				current_external.set_description (current_content)
			elseif current_group /= Void then
				current_group.set_description (current_content)
			elseif current_target /= Void then
				current_target.set_description (current_content)
			elseif last_system /= Void then
				last_system.set_description (current_content)
			else
				set_parse_error_message (conf_interface_names.e_parse_incorrect_description)
			end
		end

	process_exclude_content is
			-- Process content of an exclude tag.
		require
			file_rule: current_file_rule /= Void
		do
			if valid_regexp (current_content) then
				current_file_rule.add_exclude (current_content)
			else
				set_error (create {CONF_ERROR_REGEXP}.make (current_content))
			end
		end

	process_include_content is
			-- Process content of an include tag.
		require
			file_rule: current_file_rule /= Void
		do
			if valid_regexp (current_content) then
				current_file_rule.add_include (current_content)
			else
				set_error (create {CONF_ERROR_REGEXP}.make (current_content))
			end
		end

feature {NONE} -- Implementation

	factory: CONF_PARSE_FACTORY
			-- Factory for node creation.

	current_library_target: STRING
	current_target: CONF_TARGET
	current_cluster: CONF_CLUSTER
	current_override: CONF_OVERRIDE
	current_library: CONF_LIBRARY
	current_assembly: CONF_ASSEMBLY
	current_group: CONF_GROUP
	current_file_rule: CONF_FILE_RULE
	current_option: CONF_OPTION
	current_external: CONF_EXTERNAL
	current_action: CONF_ACTION
	current_content: STRING
	current_condition: CONF_CONDITION

	uses_list: HASH_TABLE [ARRAYED_LIST [CONF_CLUSTER], STRING]
			-- The list of classes, that have a uses clause on something.
			-- Entries will be handled at the end.

	overrides_list: HASH_TABLE [ARRAYED_LIST [CONF_OVERRIDE], STRING]
			-- The list of classes, that have an overrides clause on something.
			-- Entries will be handled at the end.

	group_list: HASH_TABLE [CONF_GROUP, STRING]
			-- All groups of `current_target', to check for name conflicts and to compute dependencies and overrides.

	current_tag: LINKED_STACK [INTEGER]
			-- The stack of tags we are currently processing

	current_attributes: HASH_TABLE [STRING, INTEGER]
			-- The values of the current attributes.
			-- Defined attributes.

	current_attributes_undefined: HASH_TABLE [STRING, STRING]
			-- The values of the current attributes.
			-- Undefined attributes.

feature {NONE} -- Implementation state transitions

	state_transitions_tag: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER] is
			-- Mapping of possible tag state transitions from `current_tag' with the tag name to the new state.
		local
			l_trans: HASH_TABLE [INTEGER, STRING]
		once
			create Result.make (14)

				-- => system
			create l_trans.make (1)
			l_trans.force (t_system, "system")
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
				-- => external_object
				-- => external_library
				-- => external_rssource
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
			l_trans.force (t_external_object, "external_object")
			l_trans.force (t_external_library, "external_library")
			l_trans.force (t_external_resource, "external_resource")
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

				-- external_(include|object|resource|make)
				-- => description
				-- => condition
			create l_trans.make (2)
			l_trans.force (t_description, "description")
			l_trans.force (t_condition, "condition")
			Result.force (l_trans, t_external_include)
			Result.force (l_trans, t_external_object)
			Result.force (l_trans, t_external_library)
			Result.force (l_trans, t_external_resource)
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

				-- cluster
				-- -everything from library/precompile except renaming
				-- => file_rule
				-- => mapping
				-- => uses
				-- => cluster
			l_trans := l_trans.twin
			l_trans.remove ("renaming")
			l_trans.force (t_note, "note")
			l_trans.force (t_file_rule, "file_rule")
			l_trans.force (t_mapping, "mapping")
			l_trans.force (t_uses, "uses")
			l_trans.force (t_cluster, "cluster")
			l_trans.force (t_test_cluster, "tests")
			Result.force (l_trans, t_cluster)

				-- tests
				-- -everything from cluster
			l_trans := l_trans.twin
			Result.force (l_trans, t_test_cluster)

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
				-- => dotnet
				-- => dynamic_runtime
				-- => version
				-- => custom
			create l_trans.make (7)
			l_trans.force (t_platform, "platform")
			l_trans.force (t_build, "build")
			l_trans.force (t_multithreaded, "multithreaded")
			l_trans.force (t_dotnet, "dotnet")
			l_trans.force (t_dynamic_runtime, "dynamic_runtime")
			l_trans.force (t_version_condition, "version")
			l_trans.force (t_custom, "custom")
			Result.force (l_trans, t_condition)
		ensure
			Result_not_void: Result /= Void
		end

	tag_attributes: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER] is
			-- Mapping of possible attributes of tags.
		local
			l_attr: HASH_TABLE [INTEGER, STRING]
		once
			create Result.make (25)

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
			l_attr.force (at_syntax_level, "syntax_level")
			Result.force (l_attr, t_option)

				-- class_option
				-- -everything from option
				-- *class
			l_attr := l_attr.twin
			l_attr.force (at_class, "class")
			Result.force (l_attr, t_class_option)

				-- external_(include|object|resource|make)
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
			l_attr.force (at_enabled, "enabled")
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

				-- multithreaded
			create l_attr.make (1)
			l_attr.force (at_value, "value")
			Result.force (l_attr, t_multithreaded)

				-- dotnet
			create l_attr.make (1)
			l_attr.force (at_value, "value")
			Result.force (l_attr, t_dotnet)

				-- dynamic_runtime
			create l_attr.make (1)
			l_attr.force (at_value, "value")
			Result.force (l_attr, t_dynamic_runtime)

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

				-- renaming
				-- * old_name
				-- * new_name
			create l_attr.make (2)
			l_attr.force (at_old_name, "old_name")
			l_attr.force (at_new_name, "new_name")
			Result.force (l_attr, t_renaming)

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

				-- mapping
				-- * old_name
				-- * new_name
			create l_attr.make (2)
			l_attr.force (at_old_name, "old_name")
			l_attr.force (at_new_name, "new_name")
			Result.force (l_attr, t_mapping)
		end

	tag_with_undefined_attributes: SEARCH_TABLE [INTEGER]
			-- Tags may contain undefined attributes.
		once
			create Result.make (1)
			Result.force (t_note)
		end

feature {NONE} -- Implementation constants

		-- Tag states
	t_none: INTEGER is 1
	t_system: INTEGER is 2
	t_description: INTEGER is 3
	t_target: INTEGER is 4
	t_root: INTEGER is 5
	t_version: INTEGER is 6
	t_file_rule: INTEGER is 7
	t_option: INTEGER is 8
	t_setting: INTEGER is 9
	t_external_include: INTEGER is 10
	t_external_object: INTEGER is 11
	t_external_library: INTEGER is 12
	t_external_resource: INTEGER is 13
	t_external_make: INTEGER is 14
	t_pre_compile_action: INTEGER is 15
	t_post_compile_action: INTEGER is 16
	t_variable: INTEGER is 17
	t_precompile: INTEGER is 18
	t_library: INTEGER is 19
	t_assembly: INTEGER is 20
	t_cluster: INTEGER is 21
	t_override: INTEGER is 22
	t_exclude: INTEGER is 23
	t_include: INTEGER is 24
	t_debug: INTEGER is 25
	t_assertions: INTEGER is 26
	t_warning: INTEGER is 27
	t_condition: INTEGER is 28
	t_platform: INTEGER is 29
	t_build: INTEGER is 30
	t_multithreaded: INTEGER is 31
	t_dotnet: INTEGER is 32
	t_dynamic_runtime: INTEGER is 33
	t_version_condition: INTEGER is 34
	t_custom: INTEGER is 35
	t_renaming: INTEGER is 36
	t_class_option: INTEGER is 37
	t_uses: INTEGER is 38
	t_visible: INTEGER is 39
	t_overrides: INTEGER is 40
	t_mapping: INTEGER is 41
	t_note: INTEGER is 42
	t_test_cluster: INTEGER is 43

		-- Attribute states
	at_abstract: INTEGER is 1000
	at_name: INTEGER is 1001
	at_uuid: INTEGER is 1002
	at_library_target: INTEGER is 1003
	at_eifgen: INTEGER is 1004
	at_extends: INTEGER is 1005
	at_cluster: INTEGER is 1006
	at_class: INTEGER is 1007
	at_all_classes: INTEGER is 1008
	at_feature: INTEGER is 1009
	at_class_rename: INTEGER is 1010
	at_feature_rename: INTEGER is 1011
	at_major: INTEGER is 1012
	at_minor: INTEGER is 1013
	at_release: INTEGER is 1014
	at_build: INTEGER is 1015
	at_product: INTEGER is 1016
	at_company: INTEGER is 1017
	at_copyright: INTEGER is 1018
	at_trademark: INTEGER is 1019
	at_trace: INTEGER is 1020
	at_profile: INTEGER is 1021
	at_optimize: INTEGER is 1022
	at_debug: INTEGER is 1023
	at_namespace: INTEGER is 1024
	at_location: INTEGER is 1025
	at_command: INTEGER is 1026
	at_value: INTEGER is 1027
	at_excluded_value: INTEGER is 1028
	at_readonly: INTEGER is 1029
	at_prefix: INTEGER is 1030
	at_target: INTEGER is 1031
	at_assembly_name: INTEGER is 1032
	at_assembly_version: INTEGER is 1033
	at_assembly_culture: INTEGER is 1034
	at_assembly_key: INTEGER is 1035
	at_recursive: INTEGER is 1036
	at_enabled: INTEGER is 1037
	at_precondition: INTEGER is 1038
	at_postcondition: INTEGER is 1039
	at_check: INTEGER is 1040
	at_invariant: INTEGER is 1041
	at_loop: INTEGER is 1042
	at_supplier_precondition: INTEGER is 1043
	at_platform: INTEGER is 1044
	at_min: INTEGER is 1045
	at_max: INTEGER is 1046
	at_old_name: INTEGER is 1047
	at_new_name: INTEGER is 1048
	at_group: INTEGER is 1049
	at_succeed: INTEGER is 1050
	at_working_directory: INTEGER is 1051
	at_type: INTEGER is 1052
	at_eifgens_location: INTEGER is 1053
	at_warning: INTEGER is 1054
	at_hidden: INTEGER is 1055
	at_msil_application_optimize: INTEGER is 1056
	at_use_application_options: INTEGER is 1057
	at_full_class_checking: INTEGER is 1058
	at_cat_call_detection: INTEGER is 1059
	at_is_attached_by_default: INTEGER is 1060
	at_is_void_safe: INTEGER is 1061
	at_syntax_level: INTEGER is 1062

feature -- Assertions

	has_resolved_namespaces: BOOLEAN is True

invariant
	current_tag_not_void: current_tag /= Void
	current_attributes_not_void: current_attributes /= Void
	current_content_not_void: current_content /= Void
	group_list_not_void: group_list /= Void
	uses_list_not_void: uses_list /= Void
	overrides_list_not_void: overrides_list /= Void
	factory_not_void: factory /= Void

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
