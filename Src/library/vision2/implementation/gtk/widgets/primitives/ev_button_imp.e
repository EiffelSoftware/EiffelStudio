indexing
        description: 
                "EiffelVision push button, gtk implementation.";
        status: "See notice at end of class";
        id: "$Id$";
        date: "$Date$";
        revision: "$Revision$"
        
class
        EV_BUTTON_IMP
        
inherit
        EV_BUTTON_I
        
	EV_PRIMITIVE_IMP
	
	EV_BAR_ITEM_IMP
        
	EV_TEXTABLE_IMP

	EV_PIXMAPABLE_IMP
		undefine
			pixmap_size_ok
		end
        
	EV_GTK_BUTTONS_EXTERNALS

creation
        make,
	make_with_text

feature {NONE} -- Initialization
	
	make is
		do
			-- Create the gtk object.
			widget := gtk_button_new
			gtk_object_ref (widget)

			-- Create the `box'.
			initialize

			-- Create a gtk label with a text set to ""
			create_text_label ("")

			-- We center-align and vertical_center-position the text.
			gtk_misc_set_alignment (gtk_misc (label_widget), 0.5, 0.5)
		end	
		
feature -- Event - command association
	
	add_click_command (com: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'com' to the list of commands to be
			-- executed when the button is pressed
		do
			add_command (widget, "clicked", com, arg)
		end
	
feature -- Event -- removing command association

	remove_click_commands is	
			-- Empty the list of commands to be executed when
			-- the button is pressed.
		do
			remove_commands (widget, clicked_id)
		end
	
end -- class EV_BUTTON_IMP

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
