--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"Eiffel Vision application. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_APPLICATION_IMP
	
inherit
	EV_APPLICATION_I

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

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the application.
		do
			base_make (an_interface)
			set_application (Current)
			create_dispatcher
			init_instance
			init_application
		end

	launch  is
			-- Start the event loop.
		do
			set_application_main_window (main_window)
			run
		end

feature -- Basic operation

	process_events is
			-- Process any pending events.
			--| Pass control to the GUI toolkit so that it can
			--| handle any events that may be in its queue.
		local
			msg: WEL_MSG
			done: BOOLEAN
		do
			from
				create msg.make
			until
				done
			loop
				msg.peek_all
				if msg.last_boolean_result then
					process_message (msg)
				else
					done := True
				end
			end
			c_sleep (0)
		end

	sleep (msec: INTEGER) is
			-- Wait for `msec' milliseconds and return.
		do
			c_sleep (msec)
		end

feature -- Root window

	main_window: EV_WINDOW_IMP is
			-- Current main window of the application
		once
			Result ?= root_windows.first.implementation
		end

feature -- Element change

	add_root_window (w: EV_WINDOW) is
			-- Add `w' to the list of root windows.
		do
			root_windows.extend (w)
		end

	remove_root_window (w: EV_WINDOW) is
			-- Remove `w' from the root windows list.
		do
			root_windows.prune_all (w)
			if root_windows.empty then
				cwin_post_quit_message (0)
			else
				set_application_main_window (main_window)
			end
		end

feature -- Status report

	tooltip_delay: INTEGER is
			-- Time in milliseconds before tooltips pop up.
		do
			check
				to_be_implemented: False
			end
		end

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER) is
			-- Set `tooltip_delay' to `a_delay'.
		do
			check
				to_be_implemented: False
			end
		end

feature -- Basic operation

	destroy is
			-- End the application.
		do
			from
				root_windows.start
			until
				root_windows.empty
			loop
				root_windows.item.destroy
			end
			quit_requested := True
			destroy_just_called := True
			is_destroyed := True
		end

feature {NONE} -- WEL Implemenation

	controls_dll: WEL_INIT_COMMCTRL_EX
			-- Needed for loading the common controls dlls.

	rich_edit_dll: WEL_RICH_EDIT_DLL
			-- Needed if the user want to open a rich edit.

	init_application is
			-- Load the dll needed sometimes
		do
			create controls_dll.make_with_flags (Icc_userex_classes
					+ Icc_win95_classes + Icc_cool_classes
					+ Icc_bar_classes + Icc_updown_class)
			create rich_edit_dll.make
		end

feature {NONE} -- Implementation

	quit_requested: BOOLEAN
			-- Has a Wm_quit message been processed?
			-- Or has destroy been called?

	message_loop is
			-- Windows message loop.
			--| Redefined to add accelerator functionality.
		local
			msg: WEL_MSG
		do
			from
				create msg.make
			until
				quit_requested
			loop
				msg.peek_all
				if msg.last_boolean_result then
					process_message (msg)
				else
					if not internal_idle_actions.empty then
						internal_idle_actions.call ([])
					elseif not interface.idle_actions.empty then 
						interface.idle_actions.call ([])
					else
						msg.wait
					end
				end
			end
		end

	process_message (msg: WEL_MSG) is
			-- Dispatch `msg'.
			--| Different from WEL because of accelerators.
		local
			dlg: POINTER
		do
			if msg.last_boolean_result then
				if msg.quit then
					quit_requested := True
				else
					dlg := cwin_get_last_active_popup (main_window.wel_item)
					if is_dialog (dlg) then
						msg.process_dialog_message (dlg)
						if not msg.last_boolean_result then
							msg.translate
							msg.dispatch
						end
					else
						--| FIXME Accelerators to be implemented.
						msg.translate
						msg.dispatch
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

feature {NONE} -- Externals

	c_sleep (v: INTEGER) is
			-- Sleep for `v' milliseconds
		external
			"C | <winbase.h>"
		alias
			"Sleep"
		end

	cwin_post_quit_message (exit_code: INTEGER) is
			-- SDK PostQuitMessage
		external
			"C [macro <wel.h>] (int)"
		alias
			"PostQuitMessage"
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.33  2000/04/20 18:26:54  brendel
--| Cleanup.
--| Application quits when every window is destroyed.
--| Every window is destroyed and app quits when destroy gets called.
--|
--| Revision 1.32  2000/04/20 00:40:47  brendel
--| process_events now also uses extended message processing that message
--| loop has.
--|
--| Revision 1.31  2000/04/13 19:36:14  brendel
--| Improved add_root_window and remove_root_window.
--| When destroy is called, wipes out root_windows.
--| Application exits when root_windows empty.
--|
--| Revision 1.30  2000/04/11 18:14:33  brendel
--| First window is now shown after postlaunch actions.
--|
--| Revision 1.29  2000/04/10 16:11:50  brendel
--| Reverted wrong implementation of message_loop.
--|
--| Revision 1.28  2000/04/06 00:04:50  brendel
--| message_loop now ends when destroyed.
--|
--| Revision 1.27  2000/04/03 17:50:13  rogers
--| Redefined run from WEL_APPLICATION to avoid `first_window'
--| being shown automatically.
--|
--| Revision 1.26  2000/03/29 20:33:48  brendel
--| Implemented post_launch_actions.
--|
--| Revision 1.25  2000/03/23 19:03:52  brendel
--| Removed once_idle_actions.
--|
--| Revision 1.24  2000/03/23 18:20:20  brendel
--| Implemented once_idle_actions in new way.
--|
--| Revision 1.23  2000/03/21 02:23:11  brendel
--| First implementation of accelerators. Takes only `first_window'. The
--| rest is to be implemented.
--|
--| Revision 1.22  2000/03/16 23:26:10  brendel
--| Formatting.
--| Tried something with accelerators.
--|
--| Revision 1.21  2000/03/14 03:02:53  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.20.2.2  2000/03/14 00:17:49  brendel
--| Improved comment.
--|
--| Revision 1.20.2.1  2000/03/14 00:05:10  brendel
--| Added `do_once_on_idle'.
--| Added `once_idle_actions', called and cleared on idle.
--|
--| Revision 1.20  2000/02/29 19:21:27  rogers
--| Launch now sets the root_window to the main_window. Set root_window now sets the application main_window. Remove window has been altered, see diffs, and destroy now sets destroy just called to True and is_destroyed to True.
--|
--| Revision 1.18  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.17  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.16.10.9  2000/01/29 01:13:30  brendel
--| Added not yet implemented features for tooltips.
--|
--| Revision 1.16.10.8  2000/01/27 19:30:09  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.16.10.7  2000/01/26 18:34:10  brendel
--| Added feature `sleep'.
--|
--| Revision 1.16.10.6  2000/01/25 17:37:51  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.16.10.5  2000/01/20 17:36:20  king
--| Added idle_actions and internal_idle_actions.
--|
--| Revision 1.16.10.4  1999/12/17 17:28:05  rogers
--| Altered to fit in with the review branch. Make takes an interface.
--|
--| Revision 1.16.10.3  1999/12/01 00:21:20  oconnor
--| partial implementation of process_events
--|
--| Revision 1.16.10.2  1999/11/30 23:58:17  oconnor
--| added process_events
--|
--| Revision 1.16.10.1  1999/11/24 17:30:17  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.16.6.3  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
