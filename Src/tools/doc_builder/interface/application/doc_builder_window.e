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
			create render_factory
			shared_document_editor.initialize (document_editor, Current)
			
				-- Menu Events
			new_xml_menu_item.select_actions.extend 		(agent open_template_dialog)
			open_xml_menu_item.select_actions.extend 		(agent Shared_document_editor.open_document)
			open_docs_xml_menu_item.select_actions.extend 	(agent Shared_project.open_from_existing_project)
			save_xml_menu_item.select_actions.extend 		(agent Shared_document_editor.save_document)
			close_menu_item.select_actions.extend 			(agent Shared_document_editor.close_document)
			menu_uppercase_tags.select_actions.extend 		(agent toggle_format_options)
			cut_menu_item.select_actions.extend				(agent Shared_document_editor.cut_text)
			copy_menu_item.select_actions.extend 			(agent Shared_document_editor.copy_text)
			paste_menu_item.select_actions.extend 			(agent Shared_document_editor.paste_text)
			settings_menu_item.select_actions.extend 		(agent open_settings_dialog)
			gen_menu_item.select_actions.extend 			(agent open_generation_dialog)
			search_menu_item.select_actions.extend 			(agent Shared_document_editor.open_search_dialog)
			parser_menu_item.select_actions.extend 			(agent open_expression_dialog)
			validator_menu_item.select_actions.extend 		(agent open_validator_tool)
			expression_menu_item.select_actions.extend 		(agent open_expression_dialog)
			
				-- Toolbar Events
			toolbar_cut.select_actions.extend 				(agent Shared_document_editor.cut_text)
			toolbar_copy.select_actions.extend 				(agent Shared_document_editor.copy_text)
			toolbar_paste.select_actions.extend 			(agent Shared_document_editor.paste_text)			
			toolbar_xml_format.select_actions.extend		(agent Shared_document_editor.pretty_print_text)
			toolbar_new.select_actions.extend 				(agent Shared_document_editor.open_new_document)
			toolbar_open.select_actions.extend 				(agent Shared_document_editor.open_document)
			toolbar_save.select_actions.extend 				(agent Shared_document_editor.save_document)
			toolbar_validate.select_actions.extend 			(agent Shared_document_editor.validate_document)
			toolbar_studio.select_actions.extend 			(agent Shared_document_manager.transform_studio_output)
			toolbar_envision.select_actions.extend 			(agent Shared_document_manager.transform_envision_output)
			toolbar_properties.select_actions.extend 		(agent open_document_properties_dialog)
				
				-- Misc Interface Events
			editor_close.select_actions.extend	 			(agent Shared_document_editor.close_document)
			document_editor.selection_actions.extend 		(agent Shared_document_editor.document_changed)
			studio_toc_radio.select_actions.extend 			(agent update_output_filter)
			envision_toc_radio.select_actions.extend 		(agent update_output_filter)

				-- Initial setup
			internal_element_selector := element_area
			internal_type_selector := type_area
			attribute_list.hide
			update_status_report (True, "No document loaded")
			
--			browser_container.extend (Shared_web_browser)
--			Shared_web_browser.show
			
			set_root_window (Current)
			initialize_path_constants
			initialize_temp_directory
			Shared_constants.Application_constants.set_output_filter (feature {APPLICATION_CONSTANTS}.All_filter)
			
			close_request_actions.extend (agent (create {EV_APPLICATION}).destroy)
		end

	initialize_path_constants is
			-- Initialize constnats
		local
			tmp_var: DIRECTORY_NAME
		do
			tmp_var := Shared_constants.Application_constants.Resources_directory
		end	
		
	initialize_temp_directory is
			-- Initialize directory for storage of temporary information.  Currently this is a directory
			-- on the root drive because help compilation for Microsoft Help 1.x fails in directories
			-- with absolute path names of a certain size.  By placing in the root this reduces the overall
			-- size of path names.
		local
			l_dir: DIRECTORY
		do
			create l_dir.make (Shared_constants.Application_constants.Temporary_directory)
			if l_dir.exists then
				l_dir.recursive_delete
			end
			l_dir.create_dir
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
		
	hide_sub_element_tool is
			-- Hide the Sub-element tool
		do
			sub_element_tool.hide	
		end
		
	hide_browser_tool is
			-- Hide the Web browser tool
		do
			sub_element_tool.hide	
		end
		
	hide_main_tool is
			-- Hide the  tool
		do
			sub_element_tool.hide	
		end
		
	toggle_types_view is
			-- Toggle Schema types view
		do
			if selector.has (internal_type_selector) then
				selector.prune (internal_type_selector)
				if selector.is_empty then
					selector_container.hide
					attribute_selector_menu.disable_select
				end
				types_selector_menu.disable_select
			else
				if not selector_container.is_displayed then
					selector_container.show
				end
				selector.put_front (internal_type_selector)
				selector.set_item_text (internal_type_selector, "Types")
				selector.select_item (internal_type_selector)
				types_selector_menu.enable_select
			end
		end	

	toggle_elements_view is
			-- Toggle Schema elements view
		do
			if selector.has (internal_element_selector) then
				selector.prune (internal_element_selector)
				if selector.is_empty then
					selector_container.hide
					attribute_selector_menu.disable_select
				end
				element_selector_menu.disable_select
			else
				if not selector_container.is_displayed then
					selector_container.show
				end
				selector.put_front (internal_element_selector)
				selector.set_item_text (internal_element_selector, "Elements")
				selector.select_item (internal_element_selector)
				element_selector_menu.enable_select
			end
		end	
		
	toggle_attribute_view is
			-- Toggle Schema type/element attribute display list
		do
			if selector_container.is_displayed then
				if attribute_list.is_displayed then
					attribute_list.hide
				else
					attribute_list.show
				end
			else
				attribute_selector_menu.disable_sensitive
			end
		end
		
	toggle_editor_view is
			-- Show/hide document editor
		do
			if editor_tool.is_displayed then
				editor_tool.hide
				doc_selector_menu_item.disable_select
			else
				editor_tool.show
				doc_selector_menu_item.enable_select
			end
		end
	
	toggle_output_view is
			-- Show/hide browser output
		do
			if browser_tool.is_displayed then
				browser_tool.hide
				output_selector_menu_item.disable_select
			else
				browser_tool.show
				output_selector_menu_item.enable_select
			end
		end	
	
	toggle_sub_element_view is
			-- Show/hide sub elements list
		do
			if sub_element_tool.is_displayed then
				sub_element_tool.hide
				sub_element_menu_item.disable_select
			else
				sub_element_tool.show
				sub_element_menu_item.enable_select
			end
		end	
	
	toggle_document_close (on: BOOLEAN) is
			-- Toggle document close button
		do
			toggle_sensitivity (on, editor_close)
		end
	
	toggle_save (on: BOOLEAN) is
			-- Toggle Save
		do
			toggle_sensitivity (on, toolbar_save)
			toggle_sensitivity (on, save_xml_menu_item)
		end
		
	toggle_paste (on: BOOLEAN) is
			-- Toggle paste
		do
			toggle_sensitivity (on, toolbar_paste)
			toggle_sensitivity (on, paste_menu_item)
		end
	
	toggle_copy (on: BOOLEAN) is
			-- Toggle Copy
		do
			toggle_sensitivity (on, toolbar_copy)
			toggle_sensitivity (on, copy_menu_item)
		end
		
	toggle_cut (on: BOOLEAN) is
			-- Toggle Cut
		do
			toggle_sensitivity (on, toolbar_cut)
			toggle_sensitivity (on, cut_menu_item)
		end
		
	toggle_xml_format_button (on: BOOLEAN) is
			-- Toggle button used for document schema validation
		do
			toggle_sensitivity (on, toolbar_xml_format)
		end	
		
	toggle_properties_button (on: BOOLEAN) is
			-- Toggle button used for document properties dialog
		do
			toggle_sensitivity (on, toolbar_properties)
		end		
		
	toggle_transform_buttons (on: BOOLEAN) is
			-- Toggle `toolbar_envision' and `toolbar_studio'
		do
			toggle_sensitivity (on, toolbar_envision)
			toggle_sensitivity (on, toolbar_studio)
		end		
		
	toggle_format_options is
			-- Toggle document format menu options
		do
			if Shared_document_manager.current_document /= Void then			
				if menu_uppercase_tags.is_sensitive then
					Shared_constants.Application_constants.set_tags_uppercase (menu_uppercase_tags.is_selected)
					if Shared_document_manager.current_document.is_valid_xml then
						Shared_document_editor.format_tags
						update_status_report (False, "")
					else
						Shared_document_manager.current_document.xml_validator.error_report.show
						report_label.set_foreground_color (Shared_constants.Application_constants.error_color)
					end		
				else
					Shared_constants.Application_constants.set_tags_uppercase (False)
				end		
			else
				update_status_report (True, "No document loaded")
			end
		end
	
	toggle_validate_button is
			-- Toggle button used for document schema validation
		do
			if 
				Shared_document_manager.current_document /= Void and then
				Shared_document_manager.schema /= Void
			then
				toolbar_validate.enable_sensitive
			else
				toolbar_validate.disable_sensitive
			end
		end		

feature -- GUI Updating
	
	update is
			-- Update full interface
		do
				
		end		
	
	update_document_editor is
			-- Update GUI element display in the document editor
		do
			if Shared_document_editor.is_empty then
				toggle_sensitivity (False, editor_close)
				update_status_report (False, "")
				update_status_line (1)
			else
				toggle_sensitivity (True, editor_close)
			end
		end
	
	update_sub_element_list (list: SORTED_TWO_WAY_LIST [STRING]) is
			-- Update the sub-element list display to reflect `list'
		local
			l_row: EV_LIST_ITEM
			schema_element: DOCUMENT_SCHEMA_ELEMENT
			children: LINKED_LIST [DOCUMENT_SCHEMA_ELEMENT]
			l_sorted_list: SORTED_TWO_WAY_LIST [STRING]
		do
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
			if sub_elements_list.is_empty then
				create l_row.make_with_text ("Element has no sub elements")
				sub_elements_list.extend (l_row)
			end
		end
	
	update_status_report (is_error: BOOLEAN; message: STRING) is
			-- Update status bar `report_label' with new `message'
		require
			message_not_void: message /= Void
		do
			if Shared_document_manager.current_document /= Void then
				report_label.set_text (message)
				report_label.set_tooltip (message)
				if is_error then
					report_label.set_foreground_color (Shared_constants.Application_constants.Error_color)
				else
					report_label.set_foreground_color (Shared_constants.Application_constants.No_error_color)
				end
			end
			toggle_validate_button
		end			
		
	update_status_line (a_line_no: INTEGER) is
			-- Update status bar `line_pos_label' with `a_line_no'
		require
			a_line_no_valid: a_line_no > 0
		do
			line_pos_label.set_text ("line: " + a_line_no.out)	
		end		

	update_output_filter is
			-- Update the output filter display information
		do
			if studio_toc_radio.is_selected then
				Shared_constants.Application_constants.set_output_filter 
					(feature {APPLICATION_CONSTANTS}.Studio_filter)
				if internal_studio_toc /= Void then
					Shared_project.set_toc (internal_studio_toc)
					set_document_toc (internal_studio_toc)
				else
					Shared_project.build_toc	
				end				
			elseif envision_toc_radio.is_selected then			
				Shared_constants.Application_constants.set_output_filter 
					(feature {APPLICATION_CONSTANTS}.Envision_filter)				
				if internal_envision_toc /= Void then
					Shared_project.set_toc (internal_envision_toc)
					set_document_toc (internal_envision_toc)
				else
					Shared_project.build_toc	
				end	
			end
		end

feature -- Status Setting

	set_document_toc (a_toc: DOCUMENT_TOC) is
			-- Set the TOC widget
		require
			toc_not_void: a_toc /= Void
		local
			l_frame: EV_FRAME
		do
			toc_area.go_i_th (1)
			toc_area.replace (a_toc)
			toc_area.go_i_th (2)
			l_frame ?= toc_area.item
			if l_frame /= Void then
				toc_area.replace (l_frame)
				toc_area.disable_item_expand (l_frame)
			end
			if Shared_constants.Application_constants.is_studio then
				internal_studio_toc := a_toc
			elseif Shared_constants.Application_constants.is_envision then
				internal_envision_toc := a_toc
			end
		end		

feature {FINAL_DIALOG} -- Implementation

	internal_studio_toc, 
	internal_envision_toc: DOCUMENT_TOC
			-- Internal TOC trees

feature {NONE} -- Implementation
		
	toggle_sensitivity (on: BOOLEAN; sensitive_item: EV_SENSITIVE)	is
			-- Toggle `button' to `on'
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
		
	render_factory: SCHEMA_RENDERING_FACTORY
			-- Factory for rendering schema views

	internal_element_selector,
	internal_type_selector: EV_WIDGET
			-- Internal widgets for memory persistence when removed from interface view
		
	connect_item_actions (a_item: EV_TREE_NODE) is
			-- 
		local
			element: DOCUMENT_SCHEMA_ELEMENT
		do
			element ?= a_item.data
			if element /= Void then
				a_item.select_actions.extend (agent render_factory.attribute_list_render (element, attribute_list))
				a_item.set_tooltip (element.annotation)
				a_item.set_pebble (element.xml)
			end
		end			

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
		do
			Shared_document_manager.current_document.properties.show_modal_to_window (Current)
		end
		
	open_validator_tool is
			-- Properties dialog for currently loaded document
		do
			Shared_dialogs.validator_tool.show_modal_to_window (Current)
		end

end -- class MAIN_WINDOW