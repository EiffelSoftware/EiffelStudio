indexing
	description: "Main application window."
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

	OBSERVER
		undefine
			default_create,
			copy
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
			shared_document_editor.initialize (document_editor, Current)
			
					-- File Menu
			new_menu_item.select_actions.extend 			(agent open_template_dialog)
			open_menu_item.select_actions.extend 			(agent Shared_document_manager.open_document)
			open_project_menu_item.select_actions.extend 	(agent Shared_project.open)
			save_menu_item.select_actions.extend 			(agent Shared_document_editor.save_document)
			close_menu_item.select_actions.extend 			(agent Shared_document_editor.close_document)
			
					-- Edit Menu
			menu_uppercase_tags.select_actions.extend 		(agent toggle_format_options)
			cut_menu_item.select_actions.extend				(agent Shared_document_editor.cut_text)
			copy_menu_item.select_actions.extend 			(agent Shared_document_editor.copy_text)
			paste_menu_item.select_actions.extend 			(agent Shared_document_editor.paste_text)
			search_menu_item.select_actions.extend 			(agent Shared_document_editor.open_search_dialog)
			parser_menu_item.select_actions.extend 			(agent open_expression_dialog)
			
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
		
					-- Toolbar Events
			toolbar_cut.select_actions.extend 				(agent Shared_document_editor.cut_text)
			toolbar_copy.select_actions.extend 				(agent Shared_document_editor.copy_text)
			toolbar_paste.select_actions.extend 			(agent Shared_document_editor.paste_text)			
			toolbar_xml_format.select_actions.extend		(agent Shared_document_editor.pretty_print_text)
			toolbar_new.select_actions.extend 				(agent Shared_document_manager.create_document)
			toolbar_open.select_actions.extend 				(agent Shared_document_manager.open_document)
			toolbar_save.select_actions.extend 				(agent Shared_document_editor.save_document)
			toolbar_validate.select_actions.extend 			(agent Shared_document_editor.validate_document)
			toolbar_properties.select_actions.extend 		(agent open_document_properties_dialog)
			toolbar_studio.select_actions.extend 			(agent update_output_filter)
			toolbar_envision.select_actions.extend 			(agent update_output_filter)
			toolbar_web.select_actions.extend 				(agent update_output_filter)
			
					-- TOC Widget Events
			toc_new_button.select_actions.extend 			(agent open_new_toc_dialog)
			toc_open_button.select_actions.extend 			(agent Shared_toc_manager.open_toc)
			toc_save_button.select_actions.extend 			(agent Shared_toc_manager.save_toc)
			toc_menu_button.select_actions.extend 			(agent show_loaded_tocs)
			toc_properties_button.select_actions.extend 	(agent open_toc_properties_dialog)
			toc_new_heading.select_actions.extend 			(agent Shared_toc_manager.new_node (True))
			toc_new_page.select_actions.extend 				(agent Shared_toc_manager.new_node (False))
			toc_remove_topic.select_actions.extend 			(agent Shared_toc_manager.remove_node)
				
					-- Misc Interface Events
			editor_close.select_actions.extend	 			(agent Shared_document_editor.close_document)
			document_editor.selection_actions.extend 		(agent Shared_document_editor.document_changed)
			attribute_list_close.select_actions.extend 		(agent attribute_selector_menu.disable_select)
			attribute_list_close.select_actions.extend 		(agent show_hide_widget (attribute_list_tool, False))
			sub_element_close.select_actions.extend 		(agent sub_element_menu.disable_select)
			sub_element_close.select_actions.extend 		(agent show_hide_widget (sub_element_tool, False))
			node_properties_close.select_actions.extend 	(agent show_hide_widget (node_properties_tool, False))
			

				-- Initial setup
			update_status_report (True, "No document loaded")			
			initialize_path_constants
			initialize_temp_directory
			should_update := True
			update			
			close_request_actions.extend (agent ((create {EV_ENVIRONMENT}).application).destroy)
		end

	initialize_path_constants is
			-- Initialize constants
		local
--			tmp_var: DIRECTORY_NAME
		do
--			tmp_var := Shared_constants.Application_constants.Resources_directory
		end	
		
	initialize_temp_directory is
			-- Initialize directory for storage of temporary information.  Currently this is a directory
			-- on the root drive because help compilation for Microsoft Help 1.x fails in directories
			-- with absolute path names of a certain size.  By placing in the root this reduces the overall
			-- size of path names.
		local
			l_dir: DIRECTORY
		do
					-- Main temporary directory
			create l_dir.make (Shared_constants.Application_constants.Temporary_directory)
			if l_dir.exists then
				l_dir.recursive_delete
			end
			l_dir.create_dir
			
					-- Temporary directory for Help projects
			create l_dir.make (Shared_constants.Application_constants.Temporary_help_directory)
			if not l_dir.exists then
				l_dir.create_dir
			end		
			
					-- 	Temporary directory for HTML
			create l_dir.make (Shared_constants.Application_constants.Temporary_html_directory)
			if not l_dir.exists then
				l_dir.create_dir
			end
			
					-- Temporary directory for XML
			create l_dir.make (Shared_constants.Application_constants.Temporary_xml_directory)
			if not l_dir.exists then
				l_dir.create_dir
			end
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
			l_curr_widget: EV_TEXT
		do
			if Shared_document_editor.has_open_document then
				l_curr_doc := Shared_document_editor.current_document
				l_curr_widget := Shared_document_editor.current_widget.internal_edit_widget
				
						-- Save
				toggle_sensitivity (toolbar_save, l_curr_doc.is_modified)
				
						-- Document
				toggle_sensitivity (toolbar_copy, l_curr_widget.has_selection)
				toggle_sensitivity (toolbar_cut, l_curr_widget.has_selection)
				toggle_sensitivity (toolbar_paste, Shared_document_editor.clipboard_empty)					
				toggle_sensitivity (toolbar_xml_format, True)
				toggle_sensitivity (editor_close, True)
				
						-- Validation and properties
				if Shared_document_manager.has_schema then
					toggle_sensitivity (toolbar_validate, True)
					toggle_sensitivity (toolbar_properties, True)
				end					
				
						-- Filtering
				toggle_sensitivity (toolbar_studio, True)
				toggle_sensitivity (toolbar_envision, True)
				toggle_sensitivity (toolbar_web, True)
			else
						-- Save
				toggle_sensitivity (toolbar_save, False)
				
						-- Document
				toggle_sensitivity (toolbar_copy, False)
				toggle_sensitivity (toolbar_cut, False)
				toggle_sensitivity (toolbar_paste, False)					
				toggle_sensitivity (toolbar_xml_format, False)
				toggle_sensitivity (editor_close, False)
				
						-- Validation
				toggle_sensitivity (toolbar_validate, False)
				
						-- Properties
				toggle_sensitivity (toolbar_properties, False)
				
						-- Filtering
				toggle_sensitivity (toolbar_studio, False)
				toggle_sensitivity (toolbar_envision, False)
				toggle_sensitivity (toolbar_web, False)
			end					
		end
		
	update_menus is
			-- Update the menus
		local
			l_curr_doc: DOCUMENT
			l_curr_widget: EV_TEXT
		do
			if Shared_document_editor.has_open_document then
				l_curr_doc := Shared_document_editor.current_document
				l_curr_widget := Shared_document_editor.current_widget.internal_edit_widget
				
						-- File Menu
				toggle_sensitivity (save_menu_item, l_curr_doc.is_modified)
				toggle_sensitivity (close_menu_item, True)
				
						-- Edit Menu
				toggle_sensitivity (document_menu, True)
				toggle_sensitivity (copy_menu_item, l_curr_widget.has_selection)
				toggle_sensitivity (cut_menu_item, l_curr_widget.has_selection)
				toggle_sensitivity (paste_menu_item, Shared_document_editor.clipboard_empty)										
			else
						-- File menu
				toggle_sensitivity (save_menu_item , False)
				toggle_sensitivity (close_menu_item, False)
				
						-- Edit Menu
				toggle_sensitivity (document_menu, False)
			end
			if Shared_project.is_valid then
				toggle_sensitivity (document_menu, True)
				toggle_sensitivity (project_menu, True)
				toggle_sensitivity (tool_menu, True)
			else
				toggle_sensitivity (document_menu, False)
				toggle_sensitivity (project_menu, False)
				toggle_sensitivity (tool_menu, False)
			end
		end
		
	update_toc_toolbar is
			-- Update TOC toolbar
		do
			if Shared_toc_manager.loaded_toc = Void then
				toggle_sensitivity (toc_save_button, False)
				toggle_sensitivity (toc_properties_button, False)
				toggle_sensitivity (toc_new_heading, False)
				toggle_sensitivity (toc_new_page, False)
				toggle_sensitivity (toc_remove_topic, False)
				toggle_sensitivity (toc_menu_button, False)
			else
				toggle_sensitivity (toc_save_button, True)
				toggle_sensitivity (toc_properties_button, True)
				toggle_sensitivity (toc_new_heading, True)
				toggle_sensitivity (toc_new_page, True)
				toggle_sensitivity (toc_remove_topic, True)
				toggle_sensitivity (toc_menu_button, True)
			end
		end		
		
	toggle_format_options is
			-- Toggle document format menu options
		local
			l_doc: DOCUMENT
		do
			if Shared_document_editor.has_open_document then			
				l_doc := Shared_document_editor.current_document
				if menu_uppercase_tags.is_sensitive then
					Shared_constants.Application_constants.set_tags_uppercase (menu_uppercase_tags.is_selected)
					if l_doc.is_valid_xml then
						Shared_document_editor.format_tags
						update_status_report (False, "")
					else
						report_label.set_foreground_color (Shared_constants.Application_constants.error_color)
					end		
				else
					Shared_constants.Application_constants.set_tags_uppercase (False)
				end		
			else
				update_status_report (True, "No document loaded")
			end
		end

feature -- GUI Updating
	
	update is
			-- Update interface
		do
			update_toolbar
			update_menus
			update_toc_toolbar
		end		
	
	update_sub_element_list (a_el_name: STRING; list: SORTED_TWO_WAY_LIST [STRING]) is
			-- Update the sub-element list display to reflect `listrequire
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
						l_row.set_pebble (list.item)
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
			if Shared_document_editor.has_open_document then
				report_label.set_text (message)
				report_label.set_tooltip (message)
				if is_error then
					report_label.set_foreground_color (Shared_constants.Application_constants.Error_color)
				else
					report_label.set_foreground_color (Shared_constants.Application_constants.No_error_color)
				end
			end
		end			
		
	update_status_line (a_line_no: INTEGER) is
			-- Update status bar `line_pos_label' with `a_line_no'
		require
			a_line_no_valid: a_line_no > 0
		do
			line_pos_label.set_text ("line: " + a_line_no.out)	
		end		

	update_output_filter is
			-- Update the output filter type
		local
			l_name: STRING
		do
			if toolbar_studio.is_selected then
				l_name := "EiffelStudio"
			elseif toolbar_envision.is_selected then
				l_name := "ENViSioN!"
			elseif toolbar_web.is_selected then
				l_name := "Web"
			end
			Shared_project.filter_manager.set_filter_by_description (l_name)
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
			toc_area.replace (a_toc)
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
			l_tocs := Shared_toc_manager.displayed_tocs_list
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
			l_menu.show_at (toc_menu_button, 0, 0)
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

	open_document_properties_dialog is
			-- Properties dialog for currently loaded document
		local
			l_doc: DOCUMENT
		do
			if Shared_document_manager.has_schema then
				l_doc := Shared_document_editor.current_document
				if l_doc.is_valid_to_schema then
					l_doc.properties.show_modal_to_window (Current)
				else
					l_doc.error_report.show
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
			if Shared_project.is_valid then
				Shared_dialogs.new_toc_dialog.show_modal_to_window (Current)
			else
				Shared_toc_manager.new_toc	
			end			
		end

	open_toc_properties_dialog is
			-- Open dialog for TOC properties
		do
			Shared_dialogs.toc_dialog.show_modal_to_window (Current)
		end

end -- class MAIN_WINDOW