indexing
	description: "Eiffel Vision radio button. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
		
class
	EV_RADIO_BUTTON_IMP

inherit
	EV_RADIO_BUTTON_I
		redefine
			interface
		end
	
	EV_BUTTON_IMP
		export
			{NONE}
				c_object
			{EV_CONTAINER_IMP}
				visual_widget
		undefine
			default_alignment
		redefine
			interface,
			make,
			initialize,
			visual_widget
		end

	EV_RADIO_PEER_IMP
		redefine
			interface, widget_object, visual_widget
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create radio button.
		do
			base_make (an_interface)
			visual_widget := feature {EV_GTK_EXTERNALS}.gtk_radio_button_new (NULL)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_event_box_new)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (visual_widget)
			feature {EV_GTK_EXTERNALS}.gtk_container_add (c_object, visual_widget)
			enable_select
		end

	initialize is
		do
			Precursor
			align_text_left
		end

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is toggle button pressed?
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_toggle_button_get_active (visual_widget)
		end 
	
feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		do
			if not is_selected then
				feature {EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (visual_widget, True)	
			end
		end

feature {EV_ANY_I} -- Implementation

	widget_object (a_list: POINTER): POINTER is
			-- Returns c_object relative to a_list data.
		do
			Result := feature {EV_GTK_EXTERNALS}.gslist_struct_data (a_list)
			Result := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (Result)
		end

	radio_group: POINTER is
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_radio_button_group (visual_widget)
		end
		
	visual_widget: POINTER
			-- Pointer to the gtk widget shown on screen.

feature {EV_ANY_I} -- Implementation

	interface: EV_RADIO_BUTTON

end -- class EV_RADIO_BUTTON_IMP

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

