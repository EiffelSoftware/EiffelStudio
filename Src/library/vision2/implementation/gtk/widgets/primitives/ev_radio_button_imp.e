indexing

        description: 
                "EiffelVision radio button, gtk implementation.";
        status: "See notice at end of class";
        id: "$Id$";
        date: "$Date$";
        revision: "$Revision$"
        
class
        EV_RADIO_BUTTON_IMP
        
inherit
        EV_RADIO_BUTTON_I
	
	EV_CHECK_BUTTON_IMP
		export {NONE}
			box,
			initialize,
			create_text_label
		redefine
			make,
			make_with_text,
			set_parent
		end
        
creation
	make,
	make_with_text

feature {NONE} -- Initialization

        make is
                        -- Create a gtk push button.
		do
			widget := gtk_radio_button_new_with_label (default_pointer, default_pointer)
   			gtk_object_ref (widget)
                end

        make_with_text (txt: STRING) is
                        -- Create a gtk push button.
                local
                        a: ANY
		do
			a := txt.to_c
			widget := gtk_radio_button_new_with_label (default_pointer, $a)
   			gtk_object_ref (widget)
		end

	set_parent (par: EV_CONTAINER) is
			-- We need to set the group pf the
			-- radio button.
		do
			{EV_CHECK_BUTTON_IMP} Precursor (par)
			gtk_radio_button_set_group (widget, parent_imp.radio_button_group)
			parent_imp.set_rbg_pointer (gtk_radio_button_group (Current.widget))
		end
	
end -- class EV_RADIO_BUTTON_IMP

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
