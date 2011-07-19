note
	description: "[
					Code generator for Quick Access Toolbar
																						]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_CODE_GENERATOR_FOR_QAT_AM

feature -- Command

	generate_quick_access_toolbar_class (a_qat_root: EV_TREE_ITEM)
			--
		require
			not_void: a_qat_root /= Void
		local
			l_file, l_dest_file: RAW_FILE
			l_constants: ER_MISC_CONSTANTS
			l_file_name, l_dest_file_name: FILE_NAME
			l_singleton: ER_SHARED_SINGLETON
			l_sub_dir, l_tool_bar_file, l_sub_imp_dir: STRING
			l_last_string: STRING
			l_identifier_name: detachable STRING
			l_quick_access_toolbar_node: EV_TREE_NODE
			l_list: ARRAYED_LIST [EV_TREE_NODE]
			l_creation_string, l_registry_string, l_declaration_string: STRING
		do
			create l_singleton
			l_list := l_singleton.layout_constructor_list.first.all_items_with ({ER_XML_CONSTANTS}.ribbon_quick_access_toolbar)
			check one_quick_access_toolbar_at_most: l_list.count <= 1 end
			if l_list.count = 1 then
				l_quick_access_toolbar_node := l_list.first
				l_sub_dir := "code_generated_once_change_by_user"
				l_tool_bar_file := "ribbon_quick_access_toolbar"
				l_sub_imp_dir := "code_generated_everytime"

				if attached l_singleton.project_info_cell.item as l_project_info then
					if attached l_project_info.project_location as l_project_location then
						create l_constants
						if attached {ER_TREE_NODE_QUICK_ACCESS_TOOLBAR_DATA} l_quick_access_toolbar_node.data as l_data
							and then attached l_data.command_name as l_identifier
							and then not l_identifier.is_empty then
							l_identifier_name := l_identifier
						end

						-- Generate Quick Access Toolbar class
						create l_file_name.make_from_string (l_constants.template)
						l_file_name.set_subdirectory (l_sub_dir)
						l_file_name.set_file_name (l_tool_bar_file + ".e")
						create l_file.make (l_file_name)
						if l_file.exists and then l_file.is_readable then
							create l_dest_file_name.make_from_string (l_project_location)
							if l_identifier_name /= Void then
								l_dest_file_name.set_file_name (l_identifier_name.as_lower + ".e")
							else
								l_dest_file_name.set_file_name ("quick_access_toolbar" + ".e")
							end

							create l_dest_file.make_create_read_write (l_dest_file_name)
							from
								l_creation_string := creation_string (a_qat_root)
								l_registry_string := registry_string (a_qat_root)
								l_declaration_string := declaration_string (a_qat_root)

								l_file.open_read
								l_file.start
							until
								l_file.after
							loop
								l_file.read_line
								l_last_string := l_file.last_string

								if l_identifier_name /= Void then
									l_last_string.replace_substring_all ("$INDEX", l_identifier_name.as_upper)
								else
									l_last_string.replace_substring_all ("$INDEX", "QUICK_ACCESS_TOOLBAR")
								end

								l_last_string.replace_substring_all ("$BUTTON_CREATION", l_creation_string)
								l_last_string.replace_substring_all ("$BUTTON_REGISTRY", l_registry_string)
								l_last_string.replace_substring_all ("$BUTTON_DECLARATION", l_declaration_string)

								l_dest_file.put_string (l_last_string + "%N")
							end

							l_file.close
							l_dest_file.close
						end

					end
				end

				generate_sub_items (a_qat_root)
			end

		end

feature {NONE} -- Implementation

	generate_sub_items (a_qat_root: EV_TREE_ITEM)
			--
		require
			not_void: a_qat_root /= Void
		local
			l_gen: ER_CODE_GENERATOR_AM
			l_gen_info: ER_CODE_GENERATOR_INFO
		do
			from
				a_qat_root.start
				create l_gen.make

				create l_gen_info
				l_gen_info.set_default_item_class_imp_name_prefix ("RIBBON_BUTTON_")
				l_gen_info.set_default_item_class_name_prefix ("RIBBON_BUTTON_IMP_")
				l_gen_info.set_item_file ("ribbon_button")
				l_gen_info.set_item_imp_file ("ribbon_button_imp")
			until
				a_qat_root.after
			loop

				l_gen.generate_item_class (a_qat_root.item, l_gen.button_counter + a_qat_root.index, l_gen_info)

				a_qat_root.forth
			end

			l_gen.increase_button_counter (a_qat_root.count)
		end

	creation_string (a_tabs_root_note: EV_TREE_NODE): STRING
			--
		require
			not_void: a_tabs_root_note /= Void
			valid:  a_tabs_root_note.text.is_equal ({ER_XML_CONSTANTS}.ribbon_quick_access_toolbar)
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

				if attached {ER_TREE_NODE_BUTTON_DATA} a_tabs_root_note.i_th (l_index).data as l_group_data then
					if attached l_group_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_command_string := "<<{" + {ER_CODE_GENERATOR}.command_name_constants.as_upper + "}." + l_command_name + ">>"
						l_generated.replace_substring_all ("$INDEX", l_command_name.as_lower)
					else
						l_command_string := "<<>>"
						l_generated.replace_substring_all ("$INDEX", "button_" + l_index.out)
					end
				else
					l_command_string := "<<>>"
					l_generated.replace_substring_all ("$INDEX", "button_" + l_index.out)
				end
				l_generated.replace_substring_all ("$COMMAND_IDS", l_command_string)
				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

	registry_string (a_tabs_root_note: EV_TREE_NODE): STRING
			--
		require
			not_void: a_tabs_root_note /= Void
			valid:  a_tabs_root_note.text.is_equal ({ER_XML_CONSTANTS}.ribbon_quick_access_toolbar)
		local
			l_count, l_index: INTEGER
			l_template: STRING
			l_generated: detachable STRING
		do
			--"tabs.extend (tab_1)"
			create Result.make_empty
			l_template := "%T%T%Tdefault_buttons.extend ($SUB_ITEMS)"

			from
				l_index := 1
				l_count := a_tabs_root_note.count
			until
				l_count < l_index
			loop
				l_generated := l_template.twin
				if attached {ER_TREE_NODE_BUTTON_DATA} a_tabs_root_note.i_th (l_index).data as l_tab_data then
					if attached l_tab_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_generated.replace_substring_all ("$SUB_ITEMS", l_command_name.as_lower)
					else
						l_generated.replace_substring_all ("$SUB_ITEMS", "button_" + l_index.out)
					end
				else
					l_generated.replace_substring_all ("$SUB_ITEMS", "button_" + l_index.out)
				end

				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

	declaration_string (a_tabs_root_note: EV_TREE_NODE): STRING
			--
		require
			not_void: a_tabs_root_note /= Void
			valid:  a_tabs_root_note.text.is_equal ({ER_XML_CONSTANTS}.ribbon_quick_access_toolbar)
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
				if attached {ER_TREE_NODE_BUTTON_DATA} a_tabs_root_note.i_th (l_index).data as l_tab_data then
					if attached l_tab_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_generated.replace_substring_all ("$INDEX_1", l_command_name.as_lower)
						l_generated.replace_substring_all ("$INDEX_2", l_command_name.as_upper)
					else
						l_generated.replace_substring_all ("$INDEX_1", "button_" + l_index.out)
						l_generated.replace_substring_all ("$INDEX_2", "RIBBONT_BUTTON_" + l_index.out)
					end
				else
					l_generated.replace_substring_all ("$INDEX_1", "button_" + l_index.out)
					l_generated.replace_substring_all ("$INDEX_2", "RIBBONT_BUTTON_" + l_index.out)
				end
				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

end
