indexing
	description: "[
		Base handler for performing idle actions on editor tokens in a EiffelStudio custom widget based editor {EB_CUSTOM_WIDGETTED_EDITOR}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_EDITOR_TOKEN_HANDLER

inherit
	EB_RECYCLABLE
		redefine
			is_interface_usable
		end

feature {NONE} -- Initialization

	make (a_editor: like editor)
			-- Initializes a token handler.
			--
			-- `a_editor': An associated editor to use with the handler.
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

feature -- Access

	last_token_handled: ?EDITOR_TOKEN
			-- The last token performed upon

feature {NONE} -- Access

	editor: !EB_CUSTOM_WIDGETTED_EDITOR
			-- Editor to perform operations on.

feature -- Status report

	is_active: BOOLEAN assign set_is_active
			-- Determines if the handler is active. This is to be used by clients
			-- to determine when and when not to use the handler.

	is_interface_usable: BOOLEAN
			-- Dtermines if the interface was usable
		do
			Result := Precursor {EB_RECYCLABLE} and then editor.is_interface_usable
		ensure then
			editor_is_interface_usable: Result implies editor.is_interface_usable
		end

feature {NONE} -- Status setting

	set_is_active (a_active: BOOLEAN)
			-- Set's handler's active state.
			--
			-- `a_active': True to indicate the handler is active; False otherwise
		do
			is_active := a_active
		ensure
			is_active_set: is_active = a_active
		end

feature -- Query

	is_applicable_token (a_token: !EDITOR_TOKEN): BOOLEAN
			-- Determines if a token is applicable for processing
			--
			-- `a_token': Token to test for applicablity.
			-- `Result': True if the token can be user; False otherwise.
		deferred
		end

	can_perform_exit (a_force: BOOLEAN): BOOLEAN
			-- Deterines if clients can perform a exit operation on an actively handled token.
			--
			-- `a_force': True to indicate a forced close operation, False to indicate a regular request to close.
			-- `Result': True if the handler can perform an exit at this time; False otherwise.
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
			not_is_active: not is_active
			a_line_positive: a_line > 0
		do
			last_token_handled := a_token

			--| Note. This is currently not used by the editor as will not be called.
		ensure
			last_token_handled_set: last_token_handled = a_token
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
			not_is_active: not is_active
			a_line_positive: a_line > 0
		do
			last_token_handled := a_token
		ensure
			last_token_handled_set: last_token_handled = a_token
		end

	perform_exit (a_force: BOOLEAN)
			-- Exits a function being performed. This is called when a non applicable token or no token needs processing.
			-- It allows the handler to perform exit or shutdown functionality.
			--
			-- Note: Implementers be careful of the force option. It is used when the pointer leave the editor, because closure
			--       must be performed.
			--
			-- `a_force': True to ignore check and perform an exit; False otherwise
		require
			is_interface_usable: is_interface_usable
			is_active: is_active
			can_perform_exit: can_perform_exit (a_force)
		do
			last_token_handled := Void
			is_active := False
		ensure
			last_token_handled_detached: can_perform_exit (a_force) implies last_token_handled = Void
			not_is_active: can_perform_exit (a_force) implies not is_active
		end

	perform_reset
			-- Peforms a reset of the token handler. This happens when the handler is not active
			-- and cannot handle a token. This is useful to reset any cached data or preventative flags based on same token matching.
		require
			is_interface_usable: is_interface_usable
			not_is_active: not is_active
		do
			last_token_handled := Void
		ensure
			last_token_handled_detached: last_token_handled = Void
		end

invariant
	editor_is_interface_usable: is_interface_usable implies editor.is_interface_usable
	last_token_handled_attached: is_active implies last_token_handled /= Void

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
