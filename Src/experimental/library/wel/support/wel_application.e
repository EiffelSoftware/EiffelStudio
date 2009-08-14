note
	description: "General notions of a Windows application. All WEL %
		%applications must define its own descendant of WEL_APPLICATION."
	legal: "See notice at end of class."
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

	make
			-- Create the application's dispatcher,
			-- set the application's main window and run
			-- the application.
		do
			set_application (Current)
			init_instance
			init_application
			set_application_main_window (main_window)
			if runable then
				run
			end
		end

feature -- Access

	main_window: WEL_COMPOSITE_WINDOW
			-- Must be defined as a once funtion to create the
			-- application's main_window.
		deferred
		ensure
			result_not_void: Result /= Void
			parent_main_window_is_void: Result.parent = Void
		end

	accelerators: detachable WEL_ACCELERATORS
			-- Application's accelerators
			-- May be redefined (in once) to associate accelerators.
		do
		end

	default_show_command: INTEGER
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

	runable: BOOLEAN
			-- Can the application be run?
			-- (True by default)
			-- The user may want to return False if the application
			-- cannot be executed for any reason.
		do
			Result := True
		end

	is_dialog (hwnd: POINTER): BOOLEAN
			-- Is the window corresponding to `hwnd' a dialog box?
			-- We call the function with a dialog box option,
			-- if it is indeed a dialog, the result will always
			-- be non zero, otherwise it is zero.
		do
			Result := cwin_get_window_long (hwnd, Dwlp_dlgproc) /= default_pointer
		end

feature -- Status setting

	enable_idle_action
			-- Enable the call to `idle_action' when the message
			-- queue is empty.
		do
			idle_action_enabled := True
		ensure
			idle_action_enabled: idle_action_enabled
		end

	disable_idle_action
			-- Disable the call to `idle_action' when the message
			-- queue is empty.
		do
			idle_action_enabled := False
		ensure
			idle_action_disabled: not idle_action_enabled
		end

feature -- Basic operations

	run
			-- Create `main_window' and start the message loop.
		require
			runable: runable
			main_window_not_void: application_main_window /= Void
			parent_main_window_is_void: attached application_main_window as l_app and then l_app.parent = Void
		local
			l_window: like application_main_window
		do
			l_window := application_main_window
				-- Per precondition.
			check l_window_attached: l_window /= Void end
			if attached {WEL_MAIN_DIALOG} l_window as l_dialog then
				l_dialog.activate
			end
			if l_window.exists then
				l_window.show_with_option (default_show_command)
			end
			message_loop
		end

	idle_action
			-- Called when the message queue is empty.
			-- Useful to perform background operations.
		require
			idle_action_enabled: idle_action_enabled
		do
		end

feature {NONE} -- Implementation

	init_instance
			-- Called for the first instance
			-- of the application.
			-- Not yet implemented, for future release.
		do
		end

	init_application
			-- Called for each instance of the application.
			-- May be defined to load DLLs.
		do
		end

	message_loop
			-- Windows message loop
		local
			msg: WEL_MSG
			accel: detachable WEL_ACCELERATORS
			main_w: detachable WEL_WINDOW
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
								if main_w /= Void and then main_w.exists then
									msg.translate_accelerator (main_w, accel)
								end
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

	dispatcher: WEL_DISPATCHER
			-- Windows and dialog boxes messages dispatcher
		once
			create Result.make
		end

feature {NONE} -- Externals

	cwin_get_last_active_popup (hwnd: POINTER): POINTER
			-- SDK GetLastActivePopup
		external
			"C [macro <wel.h>] (HWND): EIF_POINTER"
		alias
			"GetLastActivePopup"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_APPLICATION

