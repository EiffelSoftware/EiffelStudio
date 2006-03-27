indexing
	description: "The callbacks that react on the xml parsing."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LOAD_PARSE_CALLBACKS

inherit
	CONF_LOAD_CALLBACKS
		redefine
			make,
			on_start_tag,
			on_start_tag_finish,
			on_attribute,
			on_end_tag,
			on_content,
			has_resolved_namespaces
		end

	SHARED_CONF_FACTORY

	CONF_VALIDITY

	CONF_ACCESS

create
	make

feature {NONE} -- Initialization

	feature make is
			-- Create.
		do
			Precursor
			create current_tag.make
			create current_attributes.make (0)
			create group_list.make (0)
			create uses_list.make (0)
			create overrides_list.make (0)
			create current_content.make_empty
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
					set_parse_error_message ("Invalid tag/tag position '"+a_local_part+"'")
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
					if l_attribute /= 0 and then not current_attributes.has (l_attribute) then
						if not a_value.is_empty then
							current_attributes.force (a_value, l_attribute)
						else
							set_parse_error_message ("Invalid value for '"+a_local_part+"'")
						end
					else
						set_parse_error_message ("Invalid attribute '"+a_local_part+"'")
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
				when t_external_ressource then
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
					process_cluster_attributes
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
				when t_if then
					process_if_attributes
				when t_ifnot then
					process_ifnot_attributes
				else
				end
				current_attributes.clear_all
			end
		end


	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- End tag.
		local
			l_group: CONF_GROUP
			l_error: CONF_ERROR_GRUNDEF
		do
			if not is_error then
				current_content.left_adjust
				current_content.right_adjust
				if not current_content.is_empty then
					inspect
						current_tag.item
					when t_description then
						process_description_content
					when t_exclude then
						process_exclude_content
					when t_include then
						process_include_content
					else
						set_parse_error_message ("Invalid content: "+current_content)
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
						elseif current_target.precompile /= Void then
							set_error (create {CONF_ERROR_LIBPRE})
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
								set_error (create {CONF_ERROR_OVERRIDE}.make (l_group.name))
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
				when t_external_ressource then
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
				when t_override then
					current_group := current_cluster.parent
					current_cluster := current_override.parent
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
			l_name, l_uuid: STRING
			l_uu: UUID
		do
			l_name := current_attributes.item (at_name)
			l_uuid := current_attributes.item (at_uuid)
			current_library_target := current_attributes.item (at_library_target)
			if l_name /= Void and then l_uuid /= Void and then check_uuid (l_uuid) then
				create l_uu.make_from_string (l_uuid)
				last_system := conf_factory.new_system (l_name, l_uu)
			else
				set_parse_error_message ("Incorrect system tag.")
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
			l_name, l_eifgen, l_extends: STRING
		do
			l_name := current_attributes.item (at_name)
			l_eifgen := current_attributes.item (at_eifgen)
			l_extends := current_attributes.item (at_extends)
			if l_name /= Void then
				current_target := conf_factory.new_target (l_name, last_system)
				if current_library_target /= Void and then l_name.is_equal (current_library_target) then
					last_system.set_library_target (current_target)
					current_library_target := Void
				end
				last_system.add_target (current_target)
				if l_extends /= Void then
					l_target := last_system.targets.item (l_extends)
					if l_target /= Void then
						current_target.set_parent (l_target)
					else
						set_parse_error_message ("Missing parent target: "+l_extends)
					end
				end
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
					set_parse_error_message ("Invalid value for all_classes attribute in root tag.")
				end
			end
			l_cluster := current_attributes.item (at_cluster)
			if l_cluster /= Void then
				l_cluster.to_lower
			end
			l_class := current_attributes.item (at_class)
			if l_class /= Void then
				l_class.to_upper
			end
			l_feature := current_attributes.item (at_feature)
			if l_feature /= Void then
				l_feature.to_lower
			end
			if (l_all_b and l_cluster = Void and l_class = Void and l_feature = Void) or else l_class /= Void then
				current_target.set_root (conf_factory.new_root (l_cluster, l_class, l_feature, l_all_b))
			else
				set_parse_error_message ("Invalid root tag.")
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
			l_version := conf_factory.new_version (l_i_major, l_i_minor, l_i_release, l_i_build)
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
			l_name := current_attributes.item (at_name).as_lower
			l_value := current_attributes.item (at_value)
			if l_name /= Void and l_value /= Void then
				if valid_setting (l_name) then
					current_target.add_setting (l_name, l_value)
				else
					set_parse_error_message ("Invalid setting: "+l_name)
				end
			else
				set_parse_error_message ("Invalid setting tag.")
			end
		end

	process_file_rule_attributes is
			-- Process attributes of a file_rule tag.
		require
			target_or_cluster: current_target /= Void or current_cluster /= Void
		do
			current_file_rule := conf_factory.new_file_rule
			if current_cluster /= Void then
				current_cluster.set_file_rule (current_file_rule)
			elseif current_target /= Void then
				current_target.set_file_rule (current_file_rule)
			else
				set_parse_error_message ("Invalid file_rule tag.")
			end
		ensure
			current_file_rule_not_void: current_file_rule /= Void
		end


	process_external_attributes is
			-- Process attributes of external_(include|object|ressource) tags.
		require
			current_target_not_void: current_target /= Void
		local
			l_location: STRING
			l_loc: CONF_LOCATION
			l_inc: CONF_EXTERNAL_INCLUDE
			l_obj: CONF_EXTERNAL_OBJECT
			l_res: CONF_EXTERNAL_RESSOURCE
			l_make: CONF_EXTERNAL_MAKE
		do
			l_location := current_attributes.item (at_location)
			if l_location /= Void then
				l_loc := conf_factory.new_location_from_full_path (l_location, current_target)
				inspect
					current_tag.item
				when t_external_include then
					l_inc := conf_factory.new_external_include (l_loc)
					current_target.add_external_include (l_inc)
					current_external := l_inc
				when t_external_object then
					l_obj := conf_factory.new_external_object (l_loc)
					current_target.add_external_object (l_obj)
					current_external := l_obj
				when t_external_ressource then
					l_res := conf_factory.new_external_ressource (l_loc)
					current_target.add_external_ressource (l_res)
					current_external := l_res
				when t_external_make then
					l_make := conf_factory.new_external_make (l_loc)
					current_target.add_external_make (l_make)
					current_external := l_res
				else
					set_parse_error_message ("Invalid external tag.")
				end
			else
				set_parse_error_message ("Invalid external tag.")
			end
		ensure
			current_external_not_void: not is_error implies current_external /= Void
		end

	process_action_attributes is
			-- Process attributes of (pre|post)_compile_action tags.
		require
			current_target_not_void: current_target /= Void
		local
			l_command: STRING
		do
			l_command := current_attributes.item (at_command)
			if l_command /= Void then
				current_action :=  conf_factory.new_action (l_command)
				inspect
					current_tag.item
				when t_pre_compile_action then
					current_target.add_pre_compile (current_action)
				when t_post_compile_action then
					current_target.add_post_compile (current_action)
				else
					set_parse_error_message ("Invalid action tag.")
				end
			else
				set_parse_error_message ("Invalid action tag.")
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
			if l_name /= Void and l_value /= Void then
				current_target.add_variable (l_name, l_value)
			else
				set_parse_error_message ("Invalid variable tag.")
			end
		end

	process_library_attributes is
			-- Process attributes of a library tag.
		require
			current_target_not_void: current_target /= Void
		local
			l_name, l_location, l_readonly, l_prefix: STRING
		do
			l_name := current_attributes.item (at_name)
			l_location := current_attributes.item (at_location)
			l_readonly := current_attributes.item (at_readonly)
			l_prefix := current_attributes.item (at_prefix)
			if l_name /= Void and l_location /= Void and not group_list.has (l_name) then
				current_library := conf_factory.new_library (l_name, conf_factory.new_location_from_full_path (l_location, current_target), current_target)
				current_group := current_library
				if l_readonly /= Void and then l_readonly.is_boolean then
					if l_readonly.to_boolean then
						current_library.enable_readonly
					end
				end
				if l_prefix /= Void then
					current_library.set_name_prefix (l_prefix)
				end
				group_list.force (current_group, l_name)
				current_target.add_library (current_library)
			else
				set_parse_error_message ("Invalid library tag.")
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
			l_pre: CONF_PRECOMPILE
		do
			l_name := current_attributes.item (at_name)
			l_location := current_attributes.item (at_location)
			l_readonly := current_attributes.item (at_readonly)
			l_prefix := current_attributes.item (at_prefix)
			l_target := current_attributes.item (at_target)
			if l_name /= Void and l_location /= Void and not group_list.has (l_name) and current_target.precompile = Void then
				l_pre := conf_factory.new_precompile (l_name, l_location, current_target)
				current_library := l_pre
				current_group := current_library
				if l_readonly /= Void and then l_readonly.is_boolean then
					if l_readonly.to_boolean then
						current_library.enable_readonly
					end
				end
				if l_prefix /= Void then
					current_library.set_name_prefix (l_prefix)
				end
				group_list.force (current_group, l_name)
				current_target.set_precompile (l_pre)
			else
				set_parse_error_message ("Invalid precompile tag.")
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
			if l_name /= Void and l_location /= Void and not group_list.has (l_name) then
				if l_location.is_equal ("none") then
					if l_assembly_name /= Void and l_assembly_version /= Void and l_assembly_culture /= Void and l_assembly_key /= Void then
						current_assembly := conf_factory.new_assembly_from_gac (l_name,l_assembly_name, l_assembly_version, l_assembly_culture, l_assembly_key, current_target )
					end
				else
					current_assembly := conf_factory.new_assembly (l_name, l_location, current_target)
				end
				current_group := current_assembly
				if l_readonly /= Void and then l_readonly.is_boolean then
					if l_readonly.to_boolean then
						current_assembly.enable_readonly
					end
				end
				if l_prefix /= Void then
					current_assembly.set_name_prefix (l_prefix)
				end
				group_list.force (current_group, l_name)
				current_target.add_assembly (current_assembly)
			else
				set_parse_error_message ("Invalid assembly tag.")
			end
		ensure
			assembly_and_group: not is_error implies current_assembly /= Void and current_group /= Void
		end

	process_cluster_attributes is
			-- Process attributes of a cluster tag.
		require
			target: current_target /= Void
		local
			l_name, l_location, l_readonly, l_prefix, l_recursive: STRING
			l_parent: CONF_CLUSTER
			l_loc: CONF_LOCATION
		do
			l_name := current_attributes.item (at_name)
			l_location := current_attributes.item (at_location)
			l_readonly := current_attributes.item (at_readonly)
			l_prefix := current_attributes.item (at_prefix)
			l_recursive := current_attributes.item (at_recursive)
			if l_name /= Void and l_location /= Void and not group_list.has (l_name) then
				l_parent := current_cluster
				l_loc := conf_factory.new_location_from_path (l_location, current_target)
				current_cluster := conf_factory.new_cluster (l_name.as_lower, l_loc, current_target)
				current_group := current_cluster
				if l_readonly /= Void and then l_readonly.is_boolean then
					if l_readonly.to_boolean then
						current_cluster.enable_readonly
					end
				end
				if l_prefix /= Void then
					current_cluster.set_name_prefix (l_prefix)
				end
				if l_recursive /= Void and then l_recursive.is_boolean then
					if l_recursive.to_boolean then
						current_cluster.enable_recursive
					end
				end
				if l_parent /= Void then
					l_parent.add_child (current_cluster)
					current_cluster.set_parent (l_parent)
					l_loc.set_parent (l_parent.location)
				end

				group_list.force (current_group, l_name)
				current_target.add_cluster (current_cluster)
			else
				set_parse_error_message ("Invalid cluster tag.")
			end
		ensure
			cluster_and_group: current_cluster /= Void and current_group /= Void
		end

	process_override_attributes is
			-- Process attributes of an override tag.
		require
			target: current_target /= Void
		local
			l_name, l_location, l_readonly, l_prefix, l_recursive: STRING
			l_parent: CONF_CLUSTER
		do
			l_name := current_attributes.item (at_name)
			l_location := current_attributes.item (at_location)
			l_readonly := current_attributes.item (at_readonly)
			l_prefix := current_attributes.item (at_prefix)
			l_recursive := current_attributes.item (at_recursive)
			if l_name /= Void and l_location /= Void and not group_list.has (l_name) then
				l_parent := current_cluster
				current_override := conf_factory.new_override (l_name, conf_factory.new_location_from_path (l_location, current_target), current_target)
				current_cluster := current_override
				current_group := current_cluster
				if l_readonly /= Void and then l_readonly.is_boolean then
					if l_readonly.to_boolean then
						current_cluster.enable_readonly
					end
				end
				if l_prefix /= Void then
					current_cluster.set_name_prefix (l_prefix)
				end
				if l_recursive /= Void and then l_recursive.is_boolean then
					if l_recursive.to_boolean then
						current_cluster.enable_recursive
					end
				end
				if l_parent /= Void then
					current_cluster.set_parent (l_parent)
				end
				group_list.force (current_group, l_name)
				current_target.add_override (current_override)
			else
				set_parse_error_message ("Invalid override tag.")
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
			if l_name /= Void and l_enabled /= Void and then l_enabled.is_boolean then
				if valid_warning (l_name) then
					current_option.add_warning (l_name, l_enabled.to_boolean)
				else
					set_parse_error_message ("Invalid warning: "+l_name)
				end
			end
		end

	process_assertions_attributes is
			-- Process attributes of a assertions tag.
		require
			current_option_not_void: current_option /= Void
		local
			l_pre, l_post, l_chk, l_inv, l_loop: STRING
			l_assert: CONF_ASSERTIONS
		do
			l_pre := current_attributes.item (at_precondition)
			l_post := current_attributes.item (at_postcondition)
			l_chk := current_attributes.item (at_check)
			l_inv := current_attributes.item (at_invariant)
			l_loop := current_attributes.item (at_loop)
			l_assert := conf_factory.new_assertions
			if l_pre /= Void and then l_pre.is_boolean and then l_pre.to_boolean then
				l_assert.enable_precondition
			end
			if l_post /= Void and then l_post.is_boolean and then l_post.to_boolean then
				l_assert.enable_postcondition
			end
			if l_chk /= Void and then l_chk.is_boolean and then l_chk.to_boolean then
				l_assert.enable_check
			end
			if l_inv /= Void and then l_inv.is_boolean and then l_inv.to_boolean then
				l_assert.enable_invariant
			end
			if l_loop /= Void and then l_loop.is_boolean and then l_loop.to_boolean then
				l_assert.enable_loop
			end
			current_option.set_assertions (l_assert)
		end

	process_renaming_attributes is
			-- Process attributes of a renaming tag.
		require
			group: current_group /= Void
		local
			l_old_name, l_new_name: STRING
		do
			l_old_name := current_attributes.item (at_old_name)
			l_new_name := current_attributes.item (at_new_name)
			if l_old_name /= Void and l_new_name /= Void then
				current_group.add_renaming (l_old_name.as_upper, l_new_name.as_upper)
			end
		end

	process_option_attributes (a_class_option: BOOLEAN) is
			-- Process attributes of a (class) option tag.
		require
			group: a_class_option implies current_group /= Void
			target: current_target /= Void
		local
			l_trace, l_profile, l_optimize, l_debug, l_namespace, l_class: STRING
		do
			l_trace := current_attributes.item (at_trace)
			l_profile := current_attributes.item (at_profile)
			l_optimize := current_attributes.item (at_optimize)
			l_debug := current_attributes.item (at_debug)
			l_namespace := current_attributes.item (at_namespace)
			l_class := current_attributes.item (at_class)

			current_option := conf_factory.new_option
			if l_trace /= Void and then l_trace.is_boolean then
				if l_trace.to_boolean then
					current_option.enable_trace
				end
			end
			if l_profile /= Void and then l_profile.is_boolean then
				if l_profile.to_boolean then
					current_option.enable_profile
				end
			end
			if l_optimize /= Void and then l_optimize.is_boolean then
				if l_optimize.to_boolean then
					current_option.enable_optimize
				else
					current_option.disable_optimize
				end
			end
			if l_debug /= Void and then l_debug.is_boolean then
				if l_debug.to_boolean then
					current_option.enable_debug
				else
					current_option.disable_debug
				end
			end
			if l_namespace /= Void then
				current_option.set_namespace (l_namespace)
			end

			if a_class_option then
				if l_class /= Void then
					current_group.add_class_options (current_option, l_class.as_upper)
				else
					set_parse_error_message ("Invalid class_option tag.")
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
			cluster: current_cluster /= Void
		local
			l_class, l_feature, l_class_rename, l_feature_rename: STRING
		do
			l_class := current_attributes.item (at_class)
			l_feature := current_attributes.item (at_feature)
			l_class_rename := current_attributes.item (at_class_rename)
			l_feature_rename := current_attributes.item (at_feature_rename)
			if l_class /= Void then
				l_class.to_upper
				if l_feature /= Void then
					current_cluster.add_visible (l_class, l_feature, l_class_rename, l_feature_rename)
				else
					current_cluster.add_visible (l_class, "*", "", "")
				end
			else
				set_parse_error_message ("Invalid visible tag.")
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
			if l_group /= Void then
				if l_group.is_equal ("none") then
					current_cluster.set_dependencies (create {LINKED_SET [CONF_GROUP]}.make)
				else
					ll := uses_list.item (l_group)
					if ll = Void then
						create ll.make (1)
					end
					ll.extend (current_cluster)
					uses_list.force (ll, l_group)
				end
			else
				set_parse_error_message ("Invalid uses tag.")
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
			if l_group /= Void then
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
				set_parse_error_message ("Invalid overrides tag.")
			end
		end

	process_if_attributes is
			-- Process attributes of an if tag.
		require
			external_or_action_or_group: current_external /= Void or current_action /= Void or current_group /= Void
		local
			l_platform, l_build: STRING
			l_i_pf, l_i_build: INTEGER
		do
			l_platform := current_attributes.item (at_platform)
			l_build := current_attributes.item (at_build)
			if l_platform = Void then
				l_platform := "all"
			end
			if l_build = Void then
				l_build := "all"
			end

			l_i_pf := get_platform (l_platform)
			l_i_build := get_build (l_build)
			if l_i_pf = 0 then
				set_parse_error_message ("Invalid platform: "+l_platform)
			end
			if l_i_build = 0 then
				set_parse_error_message ("Invalid build: "+l_build)
			end

			if not is_error then
				if current_external /= Void then
					current_external.enable (l_i_pf, l_i_build)
				elseif current_action /= Void then
					current_action.enable (l_i_pf, l_i_build)
				elseif current_group /= Void then
					if l_platform.is_equal ("all") and then current_group.is_assembly then
						l_platform := "dotnet"
					end
						-- remove default entry of assemblies
					if current_group.is_assembly and then current_group.is_enabled (pf_dotnet, build_all) then
						current_group.wipe_out
					end
					current_group.enable (l_i_pf, l_i_build)
				else
					set_parse_error_message ("Invalid if tag.")
				end
			end
		end

	process_ifnot_attributes is
			-- Process attributes of an ifnot tag.
		require
			external_or_action_or_group: current_external /= Void or current_action /= Void or current_group /= Void
		local
			l_platform, l_build: STRING
			l_i_pf, l_i_build: INTEGER
		do
			l_platform := current_attributes.item (at_platform)
			l_build := current_attributes.item (at_build)
			if l_platform = Void then
				l_platform := "all"
			end
			if l_build = Void then
				l_build := "all"
			end

			l_i_pf := get_platform (l_platform)
			l_i_build := get_build (l_build)
			if l_i_pf = 0 then
				set_parse_error_message ("Invalid platform: "+l_platform)
			end
			if l_i_build = 0 then
				set_parse_error_message ("Invalid build: "+l_build)
			end

			if not is_error then
				if current_external /= Void then
					current_external.inverse_enable (get_platform (l_platform), get_build (l_build))
				elseif current_action /= Void then
					current_action.inverse_enable (get_platform (l_platform), get_build (l_build))
				elseif current_group /= Void then
						-- remove default entry of assemblies
					if current_group.is_assembly and then current_group.is_enabled (pf_dotnet, build_all) then
						current_group.wipe_out
					end
					current_group.inverse_enable (get_platform (l_platform), get_build (l_build))
				else
					set_parse_error_message ("Invalid ifnot tag.")
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
				set_parse_error_message ("Invalid description tag.")
			end
		end

	process_exclude_content is
			-- Process content of an exclude tag.
		require
			file_rule: current_file_rule /= Void
		do
			current_file_rule.add_exclude (current_content)
			if current_file_rule.is_error then
				set_error (current_file_rule.last_error)
			end
		end

	process_include_content is
			-- Process content of an include tag.
		require
			file_rule: current_file_rule /= Void
		do
			current_file_rule.add_include (current_content)
			if current_file_rule.is_error then
				set_error (current_file_rule.last_error)
			end
		end

feature {NONE} -- Implementation

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
				-- => description
				-- => root
				-- => version
				-- => file_rule
				-- => setting
				-- => option
				-- => external_include
				-- => external_object
				-- => external_ressource
				-- => external_make
				-- => pre_compile_action
				-- => post_compile_action
				-- => variable
				-- => precompile
				-- => library
				-- => assembly
				-- => cluster
				-- => override
			create l_trans.make (17)
			l_trans.force (t_description, "description")
			l_trans.force (t_root, "root")
			l_trans.force (t_version, "version")
			l_trans.force (t_file_rule, "file_rule")
			l_trans.force (t_setting, "setting")
			l_trans.force (t_option, "option")
			l_trans.force (t_external_include, "external_include")
			l_trans.force (t_external_object, "external_object")
			l_trans.force (t_external_ressource, "external_ressource")
			l_trans.force (t_external_make, "external_make")
			l_trans.force (t_pre_compile_action, "pre_compile_action")
			l_trans.force (t_post_compile_action, "post_compile_action")
			l_trans.force (t_variable, "variable")
			l_trans.force (t_precompile, "precompile")
			l_trans.force (t_library, "library")
			l_trans.force (t_assembly, "assembly")
			l_trans.force (t_cluster, "cluster")
			l_trans.force (t_override, "override")
			Result.force (l_trans, t_target)

				-- file_rule
				-- => description
				-- => exclude
				-- => include
			create l_trans.make (3)
			l_trans.force (t_description, "description")
			l_trans.force (t_exclude, "exclude")
			l_trans.force (t_include, "include")
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
				-- => if
				-- => ifnot
			create l_trans.make (3)
			l_trans.force (t_description, "description")
			l_trans.force (t_if, "if")
			l_trans.force (t_ifnot, "ifnot")
			Result.force (l_trans, t_pre_compile_action)
			Result.force (l_trans, t_post_compile_action)

				-- external_(include|object|ressource|make)
				-- => description
				-- => if
				-- => ifnot
			create l_trans.make (3)
			l_trans.force (t_description, "description")
			l_trans.force (t_if, "if")
			l_trans.force (t_ifnot, "ifnot")
			Result.force (l_trans, t_external_include)
			Result.force (l_trans, t_external_object)
			Result.force (l_trans, t_external_ressource)
			Result.force (l_trans, t_external_make)

				-- library/assembly/precompile
				-- => description
				-- => option
				-- => renaming
				-- => class_option
				-- => if
				-- => ifnot
			create l_trans.make (6)
			l_trans.force (t_description, "description")
			l_trans.force (t_option, "option")
			l_trans.force (t_renaming, "renaming")
			l_trans.force (t_class_option, "class_option")
			l_trans.force (t_if, "if")
			l_trans.force (t_ifnot, "ifnot")
			Result.force (l_trans, t_library)
			Result.force (l_trans, t_assembly)
			Result.force (l_trans, t_precompile)

				-- cluster
				-- -everything from library/assembly
				-- => file_rule
				-- => uses
				-- => visible
				-- => cluster
			l_trans.force (t_file_rule, "file_rule")
			l_trans.force (t_uses, "uses")
			l_trans.force (t_visible, "visible")
			l_trans.force (t_cluster, "cluster")
			Result.force (l_trans, t_cluster)

				-- override
				-- -everything from cluster
				-- => overrides
			l_trans.force (t_overrides, "overrides")
			Result.force (l_trans, t_override)
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
				-- * library_target
			create l_attr.make (3)
			l_attr.force (at_name, "name")
			l_attr.force (at_uuid, "uuid")
			l_attr.force (at_library_target, "library_target")
			Result.force (l_attr, t_system)

				-- target
				-- * name
				-- * eifgen
				-- * extends
			create l_attr.make (3)
			l_attr.force (at_name, "name")
			l_attr.force (at_eifgen, "eifgen")
			l_attr.force (at_extends, "extends")
			Result.force (l_attr, t_target)

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
				-- * namespace
			create l_attr.make (6)
			l_attr.force (at_trace, "trace")
			l_attr.force (at_profile, "profile")
			l_attr.force (at_optimize, "optimize")
			l_attr.force (at_debug, "debug")
			l_attr.force (at_namespace, "namespace")
			Result.force (l_attr, t_option)

				-- class_option
				-- -everything from option
				-- *class
			l_attr.force (at_class, "class")
			Result.force (l_attr, t_class_option)

				-- external_(include|object|ressource|make)
				-- * location
			create l_attr.make (1)
			l_attr.force (at_location, "location")
			Result.force (l_attr, t_external_include)
			Result.force (l_attr, t_external_object)
			Result.force (l_attr, t_external_ressource)
			Result.force (l_attr, t_external_make)

				-- (pre|post)_compile_action
				-- * command
			create l_attr.make (1)
			l_attr.force (at_command, "command")
			Result.force (l_attr, t_pre_compile_action)
			Result.force (l_attr, t_post_compile_action)

				-- variable
				-- * name
				-- * value
			create l_attr.make (2)
			l_attr.force (at_name, "name")
			l_attr.force (at_value, "value")
			Result.force (l_attr, t_variable)

				-- library/precompile
				-- * name
				-- * location
				-- * readonly
				-- * prefix
			create l_attr.make (4)
			l_attr.force (at_name, "name")
			l_attr.force (at_location, "location")
			l_attr.force (at_readonly, "readonly")
			l_attr.force (at_prefix, "prefix")
			Result.force (l_attr, t_library)
			Result.force (l_attr, t_precompile)

				-- assembly
				-- -everything from library
				-- * assembly_name
				-- * assembly_version
				-- * assembly_culture
				-- * assembly_key
			l_attr.force (at_assembly_name, "assembly_name")
			l_attr.force (at_assembly_version, "assembly_version")
			l_attr.force (at_assembly_culture, "assembly_culture")
			l_attr.force (at_assembly_key, "assembly_key")
			Result.force (l_attr, t_assembly)

				-- cluster/override
				-- -everything from library
				-- * recursive
			create l_attr.make (5)
			l_attr.force (at_name, "name")
			l_attr.force (at_location, "location")
			l_attr.force (at_readonly, "readonly")
			l_attr.force (at_prefix, "prefix")
			l_attr.force (at_recursive, "recursive")
			Result.force (l_attr, t_cluster)
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
			create l_attr.make (5)
			l_attr.force (at_precondition, "precondition")
			l_attr.force (at_postcondition, "postcondition")
			l_attr.force (at_check, "check")
			l_attr.force (at_invariant, "invariant")
			l_attr.force (at_loop, "loop")
			Result.force (l_attr, t_assertions)

				-- if/ifnot
				-- * platform
				-- * build
			create l_attr.make (2)
			l_attr.force (at_platform, "platform")
			l_attr.force (at_build, "build")
			Result.force (l_attr, t_if)
			Result.force (l_attr, t_ifnot)

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
		end

feature {NONE} -- Implementation constants

		-- Tag states
	t_none,
	t_system,
	t_description,
	t_target,
	t_root,
	t_version,
	t_file_rule,
	t_option,
	t_setting,
	t_external_include,
	t_external_object,
	t_external_ressource,
	t_external_make,
	t_pre_compile_action,
	t_post_compile_action,
	t_variable,
	t_precompile,
	t_library,
	t_assembly,
	t_cluster,
	t_override,
	t_exclude,
	t_include,
	t_debug,
	t_assertions,
	t_warning,
	t_if,
	t_ifnot,
	t_renaming,
	t_class_option,
	t_uses,
	t_visible,
	t_overrides: INTEGER is unique

		-- Attribute states
	at_name,
	at_uuid,
	at_library_target,
	at_eifgen,
	at_extends,
	at_cluster,
	at_class,
	at_all_classes,
	at_feature,
	at_class_rename,
	at_feature_rename,
	at_major,
	at_minor,
	at_release,
	at_build,
	at_product,
	at_company,
	at_copyright,
	at_trademark,
	at_trace,
	at_profile,
	at_optimize,
	at_debug,
	at_namespace,
	at_location,
	at_command,
	at_value,
	at_readonly,
	at_prefix,
	at_target,
	at_assembly_name,
	at_assembly_version,
	at_assembly_culture,
	at_assembly_key,
	at_recursive,
	at_enabled,
	at_precondition,
	at_postcondition,
	at_check,
	at_invariant,
	at_loop,
	at_platform,
	at_old_name,
	at_new_name,
	at_group: INTEGER is unique

feature -- Assertions

	has_resolved_namespaces: BOOLEAN is True

invariant
	current_tag_not_void: current_tag /= Void
	current_attributes_not_void: current_attributes /= Void
	current_content_not_void: current_content /= Void
	group_list_not_void: group_list /= Void
	uses_list_not_void: uses_list /= Void
	overrides_list_not_void: overrides_list /= Void

end
