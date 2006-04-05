indexing
	description: "Miscellaneous actions applicable to error reports."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_ACTIONS
		
inherit
	SHARED_OBJECTS

create {ERROR_REPORT}
	default_create

feature -- Actions

	highlight_text_in_editor (a_line_no, a_line_pos: INTEGER) is
			-- Highlight error in editor
		do
			Shared_document_manager.current_editor.text_displayed.cursor.set_y_in_lines (a_line_no)
			Shared_document_manager.current_editor.text_displayed.cursor.set_x_in_characters (a_line_pos)
			Shared_document_manager.current_editor.text_displayed.highlight_line (a_line_no)
			Shared_document_manager.current_editor.display_line_with_context (a_line_no)
			Shared_document_manager.current_editor.set_focus
		end
		
	highlight_text_byte_in_editor (a_byte_pos: INTEGER) is
			-- Highlight error in editor based on byte position
		do
--			shared_document_editor.text_displayed.cursor.set_y_in_lines (a_line_no)
--			shared_document_editor.text_displayed.cursor.set_x_in_characters (a_byte_pos)
--			shared_document_editor.text_displayed.highlight_line (a_line_no)
--			shared_document_editor.set_focus
		end

	load_file_in_editor (a_filename: STRING) is
			-- Load file in editor
		require
			filename_not_void: a_filename /= Void
		do
			Shared_document_manager.load_document_from_file (a_filename)
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
end -- class ERROR_ACTIONS
