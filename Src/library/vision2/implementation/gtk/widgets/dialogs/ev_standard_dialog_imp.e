indexing
	description: "Eiffel Vision standard dialog. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STANDARD_DIALOG_IMP

inherit
	EV_STANDARD_DIALOG_I
		redefine
			interface
		select
			interface,
			make
		end

	EV_ANY_IMP
		redefine
			interface
		end

	EV_WINDOW_IMP
		rename
			interface as ev_window_imp_interface,
			make as ev_window_imp_make
		undefine
			destroy,
			title,
			set_title,
			set_blocking_window,
			block
		redefine
			blocking_window,
			on_key_event,
			initialize_client_area,
			call_close_request_actions
		end

	EV_STANDARD_DIALOG_ACTION_SEQUENCES_IMP
	
feature -- Initialization

	initialize_client_area is
			-- Implementation not needed as this is already done by toolkit
		do
			-- Do nothing
		end

feature -- Access

	title: STRING is
			-- Title of dialog shown in title bar.
		do
			check
				c_object /= NULL
			end
			check
				C.gtk_window_struct_title (c_object) /= NULL
			end
			create Result.make_from_c (C.gtk_window_struct_title (c_object))
		end

	blocking_window: EV_WINDOW
			-- Window this dialog is a transient for.

feature -- Status report

	selected_button: STRING
			-- Label of the last clicked button.

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show the dialog and wait until the user closes it.
		do
			user_clicked_ok := False
			set_blocking_window (a_window)
			selected_button := Void
			C.gtk_widget_show (c_object)
			block
			set_blocking_window (Void)
			if selected_button /= Void then
				if selected_button.is_equal ("OK") then
					interface.ok_actions.call ([])
				elseif selected_button.is_equal ("Cancel") then
					interface.cancel_actions.call ([])
				end
			end
		end

	set_title (a_title: STRING) is
			-- Set the title of the dialog.
		do
			C.gtk_window_set_title (c_object, eiffel_to_c (a_title))
		end

	set_blocking_window (a_window: EV_WINDOW) is
			-- Set as transient for `a_window'.
		local
			win_imp: EV_WINDOW_IMP
		do
			blocking_window := a_window
			if a_window /= Void then
				win_imp ?= a_window.implementation
				C.gtk_window_set_transient_for (c_object, win_imp.c_object)
			else
				C.gtk_window_set_transient_for (c_object, NULL)
			end
		end

feature {NONE} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
		do
			Precursor {EV_WINDOW_IMP} (a_key, a_key_string, a_key_press)
			if a_key /= Void and then a_key.code = app_implementation.Key_constants.key_escape and then not a_key_press then
				on_ok
			end				
		end

	block is
			-- Wait until window is closed by the user.
		local
			dummy: INTEGER
		do
			from
			until
				is_destroyed or else selected_button /= Void
			loop
				dummy := C.gtk_main_iteration_do (True)
			end
		end

	enable_closeable is
			-- Set the window to be closeable by the user
		do
			C.gdk_window_set_functions (
				C.gtk_widget_struct_window (c_object),
				C.GDK_FUNC_CLOSE_ENUM + C.GDK_FUNC_MOVE_ENUM
			)
		end
		
	call_close_request_actions is
			-- Call `on_cancel' if user wants to quit dialog.
		do
			on_cancel
		end

	on_cancel is
			-- Close window and call action sequence.
		do
			selected_button := "Cancel"
			C.gtk_widget_hide (c_object)
		end

	on_ok is
			-- Close window and call action sequence.
		do
			user_clicked_ok := True
			selected_button := "OK"
			C.gtk_widget_hide (c_object)
		end
		
	user_clicked_ok: BOOLEAN
		-- Has the user explicitly cancelled the dialog.

	interface: EV_STANDARD_DIALOG

end -- class EV_STANDARD_DIALOG_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.18  2001/07/14 12:46:23  manus
--| Replace --! by --|
--|
--| Revision 1.17  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.16  2001/06/29 23:00:49  king
--| Accounted for info hide in ev_key
--|
--| Revision 1.15  2001/06/29 22:26:47  king
--| Added user_clicked_ok functionality
--|
--| Revision 1.14  2001/06/22 00:50:04  king
--| Now using initialize precursor
--|
--| Revision 1.13  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.7.4.9  2000/11/17 19:41:19  etienne
--| Added void support for set_blocking_window
--|
--| Revision 1.7.4.8  2000/09/04 18:23:26  oconnor
--| inherit EV_WINDOW_IMP for positionable stuff
--|
--| Revision 1.7.4.7  2000/08/16 19:45:01  king
--| Implemented show_modal_to_window and enable_closeable
--|
--| Revision 1.7.4.6  2000/07/24 21:36:07  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.7.4.5  2000/07/20 19:56:36  king
--| Removed hide/show
--|
--| Revision 1.7.4.4  2000/07/20 18:38:52  king
--| Added double_array_i_thimplementation/gtk/Clib/ev_c_util.h
--|
--| Revision 1.7.4.3  2000/06/05 23:50:13  oconnor
--| dont try to access void selected_button
--|
--| Revision 1.7.4.2  2000/05/05 20:41:11  brendel
--| Fixed bug in `block'.
--|
--| Revision 1.7.4.1  2000/05/03 19:08:46  oconnor
--| mergred from HEAD
--|
--| Revision 1.11  2000/03/01 00:08:38  brendel
--| Improved implementation of `title'.
--| Removed set and unset of modal in show_modal, since standard dialogs are
--| modal at all times because of windows limitations.
--|
--| Revision 1.10  2000/02/29 02:26:22  brendel
--| Improved implementation of `block'.
--| Rearranged some calls to try solving some strange behaviour when
--| a dialog is shown from within an action of another dialog. Seems to make
--| no difference, though.
--|
--| Revision 1.9  2000/02/22 18:39:37  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.8  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.7  2000/02/04 04:25:37  oconnor
--| released
--|
--| Revision 1.7.6.6  2000/01/27 23:52:53  brendel
--| Added feature selected_button.
--| Finished implementing events.
--|
--| Revision 1.7.6.5  2000/01/27 19:29:41  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.4  2000/01/27 17:04:48  brendel
--| Added blocking_window and set-blocking_window.
--|
--| Revision 1.7.6.3  2000/01/27 02:38:19  brendel
--| Revised with features: set_title, title, show_modal, ok_actions and
--| cancel_actions.
--|
--| Revision 1.7.6.2  2000/01/26 18:16:48  brendel
--| Cleanup.
--| Fate of this class is uncertain.
--|
--| Revision 1.7.6.1  1999/11/24 17:29:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
