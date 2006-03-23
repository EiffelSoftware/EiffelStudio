indexing
	description: "Eiffel Vision spin button. GTK+ Implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SPIN_BUTTON_IMP

inherit
	EV_SPIN_BUTTON_I
		undefine
			hide_border
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
			initialize,
			set_text
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

feature {NONE} -- Implementation

	set_text (a_text: STRING_GENERAL) is
			-- Assign `a_text' to `text'.
		do
			Precursor {EV_TEXT_FIELD_IMP} (a_text)
				-- Make sure the spin button updates the internal value
			{EV_GTK_EXTERNALS}.gtk_spin_button_update (entry_widget)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SPIN_BUTTON;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_SPIN_BUTTON_IMP

