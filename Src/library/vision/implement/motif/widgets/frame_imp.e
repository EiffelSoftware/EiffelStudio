indexing

	description: 
		"EiffelVision implementation of a Motif frame widget.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	FRAME_IMP

inherit

	FRAME_I;

	MANAGER_IMP
		rename
			is_shown as shown
		undefine
			is_frame
		end;

	MEL_FRAME
		rename
			make as mel_frame_make,
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

create

	make

feature {NONE} -- Initialization

	make (a_frame: FRAME; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif frame.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_frame_make (a_frame.identifier, mc, man);
		end

end -- class FRAME

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

