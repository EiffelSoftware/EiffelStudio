--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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
			add_root_window (interface.first_window)
			--root_window)
			--|FIXME
			set_root_window
			run
			destroy_application
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
			create msg.make
			from
			until done
			loop
				msg.peek_all
				if msg.last_boolean_result then
					msg.translate
					msg.dispatch
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

feature -- Status setting

	destroy_application is
			-- Destroy few objects before to leave.
		do
		end

	set_root_window is
		do
			main_window.application.put (Current)
			set_application_main_window (main_window)
		end

feature -- Element change

	add_root_window (w: EV_WINDOW) is
			-- Add `w' to the list of root windows.
		do
			root_windows.extend (w)
			--|FIXME .implementation)
		end

	remove_root_window (w: EV_WINDOW) is
			-- Remove `w' from the root windows list.
		do
			if root_windows.count /= 1 then
				root_windows.start
				if root_windows.item = w then
					--.implementation then
					--|FIXME
					root_windows.remove
					set_root_window
				else
					root_windows.prune (w)
					--.implementation)
					--|FIXME
				end
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
			main_window.destroy
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

feature {NONE} -- Message loop, we redefine it because the user
			   -- Can add an accelerator at the run-time.

	message_loop is
			-- Windows message loop
		local
			msg: WEL_MSG
			--accel: WEL_ACCELERATORS
			main_w: WEL_WINDOW
			done: BOOLEAN
			dlg: POINTER
		do
			-- `accel' and `main_w' are declared
			-- locally to get a faster access.
			--accel := accelerator_table
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
							--if has_accelerator then
							--	msg.translate_accelerator (main_w, accel)
							--	if not msg.last_boolean_result then
							--		msg.translate
							--		msg.dispatch
							--	end
							--else
								msg.translate
								msg.dispatch
							--end
						end
					end
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

feature -- External Implementation

	c_sleep (v: INTEGER) is
			-- Sleep for `v' milliseconds
		external
			"C | <winbase.h>"
		alias
			"Sleep"
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
