indexing

	description: "Description of a font";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	FONT_I 

inherit

	G_ANY_I
		export
			{NONE} all
		end
	
feature -- Acces

	ascent: INTEGER is
			-- Ascent value in pixel of the font loaded 
		require
			font_specified: is_specified;
			valid_font: is_valid 
		deferred
		ensure
			non_negative_result: Result >= 0
		end;

	descent: INTEGER is
			-- Descent value in pixel of the font loaded for `a_widget'.
		require
			font_specified: is_specified;
			valid_font: is_valid 
		deferred
		ensure
			non_negative_result: Result >= 0
		end;

	width_of_string (a_text: STRING): INTEGER is
			-- Width in pixel of `a_text' in the current font loaded for `a_widget'.
		require
			a_text_exists: a_text /= Void;
			font_specified: is_specified;
			valid_font: is_valid 
		deferred
		ensure
			non_negative_result: Result >= 0
		end;

	average_width: INTEGER is
			-- Width of all characters in the font in tenth of pixel
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			positive_result: average_width >= 0
		end;

	character_set: STRING is
			-- (iso8859-1...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			result_not_void: Result /= Void
		end;

	family: STRING is
			-- Family name (Courier, Helvetica...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			result_not_void: Result /= Void
		end;

	foundry: STRING is
			-- Foundry name (Adobe...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			result_not_void: Result /= Void
		end;

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font is designed
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			positive_result: Result > 0
		end;

	name: STRING is
			-- Name of the font
		require
			font_specified: is_specified
		deferred
		ensure
			result_not_void: Result /= Void
		end;

	pixel_size: INTEGER is
			-- Size of font in pixel
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			positive_result: Result > 0
		end;

	point: INTEGER is
			-- Size of font in tenth of points (1 point = 1/72 of an inch)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			positive_reuslt: Result > 0
		end;

	slant: CHARACTER is
			-- Slant of font (o, r, i...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		end;

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font is designed
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			positive_result: Result > 0
		end;

	weight: STRING is
			-- Weight of font (Bold, Medium...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			result_not_void: Result /= Void
		end;

	width: STRING is
			-- Width of font (Normal, Condensed...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_valid: BOOLEAN is
			-- Is the font valid?
		require
			font_specified: is_specified
		deferred
		end;

	is_proportional: BOOLEAN is
			-- Is the font proportional?
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		end;

	is_specified: BOOLEAN is
			-- Is the font specified?
		deferred
		end;

	is_standard: BOOLEAN is
			-- Is the font standard and informations available (except for name)?
		require
			font_specified: is_specified
		deferred
		end;

feature -- Element change

	set_name (a_name: STRING) is
			-- Set `n_ame' to `a_name'.
		require
			a_name_exists: a_name /= Void
		deferred
		ensure
			is_specified implies a_name.is_equal (a_name)
		end;

end -- class FONT_I



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

