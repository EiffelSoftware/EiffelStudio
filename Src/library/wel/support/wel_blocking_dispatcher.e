indexing
	description	: "Receive and dispatch the Windows messages to the Eiffel objects.%N%
				  %block the message if a blocking window is present"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_BLOCKING_DISPATCHER

inherit
	WEL_DISPATCHER

	WEL_CONSTANTS
		export
			{NONE} all
		end
	
	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

create
	make

feature -- Status setting

	enable_blocking_dispatcher is
			-- Enable the blocking window dispatcher
		do
			if not blocking_dispatcher_enabled then
				cwel_set_window_procedure_address ($window_blocking_procedure)
				blocking_dispatcher_enabled := True
			end
		end

	disable_blocking_dispatcher is
			-- Disable the blocking window dispatcher
		do
			if blocking_dispatcher_enabled then
				cwel_set_window_procedure_address ($window_procedure)
				blocking_dispatcher_enabled := False
			end
		end

	blocking_dispatcher_enabled: BOOLEAN
			-- Is the dispatcher with blocking window handling enabled?

	set_blocking_dispatcher_window (a_window: WEL_WINDOW) is
			-- Set the blocking window to `a_window'
		do
			blocking_dispatcher_window := a_window
		end
	
	remove_blocking_dispatcher_window is
			-- Remove the current blocking window
		do
			blocking_dispatcher_window := Void
		end

	blocking_dispatcher_window: WEL_WINDOW
			-- Current blocking window

feature {NONE} -- Implementation

	authorized_messages: HASH_TABLE [INTEGER, INTEGER] is
			-- Message always processed
		once
			create Result.make (50)
			Result.put (Wel_window_constants.Wm_paint,				Wel_window_constants.Wm_paint)
			Result.put (Wel_window_constants.Wm_erasebkgnd,			Wel_window_constants.Wm_erasebkgnd)
			Result.put (Wel_window_constants.Wm_initmenupopup,		Wel_window_constants.Wm_initmenupopup)
			Result.put (Wel_window_constants.Wm_initdialog,			Wel_window_constants.Wm_initdialog)
			Result.put (Wel_window_constants.Wm_timer,				Wel_window_constants.Wm_timer)
			Result.put (Wel_window_constants.Wm_initmenu,			Wel_window_constants.Wm_initmenu)
			Result.put (Wel_window_constants.Wm_ncpaint,			Wel_window_constants.Wm_ncpaint)
			Result.put (Wel_window_constants.Wm_gettext,			Wel_window_constants.Wm_gettext)
			Result.put (Wel_window_constants.Wm_notify,				Wel_window_constants.Wm_notify)
			Result.put (Wel_window_constants.Wm_ctlcolorstatic,		Wel_window_constants.Wm_ctlcolorstatic)
			Result.put (Wel_window_constants.Wm_setcursor,			Wel_window_constants.Wm_setcursor)
			Result.put (Wel_window_constants.Wm_syncpaint,			Wel_window_constants.Wm_syncpaint)
			Result.put (Wel_window_constants.Wm_nchittest,			Wel_window_constants.Wm_nchittest)
			Result.put (Wel_window_constants.Wm_killfocus,			Wel_window_constants.Wm_killfocus)
			Result.put (Wel_window_constants.Wm_notify,				Wel_window_constants.Wm_notify)
			Result.put (Wel_list_view_constants.Lvm_gettopindex,	Wel_list_view_constants.Lvm_gettopindex)
			Result.put (Wel_list_view_constants.Lvm_getitemrect,	Wel_list_view_constants.Lvm_getitemrect)
			Result.put (Wel_list_view_constants.Lvm_getcountperpage,Wel_list_view_constants.Lvm_getcountperpage)
			Result.put (Wel_list_view_constants.Lvm_getbkcolor,		Wel_list_view_constants.Lvm_getbkcolor)
			Result.put (Wel_window_constants.Wm_ncactivate,			Wel_window_constants.Wm_ncactivate)
			Result.put (Wel_window_constants.Wm_ctlcolormsgbox,		Wel_window_constants.Wm_ctlcolormsgbox)
			Result.put (Wel_window_constants.Wm_ctlcoloredit,		Wel_window_constants.Wm_ctlcoloredit)
			Result.put (Wel_window_constants.Wm_ctlcolorbtn,		Wel_window_constants.Wm_ctlcolorbtn)
			Result.put (Wel_window_constants.Wm_ctlcolordlg,		Wel_window_constants.Wm_ctlcolordlg)
			Result.put (Wel_window_constants.Wm_ctlcolorscrollbar,	Wel_window_constants.Wm_ctlcolorscrollbar)
			Result.put (Wel_window_constants.Wm_ctlcolorstatic,		Wel_window_constants.Wm_ctlcolorstatic)
			Result.put (Wel_window_constants.Wm_command,			Wel_window_constants.Wm_command)
			Result.put (Wel_window_constants.Wm_geticon,			Wel_window_constants.Wm_geticon)
			Result.put (Wel_window_constants.Wm_showwindow,			Wel_window_constants.Wm_showwindow)
			Result.put (Wel_window_constants.Wm_enteridle,			Wel_window_constants.Wm_enteridle)
			Result.put (Wel_window_constants.Wm_drawitem,			Wel_window_constants.Wm_drawitem)
			Result.put (Wel_window_constants.Wm_gettextlength,		Wel_window_constants.Wm_gettextlength)
		end

	special_messages: HASH_TABLE [INTEGER, INTEGER] is
			-- Message always processed but also sent to the blocking window.
		once
			create Result.make (50)
			Result.put (Wel_window_constants.Wm_activate,			Wel_window_constants.Wm_activate)
			Result.put (Wel_window_constants.Wm_mouseactivate,		Wel_window_constants.Wm_mouseactivate)
			Result.put (Wel_window_constants.Wm_childactivate,		Wel_window_constants.Wm_childactivate)
			Result.put (Wel_window_constants.Wm_activateapp,		Wel_window_constants.Wm_activateapp)
			Result.put (Wel_window_constants.Wm_windowposchanging,	Wel_window_constants.Wm_windowposchanging)
			Result.put (Wel_window_constants.Wm_windowposchanged,	Wel_window_constants.Wm_windowposchanged)
		end

	frozen window_blocking_procedure (hwnd: POINTER; msg, wparam,
			lparam: INTEGER): INTEGER is
			-- Window messages dispatcher routine when a blocking
			-- window is present.
		local
			window: WEL_WINDOW
		do
			window := window_of_item (hwnd)
			if window /= Void then
				-- Message are "authorized" if they are for the blocking window (and one
				-- of its control, or if they are listed in the list of authorized messages.
				if (blocking_dispatcher_window = Void) or else 
				   (not unauthorized_messages.has(msg) and not special_messages.has(msg)) or else
				   (window.is_located_inside (blocking_dispatcher_window))
				then
					Result := process_received_message (window, hwnd, msg, wparam, lparam)
	
				-- For "activate" message, we activate the window that asks the activation but
				-- then we activate the blocking window, so that the blocking window stays on
				-- top of the window.
				elseif (blocking_dispatcher_window /= Void) and then special_messages.has(msg) then
					Result := process_special_message (window, hwnd, msg, wparam, lparam)
				end
			else
				Result := cwin_def_window_proc (hwnd, msg, wparam, lparam)
			end
		end

feature {NONE}

	process_special_message (window: WEL_WINDOW; hwnd: POINTER; msg, wparam, lparam: INTEGER): INTEGER is
		local
			frame_window: WEL_FRAME_WINDOW
			bres: BOOLEAN
			window_pos: WEL_WINDOW_POS
		do
			frame_window ?= window

			if msg = Wel_window_constants.Wm_windowposchanging then
				debug ("WEL_BLOCKING_DISPATCHER") 
					io.putstring ("Received WM_WINDOWPOSCHANGING message") 
				end
				create window_pos.make_by_pointer (cwel_integer_to_pointer(lparam))
				window_pos.set_flags (
					Wel_window_constants.Swp_nomove +
					Wel_window_constants.Swp_nosize +
					Wel_window_constants.Swp_noactivate
					)
					-- we activate the dialog
				cwin_set_active_window (blocking_dispatcher_window.item)
				Result := 0

			elseif msg = Wel_window_constants.Wm_windowposchanged then
				debug ("WEL_BLOCKING_DISPATCHER") io.putstring ("Received WM_WINDOWPOSCHANGED message") end
					-- we activate the dialog
				cwin_set_active_window (blocking_dispatcher_window.item)

			elseif msg = Wel_window_constants.Wm_mouseactivate then
				debug ("WEL_BLOCKING_DISPATCHER") io.putstring ("Received WM_MOUSEACTIVATE message") end
				Result := Wel_input_constants.Ma_noactivateandeat
					-- we activate the dialog
				bres := cwin_set_foreground_window (blocking_dispatcher_window.item)

			elseif msg = Wel_window_constants.Wm_childactivate then
				debug ("WEL_BLOCKING_DISPATCHER") io.putstring ("Received WM_CHILDACTIVATE message") end

			elseif msg = Wel_window_constants.Wm_activate then
				debug ("WEL_BLOCKING_DISPATCHER") io.putstring ("Received WM_ACTIVATE message") end
				
				if cwin_lo_word (wparam) /= Wel_window_constants.Wa_inactive then
						-- we activate the dialog
					cwin_set_active_window (blocking_dispatcher_window.item)
					Result := 0
				end

			elseif msg = Wel_window_constants.Wm_activateapp then
				debug ("WEL_BLOCKING_DISPATCHER") 
					io.putstring ("Received WM_ACTIVATEAPP message")
					if wparam /= 0 then 
						io.putstring (" [TRUE: "+wparam.out+"] ") 
					else 
						io.putstring (" [FALSE: "+wparam.out+"] ")
					end
				end
				if wparam /= 0 then -- Window being activated then
						-- we activate the dialog
					bres := cwin_set_foreground_window (blocking_dispatcher_window.item)
					Result := 0
				end
			end
		end

	process_received_message (window: WEL_WINDOW; hwnd: POINTER; msg, wparam, lparam: INTEGER): INTEGER is
			-- Process the message.
		local
			returned_value: INTEGER
			has_return_value: BOOLEAN
		do
			check
				window_exists: window.exists
			end
			window.increment_level

			Result := window.process_message (hwnd, msg, wparam, lparam)
				--| Store `message_return_value' and `has_return_value' for later
				--| use, since `call_default_window_procedure' can reset their value.
			if window.has_return_value then
				returned_value := window.message_return_value
				has_return_value := window.has_return_value
			end

			if window.default_processing then
				Result := window.call_default_window_procedure (msg, wparam, lparam)
			end

			if has_return_value then
				Result := returned_value
			end

			window.decrement_level
		end


feature {NONE} -- Debugging

	unauthorized_messages: HASH_TABLE [INTEGER, INTEGER] is
		once
			create Result.make (50)
			Result.put (Wel_window_constants.Wm_mousemove,			Wel_window_constants.Wm_mousemove)
			Result.put (Wel_window_constants.Wm_nchittest,			Wel_window_constants.Wm_nchittest)
			Result.put (Wel_window_constants.Wm_ncmousemove,		Wel_window_constants.Wm_ncmousemove)
			Result.put (Wel_window_constants.Wm_lbuttondown,		Wel_window_constants.Wm_lbuttondown)
			Result.put (Wel_window_constants.Wm_mbuttondown,		Wel_window_constants.Wm_mbuttondown)
			Result.put (Wel_window_constants.Wm_rbuttondown,		Wel_window_constants.Wm_rbuttondown)
			Result.put (Wel_window_constants.Wm_lbuttonup,			Wel_window_constants.Wm_lbuttonup)
			Result.put (Wel_window_constants.Wm_mbuttonup,			Wel_window_constants.Wm_mbuttonup)
			Result.put (Wel_window_constants.Wm_rbuttonup,			Wel_window_constants.Wm_rbuttonup)
			Result.put (Wel_window_constants.Wm_lbuttondblclk,		Wel_window_constants.Wm_lbuttondblclk)
			Result.put (Wel_window_constants.Wm_mbuttondblclk,		Wel_window_constants.Wm_mbuttondblclk)
			Result.put (Wel_window_constants.Wm_rbuttondblclk,		Wel_window_constants.Wm_rbuttondblclk)
			Result.put (Wel_window_constants.Wm_nclbuttondown,		Wel_window_constants.Wm_nclbuttondown)
			Result.put (Wel_window_constants.Wm_ncmbuttondown,		Wel_window_constants.Wm_ncmbuttondown)
			Result.put (Wel_window_constants.Wm_ncrbuttondown,		Wel_window_constants.Wm_ncrbuttondown)
			Result.put (Wel_window_constants.Wm_nclbuttonup,		Wel_window_constants.Wm_nclbuttonup)
			Result.put (Wel_window_constants.Wm_ncmbuttonup,		Wel_window_constants.Wm_ncmbuttonup)
			Result.put (Wel_window_constants.Wm_ncrbuttonup,		Wel_window_constants.Wm_ncrbuttonup)
			Result.put (Wel_window_constants.Wm_nclbuttondblclk,	Wel_window_constants.Wm_nclbuttondblclk)
			Result.put (Wel_window_constants.Wm_ncmbuttondblclk,	Wel_window_constants.Wm_ncmbuttondblclk)
			Result.put (Wel_window_constants.Wm_ncrbuttondblclk,	Wel_window_constants.Wm_ncrbuttondblclk)
			Result.put (Wel_window_constants.Wm_keyup,				Wel_window_constants.Wm_keyup)
			Result.put (Wel_window_constants.Wm_keydown,			Wel_window_constants.Wm_keydown)
			Result.put (Wel_window_constants.Wm_syskeyup,			Wel_window_constants.Wm_syskeyup)
			Result.put (Wel_window_constants.Wm_syskeydown,			Wel_window_constants.Wm_syskeydown)
			Result.put (Wel_window_constants.Wm_syschar,			Wel_window_constants.Wm_syschar)
			Result.put (Wel_window_constants.Wm_sysdeadchar,		Wel_window_constants.Wm_sysdeadchar)
			Result.put (Wel_window_constants.Wm_char,				Wel_window_constants.Wm_char)
			Result.put (Wel_window_constants.Wm_deadchar,			Wel_window_constants.Wm_deadchar)
			Result.put (Wel_window_constants.Wm_hscroll,			Wel_window_constants.Wm_hscroll)
			Result.put (Wel_window_constants.Wm_vscroll,			Wel_window_constants.Wm_vscroll)
			Result.put (Wel_window_constants.Wm_syscommand,			Wel_window_constants.Wm_syscommand)
			Result.put (Wel_window_constants.Wm_enable,				Wel_window_constants.Wm_enable)
			Result.put (Wel_window_constants.Wm_mouseleave,			Wel_window_constants.Wm_mouseleave)
			Result.put (Wel_window_constants.Wm_parentnotify,		Wel_window_constants.Wm_parentnotify)
			Result.put (Wel_window_constants.Wm_setfocus,			Wel_window_constants.Wm_setfocus)
			Result.put (Wel_window_constants.Wm_devicechange,		Wel_window_constants.Wm_devicechange)
		end

feature {NONE} -- Externals

	cwin_set_foreground_window (hwnd: POINTER): BOOLEAN is
			-- SDK GetWindowLong
		external
			"C [macro <wel.h>] (HWND): BOOL"
		alias
			"SetForegroundWindow"
		end

	cwin_set_active_window (hwnd: POINTER) is
			-- SDK GetWindowLong
		external
			"C [macro <wel.h>] (HWND)"
		alias
			"SetActiveWindow"
		end

	cwin_begin_defer_window_pos (number_of_windows: INTEGER): POINTER is
			-- SDK BeginDeferWindowPos
		external
			"C [macro <wel.h>] (int) : HDWP"
		alias
			"BeginDeferWindowPos"
		end

	cwin_end_defer_window_pos (windowposinfo: POINTER): BOOLEAN is
			-- SDK EndDeferWindowPos
		external
			"C [macro <wel.h>] (HDWP): BOOL"
		alias
			"EndDeferWindowPos"
		end

	cwin_defer_window_pos (
		windowposinfo: POINTER
		hwnd: POINTER
		hwnd_insertafter: POINTER
		x, y: INTEGER
		cx, cy: INTEGER
		flags: INTEGER
	): POINTER is
		external
			"C [macro <wel.h>] (HDWP, HWND, HWND, int, int, int, int, UINT): HDWP"
		alias
			"DeferWindowPos"
		end

end -- class WEL_BLOCKING_DISPATCHER
