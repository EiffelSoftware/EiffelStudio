indexing

        description: 
                "EiffelVision check button, gtk implementation.";
        status: "See notice at end of class";
        id: "$Id$";
        date: "$Date$";
        revision: "$Revision$"
        
class
        EV_CHECK_BUTTON_IMP
        
inherit
        EV_CHECK_BUTTON_I
	
	EV_TOGGLE_BUTTON_IMP
		redefine
			make,
			create_pixmap_place
		end
        
creation
	make,
	make_with_text

feature {NONE} -- Initialization

        make is
                        -- Create a gtk check button.
		do
 			-- Create the gtk object.
			widget := gtk_check_button_new
			gtk_object_ref (widget)

			-- Create the `box'.
			initialize

			-- Create the label with a text set to "".
			create_text_label ("")
                end

	create_pixmap_place is
			-- prepare the place for the pixmap in the `box'.
			-- For that, we add a pixmap with a default gdk pixmap
			-- in the `box'.
			-- Redefined because we want the pixmap to be on the left.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			-- create the pixmap with a default xpm.
			pixmap_widget := c_gtk_pixmap_create_empty (box)

			-- Set the pixmap in the `box'.
			gtk_box_pack_start (GTK_BOX (box), pixmap_widget, False, False, 0)

			-- show the pixmap now that it has a parent.
			gtk_widget_show (pixmap_widget)
		end					

end -- class EV_CHECK_BUTTON_IMP

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
