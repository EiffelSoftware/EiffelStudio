indexing

	description: 
		"Description of a font.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 

	FONT 

inherit

	G_ANY

creation

	make, 
	make_for_screen

feature {NONE} -- Initialization

	make is
			-- Create a font. 
			-- (By default, font allocated will be for 
			-- the last created screen).
		do
			!FONT_IMP!implementation.make (Current)
		end;

	make_for_screen (a_screen: SCREEN) is
			-- Create a font for `a_screen'.
		require
			valid_screen: a_screen /= Void and then a_screen.is_valid
		do
			!FONT_IMP!implementation.make_for_screen (Current, a_screen)
		end;

feature -- Access

	implementation: FONT_I;
			-- Implementation of font

	font_ascent: INTEGER is
			-- Ascent value in pixel of the font loaded for `a_screen'.
		require
			font_specified: is_specified;
			valid_font: is_font_valid 
		do
			Result := implementation.ascent 
		ensure
			non_negative_result: Result >= 0
		end;

	font_descent: INTEGER is
			-- Descent value in pixel of the font loaded 
		require
			font_specified: is_specified;
			valid_font: is_font_valid 
		do
			Result := implementation.descent 
		ensure
			non_negative_result: Result >= 0
		end;

	width_of_string (a_text: STRING): INTEGER is
			-- Width in pixel of `a_text' in the current font loaded 
		require
			a_text_exists: a_text /= Void;
			font_specified: is_specified;
			valid_font: is_font_valid 
		do
			Result := implementation.width_of_string (a_text)
		ensure
			non_negative_result: Result >= 0
		end;

	average_width: INTEGER is
			-- Width of all characters in the font in tenth of pixel
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.average_width
		ensure
			non_negative_result: average_width >= 0
		end;

	character_set: STRING is
			-- (iso8859-1...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.character_set
		ensure
			result_exists: Result /= Void
		end;

	family: STRING is
			-- Family name (Courier, Helvetica...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.family
		ensure
			result_exists: Result /= Void
		end;

	name: STRING is
			-- Name of the font
		require
			font_specified: is_specified
		do
			Result := implementation.name
		end;

	foundry: STRING is
			-- Foundry name (Adobe...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.foundry
		ensure
			result_exists: Result /= Void
		end;

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font is designed
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.horizontal_resolution
		ensure
			positive_result: Result > 0
		end;

feature -- Status report

	is_font_valid: BOOLEAN is
			-- Is the font valid?
		require
			font_specified: is_specified
		do
			Result := implementation.is_valid 
		end;

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
			positive_result: Result > 0
		end;

	point: INTEGER is
			-- Size of font in tenth of points (1 point = 1/72 of an inch)
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.point
		ensure
			positive_result: Result > 0
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
			positive_result: Result > 0
		end;

	weight: STRING is
			-- Weight of font (Bold, Medium...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.weight
		ensure
			result_exists: Result /= Void
		end;

	width: STRING is
			-- Width of font (Normal, Condensed...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		do
			Result := implementation.width
		ensure
			result_exists: Result /= Void
		end

feature -- Element change

	set_name (a_name: STRING) is
			-- Set `name' to `a_name'.
		require
			a_name_exists: a_name /= Void
		do
			implementation.set_name (a_name)
		ensure
			name_set: is_specified implies a_name.is_equal (a_name)
		end;

feature -- Obsolete features

	is_valid (a_screen: WIDGET): BOOLEAN is
			-- Is the font valid in `a_screen''s display ?
		obsolete
			"Use `is_font_valid' instead."
		require
			font_specified: is_specified
		do
			Result := is_font_valid
		end;

	ascent (a_screen: WIDGET): INTEGER is
			-- Ascent value in pixel of the font loaded for `a_screen'.
		obsolete
			"Use `font_ascent' instead."
		require
			a_screen_exists: a_screen /= Void;
			font_specified: is_specified;
			font_valid_for_a_screen: is_valid (a_screen)
		do
			Result := font_ascent 
		ensure
			non_negative_result: Result >= 0
		end;

	descent (a_screen: WIDGET): INTEGER is
			-- Descent value in pixel of the font loaded for `a_screen'.
		obsolete
			"Use `font_descent' instead."
		require
			a_screen_exists: a_screen /= Void;
			font_specified: is_specified;
			font_valid_for_a_screen: is_valid (a_screen)
		do
			Result := font_descent
		ensure
			non_negative_result: Result >= 0
		end;

	string_width (a_screen: WIDGET; a_text: STRING): INTEGER is
			-- Width in pixel of `a_text' in the current font loaded for `a_screen'.
		obsolete
			"Use `width_of_string' instead."
		require
			a_screen_exists: a_screen /= Void;
			a_text_exists: a_text /= Void;
			font_specified: is_specified;
			font_valid_for_a_screen: is_valid (a_screen)
		do
			Result := width_of_string (a_text)
		ensure
			valid_result: Result >= 0
		end;

invariant

	valid_implementation: implementation /= Void

end -- class FONT



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

