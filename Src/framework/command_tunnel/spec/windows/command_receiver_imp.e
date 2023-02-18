note
	description: "Comand recevier implementation"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_RECEIVER_IMP

inherit
	COMMAND_RECEIVER_I

	WEL_COMMAND

create
	make

feature -- Operation

	destroy
			-- <precursor>
		do
			if attached message_window as win and then win.exists then
				win.remove_command ({WEL_WM_CONSTANTS}.WM_COPYDATA)
				win.destroy
				message_window := Void
			end
		end

feature {NONE} -- Initialization

	make (an_interface: attached like interface)
			-- Initialization
		do
			interface := an_interface
			setup_callback
		end

feature {NONE} -- Implementation

	setup_callback
			-- Setup callback to handle WM_COPYDATA message.
		local
			win: like message_window
		do
			create win.make_top (interface.key)
			win.put_command (Current, {WEL_WM_CONSTANTS}.WM_COPYDATA, Void)
			win.enable_commands
			message_window := win
		end

	execute (argument: ANY)
			-- Execute the command with `argument'.
		local
			l_string: STRING_32
			l_result: BOOLEAN
		do
			if
				attached message_window as msg_win and then
				attached message_information as msg and then
				attached interface.external_command_action as lt_action
			then
				l_string := command_string (msg.l_param).string
				if not l_string.is_empty and then l_string.starts_with ({COMMAND_CONSTANTS}.ise_command) then
					l_string.remove_head ({COMMAND_CONSTANTS}.ise_command.count)
					l_result := lt_action.item ([l_string])
					if l_result then
						msg_win.set_message_return_value (to_lresult (1))
					else
						msg_win.set_message_return_value (to_lresult (0))
					end
				end
			end
		end

	message_window: detachable EV_INTERNAL_SILLY_WINDOW_IMP

	command_string (a_pointer: POINTER): WEL_STRING
			-- `a_pointer' points to COPYDATASTRUCT structure.
		local
			l_p: POINTER
			l_count: INTEGER
		do
			l_p := c_pointer_from_wm_copydata (a_pointer, $l_count)
			create Result.make_by_pointer_and_count (l_p, l_count)
		end

	frozen to_lresult (i: INTEGER): POINTER
			-- Convert integer value `i' in a valid LRESULT value.
		external
			"C inline use <windows.h>"
		alias
			"(EIF_POINTER) (LRESULT) $i"
		end

	frozen c_pointer_from_wm_copydata (a_pointer: POINTER; a_count: TYPED_POINTER [INTEGER]): POINTER
			-- Data from COPYDATASTRUCT structure.
		external
			"C inline"
		alias
			"[
				COPYDATASTRUCT* data;
				data = (COPYDATASTRUCT *)$a_pointer;
				*$a_count = data->cbData;
				return data->lpData;
			]"
		end

feature {NONE} -- Access

	interface: COMMAND_RECEIVER;

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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

end
