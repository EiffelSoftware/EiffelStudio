indexing

	description: "Description of a font";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_FONT_IMP 

inherit
 	EV_FONT_I

creation
	make,
	make_by_name

feature {NONE} -- Initialization

 	make (ft: EV_FONT) is
 			-- Create a font.
 		do
			check
                                not_yet_implemented: False
                        end
 		end

	make_by_name (ft: EV_FONT; str: STRING) is
			-- Create the font corresponding to the given name.
			-- The font is directly readed on a file.
		do
			check
                                not_yet_implemented: False
                        end
		end

feature -- Access

	name: STRING is
			-- Name of the font
		do
		end

	ascent: INTEGER is
			-- Ascent value in pixel of the font loaded.
		do
		end

	descent: INTEGER is
			-- Descent value in pixel of the font loaded.
		do
		end

feature -- Measurement

	height: INTEGER is
			-- Height of the font
		do
		end

	width: INTEGER is
			-- Average width of the current font
		do
		end

	maximum_width: INTEGER is
			-- Width of the widest character in the font
		do
		end
		
	string_width (str: STRING): INTEGER is
			-- Width in pixel of `str' in the current font.
		do
		end

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font
			-- is designed
		do
		end

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font
			-- is designed
		do
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?
		do
		end

	is_proportional: BOOLEAN is
			-- Is the font proportional ?
		do
		end

 	is_standard: BOOLEAN is
 			-- Is the font standard and informations available (except for name) ?
 		do
 		end
 
	weight: STRING is
			-- Weight of font (Bold, Medium...)
		do
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
		end

feature -- Element change

	set_name (str: STRING) is
			-- Make `str' the new name of the string.
		do
		end

	set_width (value: INTEGER) is
			-- Make `value' the new width.
		do
		end

	set_height (value: INTEGER) is
			-- Make `value' the new height.
		do
		end

	set_weight (value: INTEGER) is
			-- Make `str' the new weight.
		do
		end

end -- class EV_FONT_IMP

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

