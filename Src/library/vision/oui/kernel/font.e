
-- Description of a font.

indexing

	date: "$Date$";
	revision: "$Revision$"

class FONT 

inherit

	G_ANY
		export
			{NONE} all;
			{FONT_LIST_I, FONT_LIST} is_equal
		end

creation

	make

feature 

	ascent (a_screen: WIDGET): INTEGER is
			-- Ascent value in pixel of the font loaded for `a_screen'.
		require
			a_screen_exists: not (a_screen = Void);
			font_specified: is_specified;
			font_valid_for_a_screen: is_valid (a_screen)
		do
			Result := implementation.ascent (a_screen.implementation)
		ensure
			Result >= 0
		end;

	descent (a_screen: WIDGET): INTEGER is
            -- Descent value in pixel of the font loaded for `a_screen'.
		require
			a_screen_exists: not (a_screen = Void);
            font_specified: is_specified;
            font_valid_for_a_screen: is_valid (a_screen)
        do
            Result := implementation.descent (a_screen.implementation)
		ensure
			Result >= 0
        end;

	string_width (a_screen: WIDGET; a_text: STRING): INTEGER is
			-- Width in pixel of `a_text' in the current font loaded for `a_screen'.
		require
			a_screen_exists: not (a_screen = Void);
			a_text_exists: not (a_text = Void);
            font_specified: is_specified;
            font_valid_for_a_screen: is_valid (a_screen)
		do
			Result := implementation.string_width (a_screen.implementation, a_text)
		ensure
			valid_result: Result >= 0
		end;

	average_width: INTEGER is
			-- Width of all characters in the font in tenth of pixel
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.average_width
		ensure
			average_width >= 0
		end;

	character_set: STRING is
			-- (iso8859-1...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.character_set
		ensure
			not (Result = Void)
		end;

	make is
			-- Create a font.
		do
			implementation := toolkit.font (Current)
		ensure
			not (implementation = Void)
		end;

	family: STRING is
			-- Family name (Courier, Helvetica...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.family
		ensure
			not (Result = Void)
		end;

	name: STRING is
			-- Name of the font
		require
			font_specified: is_specified
		do
			Result := implementation.name
		ensure
			valid_result: Result /= Void
		end;

	n_ame: STRING is obsolete "Use ``name''"
			-- Name of the font
		do
			Result := name
		end;

	foundry: STRING is
			-- Foundry name (Adobe...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.foundry
		ensure
			not (Result = Void)
		end;

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font is designed
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.horizontal_resolution
		ensure
			Result > 0
		end;

	implementation: FONT_I;
			-- Implementation of font

	is_proportional: BOOLEAN is
			-- Is the font proportional ?
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.is_proportional
		end;

	is_standard: BOOLEAN is
			-- Is the font standard and informations available (except for name) ?
		require
			font_specified: is_specified
		do
			Result := implementation.is_standard
		end;

	is_valid (a_screen: WIDGET): BOOLEAN is
			-- Is the font valid in `a_screen''s display ?
		require
			font_specified: is_specified
		do
			Result := implementation.is_valid (a_screen.implementation)
		end;

	is_specified: BOOLEAN is
			-- Is the font specified ?
		do
			Result := implementation.is_specified
		end;

	pixel_size: INTEGER is
			-- Size of font in pixel
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.pixel_size
		ensure
			Result > 0
		end;

	point: INTEGER is
			-- Size of font in tenth of points (1 point = 1/72 of an inch)
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.point
		ensure
			Result > 0
		end;

	set_name (a_name: STRING) is
			-- Set `name' to `a_name'.
		require
			a_name_exists: not (a_name = Void)
		do
			implementation.set_name (a_name)
		ensure
			is_specified implies a_name.is_equal (a_name)
		end;

	slant: CHARACTER is
			-- Slant of font (o, r, i...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.slant
		end;

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font is designed
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.vertical_resolution
		ensure
			Result > 0
		end;

	weight: STRING is
			-- Weight of font (Bold, Medium...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.weight
		ensure
			not (Result = Void)
		end;

	width: STRING is
			-- Width of font (Normal, Condensed...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.width
		ensure
			not (Result = Void)
		end

invariant

	valid_implementation: implementation /= Void

end


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
