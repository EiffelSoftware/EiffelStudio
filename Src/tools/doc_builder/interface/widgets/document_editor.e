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
			
--				-- Ctrl-A
--			create key.make_with_code (key_constants.Key_a)
--			create accelerator.make_with_key_combination (key, True, False, False)
--			accelerator.actions.extend (agent select_all)
--			Application_window.accelerators.extend (accelerator)
--			
--				-- Ctrl-B
--			create key.make_with_code (key_constants.Key_b)
--			create accelerator.make_with_key_combination (key, True, False, False)
--			accelerator.actions.extend (agent tag_selection ("bold"))
--			Application_window.accelerators.extend (accelerator)
--			
--				-- Ctrl-I
--			create key.make_with_code (key_constants.Key_i)
--			create accelerator.make_with_key_combination (key, True, False, False)
--			accelerator.actions.extend (agent tag_selection ("italic"))
--			Application_window.accelerators.extend (accelerator)
			
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
			
				-- Ctrl-V
			create key.make_with_code (key_constants.Key_v)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent paste_text)
			Application_window.accelerators.extend (accelerator)			
		end
		
feature -- Editing		
		
	cut_text is
			-- Cut
		do
			clip_text := current_widget.internal_edit_widget.selected_text
			current_widget.internal_edit_widget.delete_selection
		end
		
	copy_text is
			-- Copy
		do
			clip_text := current_widget.internal_edit_widget.selected_text
		end	
		
	paste_text is
			-- Paste
		do
			if current_widget.internal_edit_widget.has_selection then
				current_widget.internal_edit_widget.delete_selection
			end
			current_widget.internal_edit_widget.insert_text (clip_text)
		end		
		
	pretty_print_text is
			-- Pretty XML format the selected text
		local
			init_caret: INTEGER
			l_text: STRING
			l_widget: DOCUMENT_TEXT_WIDGET
		do
			l_widget := current_widget.internal_edit_widget
			if l_widget /= Void then
				init_caret := l_widget.caret_position
				if not l_widget.has_selection then					
					l_widget.select_all
				end
				l_text := l_widget.selected_text
				if l_widget.can_insert (l_text) then
					cut_text
					l_widget.insert_xml_formatted (l_text)
				else
					l_widget.deselect_all
				end
			end
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
				else
					Shared_document_manager.remove_document (current_document)
				end
			end
			Documents.prune (current_document)
			close_widget		
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
		do
			if Shared_document_manager.has_schema then 
				if current_widget /= Void then
					l_widget := current_widget.internal_edit_widget
					if not l_widget.is_valid_xml then
						l_widget.error_report.show
						l_widget.highlight_xml_error
					elseif not l_widget.is_valid_to_schema then
						l_widget.error_report.show
						l_widget.highlight_schema_error
					else 
						parent_window.update_status_report (False, (create {MESSAGE_CONSTANTS}).file_schema_valid_report)						
						Shared_project.remove_invalid_file (l_widget.document.name)
					end
				end
			end
		end	
		
	open_search_dialog is
			-- Open the search dialog for text searching
		do
			Shared_dialogs.search_dialog.set_document (current_widget.internal_edit_widget)
			Shared_dialogs.search_dialog.show_relative_to_window (Application_window)
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
			Result := clip_text /= Void and then not clip_text.is_empty	
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
		
feature -- Access

	documents: ARRAYED_LIST [DOCUMENT] is
			-- Currently open documents
		once
			create Result.make (1)
			Result.compare_objects
		end		

	current_document: DOCUMENT
			-- Currently open document

feature -- Events		
		
	document_changed is
			-- User selected another open document in notebook
		local
			l_widget: like current_widget
		do
			if current_widget /= Void then
				l_widget ?= notebook.selected_item
				set_current_document (l_widget.document)
				if current_widget /= Void then
					parent_window.update_status_report (False, current_document.name)
				else
					parent_window.update_status_report (False, "No document loaded")
				end
			end			
		end					
		
feature -- Access
	
	parent_window: DOC_BUILDER_WINDOW
			-- Parent window		
		
feature {DOCUMENT_EDITOR, DOC_BUILDER_WINDOW} -- Implementation

	notebook: EV_NOTEBOOK
			-- Notebook
	
	current_widget: DOCUMENT_WIDGET is
			-- Widget of `current_document'
		do
			Result := current_document.widget
		end
			
	clip_text: STRING
			-- Clipboard text

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

end -- class DOCUMENT_EDITOR
