indexing

	description: 
		"EiffelVision implementation of a MOTIF composite.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 		
	COMPOSITE_IMP

inherit

	WIDGET_IMP
		undefine
			mel_destroy, clean_up, object_clean_up, mel_set_insensitive
		end;

	MEL_COMPOSITE
		rename
            background_color as mel_background_color,
            background_pixmap as mel_background_pixmap,
            set_background_color as mel_set_background_color,
            set_background_pixmap as mel_set_background_pixmap,
            destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen
        end

end -- class COMPOSITE_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

