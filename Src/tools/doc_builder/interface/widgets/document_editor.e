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
			set_split_position (300)
		end
		
	initialize_accelerators is
			-- Initialize the accelerators for the system
		local
			key: EV_KEY
			key_constants: EV_KEY_CONSTANTS
			accelerator: EV_ACCELERATOR
		once
			initialize_tag_accelerators
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
			
				-- Ctrl-S
			create key.make_with_code (key_constants.Key_s)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent save_document)
			Application_window.accelerators.extend (accelerator)
			
				-- Tab
			create key.make_with_code (key_constants.key_tab)
			create accelerator.make_with_key_combination (key, True, False, False)
			accelerator.actions.extend (agent indent_selection (True))
			Application_window.accelerators.extend (accelerator)
			
				-- Shift-Tab
			create key.make_with_code (key_constants.Key_tab)
			create accelerator.make_with_key_combination (key, True, False, True)
			accelerator.actions.extend (agent indent_selection (False))
			Application_window.accelerators.extend (accelerator)
		end
		
	initialize_tag_accelerators is
			-- Initialize default accelerators which add XML tags into the editor
		local
			key: EV_KEY
			key_constants: EV_KEY_CONSTANTS
			accelerator: EV_ACCELERATOR
		do
			create key_constants
			
				-- Ctrl-B
			create key.make_with_code (key_constants.Key_b)
			create accelerator.make_with_key_combination (key, True, False, False)
			add_tag_accelerator (accelerator, "bold")	
			
				-- Ctrl-I
			create key.make_with_code (key_constants.Key_i)
			create accelerator.make_with_key_combination (key, True, False, False)
			add_tag_accelerator (accelerator, "italic")		
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
		do
			if not clipboard_empty then
				if current_widget.internal_edit_widget.has_selection then
					current_widget.internal_edit_widget.delete_selection
				end
				current_widget.internal_edit_widget.insert_text (Clipboard.text)
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
					l_text := l_widget.pretty_xml (l_text)
					current_document.set_text (l_text)
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

	indent_selection (is_shift: BOOLEAN) is
			-- Indent selection by tab
		do
			-- TO DO		
		end		

feature -- GUI Commands			
		
	display_document is
			-- Display `current_document'
		require
			has_open_document: has_open_document
		do			
			if not notebook.has (current_widget) then
				current_widget.internal_edit_widget.resize_actions.block			
				notebook.extend (current_widget)
				current_widget.internal_edit_widget.resize_actions.resume
			end			
			notebook.set_item_text (current_widget, current_widget.title)
			notebook.selection_actions.block
			notebook.select_item (current_widget)			
			notebook.selection_actions.resume
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
--			refresh
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
				if preferences.font /= Void then					
					l_widget.internal_edit_widget.set_font (preferences.font)	
				end
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
		
feature -- Implementation

	notebook: EV_NOTEBOOK
			-- Notebook

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

	add_document (a_doc: DOCUMENT) is
			-- Add a document
		require
			a_doc_not_void: a_doc /= Void
		do
			if not documents.has (a_doc) then
				documents.extend (a_doc)
			end			
		end		

	tag_selection (a_tag: STRING) is
			-- Enclose `selected_text' in XML `a_tag'.  Eg, `some_text'
			-- becomes '<a_tag>some_text</a_tag>'.  If there is no selection
			-- just insert '<a_tag></a_tag>'.		
		do
			current_widget.internal_edit_widget.tag_selection (a_tag)
		end	

end -- class DOCUMENT_EDITOR
