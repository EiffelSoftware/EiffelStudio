indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
end
