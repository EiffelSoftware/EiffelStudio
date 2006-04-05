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
			error_dialog: EV_ERROR_DIALOG
			error_string: STRING
		do
				-- Set up the error message.
			if error_messages.is_empty then
				error_string := "An unknown error has occurred%N"
			else
				from
					error_messages.start
				until
					error_messages.after
				loop
					error_string := error_messages.item + "%N%N"
					error_messages.forth
				end
			end
			create error_dialog.make_with_text (error_string)
			error_dialog.set_buttons (<<Interface_names.b_ok>>)
			set_catch_exception (True)
			debug ("display_exception_trace")
				error_dialog.set_buttons (<<Interface_names.b_ok,
					Interface_names.b_Display_Exception_Trace>>)
				error_dialog.button (Interface_names.b_Display_Exception_Trace).select_actions.
					extend (agent set_catch_exception(False))
			end
			error_dialog.set_default_push_button (error_dialog.button (Interface_names.b_ok))
			error_dialog.set_default_cancel_button (error_dialog.button (Interface_names.b_ok))
			error_dialog.show_modal_to_window (a_relative_window)
			clear_error_messages
		end

feature {NONE} -- Implementation

	set_catch_exception (new_state: BOOLEAN) is
			-- Set `catch_exception' to `new_state'.
		do
			catch_exception := new_state
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

end -- class EB_GRAPHICAL_ERROR_MANAGER
