indexing
	description: "EV_TEXT widget representation of a document."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_TEXT_WIDGET

inherit	
	EV_TEXT
		redefine
			initialize
		end

	OBSERVER
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

create
	make

feature -- Creation

	make (a_document: DOCUMENT) is
			-- Make Current with `text'
		do			
			document := a_document
			document.attach (Current)
			default_create
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialization
		do	
			Precursor {EV_TEXT}
			if document.text /= Void then				
				append_text (document.text)
			end
			should_update := True
			create schema_validator
			change_actions.extend (agent update_subject)
			key_release_actions.force_extend (agent update_subject)
			pointer_button_release_actions.force_extend (agent update_subject)
			pointer_button_release_actions.force_extend (agent pointer_released)
			pointer_button_press_actions.extend (agent pointer_pressed (?,?,?,?,?,?,?,?))
			initialize_accelerators
			enable_word_wrapping			
			
		end

	initialize_accelerators is
			-- Initialize accelerators
		local
			key: EV_KEY
			key_constants: EV_KEY_CONSTANTS
			accelerator: EV_ACCELERATOR
		do		
				-- Ctrl-B
			create key.make_with_code (key_constants.Key_b)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent tag_selection ("bold"))
			Application_window.accelerators.extend (accelerator)
			
				-- Ctrl-I
			create key.make_with_code (key_constants.Key_i)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent tag_selection ("italic"))
			Application_window.accelerators.extend (accelerator)	
			
				-- Ctrl-S
			create key.make_with_code (key_constants.Key_s)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent save)
			Application_window.accelerators.extend (accelerator)
		end		

feature -- Query
			
	is_valid_xml: BOOLEAN is
			-- Is `text' valid xml?
		do
			if not text.is_empty then					
				Result := is_valid_xml_text (text)
				if not Result then
					create error_report.make_from_gobo_error (error_description)
				end
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

feature -- Status report

	highlight_substring (a_string: STRING) is
			-- Highlight first occurence of `a_string' from `caret_position'.
			-- If can't be found from there then start from the beginning
		require
			a_string_not_void: a_string /= Void
			has_string: text.has_substring (a_string)
		local
			l_text: STRING
			cnt: INTEGER
			done: BOOLEAN
		do
			l_text := text.substring (caret_position, text.count)
			if l_text.has_substring (a_string) then
				set_focus
				select_region (caret_position + l_text.substring_index (a_string, 1) - 1, caret_position + l_text.substring_index (a_string, 1) + a_string.count - 2)
				from
					cnt := 1
				until
					cnt = line_count or done
				loop
					if 
						caret_position > first_position_from_line_number (cnt) and then
						caret_position < first_position_from_line_number (cnt + 1)
					then
						scroll_to_line (cnt - 5)
						done := True
					end
					cnt := cnt + 1
				end
			end
			if not has_selection then
				set_caret_position (1)
				highlight_substring (a_string)
			end	
		end		

	highlight_error is
			-- Highlight error.		
		do			
		end	

	highlight_error_pos (l_no, l_pos: INTEGER) is
			-- Highlight line at `l_no' and position `l_pos'.  Since `l_no' denoted a file
			-- line number this must be converted to the relevant poistion in Current.
		local
			found: BOOLEAN
			line_cnt, new_line_cnt,
			start_pos, end_pos: INTEGER
			l_curr_line: STRING
		do
			set_focus
			from
				line_cnt := 1
				found := (line_count = 1)
			until
				found or line_cnt > line_count or l_no = 1
			loop
				l_curr_line := line (line_cnt)
				if l_curr_line.item (l_curr_line.count) = '%N' then
					new_line_cnt := new_line_cnt + 1
					if new_line_cnt = (l_no - 1) then
						found := True
					end
				end
				if not found then
					line_cnt := line_cnt + 1	
				end
			end
			start_pos := first_position_from_line_number (line_cnt) + l_pos
			end_pos := first_position_from_line_number (line_cnt) + l_pos + 1
			select_region (start_pos, end_pos)
			scroll_to_line (l_no)
		end		

	highlight_xml_error is
			-- Highlight XML parsing or validation error in text
		local
			line_no: INTEGER
		do
			if line_no > 0 then
				select_lines (line_no, line_no + 1)
				scroll_to_line (line_no)
			end			
		end
		
	highlight_schema_error is
			-- Highlight Schema parsing or validation error in text
		local
			line_no: INTEGER
		do
			line_no := schema_validator.error_report.line_number
			if line_no > 0 then
				select_lines (line_no, line_no + 1)
				scroll_to_line (line_no)
			end
		end	

	update_line_display is
			-- Update line display to reflect caret position
		do
			Application_window.update_status_line (current_line_number)	
		end	

feature -- Status Setting

	save is
			-- Save current to disk
		do
			document.save
		end	
		
--	insert_xml (a_xml: STRING) is
--			-- Insert 'xml' into Current text
--		require
--			xml_validator.is_valid_xml_text (a_xml)
--		do
--			insert_text (a_xml)
--			select_region (caret_position, caret_position + a_xml.count - 1)
--		end
		
--	insert_xml_formatted (a_xml: STRING) is
--			-- Insert 'xml' into Current text, pretty formatted
--		require
--			Xml_validator.is_valid_xml_text (a_xml)
--		local
--			new_xml, tag: STRING
--			char_cursor, tab_count, init_caret: INTEGER
--			curr_char: CHARACTER
--			start: BOOLEAN
--		do
--			if can_insert (a_xml) then
--				create new_xml.make_empty
--				a_xml.prune_all ('%N')
--				a_xml.prune_all ('%T')
--				from
--					init_caret := caret_position
--					char_cursor := 1
--					start := True
--				until
--					char_cursor > xml.count
--				loop
--					curr_char := a_xml.item (char_cursor)
--					if curr_char = '<' and then not start then
--						if a_xml.substring (char_cursor, char_cursor + 1).is_equal ("</") then
--							new_xml.extend ('%N')
--							new_xml := add_tabs_to_text (new_xml, tab_count)
--							tab_count := tab_count - 1
--						else
--							new_xml.extend ('%N')
--							tab_count := tab_count + 1
--							new_xml := add_tabs_to_text (new_xml, tab_count)
--						end
--					else
--						start := False
--					end
--					new_xml.extend (curr_char)
--					char_cursor := char_cursor + 1
--				end
--				insert_text (new_xml)
--				select_region (init_caret, init_caret + new_xml.count - 1)
--			end
--		end		

	insert_xml_formatted (a_xml: STRING) is
			-- Insert 'xml' into Current text, pretty formatted
		require
			is_valid_xml_text (a_xml)
		do
			insert_text (pretty_xml (a_xml))	
		end	
		
	add_tabs_to_text (txt: STRING; tab_no: INTEGER): STRING is
			-- Apply tabbing to 'txt'.  Start from end and
			-- insert 'tab_no' tabs
		local
			cnt: INTEGER
		do
			from
				cnt := 0
				create Result.make_from_string (txt)
			until
				cnt = tab_no
			loop
				Result.extend ('%T')
				cnt := cnt + 1
			end
		end	
		
	set_tag_case (to_upper: BOOLEAN) is
			-- Make XML tags `to_upper'
		local
			new_xml: STRING
			curr_char: CHARACTER
			char_cursor: INTEGER
			in_tag, at_attributes: BOOLEAN
		do
			create new_xml.make_empty
			from
				char_cursor := 1
			until
				char_cursor > text.count
			loop
				curr_char := text.item (char_cursor)
				if curr_char = '<' and not in_tag then
					in_tag := True
				elseif curr_char = '>' and in_tag then
					in_tag := False
					at_attributes := False
				end
				if in_tag and then not at_attributes and then 
					not (text.item (char_cursor + 1) = '?') and then
					not (text.item (char_cursor + 1) = '!') then
					if curr_char.is_alpha then
						if to_upper then
							curr_char := curr_char.upper
						else
							curr_char := curr_char.lower
						end						
					end
					if curr_char = ' ' then
						at_attributes := True
					end
				elseif in_tag and then
					((text.item (char_cursor + 1) = '?') or (text.item (char_cursor + 1) = '!')) then
					at_attributes := True
				end
				char_cursor := char_cursor + 1
				new_xml.extend (curr_char)
			end
			set_text ("")
			insert_text (new_xml)
		end		

	tag_selection (a_tag: STRING) is
			-- Enclose `selected_text' in XML `a_tag'.  Eg, `some_text'
			-- becomes '<a_tag>some_text</a_tag>'.  If there is no selection
			-- just insert '<a_tag></a_tag>'.
		local
			l_text: STRING
		do
			create l_text.make_from_string ("<" + a_tag + ">")
			if has_selection then
				l_text.append (selected_text)
				cut_selection
			end
			l_text.append ("</" + a_tag + ">")
			insert_text (l_text)
			select_region (caret_position, caret_position + l_text.count - 1)
			if current_line_number > 9 then
				scroll_to_line (current_line_number - 10)
			end			
		end		

	update_subject is
			-- Update the observed subject of changes so it can update
			-- all of it observers
		do
			should_update := False
			document.set_text (text)
			update_line_display
			should_update := True
		end 

feature -- Query

	is_modified: BOOLEAN
			-- Has text been modifed?	

feature -- Access

	xml: XM_DOCUMENT is
			-- XML Document representation of `text' if `text' is valid XML, Void otherwise
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
			set_text (document.text)
		end
	
feature {NONE} -- Implementation

	internal_xml: like xml
			-- XML

	editor: DOCUMENT_EDITOR
			-- The parent editor

	schema_validator: SCHEMA_VALIDATOR
			-- Schema Validator	

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
				Result := Result.substring (1, Result.index_of (' ', 1))
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
					children := clone (schema_element.children)
				elseif not schema_element.type_children.is_empty then
					children := clone (schema_element.type_children)
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

end -- class DOCUMENT_TEXT_WIDGET
