indexing
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

	destroy is
			-- <precursor>
		do
			if message_window /= Void and then message_window.exists then
				message_window.remove_command ({WEL_WM_CONSTANTS}.WM_COPYDATA)
				message_window.destroy
				message_window := Void
			end
		end

feature {NONE} -- Initialization

	make (an_interface: !like interface)
			-- Initialization
		do
			interface := an_interface
			setup_callback
		end

feature {NONE} -- Implementation

	setup_callback is
			-- Setup callback to handle WM_COPYDATA message.
		do
			create message_window.make_top (interface.key)
			message_window.put_command (Current, {WEL_WM_CONSTANTS}.WM_COPYDATA, Void)
			message_window.enable_commands
		end

	execute (argument: ANY) is
			-- Execute the command with `argument'.
		local
			l_wel_string: WEL_STRING
			l_string: STRING
			l_result: BOOLEAN
		do
			if message_information /= Void and then {lt_action: FUNCTION [ANY, TUPLE [STRING], BOOLEAN]}interface.external_command_action then
				l_wel_string := command_string (message_information.l_param)
					-- |Fixme: Causes information loss doing as_string_8.
				l_string := l_wel_string.string.as_string_8
				if not l_string.is_empty and then l_string.starts_with ({COMMAND_CONSTANTS}.ise_command) then
					l_string.remove_head ({COMMAND_CONSTANTS}.ise_command.count)
					l_result := lt_action.item ([l_string])
					if l_result then
						message_window.set_message_return_value (to_lresult (1))
					else
						message_window.set_message_return_value (to_lresult (0))
					end
				end
			end
		end

	message_window: ?EV_INTERNAL_SILLY_WINDOW_IMP

	command_string (a_pointer: POINTER): WEL_STRING is
			-- `a_pointer' points to COPYDATASTRUCT structure.
		local
			l_p: POINTER
			l_count: INTEGER
		do
			l_p := c_pointer_from_wm_copydata (a_pointer, $l_count)
			create Result.make_by_pointer_and_count (l_p, l_count)
		end

	frozen to_lresult (i: INTEGER): POINTER is
			-- Convert integer value `i' in a valid LRESULT value.
		external
			"C inline use <windows.h>"
		alias
			"(EIF_POINTER) (LRESULT) $i"
		end

	frozen c_pointer_from_wm_copydata (a_pointer: POINTER; a_count: TYPED_POINTER [INTEGER]): POINTER is
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

feature {NONE} -- Implementation

	interface: !COMMAND_RECEIVER;

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
