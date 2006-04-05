indexing
	description: "User editor preferences."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_EDITOR_PREFERENCES

create
	make
	
feature {DOCUMENT_EDITOR} -- Creation
	
	make (a_editor: like editor) is
			-- Make
		require
			editor_not_void: a_editor /= Void
		do
			editor := a_editor			
		ensure
			editor_set: editor = a_editor
		end		

feature -- Access

	font: EV_FONT
			-- Font currently in use

	word_wrap_on: BOOLEAN is
			-- Is word wrapping on?
		do
			Result := editor.parent_window.wrap_menu_item.is_selected	
		end	
	
feature -- Commands

	load_font_dialog is
			-- Loaf font selection dialog
		local
			l_dialog: EV_FONT_DIALOG	
		do
			create l_dialog.make_with_title ("Choose Font")
			if font /= Void then				
				l_dialog.set_font (font)	
			end
			l_dialog.show_modal_to_window (editor.parent_window)
			if l_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				font := l_dialog.font
				editor.refresh
			end
		end		
		
feature {NONE} -- Implementation

	editor: DOCUMENT_EDITOR
			-- Editor

invariant
	has_editor: editor /= void

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
end -- class DOCUMENT_EDITOR_PREFERENCES
