indexing

	description: 
		"EiffelVision implementation of a Motif separator.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SEPARATOR_M

inherit

    SEPARATOR_I;

	PRIMITIVE_M;

    MEL_SEPARATOR
        rename
            make as mel_sep_make,
            foreground_color as mel_foreground_color,
            set_foreground_color as mel_set_foreground_color,
            background_color as mel_background_color,
            background_pixmap as mel_background_pixmap,
            set_background_color as mel_set_background_color,
            set_background_pixmap as mel_set_background_pixmap,
            destroy as mel_destroy,
            screen as mel_screen,
			set_horizontal as mel_set_horizontal
        end

creation

    make

feature {NONE} -- Initialization

    make (a_separator: SEPARATOR; man: BOOLEAN) is
            -- Create a motif separator.
        do
			widget_index := widget_manager.last_inserted_position;
            mel_sep_make (a_separator.identifier,
                    mel_parent (a_separator, widget_index),
                    man);
        end

feature -- Status setting

	set_horizontal (flag: BOOLEAN) is
            -- Set orientation of the scale to horizontal if `flag',
            -- to vertical otherwise.
        do
				mel_set_horizontal (flag)
        end;

end -- class SEPARATOR_M

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
