indexing
	description: "Notebook Editor for multiple document editing.  Notebook holds widgets%
		%of type DOCUMENT_WIDGET, a composite widget class for DOCUMENTs."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_EDITOR

inherit
	EDITABLE_TEXT_PANEL		
		redefine
			on_mouse_button_up,
			handle_extended_ctrled_key
		end
	
	SHARED_OBJECTS
		undefine
			default_create,
			is_equal,
			copy
		end
	
	UTILITY_FUNCTIONS
		undefine
			default_create,
			is_equal,
			copy
		end
		
create
	make

feature -- Initialization

	make is
			-- 
		do
			default_create
			register_document ("xml", xml_class)
			register_document ("java", java_class)
			create header.make_with_panel (Current)
			header.selection_actions.extend (agent on_document_change (?))
			editor_area.pointer_button_release_actions.force_extend (agent pointer_released)
			editor_area.pointer_button_press_actions.extend (agent pointer_pressed (?,?,?,?,?,?,?,?))		
			editor_area.drop_actions.extend (agent pebble_dropped)
		end
		
	update_observers is
			-- Update observers of text editing
		do
			add_edition_observer (shared_web_browser)
			add_edition_observer (application_window)			
		end
		
	handle_extended_ctrled_key (ev_key: EV_KEY) is
 			-- Process the push on Ctrl + an extended key.
		do
			inspect
				ev_key.code
				
			when Key_s then
					-- Ctrl-S (cut)
				save_document

			when Key_f then
					-- Ctrl-C (copy)
				open_search_dialog
			else
				Precursor (ev_key)
			end			
		end
		
	initialize_editor_context is
			-- Here initialize editor contextual settings.  For example, set location of cursor
			-- pixmaps.
		do
			cursors.set_editor_installation_dir_name (shared_constants.application_constants.cursor_resources_directory)			
			icons.set_editor_installation_dir_name (shared_constants.application_constants.icon_resources_directory)			
		end		
		
feature -- Access

	header: TEXT_PANEL_HEADER
		
feature -- Editing		
		
	pretty_print_text is
			-- Pretty XML format the current document
		do
			if current_document /= Void then
				if current_document.is_valid_xml (text) then								
					current_document.set_text (current_document.pretty_xml (text))
					reset
					load_text (current_document.text)
				else
					shared_error_reporter.show
				end
			end
		end

	pretty_format_code_text is
			-- Pretty format the selected text as Eiffel code
		local		
			l_code_formatter: CODE_FORMATTER
		do
			if current_document /= Void and then text_displayed.has_selection then
				create l_code_formatter
				l_code_formatter.format (text_displayed.selected_string.twin)																		
				clipboard.set_text (l_code_formatter.text)
				paste
			end
		end			

	reference_window: EV_WINDOW is
			-- 
		once
			Result := application_window
		end		

feature -- Query

	has_open_document: BOOLEAN is
			-- 
		do
			Result := not header.is_empty
		end		

feature -- Commands
	
	load_document (a_doc: DOCUMENT) is
			-- Load document
		require
			a_doc_not_void: a_doc /= Void
		local
			l_widget: TEXT_PANEL_HEADER_ITEM
		do
			create l_widget.make (a_doc.name)
			header.open_document (l_widget)
			a_doc.set_widget (l_widget)
			documents.put (a_doc, header.index)
			on_document_change (header)
		end	

	save_document is
			-- Called by `select_actions' of `save_xml_menu_item'.
		do
			current_document.set_text (text)
			current_document.save
		end				
		
	validate_document is
			-- Validate current document to loaded schema
		local
			l_error: BOOLEAN
		do
			if Shared_document_manager.has_schema then 
				if has_open_document then					
					if not current_document.is_valid_xml (text) then
						shared_error_reporter.show
					elseif not current_document.is_valid_to_schema then
						shared_error_reporter.show
					else 
						application_window.update_status_report (False, (create {MESSAGE_CONSTANTS}).file_schema_valid_report)						
						Shared_project.remove_invalid_file (current_document.name)
					end
				end
			end
		end
		
	validate_document_links is
			-- Validate current document links/hrefs
		local
			l_has_error: BOOLEAN
			l_manager: LINK_MANAGER
			l_links: ARRAYED_LIST [DOCUMENT_LINK]
			l_error: ERROR
			l_error_report: ERROR_REPORT
		do			
			if current_document /= Void then
				if not current_document.is_valid_xml (text) then
					shared_error_reporter.show
				else								
					create l_manager
					l_manager.add_document (current_document)
					l_manager.check_links
					if l_manager.invalid_links.is_empty then
						application_window.update_status_report (True, ("All links valid"))
					else	
						from
							l_has_error := True
							l_links := l_manager.invalid_links
							l_links.start
						until
							l_links.after
						loop
							create l_error.make (l_links.item.url)	
							l_error.set_action (agent (l_error_report.actions).search_for_error_text (l_links.item.url))
							l_error_report.set_error (l_error)
							l_links.forth
						end
						l_error_report.show
					end
				end
				if l_has_error and then Shared_constants.Application_constants.is_gui_mode then
					shared_error_reporter.show
				end			
			end
		end		
		
	open_search_dialog is
			-- Open the search dialog for text searching
		do
			if has_open_document then
--				Shared_dialogs.search_dialog.set_widget (current_widget.internal_edit_widget)
--				Shared_dialogs.search_dialog.show_relative_to_window (application_window)
			end			
		end

	tag_selection (a_tag: STRING) is
			-- Enclose `selected_text' in XML `a_tag'.  Eg, `some_text'
			-- becomes '<a_tag>some_text</a_tag>'.  If there is no selection
			-- just insert '<a_tag></a_tag>'.		
		local
			l_text: STRING
		do
			if a_tag.has_substring ("[tag]") then
				l_text := a_tag.twin
				if current_document /= Void and then text_displayed.has_selection then
					cut_selection	
					l_text.replace_substring_all ("[tag]", clipboard.text)
				end
			else
				create l_text.make_from_string ("<" + a_tag + ">")	
				if current_document /= Void and then text_displayed.has_selection then
					cut_selection												
					l_text.append (clipboard.text)
				end				
				l_text.append ("</" + a_tag + ">")								
			end
			clipboard.set_text (l_text)
			paste
			
--			if l_selected then
--				select_region (caret_position + (a_tag.count + 2), caret_position + (l_text.count - 1) - (a_tag.count + 3))
--			else
--				set_caret_position (caret_position + a_tag.count + 2)
--			end						
		end

feature -- Query				
		
	clipboard_empty: BOOLEAN is
			-- Is clipboard empty?
		do
			Result := clipboard.text.is_empty
		end			

feature -- Status Setting

	add_tag_accelerator (a_accelerator: EV_ACCELERATOR; a_tag_text: STRING) is
			-- Add an accelerator to Current
		require
			accelerator_not_void: a_accelerator /= Void
			tag_text_not_void: a_tag_text /= Void
		local
			l_accelerator: EV_ACCELERATOR
		do		
			l_accelerator := a_accelerator
			if application_window.accelerators.has (l_accelerator) then
				application_window.accelerators.start
				application_window.accelerators.search (l_accelerator)
				if not application_window.accelerators.exhausted then					
					l_accelerator := application_window.accelerators.item
					l_accelerator.actions.wipe_out
				end
			else
				application_window.accelerators.extend (l_accelerator)
			end
			l_accelerator.actions.extend (agent tag_selection (a_tag_text))
			tag_accelerators.replace (a_tag_text, a_accelerator.key.code)
		end		

feature -- Access

	current_document: DOCUMENT is
			-- Currently open document
		do
			Result := documents.item (header.index)
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
			Result.extend ("", l_key_constants.key_l)
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
		

feature {NONE} -- Implementation

	documents: HASH_TABLE [DOCUMENT, INTEGER] is
			-- Opened documents
		once
			create Result.make (2)
		end		

	xml_class: DOCUMENT_CLASS is
			--
			-- (export status {NONE})
		local
			l_file_name: FILE_NAME
		once
			create l_file_name.make_from_string (shared_constants.application_constants.syntax_files_directory)
			l_file_name.extend ("xml.syn")
			create Result.make ("xml", "xml", l_file_name.string)
		end

	java_class: DOCUMENT_CLASS is
			--
			-- (export status {NONE})
		local
			l_file_name: FILE_NAME
		once
			create l_file_name.make_from_string (shared_constants.application_constants.syntax_files_directory)
			l_file_name.extend ("java.syn")
			create Result.make ("java", "java", l_file_name.string)
		end

--	eiffel_class: DOCUMENT_CLASS is
--			--
--			-- (export status {NONE})
--		once
--			create Result.make ("eiffel", "e", Void)
--			Result.set_scanner (create {EDITOR_EIFFEL_SCANNER}.make)
--		end

feature {NONE} -- Events
	
	on_mouse_button_up (x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; unused4,unused5:INTEGER) is
			-- Process release of mouse buttons.
		do
			Precursor {EDITABLE_TEXT_PANEL} (x_pos, y_pos, button, unused1, unused2, unused3, unused4, unused5)
			application_window.update_toolbar
			application_window.update_menus
		end

	pointer_pressed (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Pointer was pressed, catch right-click
		local
			l_popup: EV_MENU
			l_menu_item: EV_MENU_ITEM			
			menu_children: SORTED_TWO_WAY_LIST [STRING]
			l_parent: STRING
		do
			if Shared_document_manager.has_schema then
					-- Determine element parent based on cursor position
				l_parent := xml_parent
				if l_parent /= Void and then not l_parent.is_empty then				
							-- Retrieve element list and build popup menu
					menu_children ?= sub_element_list (l_parent)
					if a_button = 3 then							
						if menu_children /= Void and then not menu_children.is_empty then
							create l_popup
							from
								menu_children.start
							until
								menu_children.after
							loop
								create l_menu_item.make_with_text (menu_children.item)
								l_menu_item.select_actions.extend (agent tag_selection (menu_children.item))
								l_popup.extend (l_menu_item)
								menu_children.forth
							end				
							l_popup.show_at (application_window, a_x, a_y)
						end				
					end		
				end		
			end				
		end

	pointer_released is
			-- Pointer was released
		local
			l_parent: STRING
		do
			if Shared_document_manager.has_schema then
				l_parent := xml_parent
				if l_parent /= Void and then not l_parent.is_empty then
					Application_window.update_sub_element_list (l_parent, sub_element_list (l_parent))
				end
			end			
		end		

	xml_parent: STRING is
			-- Determine the parent XML text based on the current
			-- cursor position
		local
			found_end_tag, found_start_tag, is_child_tag, invalid: BOOLEAN
			start_pos, end_pos, curr_pos, cnt, ch_cnt: INTEGER
		do			
			if text_displayed.cursor /= Void then
				from
					Result := text.substring (1, text_displayed.cursor.pos_in_text)
					cnt := Result.count
					ch_cnt := 1
				until
					((found_end_tag and found_start_tag and not is_child_tag) or (cnt = 0)) or invalid
				loop
					curr_pos := cnt - 1
					if found_end_tag and found_start_tag and is_child_tag then
						found_end_tag := False
						found_start_tag := False
					end
					if not found_end_tag then
						found_end_tag := Result.substring (cnt, cnt).is_equal (">")
						if found_end_tag then
							if Result.substring (curr_pos, curr_pos).is_equal ("/") then
								ch_cnt := ch_cnt + 1
							end
						end
						end_pos := curr_pos
					else			
						found_start_tag := Result.substring (curr_pos, curr_pos).is_equal ("<")
						if found_start_tag then
							if Result.substring (cnt, cnt).is_equal ("/") then
								found_start_tag := True
								ch_cnt := ch_cnt + 1
							else
								ch_cnt := ch_cnt - 1
							end
						end
						start_pos := curr_pos
					end
					is_child_tag := ch_cnt /= 0
					cnt := cnt - 1
				end
				Result := Result.substring (start_pos + 1, end_pos)
				if not Result.is_empty then
							-- Tidy result
					Result.prune_all_leading (' ')
					Result.prune_all_leading ('%T')
					Result.prune_all_leading ('%N')
					Result.prune_all_trailing (' ')
					Result.prune_all_trailing ('%T')
					Result.prune_all_trailing ('%N')
				end
				
						-- Prune out any attribute declarations
				if Result.occurrences (' ') > 0 then
					Result := Result.substring (1, Result.index_of (' ', 1) - 1)
				end	
			end
		end

	sub_element_list (a_parent: STRING): SORTED_TWO_WAY_LIST [STRING] is
			-- Alphabetically sorted list of sub elements of `a_parent'
		local
			schema_element: DOCUMENT_SCHEMA_ELEMENT
			children: ARRAYED_LIST [DOCUMENT_SCHEMA_ELEMENT]
		do
			schema_element ?= shared_document_manager.schema.get_element_by_name (a_parent)
			if schema_element /= void then
				if not schema_element.children.is_empty then
					children := schema_element.children.twin
				elseif not schema_element.type_children.is_empty then
					children := schema_element.type_children.twin
				end
				if children /= Void then
					from
						create Result.make
						children.start
					until
						children.after
					loop
						Result.extend (children.item.name)
						children.forth
					end
					Result.sort
				end					
			end
		end
		
	pebble_dropped (a_url: STRING) is
			-- Pebble dropped on target
		local
			l_start_pos,
			l_end_pos: INTEGER
			l_link: DOCUMENT_LINK
			l_url: STRING
		do
			if current_document /= Void then
				set_focus
				l_start_pos := text_displayed.cursor.pos_in_text
				if current_document.is_persisted then				
					create l_link.make (current_document.name, a_url)
					l_url := l_link.relative_url
				else
					l_url := a_url
				end
				l_end_pos := l_start_pos + l_url.count
				if has_selection then
					cut_selection
				end
				text_displayed.insert_string (l_url)
				select_region (l_start_pos, l_end_pos)
			end
		end		

	on_document_change (a_header: TEXT_PANEL_HEADER) is
			-- Document was changed
		do		
			update_observers
			if current_document /= Void then
				shared_web_browser.set_document (current_document)		
			end
		end		

end -- class DOCUMENT_EDITOR
