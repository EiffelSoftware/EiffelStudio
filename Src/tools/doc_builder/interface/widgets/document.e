indexing
	description: "Editor Documents."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT

inherit
	DOCUMENT_XML
		rename
			validator as xml_validator,
			text as document_xml_text,
			make_from_file as make_xml_from_file,
			initialize as initialize_xml
		undefine
			copy, 
			default_create
		redefine
			is_valid_xml
		end
	
	EV_TEXT
		rename
			initialize as initialize_parent
		end

	SHARED_OBJECTS
		undefine 
			copy,
			default_create
		end
	
	UTILITY_FUNCTIONS
		undefine 
			copy,
			default_create
		end

create
	make_new,
	make_from_file

feature -- Initialization

	make_new (a_name: STRING; a_editor: DOCUMENT_EDITOR) is
			-- Make new document
		require
			a_name_not_void: a_name /= Void
		do
			editor := a_editor
			default_create
			name := a_name
			display_name := a_name
			initialize_xml
			initialize
		end
		
	make_from_file (a_file: PLAIN_TEXT_FILE; a_editor: DOCUMENT_EDITOR) is
			-- Make from existing file
		require
			file_not_void: a_file /= Void
			file_exists: a_file.exists
		do
			default_create
			editor := a_editor			
			make_xml_from_file (a_file)
			file.open_read
			file.read_stream (file.count)
			append_text (file.last_string)
			file.close
			initialize
		ensure
			has_file: file /= Void
		end		
		
	initialize is
			-- Initialization
		do
			create schema_validator
			create links.make (3)
			create invalid_links.make_empty ("Invalid links")
			
			if Shared_constants.Application_constants.is_gui_mode then
				initialize_accelerators
				change_actions.extend (agent editor.document_edited)
				pointer_button_release_actions.force_extend (agent update)
				pointer_button_press_actions.extend (agent pointer_pressed (?,?,?,?,?,?,?,?))
				key_release_actions.force_extend (agent update)
				drop_actions.extend (agent insert_xml (?))
				drop_actions.set_veto_pebble_function (agent can_insert_xml (?))
	--			disable_word_wrapping
			end
		end

	initialize_accelerators is
			-- Initialize the accelerators for the system
		local
			key: EV_KEY
			key_constants: EV_KEY_CONSTANTS
			accelerator: EV_ACCELERATOR
		do
				-- Ctrl-A
			create key.make_with_code (key_constants.Key_a)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent select_all)
			Application_window.accelerators.extend (accelerator)
			
				-- Ctrl-C
			create key.make_with_code (key_constants.Key_c)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent editor.copy_text)
			Application_window.accelerators.extend (accelerator)
			
				-- Ctrl-X
			create key.make_with_code (key_constants.Key_x)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent editor.cut_text)
			Application_window.accelerators.extend (accelerator)
			
				-- Ctrl-V
			create key.make_with_code (key_constants.Key_v)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent editor.paste_text)
			Application_window.accelerators.extend (accelerator)
			
				-- Ctrl-B
			create key.make_with_code (key_constants.Key_b)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent tag_selection ("<bold>"))
			Application_window.accelerators.extend (accelerator)
			
				-- Ctrl-I
			create key.make_with_code (key_constants.Key_i)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent tag_selection ("<italic>"))
			Application_window.accelerators.extend (accelerator)
		end	

feature -- Access	
	
	links: ARRAYED_LIST [DOCUMENT_LINK]
			-- Links in Current		
	
	display_name: STRING
			-- Name to display in Editor for file		

	error_report: ERROR_REPORT
			-- Validation error string
			
	toc_data: DOCUMENT_TOC_DATA is
			-- TOC data for Current
		local
			l_xm_doc: XM_DOCUMENT
			l_element, l_toc_element: XM_ELEMENT
			l_att: XM_ATTRIBUTE
			l_title, l_toc_location: STRING
		do
			if is_valid_xml and then is_valid_to_schema then
				l_xm_doc := deserialize_text (text)
				l_element ?= l_xm_doc.root_element.element_by_name ("help")
				if l_element /= Void  then
					l_toc_element := l_element.element_by_name ("toc")
				end
				
						-- Determine correct TOC title
				if Shared_constants.Application_constants.is_studio then
					if l_toc_element /= Void then
						l_element := l_toc_element.element_by_name ("studio_title")
						if l_element /= Void then							
							l_title := l_element.text
						end
						l_element := l_toc_element.element_by_name ("studio_location")
						if l_element /= Void then
							l_toc_location := l_element.text
						end
					end
				elseif Shared_constants.Application_constants.is_envision then
					if l_toc_element /= Void then
						l_element := l_toc_element.element_by_name ("envision_title")
						if l_element /= Void then
							l_title := l_element.text
						end
						l_element := l_toc_element.element_by_name ("envision_location")
						if l_element /= Void then
							l_toc_location := l_element.text
						end
					end
				end
			end
			
			if l_title /= Void then
				l_title.prune_all ('%N')
				l_title.prune_all ('%T')
			end			
			if l_title = Void or l_title.is_empty then
				l_title := title
			end
			
			if l_toc_location /= Void then
				l_toc_location.prune_all ('%N')
				l_toc_location.prune_all ('%T')
			end			
			if l_toc_location = Void or l_toc_location.is_empty then
				l_toc_location := directory_no_file_name (name)
			end	
			
			create Result.make (l_title, l_toc_location, name)
			Result.set_document (Current)
		ensure
			has_result: Result /= Void
		end		

	properties: DOCUMENT_PROPERTIES_DIALOG is
			-- Properties dialog for Current
		require
			is_valid_to_schema
		do
			create Result.make (Current)
		end		

	invalid_links: ERROR_REPORT
			-- Invalid link errors

feature -- XML Access
			
	title: STRING is
			-- Document Title, Void if none or if Current is not valid xml.
		local
			l_xm_doc: XM_DOCUMENT
			l_element: XM_ELEMENT
			l_att: XM_ATTRIBUTE
		do
			if is_valid_xml then
				l_xm_doc := deserialize_text (text)
			end
			if l_xm_doc /= Void then
				l_element ?= l_xm_doc.root_element
				if l_element /= Void then
					l_att := l_element.attribute_by_name ("title")
					if l_att /= Void then
						Result := l_att.value
					end					
				end
			end
			if Result = Void then
				Result := (create {MESSAGE_CONSTANTS}).unknown_toc_title
			end
		ensure
			has_result: Result /= Void
		end
		
	output_filter_text: STRING is
			-- Document level output filter text (default: "all")
		local
			l_xm_doc: XM_DOCUMENT
			l_element: XM_ELEMENT
			l_att: XM_ATTRIBUTE
			l_value: STRING
		do
			if is_valid_xml then
				l_xm_doc := deserialize_text (text)
			end
			if l_xm_doc /= Void then
				l_element ?= l_xm_doc.root_element
				if l_element /= Void then
					l_att := l_element.attribute_by_name ("output")
					if l_att /= Void then
						l_value := l_att.value
					end					
				end
			end
			if l_value = Void or l_value.is_equal ("all") then
				Result := "all"
			elseif l_value.is_equal ("envision") then
				Result := "envision"
			elseif l_value.is_equal ("studio") then
				Result := "studio"
			end
		ensure
			has_result: Result /= Void
		end		
		
	output_filter: INTEGER is
			-- Document level output filter (default: all)
		local
			l_text: STRING
		do
			l_text := output_filter_text
			if l_text.is_equal ("all") then
				Result := feature {APPLICATION_CONSTANTS}.All_filter
			elseif l_text.is_equal ("envision") then
				Result := feature {APPLICATION_CONSTANTS}.Envision_filter
			elseif l_text.is_equal ("studio") then
				Result := feature {APPLICATION_CONSTANTS}.Studio_filter
			end
		ensure
			has_result: Result /= Void
		end	
			
	xml_text: STRING is
			-- Valid XML text of current
		local
			l_xml: XM_DOCUMENT
		do
			l_xml := deserialize_text (text)
			if l_xml /= Void then
				Result := document_text (l_xml)
			end
		end

feature -- Validation
			
	is_valid_xml: BOOLEAN is
			-- Is `text' valid xml?
		do
			if not text.is_empty then					
				Result := xml_validator.is_valid_xml_text (text)
				if not Result then
					error_report := xml_validator.error_report	
				end	
			end
		end		

	selection_is_valid_xml: BOOLEAN is
			-- Is `selected_text' valid XML?
		do
			if not text.is_empty then
				Result := xml_validator.is_valid_xml_text (selected_text)	
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
	
feature -- Statu sSetting

	add_link (a_url: DOCUMENT_LINK) is
			-- Add `a_url' to list of links
		require
			url_not_void: a_url /= Void
		do
			links.extend (a_url)
		end		
	
	change_name (a_new_name: STRING) is
			-- Change name of current on disk to `a_new_name'
		local
			l_dir: FILE_NAME
		do
			if is_persisted then
				create file.make (name)
				file.delete
				create l_dir.make_from_string (directory_no_file_name (name))
				l_dir.extend (a_new_name)
				name := l_dir.string
			else
				name := a_new_name
			end
		end		
	
feature -- Commands

	highlight_substring (a_string: STRING) is
			-- Highlight first occurence of `a_string' from `caret_position'.
			-- If can't be found from there then start from the beginning
		require
			a_string_not_void: a_string /= Void
			has_string: text.has_substring (a_string)
		local
			l_text: STRING
			cnt, line_no: INTEGER
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

	highlight_error (l_no, l_pos: INTEGER) is
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
			line_no := xml_validator.error_report.line_number
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

	save is
			-- Save current to disk
		local
			l_save_dialog: EV_FILE_SAVE_DIALOG
		do
			if not is_persisted then
				create l_save_dialog
				l_save_dialog.show_modal_to_window (editor.parent_window)
				if l_save_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_save) then
					internal_save (l_save_dialog.file_name)
				end
			else
				internal_save (name)
			end			
		end		
	
	set_modified (flag: BOOLEAN) is
			-- Set current to indicate it has been modified by user
		do
			is_modified := flag
			Shared_document_manager.add_modified_document (Current)
		end		
		
	insert_xml (xml: STRING) is
			-- Insert 'xml' into Current text
		require
			Xml_validator.is_valid_xml_text (xml)
		do
			insert_text (xml)
			select_region (caret_position, caret_position + xml.count - 1)
		end
		
	insert_xml_formatted (xml: STRING) is
			-- Insert 'xml' into Current text, formatted
		require
			Xml_validator.is_valid_xml_text (xml)
		local
			new_xml, tag: STRING
			char_cursor, tab_count, init_caret: INTEGER
			curr_char: CHARACTER
			start: BOOLEAN
		do
			if can_insert (xml) then
				create new_xml.make_empty
				xml.prune_all ('%N')
				xml.prune_all ('%T')
				from
					init_caret := caret_position
					char_cursor := 1
					start := True
				until
					char_cursor > xml.count
				loop
					curr_char := xml.item (char_cursor)
					if curr_char = '<' and then not start then
						if xml.substring (char_cursor, char_cursor + 1).is_equal ("</") then
							new_xml.extend ('%N')
							new_xml := add_tabs_to_text (new_xml, tab_count)
							tab_count := tab_count - 1
						else
							new_xml.extend ('%N')
							tab_count := tab_count + 1
							new_xml := add_tabs_to_text (new_xml, tab_count)
						end
					else
						start := False
					end
					new_xml.extend (curr_char)
					char_cursor := char_cursor + 1
				end
				insert_text (new_xml)
				select_region (init_caret, init_caret + new_xml.count - 1)
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
							curr_char := curr_char.to_upper (curr_char)
						else
							curr_char := curr_char.to_lower (curr_char)
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

	check_links is
			-- Check links.  Put invalid links into `invalid_links'.
		require
			valid_xml: is_valid_xml
			is_persisted: is_persisted
		local
			l_doc: XM_DOCUMENT
			l_formatter: XM_DOCUMENT_FORMATTER
			l_link: DOCUMENT_LINK
		do
			if invalid_links /= Void then
				invalid_links.clear	
			end
			l_doc := deserialize_document (create {FILE_NAME}.make_from_string (name))
			if l_doc /= Void then
				create l_formatter.make_with_document (Current)
				l_formatter.process_document (l_doc)
			end
			if not links.is_empty then
				create invalid_links.make_empty ("Invalid Links")
				from
					links.start
				until
					links.after
				loop
					if not links.item.exists then
						invalid_links.append_error ("File: " + name + " (Url: " + links.item.url + ")", 0, 0)
					end
					links.forth
				end
			end
		end		

	update_link (a_old, a_new: DOCUMENT_LINK) is
			-- Update all links in Current to `a_old' to link to `a_new'
		require
			old_link_not_void: a_old /= Void
			new_link_not_void: a_new /= void
		local
			l_doc: XM_DOCUMENT
			l_formatter: XM_DOCUMENT_FORMATTER
			l_link: DOCUMENT_LINK
		do
			do_update_link := True
			l_doc := deserialize_document (create {FILE_NAME}.make_from_string (name))
			if l_doc /= Void then
				create l_formatter.make_with_document (Current)
				l_formatter.set_links (a_old, a_new)
				l_formatter.process_document (l_doc)
				save_xml_document (l_doc, create {FILE_NAME}.make_from_string (name))
			end
			do_update_link := False
		end			

	set_links_relative is
			-- Set all links in Current to relative links
		do			
		end
		
	set_links_absolute is
			-- Set all links in Current to absolute links
		do			
		end

feature {XM_DOCUMENT_FORMATTER} -- Query 

	do_update_link: BOOLEAN
			-- Can links in Current be updated?

feature -- Query
		
	is_modified: BOOLEAN
			-- Has current been modified since it was opened for editing?
		
	can_insert_xml (object: ANY): BOOLEAN is
			-- Can xml be inserted into Current at current
			-- `caret_position' and still be valid according
			-- to loaded schema?
		local
			new_xml,
			xml_snippet: STRING
		do
			new_xml := text
			xml_snippet ?= object
			if xml_snippet /= Void and then Shared_document_manager.schema /= Void then
				new_xml.insert_string (xml_snippet, caret_position)
				Schema_validator.validate_against_text (new_xml, Shared_document_manager.schema.name)
				if Schema_validator.is_valid then
					Result := True
				else
					Result := False
					editor.parent_window.update_status_report (True, "Cannot insert this element as%
						% resulting xml would be invalid to project schema.")					
				end
			elseif text.is_empty then
				Result := True
			end
		end

	can_insert (xml: STRING): BOOLEAN is
			-- Can `xml' be inserted into Current?
		local
			l_constants: EV_DIALOG_CONSTANTS
			l_message_dialog: EV_MESSAGE_DIALOG
		do
			if not xml_validator.is_valid_xml_text (xml) then
				create l_message_dialog.make_with_text ((create {MESSAGE_CONSTANTS}).invalid_xml_dialog_title)
				l_message_dialog.set_text ((create {MESSAGE_CONSTANTS}).invalid_xml_file_warning)
				l_message_dialog.set_buttons (<<(create {EV_DIALOG_CONSTANTS}).ev_ok>>)
				l_message_dialog.show_modal_to_window (Application_window)
			elseif xml.has_substring ("code_block") then
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

	can_display, can_transform: BOOLEAN is
			-- Can we display/transform Current based on `output_filter'?
		local
			l_constants: APPLICATION_CONSTANTS
		do
			l_constants := Shared_constants.Application_constants
			Result := 
				output_filter = l_constants.output_filter or
				output_filter = l_constants.All_filter or
				l_constants.output_filter = l_constants.All_filter
		end		

feature {NONE} -- Implementation

	editor: DOCUMENT_EDITOR
			-- The parent editor 
			
	schema_validator: SCHEMA_VALIDATOR
			-- Schema Validator

	internal_save (a_filename: STRING) is
			-- Save with `a_filename'
		do
			if not is_persisted then
				set_name (a_filename)				
			end
			write_to_disk
		end		

	write_to_disk is
			-- Write Current text to disk
		local
			line_cnt: INTEGER
		do			
			if file /= Void and then not file.is_closed then
				file.close
			end
			create file.make_open_write (name)
			if file.is_open_write then
				file.putstring (text)
				file.flush
				file.close
				is_persisted := True
				set_modified (False)
			end
		end

	process_selection is
			-- Process selected text in Current
		do
			if has_selection then
				editor.parent_window.toggle_copy (True)
				editor.parent_window.toggle_cut (True)
				if selection_is_valid_xml then
					editor.parent_window.toggle_xml_format_button (True)
				else
					editor.parent_window.toggle_xml_format_button (False)
				end
			else
				editor.parent_window.toggle_copy (False)
				editor.parent_window.toggle_cut (False)
				if is_valid_xml then
					editor.parent_window.toggle_xml_format_button (True)
				else
					editor.parent_window.toggle_xml_format_button (False)
				end
			end			
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

	update_line_display is
			-- Update line display to reflect caret position
		do
			Application_window.update_status_line (current_line_number)	
		end		

	update is
			-- Update
		do
			process_selection
			update_line_display
			if not has_selection and then Shared_project.preferences.has_schema then
				Application_window.update_sub_element_list (sub_element_list (xml_parent))
			end
		end
		
	pointer_pressed (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Pointer was pressed, catch right-click
		local
			l_popup: EV_MENU
			l_menu_item: EV_MENU_ITEM			
			menu_children: SORTED_TWO_WAY_LIST [STRING]
		do
			if a_button = 3 then
				menu_children ?= sub_element_list (xml_parent)
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

invariant
	has_name: name /= Void
		
end -- class DOCUMENT
