indexing
	description: "Notebook Editor for multiple document editing.  Notebook holds widgets%
		%of type DOCUMENT_WIDGET, a composite widget class for DOCUMENTs."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_EDITOR

inherit
	SHARED_OBJECTS
	
	UTILITY_FUNCTIONS
		
create
	default_create

feature -- Initialization

	initialize (widget: EV_NOTEBOOK; window: DOC_BUILDER_WINDOW) is
			-- Initialize
		do
			notebook := widget
			parent_window := window
			initialize_accelerators
		end
		
	initialize_accelerators is
			-- Initialize the accelerators for the system
		local
			key: EV_KEY
			key_constants: EV_KEY_CONSTANTS
			accelerator: EV_ACCELERATOR
		once
			create key_constants			

				-- Ctrl-A
			create key.make_with_code (key_constants.Key_a)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent select_all)
			Application_window.accelerators.extend (accelerator)

				-- Ctrl-C
			create key.make_with_code (key_constants.Key_c)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent copy_text)
			Application_window.accelerators.extend (accelerator)
			
				-- Ctrl-X
			create key.make_with_code (key_constants.Key_x)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent cut_text)
			Application_window.accelerators.extend (accelerator)			
			
				-- Ctrl-F
			create key.make_with_code (key_constants.Key_f)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent open_search_dialog)
			Application_window.accelerators.extend (accelerator)
		end
		
feature -- Editing		
		
	cut_text is
			-- Cut
		do
			copy_text
			current_widget.internal_edit_widget.delete_selection
		end
		
	copy_text is
			-- Copy
		local
			l_text: STRING
		do
			l_text := current_widget.internal_edit_widget.selected_text
			if l_text /= Void and then not l_text.is_empty then
				clipboard.set_text (l_text)	
			end
		end	
		
	paste_text is
			-- Paste
		local
			l_line: INTEGER
		do
			if not clipboard_empty then
				l_line := current_widget.internal_edit_widget.current_line_number
				if current_widget.internal_edit_widget.has_selection then
					current_widget.internal_edit_widget.delete_selection
				end
				current_widget.internal_edit_widget.insert_text (Clipboard.text)
				current_widget.internal_edit_widget.scroll_to_line (l_line)
			end
		end		
	
	select_all is
			-- Select all text in open document
		do
			current_widget.internal_edit_widget.select_all	
		end	
		
	pretty_print_text is
			-- Pretty XML format the current document
		local
			l_text: STRING
			l_widget: DOCUMENT_TEXT_WIDGET
		do
			l_widget := current_widget.internal_edit_widget
			if l_widget /= Void then							
				l_widget.select_all
				l_text := l_widget.selected_text
				if l_widget.can_insert (l_text) then					
					l_widget.set_text ("")
					Clipboard.set_text (l_widget.pretty_xml (l_text))
					paste_text
				else
					l_widget.deselect_all
				end
			end
		end

	pretty_format_code_text is
			-- Pretty format the selected text as Eiffel code
		local
			l_widget: DOCUMENT_TEXT_WIDGET
			l_code_formatter: CODE_FORMATTER
			l_old_text: STRING
		do
			l_widget := current_widget.internal_edit_widget
			if l_widget /= Void and l_widget.has_selection then					
				create l_code_formatter
				l_code_formatter.format (l_widget.selected_text.twin)												
				if not clipboard_empty then
					l_old_text := clipboard.text
				end
				Clipboard.set_text (l_code_formatter.text)
				paste_text
				if l_old_text /= Void then
					clipboard.set_text (l_old_text)
				end
			end
		end

	toggle_word_wrap is
			-- Toggle word wrap
		do
			if parent_window.wrap_menu_item.is_selected then
				current_widget.internal_edit_widget.enable_word_wrapping
			else
				current_widget.internal_edit_widget.disable_word_wrapping
			end
			current_widget.internal_edit_widget.set_font (preferences.font)
		end		

feature -- GUI Commands			
		
	display_document is
			-- Display `current_document'
		require
			has_open_document: has_open_document
		do			
			if not notebook.has (current_widget) then
				notebook.extend (current_widget)
			end			
			notebook.set_item_text (current_widget, current_widget.title)
			notebook.select_item (current_widget)			
		end		
	
	close_widget is
			-- Hide widget of `current_document'
		do
			notebook.prune (current_document.widget)			
		end		

feature -- Commands
	
	load_document (a_doc: DOCUMENT) is
			-- Load document
		require
			a_doc_not_void: a_doc /= Void
		do
			add_document (a_doc)
			set_current_document (a_doc)
			display_document
			Application_window.update
		end
		
	close_documents is
			-- Remove all open documents
		do
			notebook.wipe_out
			from
				Documents.start
			until
				Documents.after
			loop
				close_document
				Documents.forth
			end
		end		

	close_document is
			-- Close `current_document'
		local
			l_constants: EV_DIALOG_CONSTANTS
			l_question_dialog: EV_MESSAGE_DIALOG
		do			
			if current_document.is_modified then
				create l_constants
				create l_question_dialog.make_with_text ((create {MESSAGE_CONSTANTS}).file_save_prompt)
				l_question_dialog.set_title (l_constants.ev_save)
				l_question_dialog.set_buttons (<<l_constants.ev_yes, l_constants.ev_no>>)
				l_question_dialog.show_modal_to_window (parent_window)
				if l_question_dialog.selected_button.is_equal (l_constants.ev_yes) then
					save_document
				end
			end								
			shared_document_manager.remove_document (current_document)
			documents.prune (current_document)
			close_widget
			refresh
		end	

	save_document is
			-- Called by `select_actions' of `save_xml_menu_item'.
		do
			current_document.save
		end			
		
	format_tags is
			-- Called by `select actions' of `menu_uppercase_tags'
		do
			if Shared_constants.Application_constants.tags_uppercase then
				current_widget.internal_edit_widget.set_tag_case (True)
			else
				current_widget.internal_edit_widget.set_tag_case (False)
			end
		end		
		
	validate_document is
			-- Validate current document to loaded schema
		local
			l_widget: DOCUMENT_TEXT_WIDGET
			l_error: BOOLEAN
		do
			if Shared_document_manager.has_schema then 
				if current_widget /= Void then
					l_widget := current_widget.internal_edit_widget
					if not l_widget.is_valid_xml then
						l_error := True
						parent_window.update_status_report (True, ("Invalid XML"))
					elseif not l_widget.is_valid_to_schema then
						l_error := True
						parent_window.update_status_report (True, ("Invalid to schema"))
					else 
						parent_window.update_status_report (False, (create {MESSAGE_CONSTANTS}).file_schema_valid_report)						
						Shared_project.remove_invalid_file (l_widget.document.name)
					end
					if l_error and then Shared_constants.Application_constants.is_gui_mode then
						l_widget.error_report.show
						l_widget.highlight_error
					end
				end
			end
		end	
		
	open_search_dialog is
			-- Open the search dialog for text searching
		do
			if has_open_document then
				Shared_dialogs.search_dialog.set_widget (current_widget.internal_edit_widget)
				Shared_dialogs.search_dialog.show_relative_to_window (application_window)
			end			
		end

feature -- Query	

	is_document_open (a_name: STRING): BOOLEAN is
			-- Is there a document with 'a_name' already open?
		require
			a_name_not_void: a_name /= Void
		do
			from
				documents.start
			until
				documents.after or Result
			loop
				Result := documents.item.name.is_equal (a_name)
				documents.forth
			end
		end		

	has_open_document: BOOLEAN is
			-- Is a document open for editing?
		do
			Result := current_document /= Void	
		end		
		
	clipboard_empty: BOOLEAN is
			-- Is clipboard empty?
		do
			Result := clipboard.text.is_empty
		end			

feature -- Status Setting

	set_current_document (a_doc: DOCUMENT) is
			-- make `a_doc' document with focus
		require
			document_not_void: a_doc /= Void
		do
			current_document := a_doc
		ensure
			is_current_document: a_doc = current_document
		end			

	set_split_position (a_split_position: INTEGER) is
			-- Set split_position
		do
			split_position := a_split_position
		end		

feature -- Access

	documents: ARRAYED_LIST [DOCUMENT] is
			-- Currently open documents
		once
			create Result.make (1)
			Result.compare_objects
		end		

	current_document: DOCUMENT
			-- Currently open document

	current_widget: DOCUMENT_WIDGET is
			-- Widget of `current_document'
		do
			if current_document /= Void then
				Result := current_document.widget				
			end
		end

	preferences: DOCUMENT_EDITOR_PREFERENCES is
			-- Editor preferences
		once
			create Result.make (Current)
		end		

	clipboard: EV_CLIPBOARD is
			-- Clipboard
		once
			Result := (create {EV_ENVIRONMENT}).application.clipboard
		end	

feature -- Events				
		
	refresh is
			-- User selected another open document in notebook
		local
			l_widget: like current_widget
		do
			l_widget ?= notebook.selected_item
			if l_widget /= Void then
				shared_dialogs.search_dialog.set_widget (l_widget.internal_edit_widget)
				set_current_document (l_widget.document)
				l_widget.internal_edit_widget.set_font (preferences.font)				
				l_widget.update
			else
				set_current_document (Void)
			end			
			parent_window.update
		end					
		
feature -- Access
	
	parent_window: DOC_BUILDER_WINDOW
			-- Parent window		
			
	split_position: INTEGER
			-- Split position in pixels
		
feature {DOCUMENT_EDITOR, DOC_BUILDER_WINDOW, ERROR_ACTIONS, DOCUMENT_WIDGET} -- Implementation

	notebook: EV_NOTEBOOK
			-- Notebook

feature {NONE} -- Implementation

	add_document (a_doc: DOCUMENT) is
			-- Add a document
		require
			a_doc_not_void: a_doc /= Void
		do
			if not documents.has (a_doc) then
				documents.extend (a_doc)
			end			
		end		

feature -- Temporary

	do_document_test is
			-- Do testing on current document
		local
			l_xml: XML_ROUTINES
		do
			create l_xml
			l_xml.format_document (l_xml.deserialize_text (current_document.text), current_document.name)
			current_document.set_text (l_xml.last_ostring)
		end	

end -- class DOCUMENT_EDITOR
