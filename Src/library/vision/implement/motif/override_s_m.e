indexing

	description: 
		"EiffelVision implementation of Motif override shell.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	OVERRIDE_S_M 

inherit

	OVERRIDE_S_I;

	POPUP_S_M;

    MEL_OVERRIDE_SHELL
        rename
            make as mel_override_make,
            background_color as mel_background_color,
            background_pixmap as mel_background_pixmap,
            set_background_color as mel_set_background_color,
            set_background_pixmap as mel_set_background_pixmap,
            destroy as mel_destroy,
            screen as mel_screen
		undefine
			popdown
		end

creation

	make

feature {NONE} -- Initialization

	make (an_override_shell: OVERRIDE_S) is
			-- Create an override shell.
		do
			widget_index := widget_manager.last_inserted_position;
            mel_override_make (an_override_shell.identifier,
                    mel_parent (an_override_shell, widget_index));
			initialize (Current)
		end;

end -- class OVERRIDE_S_M

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
