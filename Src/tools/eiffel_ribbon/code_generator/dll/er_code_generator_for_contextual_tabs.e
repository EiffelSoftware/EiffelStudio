note
	description: "Summary description for {ER_CODE_GENERATOR_FOR_CONTEXTUAL_TABS}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_CODE_GENERATOR_FOR_CONTEXTUAL_TABS

feature -- Command

	generate_contextual_tabs_class (a_ribbon_contextual_tabs: EV_TREE_NODE)
			--
		require
			not_void: a_ribbon_contextual_tabs /= Void
			valid: a_ribbon_contextual_tabs.text.same_string ({ER_XML_CONSTANTS}.ribbon_contextual_tabs)
		local
			l_item: EV_TREE_NODE
		do
			from
				a_ribbon_contextual_tabs.start
			until
				a_ribbon_contextual_tabs.after
			loop
				l_item := a_ribbon_contextual_tabs.item
				if l_item.text.same_string ({ER_XML_CONSTANTS}.tab_group) then
					generate_contextual_tabs_class_tab_group (l_item, a_ribbon_contextual_tabs.index)
				end

				a_ribbon_contextual_tabs.forth
			end
		end

	window_contextual_tabs (a_tree: EV_TREE; a_list_index: INTEGER; a_last_string: STRING)
			-- For EV_RIBBON_TITLED_WIDNOW_CLASS
		require
			not_void: a_tree /= Void
			not_void: a_last_string /= Void
		local
			l_found: BOOLEAN
			l_creation_string, l_register_string,l_declaration_string: STRING
			l_toolbars_or_menus: EV_TREE_NODE
		do
			from
				a_tree.start
			until
				a_tree.after or l_found
			loop
				if a_tree.item.text.same_string ({ER_XML_CONSTANTS}.ribbon_contextual_tabs) then
					l_found := True

					from
						create l_creation_string.make_empty
						create l_register_string.make_empty
						create l_declaration_string.make_empty

						l_toolbars_or_menus := a_tree.item
						l_toolbars_or_menus.start
					until
						l_toolbars_or_menus.after
					loop
						if l_toolbars_or_menus.item.text.same_string ({ER_XML_CONSTANTS}.tab_group) then

							l_creation_string.append (tab_group_creation_string (l_toolbars_or_menus.item, l_toolbars_or_menus.index))
							l_register_string.append (tab_group_registry_string (l_toolbars_or_menus.item))
							l_declaration_string.append (tab_group_declaration_string (l_toolbars_or_menus.item, l_toolbars_or_menus.index))
						end
						l_toolbars_or_menus.forth
					end

					a_last_string.replace_substring_all ("$TAB_GROUP_NAME", "%N" + l_declaration_string)
					a_last_string.replace_substring_all ("$TAB_GROUP_CREATION", "%N" + l_creation_string)
					a_last_string.replace_substring_all ("$TAB_GROUP_REGISTER", "%N" + l_register_string)
				end
				a_tree.forth
			end

			if not l_found then
				-- Remove help button tags
				a_last_string.replace_substring_all ("$TAB_GROUP_NAME", "")
				a_last_string.replace_substring_all ("$TAB_GROUP_CREATION", "")
				a_last_string.replace_substring_all ("$TAB_GROUP_REGISTER", "")
			end
		end

feature {NONE} -- Implemenation

	generate_contextual_tabs_class_tab_group (a_tab_group: EV_TREE_NODE; a_index: INTEGER)
			--
		require
			not_void: a_tab_group /= Void
			valid: a_tab_group.text.same_string ({ER_XML_CONSTANTS}.tab_group)
		local
			l_tab_count: INTEGER
			l_file, l_dest_file: RAW_FILE
			l_constants: ER_MISC_CONSTANTS
			l_file_name, l_dest_file_name: FILE_NAME
			l_singleton: ER_SHARED_SINGLETON
			l_sub_dir, l_tool_bar_file, l_sub_imp_dir, l_tool_bar_tab_imp_file: STRING
			l_last_string: STRING
			l_tab_creation_string, l_tab_registry_string, l_tab_declaration_string: STRING
			l_identifier_name: detachable STRING
		do
			-- First check how many contextual tabs
			l_tab_count := a_tab_group.count

			create l_singleton
			create l_constants

			l_sub_dir := "code_generated_once_change_by_user"
			l_tool_bar_file := "ribbon_tab_group_imp"
			l_sub_imp_dir := "code_generated_everytime"
			l_tool_bar_tab_imp_file := "ribbon_tab_group"

			if attached l_singleton.project_info_cell.item as l_project_info then
				if attached l_project_info.project_location as l_project_location then

					if attached {ER_TREE_NODE_TAB_GROUP_DATA} a_tab_group.data as l_data
						and then attached l_data.command_name as l_identifier
						and then not l_identifier.is_empty then
						l_identifier_name := l_identifier
					end

					-- Generate tab group class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_dir)
					l_file_name.set_file_name (l_tool_bar_file + ".e")
					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						if l_identifier_name /= Void then
							l_dest_file_name.set_file_name (l_identifier_name.as_lower + "_imp.e")
						else
							if a_index /= 1 then
								l_dest_file_name.set_file_name ("tab_group_imp_" + a_index.out + ".e")
							else
								l_dest_file_name.set_file_name ("tab_group_imp" + ".e")
							end
						end

						create l_dest_file.make_create_read_write (l_dest_file_name)
						from
							l_file.open_read
							l_file.start
							l_tab_creation_string := tab_creation_string (a_tab_group)
							l_tab_registry_string := tab_registry_string (a_tab_group)
							l_tab_declaration_string := tab_declaration_string (a_tab_group)
						until
							l_file.after
						loop
							l_file.read_line
							l_last_string := l_file.last_string
							l_last_string.replace_substring_all ("$TAB_CREATION", l_tab_creation_string)
							l_last_string.replace_substring_all ("$TAB_REGISTRY", l_tab_registry_string)
							l_last_string.replace_substring_all ("$TAB_DECLARATION", l_tab_declaration_string)
							if l_identifier_name /= Void then
								l_last_string.replace_substring_all ("$INDEX", l_identifier_name.as_upper + "_IMP")
							else
								if a_index = 1 then
									l_last_string.replace_substring_all ("$INDEX", "TAB_GROUP_IMP")
								else
									l_last_string.replace_substring_all ("$INDEX", "TAB_GROUP_IMP_" + a_index.out)
								end
							end

							l_dest_file.put_string (l_last_string + "%N")
						end

						l_file.close
						l_dest_file.close
					end

					-- Generate tool bar tab imp class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_imp_dir)
					l_file_name.set_file_name (l_tool_bar_tab_imp_file + ".e")

					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						if l_identifier_name /= Void then
							l_dest_file_name.set_file_name (l_identifier_name.as_lower + ".e")
							create l_dest_file.make (l_dest_file_name)
						else
							l_dest_file_name.set_file_name (l_tool_bar_tab_imp_file)
							create l_dest_file.make (l_dest_file_name + "_" + a_index.out + ".e")
						end

						-- Don't replace destination file if exists
						if not l_dest_file.exists then
							l_dest_file.create_read_write
							from
								l_file.open_read
								l_file.start
							until
								l_file.after
							loop
								-- replace/add tab codes here
								l_file.read_line
								l_last_string := l_file.last_string
								if l_identifier_name /= Void then
									l_last_string.replace_substring_all ("$INDEX_1", l_identifier_name.as_upper)
									l_last_string.replace_substring_all ("$INDEX_2", l_identifier_name.as_upper + "_IMP")
								else
									l_last_string.replace_substring_all ("$INDEX_1", "TAB_GROUP" + a_index.out)
									l_last_string.replace_substring_all ("$INDEX_2", "TAB_GROUP_IMP_" + a_index.out)
								end
								l_dest_file.put_string (l_last_string + "%N")
							end

							l_file.close
							l_dest_file.close
						end

					end

				end
			end

				-- Generate tab classes
			from
				a_tab_group.start
			until
				a_tab_group.after
			loop
				check a_tab_group.item.text.same_string ({ER_XML_CONSTANTS}.tab) end
				generate_tab_group_tab_class (a_tab_group.item, a_tab_group.index)
				a_tab_group.forth
			end

		end

	generate_tab_group_tab_class (a_tab_tree_node: EV_TREE_NODE; a_index: INTEGER)
			--
		local
			l_helper: ER_CODE_GENERATOR
		do
			create l_helper.make
			l_helper.generate_tab_class (a_tab_tree_node, a_index)
		end

	tab_creation_string (a_tabs_root_note: EV_TREE_NODE): STRING
			--
		require
			not_void: a_tabs_root_note /= Void
			valid: a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.ribbon_application_menu) or else
				a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.mini_toolbar) or else
				a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.context_menu) or else
				a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.tab_group)
		local
			l_count, l_index: INTEGER
			l_template, l_command_string: STRING
			l_generated: detachable STRING
		do
			create Result.make_empty
			l_template := "%T%T%Tcreate $INDEX.make_with_command_list ($COMMAND_IDS)"

			from
				l_index := 1
				l_count := a_tabs_root_note.count
			until
				l_count < l_index
			loop
				l_generated := l_template.twin

				if attached {ER_TREE_NODE_DATA} a_tabs_root_note.i_th (l_index).data as l_group_data then
					if attached l_group_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_command_string := "<<{" + {ER_CODE_GENERATOR}.command_name_constants.as_upper + "}." + l_command_name + ">>"
						l_generated.replace_substring_all ("$INDEX", l_command_name.as_lower)
					else
						l_command_string := "<<>>"
						l_generated.replace_substring_all ("$INDEX", "tab_" + l_index.out)
					end
				else
					l_command_string := "<<>>"
					l_generated.replace_substring_all ("$INDEX", "tab_" + l_index.out)
				end
				l_generated.replace_substring_all ("$COMMAND_IDS", l_command_string)
				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

	tab_registry_string (a_tabs_root_note: EV_TREE_NODE): STRING
			--
		require
			not_void: a_tabs_root_note /= Void
			valid: a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.ribbon_application_menu) or else
				a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.mini_toolbar) or else
				a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.context_menu) or else
				a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.tab_group)
		local
			l_count, l_index: INTEGER
			l_template: STRING
			l_generated: detachable STRING
		do
			--"tabs.extend (tab_1)"
			create Result.make_empty
			l_template := "%T%T%Ttabs.extend ($SUB_ITEM)"

			from
				l_index := 1
				l_count := a_tabs_root_note.count
			until
				l_count < l_index
			loop
				l_generated := l_template.twin
				if attached {ER_TREE_NODE_DATA} a_tabs_root_note.i_th (l_index).data as l_tab_data then
					if attached l_tab_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_generated.replace_substring_all ("$SUB_ITEM", l_command_name.as_lower)
					else
						l_generated.replace_substring_all ("$SUB_ITEM", "tab_" + l_index.out)
					end
				else
					l_generated.replace_substring_all ("$SUB_ITEM", "tab_" + l_index.out)
				end

				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

	tab_declaration_string (a_tabs_root_note: EV_TREE_NODE): STRING
			--
		require
			not_void: a_tabs_root_note /= Void
			valid: a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.ribbon_application_menu) or else
				a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.mini_toolbar) or else
				a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.context_menu) or else
				a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.tab_group)
		local
			l_count, l_index: INTEGER
			l_template: STRING
			l_generated: detachable STRING
		do
			create Result.make_empty
			l_template := "%T$INDEX_1: $INDEX_2"

			from
				l_index := 1
				l_count := a_tabs_root_note.count
			until
				l_count < l_index
			loop
				l_generated := l_template.twin
				if attached {ER_TREE_NODE_DATA} a_tabs_root_note.i_th (l_index).data as l_tab_data then
					if attached l_tab_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_generated.replace_substring_all ("$INDEX_1", l_command_name.as_lower)
						l_generated.replace_substring_all ("$INDEX_2", l_command_name.as_upper)
					else
						l_generated.replace_substring_all ("$INDEX_1", "tab_" + l_index.out)
						l_generated.replace_substring_all ("$INDEX_2", "RIBBON_TAB_GROUP_" + l_index.out)
					end
				else
					l_generated.replace_substring_all ("$INDEX_1", "tab_" + l_index.out)
					l_generated.replace_substring_all ("$INDEX_2", "RIBBON_TAB_GROUP_" + l_index.out)
				end
				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

feature {NONE} -- Implementation for main window

	tab_group_creation_string (a_tabs_root_note: EV_TREE_NODE; a_index: INTEGER): STRING
			--
		require
			not_void: a_tabs_root_note /= Void
			valid: a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.tab_group)
		local
			l_template: STRING
			l_generated, l_command_string: detachable STRING
			l_gen_default: BOOLEAN
		do
			create Result.make_empty
			l_template := "%T%T%Tcreate $INDEX.make_with_command_list ($COMMAND_IDS)"

			l_gen_default := False
			l_generated := l_template.twin

			if attached {ER_TREE_NODE_DATA} a_tabs_root_note.data as l_group_data then
				if attached l_group_data.command_name as l_command_name and then not l_command_name.is_empty then
					l_command_string := "<<{" + {ER_CODE_GENERATOR}.command_name_constants.as_upper + "}." + l_command_name + ">>"
					l_generated.replace_substring_all ("$INDEX", l_command_name.as_lower)
				else
					l_gen_default := True
				end
			else
				l_gen_default := True
			end
			if l_gen_default then
				l_command_string := "<<>>"
				l_generated.replace_substring_all ("$INDEX", "tab_group_" + a_index.out)
			end
			if l_command_string /= Void then
				l_generated.replace_substring_all ("$COMMAND_IDS", l_command_string)
			end

			if l_generated /= Void then
				Result.append (l_generated + "%N")
			end

		end

	tab_group_registry_string (a_tabs_root_note: EV_TREE_NODE): STRING
			--
		require
			not_void: a_tabs_root_note /= Void
			valid: a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.tab_group)
		local
			l_index: INTEGER
			l_template: STRING
			l_generated: detachable STRING
			l_gen_default: BOOLEAN
		do
			--"tabs.extend (tab_1)"
			create Result.make_empty

			l_template := "%T%T%Tcontextual_tabs.extend ($TAB_GROUP)"

			l_gen_default := False
			l_generated := l_template.twin
			if attached {ER_TREE_NODE_DATA} a_tabs_root_note.data as l_tab_data then
				if attached l_tab_data.command_name as l_command_name and then not l_command_name.is_empty then
					l_generated.replace_substring_all ("$TAB_GROUP", l_command_name.as_lower)
				else
					l_gen_default := True
				end
			else
				l_gen_default := True
			end
			if l_gen_default then
				l_generated.replace_substring_all ("$TAB_GROUP", "tab_group_" + l_index.out)
			end

			if l_generated /= Void then
				Result.append (l_generated + "%N")
			end

		end

	tab_group_declaration_string (a_tabs_root_note: EV_TREE_NODE; a_index: INTEGER): STRING
			--
		require
			not_void: a_tabs_root_note /= Void
			valid: a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.tab_group)
		local
			l_template: STRING
			l_generated: detachable STRING
			l_gen_default: BOOLEAN
		do
			create Result.make_empty
			l_template := "%T$INDEX_1: $INDEX_2"
			l_template.append ("%N%T%T%T-- Tab group")

			l_gen_default := False
			l_generated := l_template.twin
			if attached {ER_TREE_NODE_DATA} a_tabs_root_note.data as l_tab_data then
				if attached l_tab_data.command_name as l_command_name and then not l_command_name.is_empty then
					l_generated.replace_substring_all ("$INDEX_1", l_command_name.as_lower)
					l_generated.replace_substring_all ("$INDEX_2", l_command_name.as_upper)
				else
					l_gen_default := True
				end
			else
				l_gen_default := True
			end
			if l_gen_default then
				l_generated.replace_substring_all ("$INDEX_1", "tab_group_" + a_index.out)
				l_generated.replace_substring_all ("$INDEX_2", "TAB_GROUP_" + a_index.out)
			end

			if l_generated /= Void then
				Result.append (l_generated + "%N")
			end

		end

end
