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
			on_focus_changed
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
		do
			Precursor {EV_GAUGE_IMP} (an_interface)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_vbox_new (False, 0))
			entry_widget := feature {EV_GTK_EXTERNALS}.gtk_spin_button_new (adjustment, 0, 0)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (entry_widget)
			feature {EV_GTK_EXTERNALS}.gtk_box_pack_start (c_object, entry_widget, False, False, 0)
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
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

