indexing
	description: "A basic text editor."
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_WINDOW

inherit
	EDITOR_WINDOW_IMP


	TEXT_OBSERVER
		undefine
		    copy,
		    default_create
		redefine
			on_cursor_moved
		end

feature -- Access

	initialize_preferences is
			-- Initialize the preferences
		local
			l_editor_data: EDITOR_DATA
			l_env: EXECUTION_ENVIRONMENT
			l_path: FILE_NAME
		do
			create l_env
			create l_path.make_from_string (l_env.current_working_directory)
			l_path.extend ("default.xml")
			create preferences.make_with_default_values_and_location (l_path.string, "HKEY_CURRENT_USER\Software\ISE\Eiffel\EditorPrefs")
			create l_editor_data.make (preferences)
			goto_line_button.select_actions.extend (agent goto_line)
			select_char_button.select_actions.extend (agent select_chars)
			select_line_button.select_actions.extend (agent select_lines)
		end
			
	preferences: PREFERENCES	

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			initialize_preferences
			editor_container.extend (text_panel.widget)	 		
			add_header
			preferences_button.select_actions.extend (agent show_preferences_window)
			open_file.select_actions.extend (agent open_document)
			cut_tb.select_actions.extend (agent text_panel.cut_selection)
			copy_tb.select_actions.extend (agent text_panel.copy_selection)
			paste_tb.select_actions.extend (agent text_panel.paste)
			editable_check.select_actions.extend (agent toggle_editable)
			line_number_check.select_actions.extend (agent toggle_show_line_numbers)
			invisible_symbol_check.select_actions.extend (agent toggle_invisible_symbols)
		end

	add_header is
			-- 
		do
			create header.make_with_panel (text_panel)
			editor_container.extend (header.container)
			editor_container.disable_item_expand (header.container)	
			header.selection_actions.extend (agent on_document_change)
			header.open_document (create {TEXT_PANEL_HEADER_ITEM}.make ("C:\test.e"))
		end	
		
	header: TEXT_PANEL_HEADER

feature {NONE} -- Preference information	
		
	show_preferences_window is
	        -- Display available preferences
	   	do
	   		if preference_window = Void or else preference_window.is_destroyed then
					-- Preference tool is not currently displayed, create and display it.
				create preference_window.make (preferences, Current)
			else
					-- Preference is currently displayed, raise it.
				preference_window.raise
			end
	   	end		
		
	system_preferences_location: FILE_NAME is
			-- System preferences location
		do
			create Result.make_from_string ("")
		ensure
			Result_not_void: Result /= Void
		end	

	preference_window: PREFERENCES_TREE_WINDOW
	        -- Preference window

feature {NONE} -- Events
		
	on_document_change is
			-- Document was changed in header
		do
			text_panel.text_displayed.add_cursor_observer (Current)
			text_panel.text_displayed.add_selection_observer (Current)		
		end		
		
	toggle_editable is
	        -- Toggle if editor panel is user editable
		do		
			if text_panel.is_editable then
				text_panel.disable_editable
		   	else
		   		text_panel.enable_editable
			end			
		end
		
	toggle_show_line_numbers is
	        -- Toggle line number display
		do	
			text_panel.toggle_line_number_display
		end
		
	toggle_invisible_symbols is
	        -- Toggle invisible panel symbols (new lines, tabs, etc)
		do		    
			text_panel.toggle_view_invisible_symbols
		end

	goto_line is
			-- 
		do
			text_panel.display_line_with_context (goto_line_text.text.to_integer)
		end
	
	select_chars is
			-- 
		do
			
		end
		
	select_lines is
			-- 
		do
			text_panel.select_lines (select_line_start_text.text.to_integer, select_line_end_text.text.to_integer)
		end

feature {NONE} -- Implementation

	open_document is
			-- Open document from disk
		local
			l_open_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_open_dialog
			l_open_dialog.show_modal_to_window (Current)
			if l_open_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_open) then
				header.open_document (create {TEXT_PANEL_HEADER_ITEM}.make (l_open_dialog.file_name))
			end
		end	
	 	
	 text_panel: GENERIC_EDITOR is
	        -- Editor.
	 	once
	 	    create Result
			register_documents (Result)			
	 	end		 		
	 	
	 register_documents (a_panel: TEXT_PANEL) is
	 		-- Register syntax definition files for particular document types
	 	do
	 		if eiffel_class /= Void then
	 			a_panel.register_document ("e", eiffel_class)
	 		end
	 		if xml_class /= Void then
	 			a_panel.register_document ("xml", xml_class)
	 		end
	 	   	if java_class /= Void then
	 	   		a_panel.register_document ("java", java_class)
	 	   	end	 	   	
	 	end	 	
	 	
	 eiffel_class: DOCUMENT_CLASS is
	         -- Eiffel syntax definition
	   	once
	   		if eiffel_syntax_file_location /= Void then
	   	    	create Result.make ("eiffel", "e", eiffel_syntax_file_location)
	   	   	end
	   	end
	 
	 xml_class: DOCUMENT_CLASS is
	         -- XML syntax definition     	
	   	once
	   		if xml_syntax_file_location /= Void then
		   	    create Result.make ("xml", "xml", xml_syntax_file_location)
		   	end
	   	end	
	   	
	 java_class: DOCUMENT_CLASS is
	         -- Java syntax definition      	
	   	once
	   		if java_syntax_file_location /= Void then
		   	    create Result.make ("xml", "xml", java_syntax_file_location)
		  	end
	   	end	

	eiffel_syntax_file_location: STRING is
			-- Location to find file containing syntax definition for Eiffel files.  Redefine this if necessary to point to the right file.
		local
			l_exec: EXECUTION_ENVIRONMENT
			l_filename: FILE_NAME
			inst_dir: STRING
		once
			create l_exec
			inst_dir := l_exec.get ("EIFFEL_SRC")
			if inst_dir /= Void then				
				create l_filename.make_from_string (inst_dir)
				l_filename.extend_from_array (<<"library", "editor", "text_window", "text", "lexer", "syntax_definitions" >>)
				l_filename.extend ("eiffel.syn")
				Result := l_filename.string
			end
		end		
		
	xml_syntax_file_location: STRING is
			-- Location to find file containing syntax definition for XML files.  Redefine this if necessary to point to the right file.
		local
			l_exec: EXECUTION_ENVIRONMENT
			l_filename: FILE_NAME
			inst_dir: STRING
		once
			create l_exec
			inst_dir := l_exec.get ("EIFFEL_SRC")
			if inst_dir /= Void then				
				create l_filename.make_from_string (inst_dir)
				l_filename.extend_from_array (<<"library", "editor", "text_window", "text", "lexer", "syntax_definitions" >>)
				l_filename.extend ("xml.syn")
				Result := l_filename.string
			end
		end		
		
	java_syntax_file_location: STRING is
			-- Location to find file containing syntax definition for Java files.  Redefine this if necessary to point to the right file.
		local
			l_exec: EXECUTION_ENVIRONMENT
			l_filename: FILE_NAME
			inst_dir: STRING
		once
			create l_exec
			inst_dir := l_exec.get ("EIFFEL_SRC")
			if inst_dir /= Void then				
				create l_filename.make_from_string (inst_dir)
				l_filename.extend_from_array (<<"library", "editor", "text_window", "text", "lexer", "syntax_definitions" >>)
				l_filename.extend ("java.syn")
				Result := l_filename.string
			end
		end		

feature {NONE} -- Observation

	on_cursor_moved is
			-- Cursor was moved
		local
			line: EDITOR_LINE
			token: EDITOR_TOKEN
			internal: INTERNAL
			l_string: STRING
			l_label: EV_LABEL
			l_line_count: INTEGER
		do
			create internal	
			
				-- Cursor information
			cursor_text_position.set_text ("Position: " + text_panel.text_displayed.cursor.pos_in_characters.out)	
			line_number.set_text ("Line number: " + text_panel.text_displayed.current_line_number.out)
			cursor_line_pos.set_text ("Line position: " + text_panel.text_displayed.cursor.x_in_characters.out)				
			if text_panel.has_selection then				
				status_label.set_text ("Selected text (" + text_panel.text_displayed.selection_cursor.pos_in_text.out + " - " + 
					text_panel.text_displayed.cursor.pos_in_text.out + ")")		
			else
				status_label.set_text ("No text selected")
			end
			
				-- Line information
			line :=	text_panel.text_displayed.line (text_panel.text_displayed.current_line_number) 
			if line /= Void and then line_info_check.is_selected then
				from
					line.start
					line_info_box.wipe_out
					l_string := ""
				until							
					line.after
				loop
					create l_label.make_with_text
					(
							line.item.image + 
							" (" + 
							internal.type_name_of_type (internal.dynamic_type (line.item)) + 
							")"						
					)		
					l_label.align_text_left					
					line_info_box.extend (l_label)
					line_info_box.disable_item_expand (l_label)
					line.forth
				end
			else
				line_info_box.wipe_out
			end
			
				-- Current token information				
			token := text_panel.text_displayed.cursor.token
			if token = Void then
				token_info_label.set_text ("No current token")
			else							
				token_info_label.set_text 
					(
						internal.type_name_of_type (internal.dynamic_type (token)) + "%N" +
						"Line pos: " + token.position.out + "%N" +
						"Chars: " + token.length.out + "%N" +
						"Width: " + token.width.out + "%N" +
						"Margin: " + token.is_margin_token.out + "%N" +
						"Image: " + token.image + "%N" +
						"Position: " + token.position.out + "%N"						
					)
					
			end
			
				-- Line information
			l_line_count := text_panel.text_displayed.number_of_lines
				
			goto_line_text.value_range.resize_exactly (1, l_line_count)	
			
--			select_char_start_text.value_range.resize_exactly (1, text_panel.text_displayed.las)
--			select_char_end_text.value_range.resize_exactly (1, l_line_count)
			
			select_line_start_text.value_range.resize_exactly (1, l_line_count)
			select_line_end_text.value_range.resize_exactly (1, l_line_count)
		end			
	
end -- class EDITOR_WINDOW

