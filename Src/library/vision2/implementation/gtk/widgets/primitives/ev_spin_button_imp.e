indexing
	description: "Eiffel Vision spin button. GTK+ Implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SPIN_BUTTON_IMP

inherit
	EV_SPIN_BUTTON_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		undefine
			visual_widget,
			set_composite_widget_pointer_style,
			on_key_event,
			default_key_processing_blocked,
			on_focus_changed,
			needs_event_box
		redefine
			interface,
			initialize,
			make
		end

	EV_TEXT_FIELD_IMP
		rename
			create_change_actions as create_text_change_actions,
			change_actions as text_change_actions,
			change_actions_internal as text_change_actions_internal
		redefine
			make,
			interface,
			initialize
		end

create
	make

feature {NONE} -- Implementation

	make (an_interface: like interface) is
			-- Create the spin button.
		local
			a_vbox: POINTER
		do
			Precursor {EV_GAUGE_IMP} (an_interface)
			a_vbox := {EV_GTK_EXTERNALS}.gtk_vbox_new (False, 0)
			set_c_object (a_vbox)
			entry_widget := {EV_GTK_EXTERNALS}.gtk_spin_button_new (adjustment, 0, 0)
			{EV_GTK_EXTERNALS}.gtk_widget_show (entry_widget)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (a_vbox, entry_widget, False, False, 0)
		end

	initialize is
		do
			Precursor {EV_TEXT_FIELD_IMP}
			ev_gauge_imp_initialize --| {EV_GAUGE} Precursor
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SPIN_BUTTON

end -- class EV_SPIN_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

