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
		undefine
			set_foreground_color,
			set_background_color
		end
	
	EV_BAR_ITEM_IMP
        
	EV_TEXTABLE_IMP
		redefine
			set_text
		end

	EV_PIXMAPABLE_IMP
		undefine
			pixmap_size_ok
		redefine
			set_foreground_color,
			set_background_color,
			create_pixmap_place
		end
        
	EV_GTK_BUTTONS_EXTERNALS

create
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
		end	
		
	create_pixmap_place (pix_imp: EV_PIXMAP_IMP) is
			-- prepare the place for the pixmap in the `box'.
			-- For that, we add a pixmap with a default gdk pixmap
			-- in the `box'.
			-- Redefined because, we want the pixmap to be in the middle of the button.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			-- create the pixmap with a default xpm.
			-- We use the pixmap's `create_window' to create the new pixmap
			-- as we need a GdkWindow.
			pixmap_widget := c_gtk_pixmap_create_empty (pix_imp.create_window)

			-- Set the pixmap in the `box'.
			gtk_box_pack_start (GTK_BOX (box), pixmap_widget, True, True, 0)

			-- show the pixmap now that it has a parent.
			gtk_widget_show (pixmap_widget)

			-- If there is a text,
			If label_widget /= default_pointer then
				-- We right-align and vertical_center-position the pixmap.
				gtk_misc_set_alignment (gtk_misc (pixmap_widget), 1.0, 0.5)

				-- We left-align and vertical_center-position the text
				gtk_misc_set_alignment (gtk_misc (label_widget), 0.0, 0.5)
			end
		end					

feature -- Element change

	set_text (txt: STRING) is
			-- Set current button text to `txt'.
			-- Redefined because we want the text to be:
			-- 	- middle-aligned if there is no pixmap
			-- 	- left-aligned if there is a pixmap
		do
			{EV_TEXTABLE_IMP} Precursor (txt)

			-- Is there a pixmap?
			if pixmap_widget /= default_pointer then
				-- Yes, there is a pixmap:
				-- We right-align and vertical_center-position the pixmap.
				gtk_misc_set_alignment (gtk_misc (pixmap_widget), 1.0, 0.5)
				-- We left-align and vertical_center-position the text
				gtk_misc_set_alignment (gtk_misc (label_widget), 0.0, 0.5)
			else
				-- No, there is no pixmap:
				-- We center and vertical_center-position the text
				gtk_misc_set_alignment (gtk_misc (label_widget), 0.5, 0.5)
			end				
		end
	
	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'.
			-- Redefined because the text is in a gtk_label.
		do
			{EV_PIXMAPABLE_IMP} Precursor (color)

			if box /= default_pointer then
				c_gtk_widget_set_fg_color (box, color.red, color.green, color.blue)
			end
		end

	set_background_color (color: EV_COLOR) is
			-- Assign `color' as new `foreground_color'.
			-- Redefined because the text is in a gtk_label.
		do
			{EV_PIXMAPABLE_IMP} Precursor (color)

			if box /= default_pointer then
				c_gtk_widget_set_bg_color (box, color.red, color.green, color.blue)
			end
		end

feature -- Event - command association
	
	add_click_command (com: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'com' to the list of commands to be
			-- executed when the button is pressed
		do
			add_command (widget, "clicked", com, arg, default_pointer)
		end
	
feature -- Event -- removing command association

	remove_click_commands is	
			-- Empty the list of commands to be executed when
			-- the button is pressed.
		do
			remove_commands (widget, clicked_id)
		end
	
end -- class EV_BUTTON_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------
