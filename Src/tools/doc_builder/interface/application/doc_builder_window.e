indexing
	description: "Main application window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOC_BUILDER_WINDOW

inherit
	DOC_BUILDER_WINDOW_IMP
		export 
			{ANY} 
				document_selector,
				document_toc
		end

	TEXT_OBSERVER				
		undefine
			default_create,
			copy
		redefine
			on_cursor_moved,
			on_selection_finished,
			on_text_fully_loaded,
			on_text_edited
		end

	SHARED_OBJECTS
		undefine
			default_create,
			copy
		end

create
	default_create

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			set_root_window (Current)
			create render_factory
			create internal_selector_widgets.make (4)
			
				-- Editor			
			search_control_container.put_front (shared_search_control)
			search_control_container.disable_item_expand (shared_search_control)
			
					-- File Menu
			new_menu_item.select_actions.extend 			(agent open_template_dialog)
			open_menu_item.select_actions.extend 			(agent Shared_document_manager.open_document)
			open_project_menu_item.select_actions.extend 	(agent Shared_project.open)
			save_menu_item.select_actions.extend 			(agent Shared_document_manager.save_document)
			close_file_menu_item.select_actions.extend 		(agent shared_document_manager.close_document)
			exit_menu_item.select_actions.extend 			(agent close_application)
			
					-- Edit Menu
			cut_menu_item.select_actions.extend				(agent Shared_document_editor_commands.cut_selection)
			copy_menu_item.select_actions.extend 			(agent Shared_document_editor_commands.copy_selection)
			paste_menu_item.select_actions.extend 			(agent Shared_document_editor_commands.paste)
			search_menu_item.select_actions.extend 			(agent Shared_document_editor_commands.open_search_dialog)
			parser_menu_item.select_actions.extend 			(agent open_expression_dialog)
			preferences_menu_item.select_actions.extend 	(agent open_preferences_window)
			
					-- View Menu
			element_selector_menu.set_data (element_area)
			element_selector_menu.select_actions.extend 			(agent toggle_view (element_selector_menu))
			types_selector_menu.set_data (type_area)
			types_selector_menu.select_actions.extend 				(agent toggle_view (types_selector_menu))
			doc_selector_menu.set_data (documentation_area)
			doc_selector_menu.select_actions.extend 				(agent toggle_view (doc_selector_menu))
			attribute_selector_menu.set_data (attribute_list_tool)
			attribute_selector_menu.select_actions.extend 			(agent toggle_view (attribute_selector_menu))
			sub_element_menu.set_data (sub_element_tool)
			sub_element_menu.select_actions.extend 					(agent toggle_view (sub_element_menu))
					
					-- Project Menu
			settings_menu_item.select_actions.extend 		(agent open_settings_dialog)
			
					-- Tools Menu
			gen_menu_item.select_actions.extend 			(agent open_generation_dialog)
			validator_menu_item.select_actions.extend 		(agent open_validator_tool)
			expression_menu_item.select_actions.extend 		(agent open_expression_dialog)
			character_menu_item.select_actions.extend 		(agent open_character_dialog)
			shortcuts_menu_item.select_actions.extend 		(agent open_shortcuts_dialog)
			
					-- Help Menu
			about_menu_item.select_actions.extend 			(agent display_about)
			help_menu_item.select_actions.extend 			(agent display_help)
		
					-- Toolbar Events
			toolbar_cut.select_actions.extend 				(agent Shared_document_editor_commands.cut_selection)
			toolbar_copy.select_actions.extend 				(agent Shared_document_editor_commands.copy_selection)
			toolbar_paste.select_actions.extend 			(agent Shared_document_editor_commands.paste)			
			toolbar_xml_format.select_actions.extend		(agent Shared_document_editor_commands.pretty_print_text)
			toolbar_code_format.select_actions.extend 		(agent Shared_document_editor_commands.pretty_format_code_text)
			toolbar_new.select_actions.extend 				(agent Shared_document_manager.create_document)
			toolbar_open.select_actions.extend 				(agent Shared_document_manager.open_document)
			toolbar_save.select_actions.extend 				(agent Shared_document_manager.save_document)
			toolbar_validate.select_actions.extend 			(agent Shared_document_editor_commands.validate_document)
			toolbar_link_check.select_actions.extend		(agent Shared_document_editor_commands.validate_document_links)
			toolbar_html_generator.select_actions.extend 	(agent shared_web_browser.refresh)
			toolbar_properties.select_actions.extend 		(agent open_document_properties_dialog)
			output_combo.select_actions.extend 				(agent update_output_filter)
											
					-- TOC Widget Events
			toc_new_button.select_actions.extend 			(agent open_new_toc_dialog)
			toc_open_button.select_actions.extend 			(agent Shared_toc_manager.open_toc)
			toc_save_button.select_actions.extend 			(agent Shared_toc_manager.save_toc)
			toc_list_button.select_actions.extend 			(agent show_loaded_tocs)
			toc_sort_button.select_actions.extend 			(agent open_toc_properties_dialog)
			toc_new_heading.select_actions.extend 			(agent Shared_toc_manager.new_node (True))
			toc_new_page.select_actions.extend 				(agent Shared_toc_manager.new_node (False))
			toc_remove_topic.select_actions.extend 			(agent Shared_toc_manager.remove_node)
			toc_move_up_button.select_actions.extend 		(agent Shared_toc_manager.move_node (True))
			toc_move_down_button.select_actions.extend 		(agent Shared_toc_manager.move_node (False))
			toc_merge_button.select_actions.extend 			(agent open_toc_merge_dialog)
				
					-- Misc Interface Events
			attribute_list_close.select_actions.extend 		(agent attribute_selector_menu.disable_select)
			attribute_list_close.select_actions.extend 		(agent show_hide_widget (attribute_list_tool, False))
			sub_element_close.select_actions.extend 		(agent sub_element_menu.disable_select)
			sub_element_close.select_actions.extend 		(agent show_hide_widget (sub_element_tool, False))
			node_properties_close.select_actions.extend 	(agent show_hide_widget (node_properties_tool, False))
			

				-- Initial setup
			browser_container.extend (shared_web_browser)
			output_combo.disable_edit
			output_combo.change_actions.extend (agent update_output_filter)					
			update			
			close_request_actions.extend (agent close_application)
		end

feature -- Commands

	render_schema is
			-- Render interface according to loaded schema
		require
			schema_loaded: Shared_document_manager.has_schema
		do
			element_selector.wipe_out
			type_selector.wipe_out
			render_factory.element_tree_render (Shared_document_manager.schema, element_selector)
			render_factory.type_tree_render (Shared_document_manager.schema, type_selector)
			element_selector.recursive_do_all (agent connect_item_actions)
		end	

feature -- Interface Events	
		
	show_hide_widget (a_widget: EV_WIDGET; show_flag: BOOLEAN) is	
			-- Show or hide widget according to `show_flag'
		local
			l_text: STRING
			l_list: ARRAYED_LIST [STRING]
			done: BOOLEAN
			l_widget: EV_WIDGET
		do
			if show_flag then
				if internal_selector_widgets.has_item (a_widget) then
					selector.extend (a_widget)
					create l_list.make_from_array (internal_selector_widgets.current_keys)
					from
						l_list.start
					until
						l_list.after or done
					loop
						l_text := l_list.item
						l_widget := internal_selector_widgets.item (l_text)
						done := l_widget = a_widget
						l_list.forth
					end
					selector.set_item_text (a_widget, l_text)
				else
					a_widget.show
				end				
			else
				if selector.has (a_widget) then
					if not internal_selector_widgets.has_item (a_widget) then
						internal_selector_widgets.extend (a_widget, selector.item_text (a_widget))
					end				
					selector.prune (a_widget)
				else
					a_widget.hide
				end				
			end
		end
		
	toggle_view (a_item: EV_CHECK_MENU_ITEM) is
			-- Toggle view
		local
			l_data: EV_WIDGET
		do
			l_data ?= a_item.data
			show_hide_widget (l_data, a_item.is_selected)
		end	

	update_toolbar is
			-- Update the toolbar
		local			
			l_curr_doc: DOCUMENT
			l_text: EDITABLE_TEXT
		do
			if shared_project.is_valid then
				toggle_sensitivity (toolbar_new, True)
				toggle_sensitivity (toolbar_open, True)
			else
				toggle_sensitivity (toolbar_new, False)
				toggle_sensitivity (toolbar_open, False)
			end
			if shared_document_manager.has_open_document then
				l_text := shared_document_manager.current_editor.text_displayed
				l_curr_doc := shared_document_manager.current_document
				
						-- Document
				toggle_sensitivity (toolbar_copy, l_text.has_selection)
				toggle_sensitivity (toolbar_cut, l_text.has_selection)
				toggle_sensitivity (toolbar_paste, not shared_document_manager.current_editor.clipboard_empty)					
				toggle_sensitivity (toolbar_xml_format, True)
				toggle_sensitivity (toolbar_code_format, l_text.has_selection)				
				toggle_sensitivity (toolbar_link_check, True)
				toggle_sensitivity (toolbar_html_generator, True)
				
						-- Validation and properties
				if shared_document_manager.has_schema then
					toggle_sensitivity (toolbar_validate, True)
					toggle_sensitivity (toolbar_properties, True)
				end					
				
						-- Filtering
				output_combo.enable_sensitive
			else
						-- Save
				toggle_sensitivity (toolbar_save, False)
				
						-- Document
				toggle_sensitivity (toolbar_copy, False)
				toggle_sensitivity (toolbar_cut, False)
				toggle_sensitivity (toolbar_paste, False)					
				toggle_sensitivity (toolbar_xml_format, False)
				toggle_sensitivity (toolbar_code_format, False)
				toggle_sensitivity (toolbar_link_check, False)
				toggle_sensitivity (toolbar_html_generator, False)
				
						-- Validation
				toggle_sensitivity (toolbar_validate, False)
				
						-- Properties
				toggle_sensitivity (toolbar_properties, False)
				
						-- Filtering
				output_combo.disable_sensitive
			end					
		end
		
	update_menus is
			-- Update the menus
		local
			l_curr_doc: DOCUMENT
			l_text: EDITABLE_TEXT
			l_name: STRING
		do
			if Shared_project.is_valid then
				toggle_sensitivity (document_menu, True)
				toggle_sensitivity (project_menu, True)
				toggle_sensitivity (tool_menu, True)				
				toggle_sensitivity (new_menu_item, True)
				toggle_sensitivity (open_menu_item, True)
			else			
				toggle_sensitivity (document_menu, False)
				toggle_sensitivity (project_menu, False)
				toggle_sensitivity (tool_menu, False)
				toggle_sensitivity (open_menu_item, False)
			end
			if shared_document_manager.has_open_document then
				l_curr_doc := shared_document_manager.current_document
				l_text := shared_document_manager.current_editor.text_displayed

						-- Title bar
				if l_curr_doc = Void then
					set_title ("Doc Builder")
				else
					l_name := l_curr_doc.name.twin
					l_name.replace_substring_all ("\", "/")
					set_title ("Doc Builder: " + l_name)
				end				
				
						-- File Menu				
				toggle_sensitivity (close_file_menu_item, True)
				
						-- Edit Menu
				toggle_sensitivity (document_menu, True)
				toggle_sensitivity (copy_menu_item, l_text.has_selection)
				toggle_sensitivity (cut_menu_item, l_text.has_selection)
				toggle_sensitivity (paste_menu_item, not shared_document_manager.current_editor.clipboard_empty)										
			else
						-- File menu
				toggle_sensitivity (save_menu_item , False)
				toggle_sensitivity (close_file_menu_item, False)
				
						-- Edit Menu
				toggle_sensitivity (document_menu, False)
			end			
		end
		
	update_toc_toolbar is
			-- Update TOC toolbar
		do
			if shared_toc_manager.loaded_toc = Void then
				toggle_sensitivity (toc_save_button, False)
				toggle_sensitivity (toc_sort_button, False)
				toggle_sensitivity (toc_new_heading, False)
				toggle_sensitivity (toc_new_page, False)
				toggle_sensitivity (toc_remove_topic, False)
				toggle_sensitivity (toc_list_button, False)
				toggle_sensitivity (toc_merge_button, False)
			else
				toggle_sensitivity (toc_save_button, True)
				toggle_sensitivity (toc_sort_button, True)
				toggle_sensitivity (toc_new_heading, True)
				toggle_sensitivity (toc_new_page, True)
				toggle_sensitivity (toc_remove_topic, True)
				toggle_sensitivity (toc_list_button, True)
				if shared_toc_manager.displayed_tocs.count > 1 then
					toggle_sensitivity (toc_merge_button, True)
				else
					toggle_sensitivity (toc_merge_button, False)
				end
			end
		end		

feature -- GUI Updating
	
	update is
			-- Update interface
		do
			update_toolbar
			update_menus
			update_toc_toolbar
			update_status_report (False, "")
		end		
	
	update_sub_element_list (a_el_name: STRING; list: SORTED_TWO_WAY_LIST [STRING]) is
			-- Update the sub-element list display
		require
			name_not_void: a_el_name /= Void
			name_not_empty: not a_el_name.is_empty
		local
			l_row: EV_LIST_ITEM
		do
			sub_elements_list.wipe_out
			title_label.set_text (" Sub Elements <" + a_el_name + ">")
			if list /= Void then
				if sub_elements_list.is_displayed then
					sub_elements_list.wipe_out
					from					
						list.start
					until
						list.after
					loop					
						create l_row.make_with_text (list.item)
						l_row.pointer_double_press_actions.force_extend (agent shared_document_editor_commands.tag_selection (list.item))
						sub_elements_list.extend (l_row)
						list.forth
					end
				end	
			end			
		end
	
	update_status_report (is_error: BOOLEAN; message: STRING) is
			-- Update status bar `report_label' with new `message'
		require
			message_not_void: message /= Void
		do
			if shared_document_manager.has_open_document then
				report_label.set_text (message)
				report_label.set_tooltip (message)
				if is_error then
					report_label.set_foreground_color (Shared_constants.Application_constants.Error_color)
				else
					report_label.set_foreground_color (Shared_constants.Application_constants.No_error_color)
				end
			end
		end				

	update_output_filter is
			-- Update the output filter type
		local
			l_filter: OUTPUT_FILTER
			l_curr_doc: DOCUMENT
		do
			l_filter ?= Shared_project.filter_manager.filter_by_description (output_combo.selected_item.text)
			shared_project.filter_manager.set_filter (l_filter)
			l_curr_doc := shared_document_manager.current_document
			if l_curr_doc /= Void then				
				shared_web_browser.set_document (l_curr_doc)
			end
		end	

	update_output_combo is
			-- Update the output combo box
		local
			l_filters: HASH_TABLE [DOCUMENT_FILTER, STRING]
			l_list_item: EV_LIST_ITEM
		do
			if shared_project.filter_manager /= Void then
				l_filters := shared_project.filter_manager.filters
				output_combo.wipe_out
				from
					l_filters.start
				until
					l_filters.after
				loop
					create l_list_item.make_with_text (l_filters.key_for_iteration)
					output_combo.extend (l_list_item)
					l_filters.forth
				end
			end
			update_output_filter
		end

	on_text_edited (directly_edited: BOOLEAN) is
			-- Update `Current' when some text has been modified
			-- if `directly_edited', the user has modified the text in the editor,
			-- not via another tool or wizard
			-- Observer must be registered as "edition_observer" for this feature to be called.
		do
			toggle_sensitivity (toolbar_save, True)
			toggle_sensitivity (save_menu_item, True)			
		end

	on_text_fully_loaded,
	on_cursor_moved is
			-- Update `Current' when the text has been completely loaded.
			-- Observer must be registered as "edition_observer" for this feature to be called.
		do		
			update_toolbar
			update_menus
			
				-- Positional information
			cursor_text_position.set_text ("Pos: " + shared_document_manager.current_editor.text_displayed.cursor.x_in_characters.out)	
			line_number.set_text ("Line:" + shared_document_manager.current_editor.text_displayed.current_line_number.out)
			cursor_line_pos.set_text ("Byte: " + shared_document_manager.current_editor.text_displayed.cursor.pos_in_characters.out)	
		end
		
	on_selection_finished is
			-- Update `Current' when the text has been completely loaded.
			-- Observer must be registered as "edition_observer" for this feature to be called.
		do
			update_toolbar
			update_menus
		end
		
feature -- Status Setting

	set_toc_widget (a_toc: TABLE_OF_CONTENTS_WIDGET) is
			-- Set the TOC widget
		require
			toc_not_void: a_toc /= Void
		do
			if a_toc.is_empty then
				a_toc.extend (create {EV_TREE_ITEM}.make_with_text ("Empty TOC"))
			end
			toc_area.go_i_th (2)
			if a_toc.parent /= Void then
				a_toc.parent.prune (a_toc)
			end
			toc_area.replace (a_toc)
			toc_status_report_label.set_text (a_toc.toc.name)
		end

	set_toc_node_widget (a_widget: EV_WIDGET) is
			-- Set widget for TOC node properties information
		require
			widget_not_void: a_widget /= Void
		do
			node_properties_area.go_i_th (2)
			node_properties_area.replace (a_widget)
		end		

feature {NONE} -- Implementation
		
	toggle_sensitivity (sensitive_item: EV_SENSITIVE; on: BOOLEAN)	is
			-- Toggle `sensitive_item' to `on'
		require
			item_valid: sensitive_item /= Void
		do
			if on then
				if not sensitive_item.is_sensitive then
					sensitive_item.enable_sensitive
				end
			else
				if sensitive_item.is_sensitive then
					sensitive_item.disable_sensitive
				end
			end
		end
	
	show_loaded_tocs is
			-- Show a menu of all loaded tocs
		local
			l_menu: EV_MENU
			l_menu_item: EV_CHECK_MENU_ITEM
			l_tocs: ARRAY [STRING]
			l_toc_name, l_curr_toc: STRING
			l_cnt: INTEGER
		do
			create l_menu
			l_tocs := Shared_toc_manager.displayed_tocs
			l_curr_toc := Shared_toc_manager.loaded_toc.name
			from
				l_cnt := 1
			until
				l_cnt > l_tocs.count
			loop
				l_toc_name := l_tocs.item (l_cnt)				
				create l_menu_item.make_with_text (l_toc_name)
				if l_toc_name.is_equal (l_curr_toc) then
					l_menu_item.enable_select
				end
				l_menu_item.select_actions.extend (agent Shared_toc_manager.load_toc (l_toc_name))
				l_menu.extend (l_menu_item)
				l_cnt := l_cnt + 1
			end
			l_menu.show_at (toc_list_button, 0, 0)
		end	
		
	connect_item_actions (a_item: EV_TREE_NODE) is
			-- 
		local
			element: DOCUMENT_SCHEMA_ELEMENT
		do
			element ?= a_item.data
			if element /= Void then
				a_item.select_actions.extend (agent render_factory.attribute_list_render (element, attribute_list))
				a_item.set_tooltip (element.annotation)
			end
		end				

	render_factory: SCHEMA_RENDERING_FACTORY
			-- Factory for rendering schema views

	internal_selector_widgets: HASH_TABLE [EV_WIDGET, STRING]
			-- Internal widgets for memory persistence when removed from interface view selector

feature -- Accelerators

	add_tag_accelerator (a_accelerator: EV_ACCELERATOR; a_tag_text: STRING) is
			-- Add an accelerator to Current
		require
			accelerator_not_void: a_accelerator /= Void
			tag_text_not_void: a_tag_text /= Void
		local
			l_accelerator: EV_ACCELERATOR
		do		
			l_accelerator := a_accelerator
			if accelerators.has (l_accelerator) then
				accelerators.start
				accelerators.search (l_accelerator)
				if not accelerators.exhausted then					
					l_accelerator := accelerators.item
					l_accelerator.actions.wipe_out
				end
			else
				accelerators.extend (l_accelerator)
			end
			l_accelerator.actions.extend (agent shared_document_editor_commands.tag_selection (a_tag_text))
			tag_accelerators.replace (a_tag_text, a_accelerator.key.code)
		end

	feature -- Shortcuts

		tag_accelerators: HASH_TABLE [STRING, INTEGER] is
				-- List of keyboard keys which are acceptable for tag accelerators
				-- hashed by key code
			local
				l_key_constants: EV_KEY_CONSTANTS
			once
				create l_key_constants
				create Result.make (10)
				Result.compare_objects
				Result.extend ("", l_key_constants.key_q)
				Result.extend ("", l_key_constants.key_w)
				Result.extend ("", l_key_constants.key_e)
				Result.extend ("", l_key_constants.key_r)
				Result.extend ("", l_key_constants.key_t)
				Result.extend ("", l_key_constants.key_y)
				Result.extend ("", l_key_constants.key_u)
				Result.extend ("", l_key_constants.key_b)
				Result.extend ("", l_key_constants.key_i)
				Result.extend ("", l_key_constants.key_o)
				Result.extend ("", l_key_constants.key_p)
				Result.extend ("", l_key_constants.key_d)
				Result.extend ("", l_key_constants.key_g)
				Result.extend ("", l_key_constants.key_h)
				Result.extend ("", l_key_constants.key_j)
				Result.extend ("", l_key_constants.key_k)
				Result.extend ("", l_key_constants.key_n)
				Result.extend ("", l_key_constants.key_m)
				Result.extend ("", l_key_constants.key_0)
				Result.extend ("", l_key_constants.key_1)
				Result.extend ("", l_key_constants.key_2)
				Result.extend ("", l_key_constants.key_3)
				Result.extend ("", l_key_constants.key_4)
				Result.extend ("", l_key_constants.key_5)
				Result.extend ("", l_key_constants.key_6)
				Result.extend ("", l_key_constants.key_7)
				Result.extend ("", l_key_constants.key_8)
				Result.extend ("", l_key_constants.key_9)
			end
		
feature {NONE} -- Dialog

	open_template_dialog is
			-- Template dialog for new projects
		do
			Shared_dialogs.template_dialog.show_modal_to_window (Current)
		end
		
	open_settings_dialog is
			-- Template dialog for new projects
		do
			Shared_dialogs.preferences_dialog.show_modal_to_window (Current)
		end
		
	open_generation_dialog is
			-- Template dialog for new projects
		do
			Shared_dialogs.generation_dialog.show_modal_to_window (Current)
		end

	open_expression_dialog is
			-- Regular Expression dialog for document text parsing
		do
			Shared_dialogs.expression_dialog.show_modal_to_window (Current)
		end
		
	open_preferences_window is
			-- Regular Expression dialog for document text parsing
		do
			Shared_preferences.show_preferences_window (Current)
		end

	open_character_dialog is
			-- Special character dialog for XML and HTML
		do
			Shared_dialogs.character_dialog.show_relative_to_window (Current)
		end

	open_shortcuts_dialog is
			-- Shortcut dialog
		do
			Shared_dialogs.shortcut_dialog.show_relative_to_window (Current)
		end

	open_document_properties_dialog is
			-- Properties dialog for currently loaded document
		local
			l_doc: DOCUMENT
		do
			if Shared_document_manager.has_schema then
				l_doc := shared_document_manager.current_document
				if l_doc.is_valid_to_schema then
					l_doc.properties.show_modal_to_window (Current)
				else
					shared_error_reporter.show
				end
			end					
		end
		
	open_validator_tool is
			-- Properties dialog for currently loaded document
		do
			Shared_dialogs.validator_tool.show_modal_to_window (Current)
		end

	open_new_toc_dialog is
			-- Open dialog for new TOC creation
		do
			Shared_dialogs.new_toc_dialog.show_modal_to_window (Current)
		end

	open_toc_properties_dialog is
			-- Open dialog for TOC properties
		do
			Shared_dialogs.toc_dialog.show_modal_to_window (Current)
		end

	open_toc_merge_dialog is
			-- Open dialog for TOC merging
		do
			Shared_dialogs.toc_merge_dialog.show_modal_to_window (Current)
		end

	display_help is
			-- Display help
		do
			shared_help_manager.show_help
			if not shared_help_manager.last_show_successful then
				shared_error_reporter.set_error (create {ERROR}.make ("Unable to initialize help"))
				shared_error_reporter.show
			end	
		end		
		
	display_about is
			-- Display about
		local
			l_about: ABOUT_DIALOG
		do
			create l_about
			l_about.show_modal_to_window (Current)
		end		

	close_application is
			-- Close application
		local
			l_env: EV_ENVIRONMENT
		do
			l_env := (create {EV_ENVIRONMENT})
			if shared_project.is_valid then				
				shared_project.preferences.write	
			end
			l_env.application.destroy
		end		

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
end -- class MAIN_WINDOW
