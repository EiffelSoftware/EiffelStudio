indexing
	description	: "Objects that helps emulating a modal window"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_MODAL_EMULATION_IMP

inherit
	EV_ANY_I
		export
			{NONE} all
		end

	WEL_GWL_CONSTANTS
		export
			{NONE} all
		end

	WEL_WM_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_window

feature {NONE} -- Initialization

	make_with_window (a_window: EV_WINDOW_IMP) is
		require
			no_other_blocking_window: blocking_window = Void
		do
			blocking_window := a_window

				-- For contract from EV_ANY_I
			base_make_called := True
		ensure
			blocking_window_set: blocking_window = a_window
		end

feature -- Access

	blocking_window: EV_WINDOW_IMP
			-- Current blocking window.

feature -- Basic Operation

	block is
			-- Wait until window is closed by the user.
		require
			blocking_window_not_void: blocking_window /= Void
		local
			app: EV_APPLICATION
			app_imp: EV_APPLICATION_IMP
			modal_emul: EV_MODAL_EMULATION_IMP
		do
			app := (create {EV_ENVIRONMENT}).application
			app_imp ?= app.implementation
			from 
			until 
				blocking_window.is_destroyed or else 
				(not blocking_window.is_show_requested)
			loop
				app.sleep (100)
				process_events (app_imp.main_window.wel_item)
			end

			blocking_window := Void
		ensure
			no_more_blocking_window: blocking_window = Void
		end

feature {NONE} -- Implementation

	quit_requested: BOOLEAN
			-- Has a Wm_quit message been processed?
			-- Or has destroy been called?

	process_events (main_hwnd: POINTER) is
			-- Process any pending events.
			--| Pass control to the GUI toolkit so that it can
			--| handle any events that may be in its queue.
		local
			msg: WEL_MSG
			done: BOOLEAN
		do
			quit_requested := False
			from
				create msg.make
			until
				(quit_requested) or else
				(blocking_window.is_destroyed) or else
				(not blocking_window.is_show_requested)
			loop
				msg.peek_all
				if msg.last_boolean_result then
					dispatch_message (msg, main_hwnd)
				else
					msg.wait
				end
			end
		end

	dispatch_message (msg: WEL_MSG; main_hwnd: POINTER) is
			-- Dispatch `msg'.
		local
			dlg: POINTER
		do
			if msg.quit then
				quit_requested := True
			else
				dlg := cwin_get_last_active_popup (main_hwnd)
				if is_dialog (dlg) then
					msg.process_dialog_message (dlg)
					if not msg.last_boolean_result then
						msg.translate
						msg.dispatch
					end
				else
					if blocking_window.is_control_in_window(msg.hwnd) then
						msg.translate
						msg.dispatch
					else
						if authorized_messages.has(msg.message) then
							msg.translate
							msg.dispatch
--|---------------------------------------------------------------------------------
--|FIXME: BEGIN DEBUGGING CODE (ARNAUD)
--|---------------------------------------------------------------------------------
						elseif unauthorized_messages.has(msg.message) then
							-- do nothing
						else
							io.putstring ("Unknown message:%N")
							io.putstring (" hwnd   = "+msg.hwnd.hash_code.out+"%N")
							io.putstring (" msg    = "+msg.message.out+"%N")
							io.putstring (" lparam = "+msg.lparam.out+"%N")
							io.putstring (" wparam = "+msg.wparam.out+"%N%N")
						end
--|---------------------------------------------------------------------------------
--|FIXME: END DEBUGGING CODE (ARNAUD)
--|---------------------------------------------------------------------------------
					end
				end
			end
		end

	is_dialog (hwnd: POINTER): BOOLEAN is
			-- Is the window corresponding to `hwnd' a dialog box?
			-- We call the function with a dialog box option,
			-- if it is indeed a dialog, the result will always
			-- be non zero, otherwise it is zero.
		do
			Result := c_get_window_long (hwnd, Dwl_dlgproc) /= 0
		end

	cwin_get_last_active_popup (hwnd: POINTER): POINTER is
			-- SDK GetLastActivePopup
		external
			"C [macro <wel.h>] (HWND): EIF_POINTER"
		alias
			"GetLastActivePopup"
		end

	c_get_window_long (hwnd: POINTER; offset: INTEGER): INTEGER is
			-- SDK GetWindowLong
		external
			"C [macro <wel.h>] (HWND, int): EIF_INTEGER"
		alias
			"GetWindowLong"
		end

	authorized_messages: ARRAY[INTEGER] is 
		once
			create Result.make (0, 10)
			Result.put (Wm_paint, 0)
			Result.put (Wm_erasebkgnd, 1)
			Result.put (Wm_setredraw, 2)
			Result.put (Wm_initmenupopup, 3)
			Result.put (Wm_initdialog, 4)
			Result.put (Wm_timer, 5)
			Result.put (Wm_initmenu, 6)
--			Result.put (Wm_syscommand, 7)
--			Result.put (Wm_enable, 8)
		end

	unauthorized_messages: ARRAY[INTEGER] is 
		once
			create Result.make (0, 25)
			Result.put (Wm_mousemove,       0)
			Result.put (Wm_nchittest,       1)
			Result.put (Wm_ncmousemove,     2)
			Result.put (Wm_lbuttondown,     3)
			Result.put (Wm_mbuttondown,     4)
			Result.put (Wm_rbuttondown,     5)
			Result.put (Wm_lbuttonup,       6)
			Result.put (Wm_mbuttonup,       7)
			Result.put (Wm_rbuttonup,       8)
			Result.put (Wm_lbuttondblclk,   9)
			Result.put (Wm_mbuttondblclk,   10)
			Result.put (Wm_rbuttondblclk,   11)
			Result.put (Wm_nclbuttondown,   12)
			Result.put (Wm_ncmbuttondown,   13)
			Result.put (Wm_ncrbuttondown,   14)
			Result.put (Wm_nclbuttonup,     15)
			Result.put (Wm_ncmbuttonup,     16)
			Result.put (Wm_ncrbuttonup,     17)
			Result.put (Wm_nclbuttondblclk, 18)
			Result.put (Wm_ncmbuttondblclk, 19)
			Result.put (Wm_ncrbuttondblclk, 20)
			Result.put (Wm_keyup,           21)
			Result.put (Wm_keydown,         22)
			Result.put (Wm_syskeyup,        23)
			Result.put (Wm_syskeydown,      24)
			Result.put (Wm_syschar,         25)
			Result.put (Wm_sysdeadchar,     26)
			Result.put (Wm_char,            27)
			Result.put (Wm_deadchar,        28)
			Result.put (Wm_hscroll,         29)
			Result.put (Wm_vscroll,         30)
		end

feature {NONE} -- EV_ANY_I compliance

	make (an_interface: EV_ANY) is
			-- Create underlying native toolkit objects.
		do
			check Do_not_use: False; end
		end

	initialize is
			-- Do post creation initialization.
		do
			check Do_not_use: False; end
		end

	destroy is
			-- Destroy underlying native toolkit objects.
		do
			check Do_not_use: False; end
		end

end -- class EV_MODAL_EMULATION_IMP
