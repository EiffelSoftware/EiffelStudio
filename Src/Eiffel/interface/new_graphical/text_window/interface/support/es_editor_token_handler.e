indexing
	description: "[
		Base handler for performing idle actions of editor tokens.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_EDITOR_TOKEN_HANDLER

inherit
	EB_RECYCLABLE

feature {NONE} -- Initialization

	make (a_editor: like editor)
			-- Initializes a token handler
		require
			a_editor_is_interface_usable: a_editor.is_interface_usable
		do
			editor := a_editor
		ensure
			editor_set: editor = a_editor
		end

feature {NONE} -- Clean up

	internal_recycle
			-- To be called when the button has became useless.
			-- Note: It's recommended that you do not detach objects here.
		do
		end

feature {NONE} -- Access

	editor: !EB_CUSTOM_WIDGETTED_EDITOR
			-- Editor to perform operations on.

feature -- Query

	is_applicable_token (a_token: !EDITOR_TOKEN): BOOLEAN
			-- Determines if a token is applicable for processing
			--
			-- `a_token': Token to test for applicablity.
			-- `Result': True if the token can be user; False otherwise.
		do
			Result := True
		end

feature -- Basic operations

	perform_on_token (a_token: !EDITOR_TOKEN; a_line: INTEGER)
			-- Performs an action on a token, regardless of the mouse or caret position.
			--
			-- `a_token': The editor token to process.
			-- `a_line': The line number where the token is located in the editor.
		require
			is_interface_usable: is_interface_usable
			a_line_positive: a_line > 0
		do
			--| Note. This is currently not used by the editor as will not be called.
		end

	perform_on_token_with_mouse_coords (a_token: !EDITOR_TOKEN; a_line: INTEGER; a_x: INTEGER; a_y: INTEGER; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Performs an action on a token, respecting the current mouse x and y coordinates.
			--
			-- `a_token': The editor token to process.
			-- `a_line': The line number where the token is located in the editor.
			-- `a_x': The relative x position of the mouse pointer, to the editor,  when processing was requested.
			-- `a_y': The relative y position of the mouse pointer, to the editor, when processing was requested.
			-- `a_screen_x': The absolute screen x position of the mouse pointer when processing was requested.
			-- `a_screen_y': The absolute screen y position of the mouse pointer when processing was requested.
		require
			is_interface_usable: is_interface_usable
			a_line_positive: a_line > 0
		do
		end

	perform_exit
			-- Exits a function being performed. This is called when a non applicable token or no token needs processing.
			-- It allows the handler to perform exit or shutdown functionality.
		require
			is_interface_usable: is_interface_usable
		do
		end

invariant
	editor_is_interface_usable: is_interface_usable implies editor.is_interface_usable

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
