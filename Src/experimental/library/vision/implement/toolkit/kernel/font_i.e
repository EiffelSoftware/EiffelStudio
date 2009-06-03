note

	description: "Description of a font"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

	ascent: INTEGER
			-- Ascent value in pixel of the font loaded 
		require
			font_specified: is_specified;
			valid_font: is_valid 
		deferred
		ensure
			non_negative_result: Result >= 0
		end;

	descent: INTEGER
			-- Descent value in pixel of the font loaded for `a_widget'.
		require
			font_specified: is_specified;
			valid_font: is_valid 
		deferred
		ensure
			non_negative_result: Result >= 0
		end;

	width_of_string (a_text: STRING): INTEGER
			-- Width in pixel of `a_text' in the current font loaded for `a_widget'.
		require
			a_text_exists: a_text /= Void;
			font_specified: is_specified;
			valid_font: is_valid 
		deferred
		ensure
			non_negative_result: Result >= 0
		end;

	average_width: INTEGER
			-- Width of all characters in the font in tenth of pixel
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			positive_result: average_width >= 0
		end;

	character_set: STRING
			-- (iso8859-1...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			result_not_void: Result /= Void
		end;

	family: STRING
			-- Family name (Courier, Helvetica...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			result_not_void: Result /= Void
		end;

	foundry: STRING
			-- Foundry name (Adobe...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			result_not_void: Result /= Void
		end;

	horizontal_resolution: INTEGER
			-- Horizontal resolution of screen for which the font is designed
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			positive_result: Result > 0
		end;

	name: STRING
			-- Name of the font
		require
			font_specified: is_specified
		deferred
		ensure
			result_not_void: Result /= Void
		end;

	pixel_size: INTEGER
			-- Size of font in pixel
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			positive_result: Result > 0
		end;

	point: INTEGER
			-- Size of font in tenth of points (1 point = 1/72 of an inch)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			positive_reuslt: Result > 0
		end;

	slant: CHARACTER
			-- Slant of font (o, r, i...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		end;

	vertical_resolution: INTEGER
			-- Vertical resolution of screen for which the font is designed
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			positive_result: Result > 0
		end;

	weight: STRING
			-- Weight of font (Bold, Medium...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			result_not_void: Result /= Void
		end;

	width: STRING
			-- Width of font (Normal, Condensed...)
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Is the font valid?
		require
			font_specified: is_specified
		deferred
		end;

	is_proportional: BOOLEAN
			-- Is the font proportional?
		require
			font_specified: is_specified;
			font_standard: is_standard
		deferred
		end;

	is_specified: BOOLEAN
			-- Is the font specified?
		deferred
		end;

	is_standard: BOOLEAN
			-- Is the font standard and informations available (except for name)?
		require
			font_specified: is_specified
		deferred
		end;

feature -- Element change

	set_name (a_name: STRING)
			-- Set `n_ame' to `a_name'.
		require
			a_name_exists: a_name /= Void
		deferred
		ensure
			is_specified implies a_name.is_equal (a_name)
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class FONT_I

