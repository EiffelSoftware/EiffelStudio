indexing
	description: "Eiffel Vision font.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	EV_FONT 

inherit
	EV_ANY
		redefine
			implementation
		end

creation
	make,
	make_by_name,
	make_by_system_name

feature {NONE} -- Initialization

	make is
			-- Create a font. 
			-- (By default, font allocated will be for 
			-- the last created screen).
		do
			!EV_FONT_IMP! implementation.make
			implementation.set_interface (Current)
		end

	make_by_name (str: STRING) is
			-- Create the font corresponding to the given name
			-- with the default values.
		do
			!EV_FONT_IMP! implementation.make_by_name (str)
			implementation.set_interface (Current)
		end

	make_by_system_name (str: STRING) is
			-- Create the font corresponding to the given system
			-- name.
		do
			!EV_FONT_IMP! implementation.make_by_system_name (str)
			implementation.set_interface (Current)
		end

feature -- Access

	name: STRING is
			-- Name of the font
		require
			exists: not destroyed
		do
			Result := implementation.name
		end

	ascent: INTEGER is
			-- Ascent value in pixel of the font loaded.
		require
			exists: not destroyed 
		do
			Result := implementation.ascent 
		ensure
			positive_result: Result >= 0
		end

	descent: INTEGER is
			-- Descent value in pixel of the font loaded.
		require
			exists: not destroyed 
		do
			Result := implementation.descent 
		ensure
			positive_result: Result >= 0
		end

feature -- Measurement

	height: INTEGER is
			-- Height of the font
		require
			exists: not destroyed
			font_standard: is_standard
		do
			Result := implementation.height
		ensure
			positive_result: Result >= 0
		end

	width: INTEGER is
			-- Average width of the current font
		require
			exists: not destroyed
			font_standard: is_standard
		do
			Result := implementation.width
		ensure
			positive_result: Result >= 0
		end

	maximum_width: INTEGER is
			-- Width of the widest character in the font
		require
			exists: not destroyed
			font_standard: is_standard
		do
			Result := implementation.maximum_width
		ensure
			positive_result: Result >= 0
		end
		
	string_width (str: STRING): INTEGER is
			-- Width in pixel of `str' in the current font.
		require
			exists: not destroyed
			valid_text: str /= Void
		do
			Result := implementation.string_width (str)
		ensure
			positive_result: Result >= 0
		end

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font
			-- is designed
		require
			exists: not destroyed
			font_standard: is_standard
		do
			Result := implementation.horizontal_resolution
		ensure
			positive_result: Result > 0
		end

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font
			-- is designed
		require
			exists: not destroyed
			font_standard: is_standard
		do
			Result := implementation.vertical_resolution
		ensure
			positive_result: Result > 0
		end

feature -- Status report

	is_proportional: BOOLEAN is
			-- Is the font proportional ?
		require
			exists: not destroyed
			font_standard: is_standard
		do
			Result := implementation.is_proportional
		end

 	is_standard: BOOLEAN is
 			-- Is the font standard and informations available (except for name) ?
 		require
			exists: not destroyed
 		do
 			Result := implementation.is_standard
 		end
 
	weight: STRING is
			-- Weight of font (Bold, Medium...)
		require
			exists: not destroyed
			font_standard: is_standard
		do
			Result := implementation.weight
		ensure
			result_exists: Result /= Void
		end

feature -- Element change

	set_name (str: STRING) is
			-- Make `str' the new name of the string.
		require
			exists: not destroyed
			valid_name: str /= Void
		do
			implementation.set_name (str)
		end

	set_width (value: INTEGER) is
			-- Make `value' the new width.
		require
			exists: not destroyed
			valid_value: value >= 0
		do
			implementation.set_width (value)
		end

	set_height (value: INTEGER) is
			-- Make `value' the new height.
		require
			exists: not destroyed
			valid_value: value >= 0
		do
			implementation.set_height (value)
		end

	set_weight (value: INTEGER) is
			-- Make `value' the new weight.
		require
			exists: not destroyed
			valid_value: value >= 0
		do
			implementation.set_weight (value)
		end

feature -- Implementation

	implementation: EV_FONT_I
			-- Implementation of font

	set_implementation (value: EV_FONT_IMP) is
			-- Make `value' the new implementation.
			-- Needed by windows.
		do
			implementation := value
		end

end -- class EV_FONT

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

