indexing
	description: "Eiffel Vision dialog. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG_IMP
	
inherit
	EV_DIALOG_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_TITLED_WINDOW_IMP
		redefine
			make,
			interface,
			call_close_request_actions
		end

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Create empty dialog box.
		do
			base_make (an_interface)
			set_c_object (C.gtk_window_new (C.Gtk_window_dialog_enum))
			C.gtk_object_ref (c_object)
			C.gtk_widget_realize (c_object)
			C.gtk_window_set_position (
				c_object,
				C.Gtk_win_pos_center_enum
			)
			C.gtk_window_set_policy (c_object, 0, 0, 1) -- False, False, True
			enable_closeable
		end
		
feature -- Status Report

	is_closeable: BOOLEAN is
			-- Is the window closeable by the user?
			-- (Through a clik on the Window Menu, or by
			-- pressing ALT-F4)
		do
			Result := is_dialog_closeable
		end

feature -- Status Setting
	
	enable_closeable is
			-- Set the window to be closeable by the user
		do
			C.gdk_window_set_functions (
				C.gtk_widget_struct_window (c_object),
				C.GDK_FUNC_CLOSE_ENUM + C.GDK_FUNC_MOVE_ENUM
			)
			is_dialog_closeable := True
		end

	disable_closeable is
			-- Set the window not to be closeable by the user
		do
			C.gdk_window_set_functions (
				C.gtk_widget_struct_window (c_object),
				C.GDK_FUNC_MOVE_ENUM
			)
			is_dialog_closeable := False
		end

feature -- Basic operations

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show `Current' modal with respect to `a_window'.
		local
			was_modal: BOOLEAN
			parent_was_modal: BOOLEAN
			a_window_imp: EV_WINDOW_IMP
		do
				-- Remove the modality of the parent if it is modal
			if a_window /= Void then
				a_window_imp ?= a_window.implementation

				if a_window_imp.is_modal then
					parent_was_modal := True
					a_window_imp.disable_modal
				end
			end

			if is_modal then
				was_modal := True
			else
				enable_modal
			end

			if a_window /= Void then
				C.gtk_window_set_transient_for (c_object, a_window_imp.c_object)
			else
				C.gtk_window_set_transient_for (c_object, NULL)
			end				
			
			show
			block
			if not is_destroyed and then not was_modal then
				disable_modal
			end

				-- Put parent's original modality back.
			if a_window /= Void and then parent_was_modal then
				a_window_imp.enable_modal
			end
		end

	show_relative_to_window (a_window: EV_WINDOW) is
			-- Show `Current' with respect to `a_window'.
		local
			a_window_imp: EV_WINDOW_IMP
		do
			if a_window /= Void then
				a_window_imp ?= a_window.implementation
				C.gtk_window_set_transient_for (c_object, a_window_imp.c_object)
			else
				C.gtk_window_set_transient_for (c_object, NULL)
			end				
			show
		end

feature {NONE} -- Implementation

	call_close_request_actions is
			-- Call the cancel actions if dialog is closeable.
		do
			if is_dialog_closeable and then internal_default_cancel_button /= Void then
				if internal_default_cancel_button.select_actions /= Void then
					internal_default_cancel_button.select_actions.call ([])
				end
			end
		end

	interface: EV_DIALOG
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'


	is_dialog_closeable: BOOLEAN
			-- Temporary flag whose only use is to enable functions
			-- `is_closeable', `enable_closeable' and `disable_closeable'
			-- to be executed without raising zillions of assertion violations.
			--| FIXME implement cited function, then remove me.

end -- class EV_DIALOG_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.16  2001/06/22 00:50:03  king
--| Now using initialize precursor
--|
--| Revision 1.15  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.7.2.5  2001/02/03 21:26:44  pichery
--| - Implemented `show_relative_to_window'.
--| - Removed precondition to `show_modal_to_window' requiring that
--|   the parent window should be modeless. If it is the case, the parent
--|   is made modeless while Current is displayed as modal.
--|
--| Revision 1.7.2.4  2000/09/18 18:06:42  oconnor
--| reimplemented propogate_[fore|back]ground_color for speeeeed
--|
--| Revision 1.7.2.3  2000/08/16 19:45:52  king
--| Added show_modal_to_window, implemented closeable procs
--|
--| Revision 1.7.2.2  2000/05/09 16:39:02  brendel
--| Added not is_destroyed when disabling modal again.
--|
--| Revision 1.7.2.1  2000/05/03 19:08:47  oconnor
--| mergred from HEAD
--|
--| Revision 1.13  2000/05/03 02:26:27  bonnard
--| Fixed "closable" features so they do not trigger assertion violations.
--| Features still have to be implemented.
--|
--| Revision 1.12  2000/04/29 03:01:35  pichery
--| Added feature `is_closeable', `enable/disable_closeable'.
--| They need to be implemented.
--|
--| Revision 1.11  2000/03/01 00:10:49  brendel
--| Improved imp of show_modal, as it now remembers the value of `is_modal'.
--|
--| Revision 1.10  2000/02/22 21:05:07  bonnard
--| Fixed disfunctionment in `show_modal'. Now modality is supressed when dialog is hidden.
--|
--| Revision 1.9  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.8  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.4.9  2000/02/08 01:00:12  king
--| Moved modality features from dialog to window
--|
--| Revision 1.7.4.8  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.7.4.7  2000/01/27 19:29:42  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.4.6  2000/01/27 01:03:28  brendel
--| Dialogs now can be resized.
--|
--| Revision 1.7.4.5  2000/01/26 22:08:02  brendel
--| Added `blocking_window' and `set_blocking_window'.
--|
--| Revision 1.7.4.4  2000/01/26 18:10:39  brendel
--| Added features `is_modal', `enable_modal' and `disable_modal'.
--|
--| Revision 1.7.4.3  2000/01/26 01:37:48  brendel
--| Started implementing.
--|
--| Revision 1.7.4.2  2000/01/25 18:40:45  oconnor
--| incomplete reorganisation
--|
--| Revision 1.7.4.1  1999/11/24 17:29:53  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
