indexing
	description: "General notions of a Windows application. All WEL %
		%applications must define its own descendant of WEL_APPLICATION."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_APPLICATION

inherit
	WEL_APPLICATION_MAIN_WINDOW

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end
	
	WEL_GWL_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make is
			-- Create the application's dispatcher,
			-- set the application's main window and run
			-- the application.
		do
			set_application (Current)
			create_dispatcher
			init_instance
			init_application
			set_application_main_window (main_window)
			if runable then
				run
			end
		end

feature -- Access

	main_window: WEL_COMPOSITE_WINDOW is
			-- Must be defined as a once funtion to create the
			-- application's main_window.
		require
			once_declaration: application_main_window = Void
		deferred
		ensure
			result_not_void: Result /= Void
			parent_main_window_is_void: Result.parent = Void
		end

	accelerators: WEL_ACCELERATORS is
			-- Application's accelerators
			-- May be redefined (in once) to associate accelerators.
		once
		end

	default_show_command: INTEGER is
			-- Default command used to show `main_window'.
			-- May be redefined to have a maximized window for
			-- instance.
			-- See class WEL_SW_CONSTANTS for values.
		local
			ma: WEL_MAIN_ARGUMENTS
		once
			create ma
			Result := ma.command_show
		end

feature -- Status report

	idle_action_enabled: BOOLEAN
			-- Is the idle action enabled?
			-- (False by default)

	runable: BOOLEAN is
			-- Can the application be run?
			-- (True by default)
			-- The user may want to return False if the application
			-- can not be executed for any reason.
		do
			Result := True
		end

	is_dialog (hwnd: POINTER): BOOLEAN is
			-- Is the window corresponding to `hwnd' a dialog box?
			-- We call the function with a dialog box option,
			-- if it is indeed a dialog, the result will always
			-- be non zero, otherwise it is zero.
		do
			Result := c_get_window_long (hwnd, Dwl_dlgproc) /= 0
		end

feature -- Status setting

	enable_idle_action is
			-- Enable the call to `idle_action' when the message
			-- queue is empty.
		do
			idle_action_enabled := True
		ensure
			idle_action_enabled: idle_action_enabled
		end

	disable_idle_action is
			-- Disable the call to `idle_action' when the message
			-- queue is empty.
		do
			idle_action_enabled := False
		ensure
			idle_action_disabled: not idle_action_enabled
		end

feature -- Basic operations

	run is
			-- Create `main_window' and start the message loop.
		require
			runable: runable
			main_window_not_void: application_main_window /= Void
			parent_main_window_is_void: application_main_window.parent = Void
		local
			d: WEL_MAIN_DIALOG
		do
			d ?= application_main_window
			if d /= Void then
				d.activate
			end
			application_main_window.show_with_option (default_show_command)
			message_loop
		end

	idle_action is
			-- Called when the message queue is empty.
			-- Useful to perform background operations.
		require
			idle_action_enabled: idle_action_enabled
		do
		end

feature {NONE} -- Implementation

	init_instance is
			-- Called for the first instance
			-- of the application.
			-- Not yet implemented, for future release.
		do
		end

	init_application is
			-- Called for each instance of the application.
			-- May be defined to load DLLs.
		do
		end

	message_loop is
			-- Windows message loop
		local
			msg: WEL_MSG
			accel: WEL_ACCELERATORS
			main_w: WEL_WINDOW
			done: BOOLEAN
			dlg: POINTER
		do
			-- `accel' and `main_w' are declared
			-- locally to get a faster access.
			accel := accelerators
			main_w := application_main_window
			if accel /= Void then
				-- Process with accelerators
				-- IsDialogMessage must be called!
				from
					create msg.make
				until
					done
				loop
					msg.peek_all
					if msg.last_boolean_result then
						if msg.quit then
							done := True
						else
							dlg := cwin_get_last_active_popup (main_window.item)
							if is_dialog (dlg) then
								msg.process_dialog_message (dlg)
								if not msg.last_boolean_result then
									msg.translate
									msg.dispatch
								end
							else
								msg.translate_accelerator (main_w, accel)
								if not msg.last_boolean_result then
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
			else
				-- Process without accelerators
				-- IsDialogMessage must be called!
				from
					create msg.make
				until
					done
				loop
					msg.peek_all
					if msg.last_boolean_result then
						if msg.quit then
							done := True
						else
							dlg := cwin_get_last_active_popup (main_window.item)
							if is_dialog (dlg) then
								msg.process_dialog_message (dlg)
								if not msg.last_boolean_result then
									msg.translate
									msg.dispatch
								end
							else
									msg.translate
									msg.dispatch
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
		end

	create_dispatcher is
			-- Create the `dispatcher'.
		require
			dispatcher_void: dispatcher = Void
		do
			create dispatcher.make
		ensure
			dispatcher_not_void: dispatcher /= Void
		end

	dispatcher: WEL_DISPATCHER
			-- Windows and dialog boxes messages dispatcher

feature {NONE} -- Externals

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

end -- class WEL_APPLICATION

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

