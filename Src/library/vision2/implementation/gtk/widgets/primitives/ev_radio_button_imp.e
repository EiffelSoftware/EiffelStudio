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
			initialize
		end

	EV_RADIO_PEER_IMP
		redefine
			interface,
			widget_object
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create radio button.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_radio_button_new (NULL))
			enable_select
		end

	initialize is
			-- Initialize `Current'
		do
			Precursor
			align_text_left
		end

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is toggle button pressed?
		do
			Result := {EV_GTK_EXTERNALS}.gtk_toggle_button_get_active (visual_widget)
		end 
	
feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		do
			if not is_selected then
				{EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (visual_widget, True)	
			end
		end

feature {EV_ANY_I} -- Implementation

	widget_object (a_list: POINTER): POINTER is
			-- Returns c_object relative to a_list data.
		do
			Result := {EV_GTK_EXTERNALS}.gslist_struct_data (a_list)
			Result := {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (Result)
		end

	radio_group: POINTER is
		do
			Result := {EV_GTK_EXTERNALS}.gtk_radio_button_group (visual_widget)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_RADIO_BUTTON

end -- class EV_RADIO_BUTTON_IMP

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

