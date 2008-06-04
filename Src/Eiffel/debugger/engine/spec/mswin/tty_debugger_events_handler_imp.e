indexing
	description: "implementation for DEBUGGER_MANAGER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TTY_DEBUGGER_EVENTS_HANDLER_IMP

create {TTY_DEBUGGER_EVENTS_HANDLER}
	make

feature {NONE} -- Initialization

	make (a_interface: like interface) is
			-- Initialize current
		do
			interface := a_interface
			reusable_pointer := reusable_pointer.memory_calloc (1, c_size_of_msg)

				--| Maybe useless ...
			timer_win32_handle := cwin_new_window_handle
		end

feature {DEBUGGER_EVENTS_HANDLER} -- Access

	process_underlying_toolkit_event_queue is
		local
			p: POINTER
			b: BOOLEAN
			res: INTEGER
			wparam: POINTER
			timer_processed: BOOLEAN
		do
			from
				p := reusable_pointer
				b := True
			until
				not b
			loop
				b := cwin_peek_message (p, default_pointer, 0, 0, Pm_qs_postmessage | Pm_remove)
				if b then
					if c_msg_get_message (p) = WM_TIMER then
						wparam := c_msg_get_wparam (p)
						timer_processed := on_timer (wparam.to_integer_32)
					end
					if not timer_processed then
						b := cwin_translate_message (p)
						res := cwin_dispatch_message (p)
					end
				end
			end
		end

	timer_win32_handle: POINTER
			-- Win32 HWND handle for timer processing.

feature {NONE} -- Interface

	interface: TTY_DEBUGGER_EVENTS_HANDLER
			-- Interface instance.

feature {TTY_DEBUGGER_TIMER} -- Timer Access

	on_timer (id: INTEGER): BOOLEAN is
			-- Wm_timer message.
		local
			dbg_timer: TTY_DEBUGGER_TIMER
		do
			if timers /= Void then
				dbg_timer ?= eif_id_any_object (timers.item (id))
				if dbg_timer /= Void then
					dbg_timer.execute
					Result := True
				end
			end
		end

	set_timer (a_obj_id: INTEGER; a_interval: INTEGER) is
			-- SetTimer
		local
			l_timer_id: INTEGER
		do
			if timers = Void then
				create timers.make (3)
			end
			l_timer_id := cwin_set_timer (timer_win32_handle, a_obj_id, a_interval, Default_pointer)
			timers.force (a_obj_id, l_timer_id)
		end

	kill_timer (a_timer_id: INTEGER) is
			-- SetTimer
		do
			cwin_kill_timer (timer_win32_handle, a_timer_id)
			timers.remove (a_timer_id)
		end

	timers: HASH_TABLE [INTEGER, INTEGER]
			-- HT [obj_id, timer_id]

feature {NONE} -- Window related externals

	cwin_new_window_handle: POINTER is
		external
			"C inline use <windows.h>"
		alias
			"[
				{
					HANDLE hInst;
					WNDCLASSEX WinClass;
					LRESULT CALLBACK MainWndProc(HWND, UINT, WPARAM, LPARAM); 					
					
					HWND dummy_window = NULL;
					int successful = 0;

					hInst = GetModuleHandle(NULL);

					WinClass.cbSize=sizeof(WNDCLASSEX);
					WinClass.hInstance=hInst;
					WinClass.lpszClassName=L"DummyTimerWindow";
					WinClass.lpfnWndProc=DefWindowProc;
					WinClass.style=CS_HREDRAW | CS_VREDRAW;
					WinClass.hIcon=LoadIcon(NULL, IDI_APPLICATION);
					WinClass.hIconSm=0;
					WinClass.hCursor=LoadCursor(NULL, IDC_ARROW);
					WinClass.lpszMenuName=NULL;
					WinClass.cbClsExtra=0;
					WinClass.cbWndExtra=0;
					WinClass.hbrBackground=(HBRUSH)GetStockObject(WHITE_BRUSH);

					successful = (int) RegisterClassEx(&WinClass);
					if (successful) {
					    dummy_window = CreateWindow(
						        L"DummyTimerWindow",
						        L"DummyTimerWindow",
						        WS_OVERLAPPEDWINDOW,
						        0,
						        0,
						        0,
						        0,
						        HWND_DESKTOP,
						        (HMENU) NULL,
						        hInst,
						        (LPVOID) NULL
					        );
					}
				    return (EIF_POINTER) dummy_window;
				 }
			]"
		end

feature {NONE} -- Timer related externals

	Wm_timer: INTEGER is
		external
			"C [macro <msg.h>]"
		alias
			"WM_TIMER"
		end

	cwin_set_timer (hwnd: POINTER; a_timer_id: INTEGER; time_out: INTEGER; proc: POINTER): INTEGER is
			-- SDK SetTimer
		external
			"C [macro <Windows.h>] (HWND, UINT, UINT, TIMERPROC): EIF_POINTER"
		alias
			"SetTimer"
		end

	cwin_kill_timer (hwnd: POINTER; a_timer_id: INTEGER) is
			-- SDK KillTimer
		external
			"C [macro <Windows.h>] (HWND, UINT)"
		alias
			"KillTimer"
		end

	frozen eif_id_any_object (an_id: INTEGER): ANY is
			-- Object associated with `an_id'
		external
			"C | %"eif_object_id.h%""
		alias
			"eif_id_object"
		end

feature {NONE} -- Message related externals

	reusable_pointer: POINTER
			-- Reusable pointer to avoid performance issue with GC.

	c_msg_get_message (p: POINTER): INTEGER is
		external
			"C inline use <msg.h>"
		alias
			"(((MSG *) $p)->message)"
		end

	c_msg_get_wparam (p: POINTER): POINTER is
		external
			"C inline use <msg.h>"
		alias
			"(((MSG *) $p)->wParam)"
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

--	Pm_noremove: INTEGER is 0

	Pm_remove: INTEGER is 1

--	Pm_noyield: INTEGER is 2

--	Pm_qs_paint: INTEGER is 0x200000

	Pm_qs_postmessage: INTEGER is 0x980000;

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
