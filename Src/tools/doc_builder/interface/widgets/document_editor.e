indexing
	description: "Notebook Editor for multiple document editing."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_EDITOR

inherit
	SHARED_OBJECTS
	
	UTILITY_FUNCTIONS
		
create
	default_create

feature -- Creation

	initialize (widget: EV_NOTEBOOK; window: DOC_BUILDER_WINDOW) is
			-- Initialize
		do
			notebook := widget
			parent_window := window
		end
		
feature -- Editing		
		
	cut_text is
			-- Cut
		do
			clip_text := current_document.selected_text
			current_document.delete_selection
			parent_window.toggle_paste (True)
		end
		
	copy_text is
			-- Copy
		do
			clip_text := current_document.selected_text
			parent_window.toggle_paste (True)
		end	
		
	paste_text is
			-- Paste
		do
			if current_document.has_selection then
				current_document.delete_selection
			end
			current_document.insert_text (clip_text)
		end		
		
	pretty_print_text is
			-- Pretty XML format the selected text
		local
			init_caret: INTEGER
			l_question_dialog: EV_MESSAGE_DIALOG
			l_text: STRING
		do
			init_caret := current_document.caret_position
			if not current_document.has_selection then
				if current_document.is_valid_xml then
					current_document.select_all
				end
			end
			l_text := current_document.selected_text
			if current_document.can_insert (l_text) then
				cut_text
				current_document.insert_xml_formatted (l_text)
			end
		end
		
	insert_xml (xml: STRING) is
			-- Insert 'xml' into currently loaded document
		require
			xml_not_void: xml /= Void
		do
			if current_document /= Void then
				current_document.insert_xml (xml)
			end
		end

feature -- Commands			
		
	close_document is
			-- Close currently open document
		do
			if current_document /= Void then
				if current_document.is_modified then
					save_prompt (current_document)	
				end			
				internal_close_document (current_document)
				notebook.prune (notebook.selected_item)				
			end
			Application_window.update_document_editor
		end			
		
	close_documents is
			-- Close all open documents
		local
			l_doc: DOCUMENT
		do
			from
				notebook.start
			until
				notebook.after
			loop
				l_doc ?= notebook.item
				if l_doc /= Void and then l_doc.is_modified then
					internal_close_document (l_doc)
				end
				notebook.forth
			end
		ensure
			notebook.is_empty
		end
		
	open_new_document is
			-- Called by `select_actions' of `new_xml_menu_item'.
		do
			load_document (Void)
		end	
		
	open_document is
			-- Called by `select_actions' of `open_xml_menu_item'.
		local
			l_open_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_open_dialog
			--open_dialog.set_filter (".xsd")
			l_open_dialog.show_modal_to_window (parent_window)
			if l_open_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_open) then
				load_document (l_open_dialog.file_name)
			end
		end

	reload_document (a_document: DOCUMENT) is
			-- Reload `a_document'
		require
			doc_not_void: a_document /= Void
		do
	
		end		

	save_document is
			-- Called by `select_actions' of `save_xml_menu_item'.
		do
			current_document.save
			notebook.set_item_text (notebook.selected_item, short_name (current_document.name))
			parent_window.toggle_save (False)
		end	
		
	format_tags is
			-- Called by `select actions' of `menu_uppercase_tags'
		do
			if Shared_constants.Application_constants.tags_uppercase then
				current_document.set_tag_case (True)
			else
				current_document.set_tag_case (False)
			end
		end		
		
	validate_document is
			-- Validate current document to loaded schema
		do
			if Shared_document_manager.schema /= Void then 
				if current_document /= Void then
					if not current_document.is_valid_xml then
						current_document.error_report.show
						current_document.highlight_xml_error
						parent_window.toggle_transform_buttons (False)
						parent_window.toggle_properties_button (False)
					elseif not current_document.is_valid_to_schema then
						current_document.error_report.show
						current_document.highlight_schema_error
						parent_window.toggle_transform_buttons (False)
						parent_window.toggle_properties_button (False)
					else 
						parent_window.update_status_report (False, (create {MESSAGE_CONSTANTS}).file_schema_valid_report)
						parent_window.toggle_properties_button (True)
						if Shared_document_manager.has_xsl then
							parent_window.toggle_transform_buttons (True)
						else
							parent_window.toggle_transform_buttons (False)
						end
						Shared_project.remove_invalid_file (current_document.name)
					end
				end
			end
		end	
		
	open_search_dialog is
			-- Open the search dialog for text searching
		do
			Shared_dialogs.search_dialog.set_document (current_document)
			Shared_dialogs.search_dialog.show_relative_to_window (Application_window)
		end

feature -- Query

	is_empty: BOOLEAN is
			-- Are any document open for editing/viewing
		do
			Result := notebook.is_empty
		end		

feature -- Retrieval		
		
	load_document (a_filename: STRING) is
			-- Load a document.  If `a_filename' is Void then open
			-- a new blank document.
		local
			document: DOCUMENT
		do
			if a_filename = Void then
				create document.make_new (Shared_document_manager.new_name, Current)
				Shared_document_manager.add_document (document)
				Shared_document_manager.set_current_document (document)
				notebook.extend (document)
				notebook.set_item_text (document, document.display_name)
				parent_window.update_status_report (False, document.display_name)
				notebook.select_item (document)
				Application_window.update_document_editor
			else
				load_document_from_file (a_filename)
			end
		end
		
	load_document_from_file (a_filename: STRING) is
			-- Load a document with `a_filename'
		local
			document: DOCUMENT
			file: PLAIN_TEXT_FILE
		do
			create file.make (a_filename)
			if file /= Void and then file.exists then
				create document.make_from_file (file, Current)
			end
			if document /= Void then
				if not Shared_document_manager.is_document_open (document.name) then
					Shared_document_manager.add_document (document)
					Shared_document_manager.set_current_document (document)
					notebook.extend (document)
					notebook.set_item_text (document, short_name (document.name) )
					parent_window.update_status_report (False, document.name)
				end
				notebook.select_item (Shared_document_manager.document_by_name (document.name))
			else
				parent_window.update_status_report (True, "Could not load document")
			end
			Application_window.update_document_editor
		end

feature -- Events		
		
	document_changed is
			-- User selected another open document in notebook
		local
			a_document: DOCUMENT
		do
			a_document ?= notebook.selected_item
			if a_document /= Void then
				Shared_document_manager.set_current_document (a_document)
				if a_document.is_modified then
					parent_window.toggle_save (True)
				else
					parent_window.toggle_save (False)
				end
				parent_window.update_status_report (False, a_document.name)
			else
				parent_window.update_status_report (False, "No document loaded")
			end			
		end		
		
	document_edited is
			-- User edited part of current document
		do
			parent_window.toggle_save (True)
			current_document.set_modified (True)
		end				
		
feature -- Access
	
	parent_window: DOC_BUILDER_WINDOW
			-- Parent window
		
feature {NONE} -- Implementation

	internal_close_document (a_doc: DOCUMENT) is
			-- Close `a_doc'
		require
			a_doc /= Void
		do
			Shared_document_manager.remove_document (current_document)
			document_changed
		end		

	save_prompt (a_doc: DOCUMENT) is
			-- Display save save prompt for document and save if
			-- user requests
		local
			l_question_dialog: EV_MESSAGE_DIALOG
			l_constants: EV_DIALOG_CONSTANTS
		do
			create l_constants
			create l_question_dialog.make_with_text ((create {MESSAGE_CONSTANTS}).file_save_prompt)
			l_question_dialog.set_title (l_constants.ev_save)
			l_question_dialog.set_buttons (<<l_constants.ev_yes, l_constants.ev_no>>)
			l_question_dialog.show_modal_to_window (parent_window)	
			if l_question_dialog.selected_button.is_equal (l_constants.ev_yes) then
				a_doc.save
			end
		end	

	current_document: DOCUMENT is
			-- Currently open document for editing
		do
			Result := Shared_document_manager.current_document
		end

	notebook: EV_NOTEBOOK
			-- Notebook

	clip_text: STRING
			-- Clipboard text

end -- class DOCUMENT_EDITOR
