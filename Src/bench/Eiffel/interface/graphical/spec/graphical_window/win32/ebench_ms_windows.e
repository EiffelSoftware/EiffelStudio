indexing
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EBENCH_MS_WINDOWS

inherit
	TOOLKIT_IMP
		redefine
			message_loop, make, run
		end

creation
	make

feature -- Initialization

	make (application_class: STRING) is
			-- We create the toolkit and get the list of all the windows.
		local
			wel_window_manager: WEL_WINDOW_MANAGER
		do
			{TOOLKIT_IMP} Precursor (application_class)

			!! wel_window_manager
			windows := wel_window_manager.windows
		end

	run is
			-- Create `main_window' and start the message loop.
		do
			message_loop
		end

feature -- Process message event

	message_loop is
			-- Windows message loop
		local
			msg: WEL_MSG
			accel: WEL_ACCELERATORS
			main_w: WEL_WINDOW
			current_window: WEL_WINDOW
			done: BOOLEAN
			dlg: POINTER
			hwnd: POINTER
		do
			from
				accel := accelerators
				main_w := application_main_window
				!! msg.make
			until
				done
			loop
				msg.peek_all
				if msg.last_boolean_result then
					if msg.quit then
						done := True
					else
						current_window := find_current_window (msg.hwnd, main_w) 
						hwnd := current_window.item
						dlg := cwin_get_last_active_popup (hwnd)
						if dlg /= hwnd or is_dialog then
							msg.process_dialog_message (dlg)
							if not msg.last_boolean_result then
								msg.translate
								msg.dispatch
							end
						else
							if accel.exists then
								msg.translate_accelerator (current_window, accel)
							end
							if not msg.last_boolean_result or else not accel.exists then
								msg.translate
								msg.dispatch
							end
						end
					end
				else
					if idle_action_enabled then
						idle_action
					else
						msg.wait
					end
				end
			end
		end

feature {NONE} -- Implementation

	find_current_window (hwnd: POINTER; main_w: WEL_WINDOW): WEL_WINDOW is
		do
			Result := windows.item (hwnd)
			if Result  /= Void then
				Result := find_top_parent (Result)
			else
				Result := main_w
			end
		end

	find_top_parent (a_window: WEL_WINDOW): WEL_WINDOW is
			-- Give the TOP_SHELL_WINDOW corresponding to `a_window'.
		require
			a_window_not_void: a_window /= Void
		local
			parent: WEL_WINDOW
		do
			from
				Result := a_window
				parent := Result.parent
			until
				parent = Void
			loop
				parent := Result.parent
				if parent /= Void then
					Result := parent
				end
			end
		end

feature {NONE} -- Access

	windows: HASH_TABLE [WEL_WINDOW, POINTER]
			-- List all the windows in your application.

end -- class EBENCH_MS_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
