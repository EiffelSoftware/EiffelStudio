note
	description: "[
					Code generator for context popup when using DLL
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_CODE_GENERATOR_FOR_CONTEXT_POPUP

feature -- Command

	generate_context_popup_class (a_context_popup_root: EV_TREE_ITEM)
			-- Generate context popup class
		do
			from
				a_context_popup_root.start
			until
				a_context_popup_root.after
			loop
				if attached {EV_TREE_ITEM} a_context_popup_root.item as l_minitoolbar_root and then
					l_minitoolbar_root.text.same_string_general ({ER_XML_CONSTANTS}.context_popup_mini_toolbars) then
					from
						l_minitoolbar_root.start
					until
						l_minitoolbar_root.after
					loop
						if attached {EV_TREE_ITEM} l_minitoolbar_root.item as l_one_mini_toolbar then
							generate_context_minitoolbar_or_menu_class (l_one_mini_toolbar, l_minitoolbar_root.index, "ribbon_mini_toolbar")

						end

						l_minitoolbar_root.forth
					end
				elseif attached {EV_TREE_ITEM} a_context_popup_root.item as l_context_menu_root and then
					l_context_menu_root.text.same_string_general ({ER_XML_CONSTANTS}.context_popup_context_menus)  then
					from
						l_context_menu_root.start
					until
						l_context_menu_root.after
					loop
						if attached {EV_TREE_ITEM} l_context_menu_root.item as l_one_context_menu then
							generate_context_minitoolbar_or_menu_class (l_one_context_menu, l_context_menu_root.index, "ribbon_context_menu")
						end

						l_context_menu_root.forth
					end
				end
				a_context_popup_root.forth
			end
		end

feature -- For EV_RIBBON_TITLED_WIDNOW_CLASS

	window_context_popups (a_tree: EV_TREE; a_list_index: INTEGER; a_last_string: STRING)
			-- Generate context popups codes for main window
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
				if a_tree.item.text.same_string ({ER_XML_CONSTANTS}.context_popup) then
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
						if l_toolbars_or_menus.item.text.same_string ({ER_XML_CONSTANTS}.context_popup_mini_toolbars) then

							l_creation_string.append (context_popup_creation_string (l_toolbars_or_menus.item, True))
							l_register_string.append (context_popup_registry_string (l_toolbars_or_menus.item, True))
							l_declaration_string.append (context_popup_declaration_string (l_toolbars_or_menus.item, True))

						elseif l_toolbars_or_menus.item.text.same_string ({ER_XML_CONSTANTS}.context_popup_context_menus) then
							l_creation_string.append (context_popup_creation_string (l_toolbars_or_menus.item, False))
							l_register_string.append (context_popup_registry_string (l_toolbars_or_menus.item, False))
							l_declaration_string.append (context_popup_declaration_string (l_toolbars_or_menus.item, False))
						end
						l_toolbars_or_menus.forth
					end

					a_last_string.replace_substring_all ("$CONTEXT_POPUPS_NAME", "%N" + l_declaration_string)

					a_last_string.replace_substring_all ("$CONTEXT_POPUPS_CREATION", "%N" + l_creation_string)
					a_last_string.replace_substring_all ("$CONTEXT_POPUPS_REGISTER", "%N" + l_register_string)
				end
				a_tree.forth
			end

			if not l_found then
				-- Remove help button tags
				a_last_string.replace_substring_all ("$CONTEXT_POPUPS_NAME", "")
				a_last_string.replace_substring_all ("$CONTEXT_POPUPS_CREATION", "")
				a_last_string.replace_substring_all ("$CONTEXT_POPUPS_REGISTER", "")
			end
		end

feature {NONE} -- Implementation

	generate_context_minitoolbar_or_menu_class (a_context_minitoolbar_root: EV_TREE_ITEM; a_index: INTEGER; a_template: STRING)
			-- Generate context minitoolbar or menu codes
		require
			not_void: a_context_minitoolbar_root /= Void
			valid: a_context_minitoolbar_root.text.same_string ({ER_XML_CONSTANTS}.mini_toolbar) or else
					a_context_minitoolbar_root.text.same_string ({ER_XML_CONSTANTS}.context_menu)
		local
			l_tab_count: INTEGER
			l_file, l_dest_file: RAW_FILE
			l_constants: ER_MISC_CONSTANTS
			l_file_name, l_dest_file_name: PATH
			l_singleton: ER_SHARED_TOOLS
			l_sub_dir, l_tool_bar_file, l_sub_imp_dir: STRING
			l_last_string: STRING
			l_tab_creation_string, l_tab_registry_string, l_tab_declaration_string: STRING
			l_identifier_name: detachable STRING
		do
			-- First check how many menu groups
			l_tab_count := a_context_minitoolbar_root.count

			create l_singleton
			l_sub_dir := "code_generated_once_change_by_user"
			l_tool_bar_file := a_template
			l_sub_imp_dir := "code_generated_everytime"

			if attached l_singleton.project_info_cell.item as l_project_info then
				if attached l_project_info.project_location as l_project_location then
					create l_constants
					if attached {ER_TREE_NODE_DATA} a_context_minitoolbar_root.data as l_data
						and then attached l_data.command_name as l_identifier
						and then not l_identifier.is_empty then
						l_identifier_name := l_identifier
					end

					-- Generate tool bar class
					l_file_name := l_constants.template.extended (l_sub_dir)
					l_file_name := l_file_name.extended (l_tool_bar_file + ".e")
					create l_file.make_with_path (l_file_name)
					if l_file.exists and then l_file.is_readable then
						if l_identifier_name /= Void then
							l_dest_file_name := l_project_location.extended (l_identifier_name.as_lower + ".e")
						else
							if a_index /= 1 then
								l_dest_file_name := l_project_location.extended ("application_menu" + "_" + a_index.out + ".e")
							else
								l_dest_file_name := l_project_location.extended ("application_menu" + ".e")
							end
						end

						create l_dest_file.make_with_path (l_dest_file_name)
						l_dest_file.create_read_write
						from
							l_file.open_read
							l_file.start
							l_tab_creation_string := helper.menu_group_creation_string (a_context_minitoolbar_root)
							l_tab_registry_string := helper.menu_group_registry_string (a_context_minitoolbar_root)
							l_tab_declaration_string := helper.menu_group_declaration_string (a_context_minitoolbar_root)
						until
							l_file.after
						loop
							l_file.read_line
							l_last_string := l_file.last_string
							l_last_string.replace_substring_all ("$MENU_GROUP_CREATION", l_tab_creation_string)
							l_last_string.replace_substring_all ("$MENU_GROUP_REGISTRY", l_tab_registry_string)
							l_last_string.replace_substring_all ("$MENU_GROUP_DECLARATION", l_tab_declaration_string)
							if l_identifier_name /= Void then
								l_last_string.replace_substring_all ("$INDEX", l_identifier_name.as_upper)
							else
								if a_index = 1 then
									l_last_string.replace_substring_all ("$INDEX", "APPLICATION_MENU")
								else
									l_last_string.replace_substring_all ("$INDEX", "APPLICATION_MENU_" + a_index.out)
								end
							end

							l_dest_file.put_string (l_last_string + "%N")
						end

						l_file.close
						l_dest_file.close
					end
				end
			end

				-- Generate menu group classes
			from
				a_context_minitoolbar_root.start
			until
				a_context_minitoolbar_root.after
			loop
				check a_context_minitoolbar_root.item.text.same_string ({ER_XML_CONSTANTS}.menu_group) end
				helper.generate_menu_group_class (a_context_minitoolbar_root.item, a_context_minitoolbar_root.index)
				a_context_minitoolbar_root.forth
			end

		end

feature {NONE} -- Implementation

	helper: ER_CODE_GENERATOR_FOR_APPLICATION_MENU
			-- Code generation helper
		once
			create Result
		end

	context_popup_creation_string (a_tabs_root_note: EV_TREE_NODE; a_is_mini_toolbar: BOOLEAN): STRING
			-- Generate context popup creation codes
		require
			not_void: a_tabs_root_note /= Void
			valid: a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.context_popup_mini_toolbars) or else
				a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.context_popup_context_menus)
		local
			l_count, l_index: INTEGER
			l_template: STRING
			l_generated, l_command_string: detachable STRING
			l_gen_default: BOOLEAN
		do
			create Result.make_empty
			l_template := "%T%T%Tcreate $INDEX.make_with_command_list ($COMMAND_IDS)"

			from
				l_index := 1
				l_count := a_tabs_root_note.count
			until
				l_count < l_index
			loop
				l_gen_default := False
				l_generated := l_template.twin

				if attached {ER_TREE_NODE_DATA} a_tabs_root_note.i_th (l_index).data as l_group_data then
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
					if a_is_mini_toolbar then
						l_command_string := "<<>>"
						l_generated.replace_substring_all ("$INDEX", "mini_toolbar_" + l_index.out)
					else
						l_command_string := "<<>>"
						l_generated.replace_substring_all ("$INDEX", "context_menu_" + l_index.out)
					end
				end
				if l_command_string /= Void then
					l_generated.replace_substring_all ("$COMMAND_IDS", l_command_string)
				end

				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

	context_popup_registry_string (a_tabs_root_note: EV_TREE_NODE; a_is_mini_toolbar: BOOLEAN): STRING
			-- Generate context popup registry codes
		require
			not_void: a_tabs_root_note /= Void
			valid: a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.context_popup_mini_toolbars) or else
				a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.context_popup_context_menus)
		local
			l_count, l_index: INTEGER
			l_template: STRING
			l_generated: detachable STRING
			l_gen_default: BOOLEAN
		do
			--"tabs.extend (tab_1)"
			create Result.make_empty
			if a_is_mini_toolbar then
				l_template := "%T%T%Tmini_toolbars.extend ($MENU_GROUP)"
			else
				l_template := "%T%T%Tcontext_menus.extend ($MENU_GROUP)"
			end

			from
				l_index := 1
				l_count := a_tabs_root_note.count
			until
				l_count < l_index
			loop
				l_gen_default := False
				l_generated := l_template.twin
				if attached {ER_TREE_NODE_DATA} a_tabs_root_note.i_th (l_index).data as l_tab_data then
					if attached l_tab_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_generated.replace_substring_all ("$MENU_GROUP", l_command_name.as_lower)
					else
						l_gen_default := True
					end
				else
					l_gen_default := True
				end
				if l_gen_default then
					if a_is_mini_toolbar then
						l_generated.replace_substring_all ("$MENU_GROUP", "mini_toolbar_" + l_index.out)
					else
						l_generated.replace_substring_all ("$MENU_GROUP", "context_popup_" + l_index.out)
					end
				end
				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

	context_popup_declaration_string (a_tabs_root_note: EV_TREE_NODE; a_is_mini_toolbar: BOOLEAN): STRING
			-- Generate context popup declaration codes
		require
			not_void: a_tabs_root_note /= Void
			valid: a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.context_popup_mini_toolbars) or else
				a_tabs_root_note.text.same_string ({ER_XML_CONSTANTS}.context_popup_context_menus)
		local
			l_count, l_index: INTEGER
			l_template: STRING
			l_generated: detachable STRING
			l_gen_default: BOOLEAN
		do
			create Result.make_empty
			l_template := "%T$INDEX_1: $INDEX_2"
			if a_is_mini_toolbar then
				l_template.append ("%N%T%T%T-- Mini toolbar")
			else
				l_template.append ("%N%T%T%T-- Context popup")
			end
			from
				l_index := 1
				l_count := a_tabs_root_note.count
			until
				l_count < l_index
			loop
				l_gen_default := False
				l_generated := l_template.twin
				if attached {ER_TREE_NODE_DATA} a_tabs_root_note.i_th (l_index).data as l_tab_data then
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
					if a_is_mini_toolbar then
						l_generated.replace_substring_all ("$INDEX_1", "mini_toolbar_" + l_index.out)
						l_generated.replace_substring_all ("$INDEX_2", "MINI_TOOLBAR_" + l_index.out)
					else
						l_generated.replace_substring_all ("$INDEX_1", "context_popup_" + l_index.out)
						l_generated.replace_substring_all ("$INDEX_2", "CONTEXT_POPUP_" + l_index.out)
					end
				end

				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end
note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
