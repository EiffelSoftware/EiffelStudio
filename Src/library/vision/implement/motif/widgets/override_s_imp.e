indexing

	description: 
		"EiffelVision implementation of Motif override shell.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	OVERRIDE_S_IMP

inherit

	OVERRIDE_S_I;

	POPUP_SHELL_IMP
		undefine
			make_from_existing, mel_destroy, mel_set_insensitive
		end;

	MEL_OVERRIDE_SHELL
		rename
			make as mel_override_make,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		undefine
			popdown, shown
		end

creation

	make

feature {NONE} -- Initialization

	make (an_override_shell: OVERRIDE_S; oui_parent: COMPOSITE) is
			-- Create an override shell.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_override_make (an_override_shell.identifier, mc);
			initialize (Current)
		end;

end -- class OVERRIDE_S_IMP


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

