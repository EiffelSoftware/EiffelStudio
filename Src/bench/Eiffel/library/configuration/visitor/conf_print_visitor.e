indexing
	description: "Generate a text representation of the configuration in xml."
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
	make

feature {NONE} -- Initialization

	make is
			-- Create.
		do
		end


feature -- Access

	text: STRING
			-- The text output.

feature -- Visit nodes

	process_system (a_system: CONF_SYSTEM) is
			-- Visit `a_system'.
		local
			l_target: CONF_TARGET
		do
			create text.make_from_string (header)
			append_text_indent ("<system%N")
			append_text ("%T xmlns=%""+Namespace+"%"%N")
			append_text ("%T xmlns:xsi=%"http://www.w3.org/2001/XMLSchema-instance%"%N")
			append_text ("%T xsi:schemaLocation=%""+Schema+"%"%N")
			append_text ("%T name=%""+a_system.name+"%" uuid=%""+a_system.uuid.out+"%"")
			l_target := a_system.library_target
			if l_target /= Void then
				append_text (" library_target=%""+l_target.name+"%"")
			end
			append_text (">%N")
			indent := indent + 1
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
			l_sort_lst: SORTED_TWO_WAY_LIST [STRING]
		do
			current_target := a_target
			append_text_indent ("<target name=%""+a_target.name+"%"")
			if a_target.extends /= Void then
				text.append (" extends=%""+a_target.extends.name+"%"")
			end
			append_text (">%N")
			indent := indent + 1
			append_description_tag (a_target.description)
			l_root := a_target.internal_root
			if l_root /= Void then
				create l_a_name.make (4)
				create l_a_val.make (4)
				l_a_name.force ("cluster")
				l_a_val.force (l_root.cluster_name)
				l_a_name.force ("class")
				l_a_val.force (l_root.class_name)
				l_a_name.force ("feature")
				l_a_val.force (l_root.feature_name)
				if l_root.is_all_root then
					l_a_name.force ("all_classes")
					l_a_val.force (l_root.is_all_root.out.as_lower)
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
				create l_sort_lst.make
				l_sort_lst.fill (l_settings.current_keys)
				l_sort_lst.sort
				l_sort_lst.start
			until
				l_sort_lst.after
			loop
				create l_a_name.make (2)
				l_a_name.force ("name")
				l_a_name.force ("value")
				create l_a_val.make (1)
				l_a_val.force (l_sort_lst.item)
				l_a_val.force (l_settings.item (l_sort_lst.item))
				append_tag ("setting", Void, l_a_name, l_a_val)
				l_sort_lst.forth
			end
			append_externals (a_target.internal_external_include, "include")
			append_externals (a_target.internal_external_object, "object")
			append_externals (a_target.internal_external_ressource, "ressource")
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

			if a_target.precompile /= Void then
				a_target.precompile.process (Current)
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
					append_text (" assembly_name=%""+l_str+"%"")
				end
				l_str := an_assembly.assembly_version
				if l_str /= Void and then not l_str.is_empty then
					append_text (" assembly_version=%""+l_str+"%"")
				end
				l_str := an_assembly.assembly_culture
				if l_str /= Void and then not l_str.is_empty then
					append_text (" assembly_culture=%""+l_str+"%"")
				end
				l_str := an_assembly.assembly_public_key_token
				if l_str /= Void and then not l_str.is_empty then
					append_text (" assembly_key=%""+l_str+"%"")
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
			append_val_group (a_library)
			append_post_group ("library")
		ensure then
			indent_back: indent = old indent
		end

	process_precompile (a_precompile: CONF_PRECOMPILE) is
			-- Visit `a_precompile'.
		do
			append_pre_group ("precompile", a_precompile)
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
						append_text_indent ("<overrides group=%""+l_overrides.item.name+"%"/>%N")
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
			l_sort_lst: SORTED_TWO_WAY_LIST [STRING]
		do
			from
				create l_sort_lst.make
				l_sort_lst.fill (a_groups.current_keys)
				l_sort_lst.sort
				l_sort_lst.start
			until
				l_sort_lst.after
			loop
				a_groups.item (l_sort_lst.item).process (Current)
				l_sort_lst.forth
			end
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
						append_text ("=%""+l_val+"%"")
					end
					an_attribute_names.forth
					an_attribute_values.forth
				end
			end
			if a_value /= Void and not a_value.is_empty then
				append_text (">"+a_value+"</"+a_name+">%N")
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

	append_conditionals (a_conditions: ARRAYED_LIST [INTEGER]) is
			-- Append `a_conditions'.
		local
			l_condition: INTEGER
			l_name: STRING
			l_tag: STRING
			l_a_name, l_a_val: ARRAYED_LIST [STRING]
		do
			if a_conditions /= Void then
				from
					a_conditions.start
				until
					a_conditions.after
				loop
					l_condition := a_conditions.item
					l_name := get_platform_name (l_condition)
					if l_name = Void then
						l_tag := "ifnot"
						l_condition := l_condition.bit_not
					else
						l_tag := "if"
					end
					create l_a_name.make (2)
					l_a_name.extend ("platform")
					l_a_name.extend ("build")
					create l_a_val.make (2)
					l_a_val.extend (get_platform_name (l_condition).as_lower)
					l_a_val.extend (get_build_name (l_condition).as_lower)
					append_tag (l_tag, Void, l_a_name, l_a_val)
					a_conditions.forth
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
					append_text (" location=%""+l_ext.location.original_path+"%">%N")
					indent := indent + 1
					last_count := text.count

					l_desc := l_ext.description
					if l_desc /= Void and not l_desc.is_empty then
						append_tag ("description", l_desc, Void, Void)
					end
					append_conditionals (l_ext.internal_enabled)
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
				append_text (" command=%""+l_action.command+"%">%N")
				indent := indent + 1
				append_description_tag (l_action.description)
				append_conditionals (l_action.internal_enabled)
				indent := indent - 1
				append_text_indent ("</"+a_name+"_compile_action>%N")
				an_actions.forth
			end
		end

	append_file_rule (a_file_rule: CONF_FILE_RULE) is
			-- Append `a_file_rule'
		local
			l_pattern: LINKED_SET [STRING]
		do
			if not a_file_rule.is_empty then
				append_text_indent ("<file_rule>%N")
				indent := indent + 1
				append_description_tag (a_file_rule.description)
				l_pattern := a_file_rule.exclude
				if l_pattern /= Void then
					from
						l_pattern.start
					until
						l_pattern.after
					loop
						append_tag ("exclude", l_pattern.item, Void, Void)
						l_pattern.forth
					end
				end
				l_pattern := a_file_rule.include
				if l_pattern /= Void then
					from
						l_pattern.start
					until
						l_pattern.after
					loop
						append_tag ("include", l_pattern.item, Void, Void)
						l_pattern.forth
					end
				end
				indent := indent - 1
				append_text_indent ("</file_rule>%N")
			end
		end


	append_options (an_options: CONF_OPTION; a_class: STRING) is
			-- Append `an_options', optionally for `a_class'.
		local
			l_str: STRING
			l_debugs, l_warnings: HASH_TABLE [BOOLEAN, STRING]
			l_assertions: CONF_ASSERTIONS
			l_a_name, l_a_val: ARRAYED_LIST [STRING]
			l_sort_lst: SORTED_TWO_WAY_LIST [STRING]
		do
			if an_options /= Void then
				if a_class /= Void and then not a_class.is_empty then
					append_text_indent ("<class_option class=%""+a_class+"%"")
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
				l_str := an_options.namespace
				if l_str /= Void and then not l_str.is_empty then
					append_text (" namespace=%""+l_str+"%"")
				end
				append_text (">%N")

				indent := indent + 1
				append_description_tag (an_options.description)

				l_debugs := an_options.debugs
				if l_debugs /= Void and then not l_debugs.is_empty then
					create l_sort_lst.make
					l_sort_lst.fill (l_debugs.current_keys)
					l_sort_lst.sort
					from
						l_sort_lst.start
					until
						l_sort_lst.after
					loop
						append_text_indent ("<debug name=%""+l_sort_lst.item+"%"")
						append_text (" enabled=%""+l_debugs.item (l_sort_lst.item).out.as_lower+"%"/>%N")
						l_sort_lst.forth
					end
				end

				l_assertions := an_options.assertions
				if l_assertions /= Void then
					create l_a_name.make (5)
					l_a_name.extend ("precondition")
					l_a_name.extend ("postcondition")
					l_a_name.extend ("check")
					l_a_name.extend ("invariant")
					l_a_name.extend ("loop")

					create l_a_val.make (5)
					l_a_val.extend (l_assertions.is_precondition.out.as_lower)
					l_a_val.extend (l_assertions.is_postcondition.out.as_lower)
					l_a_val.extend (l_assertions.is_check.out.as_lower)
					l_a_val.extend (l_assertions.is_invariant.out.as_lower)
					l_a_val.extend (l_assertions.is_loop.out.as_lower)
					append_tag ("assertions", Void, l_a_name, l_a_val)
				end

				if an_options.warnings /= Void then
					l_warnings := an_options.warnings.internal_warnings
				end
				if l_warnings /= Void and then not l_warnings.is_empty then
					from
						l_warnings.start
					until
						l_warnings.after
					loop
						append_text_indent ("<warning name=%""+l_warnings.key_for_iteration.as_lower+"%"")
						append_text (" enabled=%""+l_warnings.item_for_iteration.out.as_lower+"%"/>%N")
						l_warnings.forth
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

	append_pre_group (a_tag: STRING; a_group: CONF_GROUP) is
			-- Append the things that start the entry for `a_group'
		require
			a_group_not_void: a_group /= Void
			a_tag_ok: a_tag /= Void and then not a_tag.is_empty
		local
			l_str: STRING
		do
			l_str := a_group.location.original_path
			if l_str.is_empty then
				l_str := "none"
			end
			append_text_indent ("<"+a_tag+" name=%""+a_group.name+"%"")
			append_text (" location=%""+l_str+"%"")
			if a_group.is_readonly then
				append_text (" readonly=%"true%"")
			end
			l_str := a_group.name_prefix
			if l_str /= Void and then not l_str.is_empty then
				append_text (" prefix=%""+l_str+"%"")
			end
		end

	append_val_group (a_group: CONF_GROUP) is
			-- Append the things that come in the value part of `a_group'.
		require
			a_group_not_void: a_group /= Void
		local
			l_renaming: HASH_TABLE [STRING, STRING]
			l_c_opt: HASH_TABLE [CONF_OPTION, STRING]
			l_cond: ARRAYED_LIST [INTEGER]
		do
			append_text (">%N")
			indent := indent + 1
			last_count := text.count
			append_description_tag (a_group.description)
				-- don't append default assembly conditional
			l_cond := a_group.internal_enabled
			if l_cond /= Void and then not a_group.is_assembly or not a_group.is_enabled (pf_dotnet, build_all) then
				append_conditionals (l_cond)
			end
			append_options (a_group.internal_options, Void)
			l_renaming := a_group.renaming
			if l_renaming /= Void then
				from
					l_renaming.start
				until
					l_renaming.after
				loop
					append_text_indent ("<renaming old_name=%""+l_renaming.key_for_iteration+"%" new_name=%""+l_renaming.item_for_iteration+"%"/>%N")
					l_renaming.forth
				end
			end
			l_c_opt := a_group.class_options
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
		end

	append_val_cluster (a_cluster: CONF_CLUSTER) is
			-- Append the values for `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			l_deps: LINKED_SET [CONF_GROUP]
			l_visible: HASH_TABLE [TUPLE [STRING, HASH_TABLE [STRING, STRING]], STRING]
			l_vis_feat: HASH_TABLE [STRING, STRING]
			l_class: STRING
			l_feat, l_feat_rename, l_class_rename: STRING
			l_clusters: HASH_TABLE [CONF_CLUSTER, STRING]
			l_cluster: CONF_CLUSTER
			l_name: STRING
			l_sort_lst: SORTED_TWO_WAY_LIST [STRING]
		do
			append_file_rule (a_cluster.internal_file_rule)
			l_deps := a_cluster.internal_dependencies
			if l_deps /= Void then
				from
					l_deps.start
				until
					l_deps.after
				loop
					append_text_indent ("<uses group=%""+l_deps.item.name+"%"/>%N")
					l_deps.forth
				end
			end
			l_visible := a_cluster.visible
			if l_visible /= Void then
				from
					l_visible.start
				until
					l_visible.after
				loop
					l_class := l_visible.key_for_iteration
					l_class_rename ?= l_visible.item_for_iteration.item (1)
					l_vis_feat ?= l_visible.item_for_iteration.item (2)
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
						append_text_indent ("<visible class=%""+l_class+"%"")
						if l_feat /= Void then
							append_text (" feature=%""+l_feat+"%"")
						end
						if l_class_rename /= Void and then not l_class_rename.is_empty and then not l_class_rename.is_equal (l_class) then
							append_text (" class_rename=%""+l_class_rename+"%"")
						end
						if l_feat_rename /= Void and then not l_feat_rename.is_empty then
							append_text (" feature_rename=%""+l_feat_rename+"%"")
						end
						append_text ("/>%N")
						l_vis_feat.forth
					end
					l_visible.forth
				end
			end
				-- look for subclusters
			from
				l_name := a_cluster.name
				l_clusters := current_target.internal_clusters.twin
				create l_sort_lst.make
				l_sort_lst.fill (l_clusters.current_keys)

				l_sort_lst.start
			until
				l_sort_lst.after
			loop
				l_cluster := l_clusters.item (l_sort_lst.item)
				if l_cluster.parent /= Void and then l_cluster.parent.name.is_equal (l_name) then
					current_is_subcluster := True
					l_cluster.process (Current)
				end
				l_sort_lst.forth
			end
		end

end

