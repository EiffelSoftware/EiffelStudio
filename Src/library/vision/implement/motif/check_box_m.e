indexing

	description: 	
		"EiffelVision implementation of a Motif check box.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	CHECK_BOX_M 

inherit

	CHECK_BOX_I;

	MANAGER_M
		rename
			is_shown as shown
		undefine
			create_callback_struct
		end;

	MEL_CHECK_BOX
		rename
			make as mel_check_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		end


creation

	make

feature {NONE} -- Initialization

	make (a_check_box: CHECK_BOX; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif check_box.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_check_make (a_check_box.identifier, mc, man)
		end

end -- class CHECK_BOX_M

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
