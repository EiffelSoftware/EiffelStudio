indexing

	description: "Description of a font";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class FONT_I 

inherit

	G_ANY_I
		export
			{NONE} all
		end
	
feature 

	ascent (a_widget: WIDGET_I): INTEGER is
			-- Ascent value in pixel of the font loaded for `a_widget'.
		require
			a_widget_exists: not (a_widget = Void);
			font_specified: is_specified;
			font_valid_for_a_widget: is_valid (a_widget)
		deferred
		ensure
			Result >= 0
		end; -- ascent

	average_width: INTEGER is
			-- Width of all characters in the font in tenth of pixel
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			average_width >= 0
		end; -- average_width

	character_set: STRING is
			-- (iso8859-1...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			not (Result = Void)
		end; -- character_set

	descent (a_widget: WIDGET_I): INTEGER is
			-- Descent value in pixel of the font loaded for `a_widget'.
		require
			a_widget_exists: not (a_widget = Void);
			font_specified: is_specified;
			font_valid_for_a_widget: is_valid (a_widget)
		deferred
		ensure
			Result >= 0
		end; -- descent

	family: STRING is
			-- Family name (Courier, Helvetica...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			not (Result = Void)
		end; -- family

	foundry: STRING is
			-- Foundry name (Adobe...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			not (Result = Void)
		end; -- foundry

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font is designed
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			Result > 0
		end; -- horizontal_resolution

	is_proportional: BOOLEAN is
			-- Is the font proportional ?
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		end; -- is_proportional

	is_specified: BOOLEAN is
			-- Is the font specified ?
		deferred
		end; -- is_specified

	is_standard: BOOLEAN is
			-- Is the font standard and informations available (except for name) ?
		require
			font_specified: is_specified
		deferred
		end; -- is_standard

	is_valid (a_widget: WIDGET_I): BOOLEAN is
			-- Is the font valid in `a_widget''s display ?
		require
			font_specified: is_specified
		deferred
		end; -- is_valid

	name: STRING is
			-- Name of the font
		require
			font_specified: is_specified
		deferred
		ensure
			not (Result = Void)
		end; -- n_ame

	n_ame: STRING is  obsolete "Use ``name''"
			-- Name of the font
		do
			Result := name
		end; -- n_ame

	pixel_size: INTEGER is
			-- Size of font in pixel
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			Result > 0
		end; -- pixel_size

	point: INTEGER is
			-- Size of font in tenth of points (1 point = 1/72 of an inch)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			Result > 0
		end; -- point

	set_name (a_name: STRING) is
			-- Set `n_ame' to `a_name'.
		require
			a_name_exists: not (a_name = Void)
		deferred
		ensure
			is_specified implies a_name.is_equal (a_name)
		end; -- set_name

	slant: CHARACTER is
			-- Slant of font (o, r, i...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		end; -- slant

	string_width (a_widget: WIDGET_I; a_text: STRING): INTEGER is
			-- Width in pixel of `a_text' in the current font loaded for `a_widget'.
		require
			a_widget_exists: not (a_widget = Void);
			a_text_exists: not (a_text = Void);
			font_specified: is_specified;
			font_valid_for_a_widget: is_valid (a_widget)
		deferred
		ensure
			Result >= 0
		end; -- string_width

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font is designed
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			Result > 0
		end; -- vertical_resolution

	weight: STRING is
			-- Weight of font (Bold, Medium...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			not (Result = Void)
		end; -- weight

	width: STRING is
			-- Width of font (Normal, Condensed...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			not (Result = Void)
		end -- width

end -- class FONT_I


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
