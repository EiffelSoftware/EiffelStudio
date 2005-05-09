indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_EDITOR_COMMANDS

inherit
	SHARED_OBJECTS

feature -- Commands

	cut_selection is
			-- Copy current selection to clipboard and remove it.
		do
			shared_document_manager.current_editor.cut_selection
		end

	copy_selection is
			-- Copy current selection to clipboard.
		do
			shared_document_manager.current_editor.copy_selection
		end

	paste is
			-- Paste clipboard at cursor position.
		do
			shared_document_manager.current_editor.paste
		end

	validate_document is
			-- Validate current document to loaded schema
		do
			shared_document_manager.current_editor.validate_document
		end
		
	validate_document_links is
			-- Validate current document links/hrefs
		do	
			shared_document_manager.current_editor.validate_document_links
		end		
		
	open_search_dialog is
			-- Open the search dialog for text searching
		do		
			shared_document_manager.current_editor.open_search_dialog
		end

	tag_selection (a_tag: STRING) is
			-- Enclose `selected_text' in XML `a_tag'.  Eg, `some_text'
			-- becomes '<a_tag>some_text</a_tag>'.  If there is no selection
			-- just insert '<a_tag></a_tag>'.	
		do							
			shared_document_manager.current_editor.tag_selection (a_tag)
		end

	pretty_print_text is
			-- Pretty XML format the current document
		do
			shared_document_manager.current_editor.pretty_print_text
		end

	pretty_format_code_text is
			-- Pretty format the selected text as Eiffel code		
		do
			shared_document_manager.current_editor.pretty_format_code_text
		end			

end
