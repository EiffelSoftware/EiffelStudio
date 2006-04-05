indexing
	description: "EV_TEXT widget representation of a document."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_TEXT_WIDGET

inherit	
	EV_RICH_TEXT
		redefine
			initialize,
			is_in_default_state,
			set_font
		end

	OBSERVER
		undefine 
			copy,
			default_create
		end
	
	OBSERVED
		undefine 
			copy,
			default_create
		end
	
	SHARED_OBJECTS
		undefine 
			copy,
			default_create
		end

	XML_ROUTINES
		rename
			is_valid_xml as is_valid_xml_text
		undefine 
			copy,
			default_create
		end
		
	GRAPHICAL_CONSTANTS
		undefine 
			copy,
			default_create
		end

create
	make
	
feature -- Creation

	make (a_document: DOCUMENT) is
			-- Make Current with `a_document'
		do
			document := a_document	
			default_create
			document.attach (Current)
			attach (application_window)
			set_tab_width (18)
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialization
		do	
			Precursor {EV_RICH_TEXT}						
			if document.text /= Void then				
				append_rich_text (document.text)
				highlight
			end
			should_update := True
			create schema_validator
			if shared_document_editor.preferences.font /= Void then
				set_font (shared_document_editor.preferences.font)
			end			
			if not shared_document_editor.preferences.word_wrap_on then
				disable_word_wrapping
			end
			
				-- Agents
			change_actions.extend (agent internal_update_subject)
			key_press_actions.extend (agent key_pressed)
			key_release_actions.extend (agent update_subject)
			pointer_button_release_actions.force_extend (agent internal_update_subject)
			pointer_button_release_actions.force_extend (agent pointer_released)
			pointer_button_press_actions.extend (agent pointer_pressed (?,?,?,?,?,?,?,?))		
			drop_actions.extend (agent pebble_dropped)
		end

feature -- Query
			
	is_valid_xml: BOOLEAN is
			-- Is `text' valid xml?
		local
			l_error: ERROR
		do
			if not text.is_empty then					
				Result := is_valid_xml_text (text)
				if not Result then
					create error_report.make ("Invalid XML")
					create l_error.make_with_line_information (error_description, error_line, error_column)
					l_error.set_action (agent (error_report.actions).highlight_text_byte_in_editor (error_byte))
					error_report.append_error (l_error)
				end
			else
				create error_report.make ("Invalid XML")
				create l_error.make ("File is empty")
				error_report.append_error (l_error)
			end
		end		

	selection_is_valid_xml: BOOLEAN is
			-- Is `selected_text' valid XML?
		do
			if not text.is_empty then
				Result := is_valid_xml_text (selected_text)	
			end			
		end		

	is_valid_to_schema: BOOLEAN is
			-- Is Current valid to the loaded schema?
		do
			if is_valid_xml then
				schema_validator.validate_against_text (text, Shared_document_manager.schema.name)
				Result := schema_validator.is_valid
				if not Result then
					error_report := schema_validator.error_report	
				end
			end
		end

	can_insert (a_xml: STRING): BOOLEAN is
			-- Can `xml' be inserted into Current?
		local
			l_constants: EV_DIALOG_CONSTANTS
			l_message_dialog: EV_MESSAGE_DIALOG
		do
			if not is_valid_xml_text (a_xml) then
				create l_message_dialog.make_with_text ((create {MESSAGE_CONSTANTS}).invalid_xml_dialog_title)
				l_message_dialog.set_title ((create {MESSAGE_CONSTANTS}).invalid_xml_dialog_title)
				l_message_dialog.set_text ((create {MESSAGE_CONSTANTS}).invalid_xml_file_warning)
				l_message_dialog.set_buttons (<<(create {EV_DIALOG_CONSTANTS}).ev_ok>>)
				l_message_dialog.show_modal_to_window (Application_window)
			elseif a_xml.has_substring ("code_block") then
				create l_constants
				create l_message_dialog.make_with_text ((create {MESSAGE_CONSTANTS}).html_pre_tag_warning)
				l_message_dialog.set_title (l_constants.ev_warning_dialog_title)
				l_message_dialog.set_buttons (<<"Continue", l_constants.ev_cancel>>)
				l_message_dialog.show_modal_to_window (application_window)
				if l_message_dialog.selected_button.is_equal ("Continue") then
					Result := True
				end
				l_message_dialog.destroy
			else
				Result := True
			end
		end

feature -- Commands	
	
	highlight is
			-- Highlight output sections		
		local
			l_highlight_filter: OUTPUT_FORMAT_FILTER
			l_parser: XM_EIFFEL_PARSER
		do			
			if is_valid_xml then
				create l_highlight_filter.make (Current)
				create l_parser.make
				l_parser.set_callbacks (l_highlight_filter)
				l_parser.parse_from_string (text)
				flush_buffer
			else
				append_rich_text (document.text)
			end	
		end

	highlight_error is
			-- Highlight error.		
		do			
		end	

	highlight_error_pos (a_no, a_pos: INTEGER) is
			-- Highlight line at `a_no' and position `a_pos'.  Since `l_no' denoted a file
			-- line number this must be converted to the relevant position in Current.
		local			
			l_has_wrap: BOOLEAN
			l_start_pos, l_end_pos: INTEGER
		do			
			l_has_wrap := has_word_wrapping
			if l_has_wrap then
				disable_word_wrapping
			end
	
			l_start_pos := first_position_from_line_number (a_no) + a_pos - 1
			l_end_pos := l_start_pos + line (a_no).count - a_pos - 2	
			
			if l_has_wrap then
				enable_word_wrapping
			end			
			
			select_region (l_start_pos, l_end_pos)
			scroll_to_line (a_no)
			set_focus
		end		

	update_line_display is
			-- Update line display to reflect caret position
		do
			Application_window.update_status_line (current_line_number, caret_position)
		end	

feature -- Status Setting

	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		local
			l_format: EV_CHARACTER_FORMAT
		do
			create l_format
			l_format.set_font (a_font)
			modify_region (1, text.count, l_format, create {EV_CHARACTER_FORMAT_RANGE_INFORMATION}.make_with_flags 
				(feature {EV_CHARACTER_FORMAT_CONSTANTS}.font_family))
		end

	tag_selection (a_tag: STRING) is
			-- Enclose `selected_text' in `a_tag'.  Eg, `some_text'
			-- becomes `a_tagsome_texta_tag'.  If there is no selection
			-- just insert `a_taga_tag'.
		local
			l_text,
			l_prev_text: STRING
			l_selected: BOOLEAN
		do
			l_selected := has_selection
			create l_text.make_from_string (a_tag)
			
			if l_selected then
				if l_text.has_substring ("[tag]") then
					l_text.replace_substring_all ("[tag]", selected_text)
				else			
					l_text.append (a_tag)
					l_text.append (selected_text)
					l_text.append (a_tag)
				end
				if not clipboard_content.is_empty then
					l_prev_text := clipboard_content
				end
				cut_selection
			end
			insert_text (l_text)
			if l_selected then
				select_region (caret_position, caret_position + (l_text.count - 1))
			elseif l_text.has_substring ("[tag]") then				
				select_region (caret_position + l_text.substring_index ("[tag]", 1) - 1, caret_position + l_text.substring_index ("[tag]", 1) + 3)
			end
			if l_prev_text /= Void then
				shared_document_editor.clipboard.set_text (l_prev_text)
			end
		end

	tag_selection_as_xml (a_tag: STRING) is
			-- Enclose `selected_text' in XML `a_tag'.  Eg, `some_text'
			-- becomes '<a_tag>some_text</a_tag>'.  If there is no selection
			-- just insert '<a_tag></a_tag>'.
		local
			l_text,
			l_prev_text: STRING
			l_selected: BOOLEAN
		do
			l_selected := has_selection
			create l_text.make_from_string ("<" + a_tag + ">")			
			
			if l_selected then
				if l_text.has_substring ("[tag]") then
					l_text.replace_substring_all ("[tag]", selected_text)
				else
					l_text.append (selected_text)
				end
				
				if not clipboard_content.is_empty then
					l_prev_text := clipboard_content
				end
				cut_selection
			end
			
			l_text.append ("</" + a_tag + ">")			
			insert_text (l_text)
			if l_selected then
				select_region (caret_position + (a_tag.count + 2), caret_position + (l_text.count - 1) - (a_tag.count + 3))
			else
				set_caret_position (caret_position + a_tag.count + 2)
			end			
			if l_prev_text /= Void then
				shared_document_editor.clipboard.set_text (l_prev_text)
			end
		end

	key_pressed (a_key: EV_KEY) is
			-- A key was pressed
		local
			l_format: EV_CHARACTER_FORMAT
		do
			l_format := character_format (caret_position)
			if l_format /= Void then				
				l_format.set_color (content_color)
				set_current_format (l_format)	
			end
		end
		
	update_subject (a_key: EV_KEY) is
			-- Update the observed subjects of changes so it can update
			-- all of it observers
		local
			l_cnt,
			l_tab_count: INTEGER
			l_string: STRING
			done: BOOLEAN
			l_char: CHARACTER
		do
			if a_key.code = enter_key_code then
				should_update := False
				l_string := line (current_line_number - 1)
				if l_string /= Void and then not l_string.is_empty then
					from
						l_cnt := 1
					until
						l_cnt > l_string.count or done
					loop
						l_char := l_string.item (l_cnt)
						if l_char = tab_char then
							l_tab_count := l_tab_count + 1
						else
							done := True
						end
						l_cnt := l_cnt + 1
					end
					if l_tab_count > 0 then
						from
							l_cnt := 1
							l_string := ""
						until
							l_cnt > l_tab_count
						loop
							l_string.append ("%T")
							l_cnt := l_cnt + 1
						end
						insert_text (l_string)
						set_caret_position (caret_position + l_tab_count)
					end
				end				
			end
			should_update := True
		end 

feature -- Query

	is_modified: BOOLEAN
			-- Has text been modifed?	

feature -- Access

	xml: XM_DOCUMENT is
			-- XML Document representation of `text' if `text' is valid XML (Void otherwise)
		do
			Result := internal_xml
			if Result = Void or is_modified then				
				Result := deserialize_text (text)
			end
		end
			
	error_report: ERROR_REPORT
			-- Validation error string
	
	document: DOCUMENT
			-- Document subject

feature {OBSERVED} -- Observer Pattern

	update is
			-- Update Current
		do
--			if not text.is_equal (document.text) then
				highlight
--			end				
		end
	
feature {NONE} -- Implementation

	internal_xml: like xml
			-- XML

	schema_validator: SCHEMA_VALIDATOR
			-- Schema Validator	

	internal_update_subject is
			-- Update subject
		do
			notify_observers
			update_line_display
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
								l_menu_item.select_actions.extend (agent tag_selection_as_xml (menu_children.item))
								l_popup.extend (l_menu_item)
								menu_children.forth
							end				
							l_popup.show_at (Current, a_x, a_y)
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
			from
				Result := text.substring (1, caret_position)
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
			set_focus
			l_start_pos := caret_position
			if document.is_persisted then				
				create l_link.make (document.name, a_url)
				l_url := l_link.relative_url
			else
				l_url := a_url
			end
			l_end_pos := l_start_pos + l_url.count
			if has_selection then
				cut_selection
			end
			insert_text (l_url)
			select_region (l_start_pos, l_end_pos)
		end		

	is_in_default_state: BOOLEAN is True
			-- Is in default state

    enter_key_code: INTEGER is
    		-- Enter key
    	once    		
    		Result := key_constants.key_enter	
    	end

	append_rich_text (a_text: STRING) is
			-- Append `a_text', formatted
		local			
			l_xml_filter: XML_FORMAT_FILTER
			l_parser: XM_EIFFEL_PARSER
			l_unformattable_text: STRING
		do
			create l_xml_filter.make (Current)
			create l_parser.make
			l_parser.set_callbacks (l_xml_filter)
			l_parser.set_string_mode_mixed
			l_parser.parse_from_string (a_text)
			flush_buffer
			if not l_parser.is_correct then
				print ("Gobo Error description: " + l_parser.last_error_extended_description)
				l_unformattable_text := a_text.substring (text.count + 1, a_text.count)
				append_text (l_unformattable_text)
			end			
		end		

	key_constants: EV_KEY_CONSTANTS is
			-- Key constants
		once
			create Result
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
end -- class DOCUMENT_TEXT_WIDGET
