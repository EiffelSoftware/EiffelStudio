indexing
	description	: "Objects that helps displaying error message"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_GRAPHICAL_ERROR_MANAGER

inherit
	EB_ERROR_MANAGER

	EB_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	catch_exception: BOOLEAN
			-- Should the current exception be catched?

feature -- Basic operations

	display_error_message (a_relative_window: EV_WINDOW) is
			-- Display error message relative to `a_relative_window'.
		require
			a_relative_windows_not_void: a_relative_window /= Void
		local
			error_dialog: ES_ERROR_PROMPT
			l_dialog_buttons: ES_DIALOG_BUTTONS
			error_string: STRING_32
		do
				-- Set up the error message.
			if error_messages.is_empty then
				error_string := warning_messages.w_Unknown_error
			else
				from
					error_messages.start
				until
					error_messages.after
				loop
					error_string := error_messages.item.as_string_32 + "%N%N"
					error_messages.forth
				end
			end

			create error_dialog.make_standard (error_string)
			set_catch_exception (True)
			debug ("display_exception_trace")
				create l_dialog_buttons
				create error_dialog.make (error_string, l_dialog_buttons.ok_cancel_buttons, l_dialog_buttons.ok_button, l_dialog_buttons.ok_button, l_dialog_buttons.cancel_button)
				error_dialog.set_button_text (l_dialog_buttons.cancel_button, Interface_names.b_Display_Exception_Trace)
				error_dialog.set_button_action (l_dialog_buttons.cancel_button, agent set_catch_exception (False))
			end
			error_dialog.show (a_relative_window)
			clear_error_messages
		end

feature {NONE} -- Implementation

	set_catch_exception (new_state: BOOLEAN) is
			-- Set `catch_exception' to `new_state'.
		do
			catch_exception := new_state
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_GRAPHICAL_ERROR_MANAGER
