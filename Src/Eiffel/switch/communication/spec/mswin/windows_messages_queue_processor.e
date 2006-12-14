indexing
	description: "Manage windows message events."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	WINDOWS_MESSAGES_QUEUE_PROCESSOR

create
	make
feature {NONE} -- Initialization

	make is
			-- Initialize current
		do
			reusable_pointer := reusable_pointer.memory_calloc (1, c_size_of_msg)
		end

feature -- Windows message loop

	process_message_queue is
		local
			p: POINTER
			b: BOOLEAN
			res: INTEGER
		do
			from
				p := reusable_pointer
				b := True
			until
				not b
			loop
				b := cwin_peek_message (p, default_pointer, 0, 0, Pm_qs_postmessage | Pm_remove)
				if b then
					if message_dispatching_enabled_on (p) then
						b := cwin_translate_message (p)
						res := cwin_dispatch_message (p)
					end
				end
			end
		end

	dispatch_message_only_on (t: INTEGER) is
		do
			message_filter := t
		end

	dispatch_only_timer_messages is
		do
			dispatch_message_only_on (Wm_timer)
		end

feature -- Message type

	Wm_timer: INTEGER is
		external
			"C [macro <msg.h>]"
		alias
			"WM_TIMER"
		end

feature {NONE} -- Filtering implementation

	reusable_pointer: POINTER
			-- Reusable pointer to avoid performance issue with GC.

	message_filter: INTEGER

	message_dispatching_enabled_on (p: POINTER): BOOLEAN is
		do
			Result := message_filter = 0 or else is_msg_of_type (p, message_filter)
		end

feature {NONE} -- Implementation

	is_timer_msg (p: POINTER): BOOLEAN is
		do
			Result := is_msg_of_type (p, Wm_timer)
		end

	is_msg_of_type (p: POINTER; a_type: INTEGER): BOOLEAN is
		do
			Result := c_msg_get_message (p) = a_type
		end

	c_msg_get_message (p: POINTER): INTEGER is
		external
			"C inline use <msg.h>"
		alias
			"(((MSG *) $p)->message)"
		end

	cwin_peek_message (ptr, a_hwnd: POINTER;
			first_msg, last_msg, flags: INTEGER): BOOLEAN is
			-- SDK PeekMessage
		external
			"C [macro <Windows.h>] (MSG *, HWND, UINT, UINT, UINT):%
				%EIF_BOOLEAN"
		alias
			"PeekMessage"
		end

	cwin_translate_message (ptr: POINTER): BOOLEAN
			-- SDK TranslateMessage
			-- (export status {NONE})
		external
			"C [macro <Windows.h>] (MSG *): EIF_BOOLEAN"
		alias
			"TranslateMessage"
		end

	cwin_dispatch_message (ptr: POINTER): INTEGER
			-- SDK DispatchMessage
			-- (export status {NONE})
		external
			"C [macro <windows.h>] (MSG *): EIF_INTEGER"
		alias
			"DispatchMessage"
		end

	c_size_of_msg: INTEGER is
		external
			"C [macro <msg.h>]"
		alias
			"sizeof (MSG)"
		end

	Pm_remove: INTEGER is
		external
			"C [macro <msg.h>]"
		alias
			"PM_REMOVE"
		end

	Pm_noremove: INTEGER is
		external
			"C [macro <msg.h>]"
		alias
			"PM_NOREMOVE"
		end

	Pm_qs_postmessage: INTEGER is
		external
			"C [macro <msg.h>]"
		alias
			"PM_QS_POSTMESSAGE"
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
