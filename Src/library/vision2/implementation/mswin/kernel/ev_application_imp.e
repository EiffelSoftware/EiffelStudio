indexing
	description:
		"EiffelVision application, mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_APPLICATION_IMP
	
inherit
	EV_APPLICATION_I

	EV_ACCELERATOR_HANDLER_IMP
		rename
			application as wrong_application
		redefine
			accelerator_table,
			on_accelerator_command,
			execute_accel_command
		end

 	WEL_APPLICATION
 		rename
 			make as wel_make
		redefine
			init_application,
			message_loop
 		end

	WEL_ICC_CONSTANTS
		export
			{NONE} all
		end

	WEL_WS_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create the application.
		do
			set_application (Current)
			create_dispatcher
			init_instance
			init_application
		end

	launch (interface: EV_APPLICATION) is
			-- Launch the main window and the application.
		local
			w: EV_UNTITLED_WINDOW_IMP
		do
			w ?= interface.first_window.implementation
			if root_windows.empty then
				add_root_window (w)
			elseif root_windows.first /= w then
				root_windows.start
				root_windows.prune (w)
				root_windows.put_front (w)
			end
			set_root_window
			interface.initialize
			if runable then
				run
			end
			destroy_application
		end

feature -- Root window

	main_window: EV_UNTITLED_WINDOW_IMP is
			-- Current main window of the application
		once
			Result := root_windows.first
		end

feature -- Status setting

	destroy_application is
			-- Destroy few objects before to leave.
		do
			if accelerator_table /= Void then
				accelerator_table.destroy
			end
		end

	set_root_window is
		do
			main_window.application.put (Current)
			set_application_main_window (main_window)
		end

feature -- Element change

	add_root_window (w: EV_UNTITLED_WINDOW_IMP) is
			-- Add `w' to the list of root windows.
		do
			root_windows.extend (w)
		end

	remove_root_window (w: EV_UNTITLED_WINDOW_IMP) is
			-- Remove `w' from the root windows list.
		do
			if root_windows.count /= 1 then
				root_windows.start
				if root_windows.item = w then
					root_windows.remove
					set_root_window
				else
					root_windows.prune (w)
				end
			end
		end

feature -- Accelerators - command association

	add_accelerator_command (acc: EV_ACCELERATOR; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when `acc' is completed by the user.
		do
			add_accel_command (acc, cmd, arg)
		end

	remove_accelerator_commands (acc: EV_ACCELERATOR) is
			-- Empty the list of commands to be executed when
			-- `acc' is completed by the user.
		do
			remove_accel_commands (acc)
		end

feature -- Basic operation

	exit is
			-- Exit the application
		do
			main_window.destroy
		end

	splash_pixmap (pix: EV_PIXMAP) is
			-- Show the splash screen pixmap `pix'.
		local
			metric: WEL_SYSTEM_METRICS
			splash: EV_UNTITLED_WINDOW_IMP
		do
			create metric
			create splash.make
			splash.set_background_pixmap (pix)
			splash.set_style (Ws_popup + Ws_overlapped + Ws_clipchildren + Ws_clipsiblings)
			splash.move ((metric.full_screen_client_area_width - pix.width) // 2, (metric.full_screen_client_area_height - pix.height) // 2)
			splash.set_minimum_size (pix.width, pix.height)
			splash.set_maximum_size (metric.screen_width, metric.screen_height)
			splash_screen := splash
			splash.show
		end

feature -- Implementation

	accelerator_table: EV_ACCELERATOR_TABLE_IMP is
			-- Table that memories and passes the accelerators to the
			-- system. In this table, all the accelerators are unique.
		do
			Result := main_window.accelerator_table
		end

	execute_accel_command (id: INTEGER; data: EV_EVENT_DATA) is
			-- Execute the command that correspond to the accelerator
			-- represented by id.
			-- If there are no command, it calls the execution of the
			-- parent.
		local
			list: LINKED_LIST [EV_INTERNAL_COMMAND]
			i: INTEGER
		do
			if accelerator_list /= Void and then accelerator_list.has (id) then
				list := (accelerator_list @ id)
				from
					i := 1
				until
					i > list.count
				loop
					(list @ i).execute (data)
					i := i + 1
				end
			end
		end

feature {NONE} -- WEL Implemenation

	controls_dll: WEL_INIT_COMMCTRL_EX
			-- Needed for loading the common controls dlls.

	rich_edit_dll: WEL_RICH_EDIT_DLL
			-- Needed if the user want to open a rich edit.

	has_accelerator: BOOLEAN is
			-- Does the application has an accelerator
		do
			Result := not accelerator_table.empty
		end

	init_application is
			-- Load the dll needed sometimes
		do
			create controls_dll.make_with_flags (Icc_userex_classes
					+ Icc_win95_classes + Icc_cool_classes
					+ Icc_bar_classes + Icc_updown_class)
			create rich_edit_dll.make
		end

feature {NONE} -- Message loop, we redefine it because the user
			   -- Can add an accelerator at the run-time.

	message_loop is
			-- Windows message loop
		local
			msg: WEL_MSG
			accel: WEL_ACCELERATORS
			main_w: WEL_WINDOW
			done: BOOLEAN
			dlg: POINTER
		do
			-- Destroy the spash screen
			if splash_screen /= Void then
				splash_screen.destroy
				splash_screen := Void
			end

			-- `accel' and `main_w' are declared
			-- locally to get a faster access.
			accel := accelerator_table
			main_w := main_window

			-- Process the messages
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
						dlg := cwin_get_last_active_popup (main_w.item)
						if is_dialog (dlg) then
							msg.process_dialog_message (dlg)
							if not msg.last_boolean_result then
								msg.translate
								msg.dispatch
							end
						else
							if has_accelerator then
								msg.translate_accelerator (main_w, accel)
								if not msg.last_boolean_result then
									msg.translate
									msg.dispatch
								end
							else
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

feature {NONE} -- Inapplicable

	iterate is
			-- Loop the application.
			-- Already done by WEL : do nothing.
        do
			check
				Do_nothing: True
			end
        end

	on_accelerator_command (id: INTEGER) is
			-- The `acelerator_id' has been activated.
		do
			check
				Inapplicable: False
			end
		end

	parent_imp: EV_CONTAINER_IMP is
			-- Parent of the current widget.
		do
			check
				Inapplicable: False
			end
		end

	wrong_application: CELL [EV_APPLICATION_IMP] is
			-- The current application. Needed for the
			-- accelerators.
		do
			check
				Inapplicable: False
			end
		end

	focus_on_widget: CELL [EV_WIDGET_IMP] is
			-- Widget that currently have the focus.
		do
			check
				Inapplicable: False
			end
 		end

end -- class EV_APPLICATION_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
