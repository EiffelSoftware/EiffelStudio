indexing
	description: "Receives and dispatch the Windows messages to the Eiffel objects."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DISPATCHER

inherit
	WEL_WINDOW_MANAGER
		export
			{NONE} all
		end

	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end

	WEL_WM_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize the C variables
		do
			cwel_set_window_procedure_address ($window_procedure)
			cwel_set_dialog_procedure_address ($dialog_procedure)
			cwel_set_dispatcher_object (Current)
		end

feature {NONE} -- Implementation

	frozen window_procedure (hwnd: POINTER; msg, wparam,
			lparam: INTEGER): INTEGER is
			-- Window messages dispatcher routine
		local
			window: WEL_WINDOW
			previous_state: BOOLEAN
		do
			window := windows.item (hwnd)
			debug ("win_dispatcher")
				if window /= Void then
					io.print (" after look at windows table ")
					io.print (window)
					io.new_line
				end
			end
			if window /= Void then
				check
					window_exists: window.exists
				end
				previous_state := window.default_processing_enabled
				Result := window.process_message (hwnd, msg, wparam, lparam)
				if window.default_processing_enabled then
					Result := window.call_default_window_procedure (msg, wparam, lparam)
				end
				window.set_default_processing (previous_state)
			else
				Result := cwin_def_window_proc (hwnd, msg, wparam, lparam)
			end
		end

	frozen dialog_procedure (hwnd: POINTER; msg, wparam,
			lparam: INTEGER): BOOLEAN is
			-- Dialog box messages dispatcher routine
		local
			window: WEL_WINDOW
		do
			debug ("dlg_dispatcher")
				io.print ("in dlg_proc ")
				io.print (hwnd)
				io.print (' ')
				io.print (msg)
				io.print (' ')
				io.print (msg = Wm_initdialog)
				io.new_line
			end
			if msg = Wm_initdialog then
				window := windows.item (cwel_temp_dialog_value)
				if window /= Void then
					-- Special case for the message
					-- Wm_initdialog. We set the hwnd value
					-- to the object because this value
					-- was unknown until now.
					windows.remove (cwel_temp_dialog_value)
					window.set_item (hwnd)
					register_window (window)
					Result := window.process_message (hwnd,
						msg, wparam, lparam) /= 0
				end
				Result := True
			else
				window := windows.item (hwnd)
				if window /= Void then
					Result := window.process_message (hwnd,
						msg, wparam, lparam) = -1
				end
			end
		end

feature {NONE} -- Implementation

	dispose is
			-- Wean `Current'
		local
			default_object: like Current
		do
			cwel_release_dispatcher_object
			cwel_set_dispatcher_object (default_object)
		end

feature {NONE} -- Externals

	cwel_integer_to_pointer (i: INTEGER): POINTER is
			-- Converts an integer `i' to a pointer
		external
			"C [macro %"wel.h%"]"
		end

	cwel_temp_dialog_value: POINTER is
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		end

	cwel_set_window_procedure_address (address: POINTER) is
		external
			"C [macro %"disptchr.h%"]"
		end

	cwel_set_dialog_procedure_address (address: POINTER) is
		external
			"C [macro %"disptchr.h%"]"
		end

	cwel_set_dispatcher_object (dispatcher: like Current) is
		external
			"C [macro %"disptchr.h%"]"
		end

	cwel_release_dispatcher_object is
		external
			"C [macro %"disptchr.h%"]"
		end

	cwin_def_window_proc (hwnd: POINTER; msg, wparam,
			lparam: INTEGER): INTEGER is
			-- SDK DefWindowProc
		external
			"C [macro <windows.h>] (HWND, UINT, WPARAM, LPARAM): EIF_INTEGER"
		alias
			"DefWindowProc"
		end

end -- class WEL_DISPATCHER

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

