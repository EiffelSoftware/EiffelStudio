note
	description: "[
		Graphical implementation of an error display used to display error information to the user.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ERROR_DISPLAYER

inherit
	I_ERROR_DISPLAYER

create
	make

feature {NONE} -- Initialization

	make (a_window: like window)
			-- Initialize error displayer using parent window `a_parent'
		require
			a_window_attached: a_window /= Void
			not_a_window_is_destoryed: not a_window.is_destroyed
		do
			window := a_window
		ensure
			window_set: window = a_window
		end

feature {NONE} -- Access

	window: EV_WINDOW
			-- Parent window to show messages modal to

feature -- Basic operations

	show (a_cateory: STRING; a_manager: MULTI_ERROR_MANAGER)
			-- Show errors using manager `a_manager'.
		local
			l_dialog: EV_ERROR_DIALOG
			l_ok: STRING_32
			l_msg: STRING_32
			l_errors: LIST [ERROR_ERROR_INFO]
		do
			if not a_manager.successful then
				l_errors := a_manager.errors
				create l_msg.make (500)
				l_msg.append_integer (l_errors.count)
				l_msg.append (" error")
				if l_errors.count > 0 then
					l_msg.append_character ('s')
				end
				l_msg.append (" occured in the last operation:%N%N")
				l_errors.do_all (agent (a_item: ERROR_ERROR_INFO; a_buffer: STRING_32)
					do
						a_buffer.append ("   ")
						a_buffer.append_code (0x25CF)
						a_buffer.append_character (' ')
						a_buffer.append (a_item.description)
						a_buffer.append_character ('%N')
					end (?, l_msg))
				create l_dialog.make_with_text (l_msg)
				l_dialog.set_title (a_cateory)
				l_ok := once "Ok"
				l_dialog.set_buttons (<<l_ok>>)
				l_dialog.show_relative_to_window (window)
			end
		end

invariant
	window_attached: window /= Void
	not_window_is_destoryed: not window.is_destroyed

;note
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
