indexing
	description: "EiffelVision font, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FONT_I 

inherit
	EV_ANY_I

feature -- Access

	name: STRING is
			-- Name of the font
		require
			exists: not destroyed
		deferred
		end

	ascent: INTEGER is
			-- Ascent value in pixel of the font loaded.
		require
			exists: not destroyed 
		deferred
		ensure
			positive_result: Result >= 0
		end

	descent: INTEGER is
			-- Descent value in pixel of the font loaded.
		require
			exists: not destroyed 
		deferred
		ensure
			positive_result: Result >= 0
		end

feature -- Measurement

	height: INTEGER is
			-- Height of the font
		require
			exists: not destroyed
			font_standard: is_standard
		deferred
		ensure
			positive_result: Result >= 0
		end

	width: INTEGER is
			-- Average width of the current font
		require
			exists: not destroyed
			font_standard: is_standard
		deferred
		ensure
			positive_result: Result >= 0
		end

	maximum_width: INTEGER is
			-- Width of the widest character in the font
		require
			exists: not destroyed
			font_standard: is_standard
		deferred
		ensure
			positive_result: Result >= 0
		end
		
	string_width (str: STRING): INTEGER is
			-- Width in pixel of `str' in the current font.
		require
			exists: not destroyed
			valid_text: str /= Void
		deferred
		ensure
			positive_result: Result >= 0
		end

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font
			-- is designed
		require
			exists: not destroyed
			font_standard: is_standard
		deferred
		ensure
			positive_result: Result > 0
		end

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font
			-- is designed
		require
			exists: not destroyed
			font_standard: is_standard
		deferred
		ensure
			positive_result: Result > 0
		end

feature -- Status report

	is_proportional: BOOLEAN is
			-- Is the font proportional ?
		require
			exists: not destroyed
			font_standard: is_standard
		deferred
		end

 	is_standard: BOOLEAN is
 			-- Is the font standard and informations available (except for name) ?
 		require
			exists: not destroyed
 		deferred
 		end
 
	weight: STRING is
			-- Weight of font (Bold, Medium...)
		require
			exists: not destroyed
			font_standard: is_standard
		deferred
		ensure
			result_exists: Result /= Void
		end

feature -- Element change

	set_name (str: STRING) is
			-- Make `str' the new name of the string.
		require
			exists: not destroyed
			valid_name: str /= Void
		deferred
		end

	set_width (value: INTEGER) is
			-- Make `value' the new width.
		require
			exists: not destroyed
			valid_value: value >= 0
		deferred
		end

	set_height (value: INTEGER) is
			-- Make `value' the new height.
		require
			exists: not destroyed
			valid_value: value >= 0
		deferred
		end

	set_weight (value: INTEGER) is
			-- Make `str' the new weight.
		require
			exists: not destroyed
			valid_value: value >= 0
		deferred
		end

end -- class EV_FONT_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
