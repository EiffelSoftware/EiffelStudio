indexing
	description:
		" Objects that represent the name of a font%
		% on gtk"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_NAME_IMP

create
	make_empty,
	make_default,
	make_with_name,
	make_with_system_name

feature -- Initialization

	make_empty is
			-- Create the object with empty attributes.
		do
		end

	make_default is
			-- Create the default font.
		do
			foundry := "*"
			family := "helvetica"
			weight := "Medium"
			slant := "R"
			setwidth := "*"
			add_style := "*"
			pixel_size := "*"
			point_size := "120"
			resolution_x := "*"
			resolution_y := "*"
			spacing := "*"
			average_width := "*"
			charset := "*"
		end

	make_with_name (str: STRING) is
			-- Create the default font with name
		do
			foundry := "*"
			family := str
			weight := "Medium"
			slant := "R"
			setwidth := "*"
			add_style := "*"
			pixel_size := "*"
			point_size := "140"
			resolution_x := "*"
			resolution_y := "*"
			spacing := "*"
			average_width := "*"
			charset := "*"
		end

	make_with_system_name (str: STRING) is
			-- Create the object with empty attributes.
		do	
			parse_name (str)
		end

feature -- Access

	foundry: STRING
		-- Foundry that made the font

	family: STRING
		-- Family name of the font

	weight: STRING
		-- Weight of the font (normal, medium, bold...)
		-- Must be `*` for any value.

	slant: STRING
		-- Slant of the font
		-- Must be `*` for any value.

	setwidth: STRING
		-- Has an integer value.
		-- Can be `*` for any value.

	add_style: STRING
		-- Has an integer value.
		-- Can be `*` for any value.

	pixel_size: STRING
		-- Size in pixel of the font
		-- Has an integer value.
		-- Can be `*` for any value.

	point_size: STRING
		-- Size in points of the font
		-- Has an integer value.
		-- Must be specified

	resolution_x: STRING
		-- Horizontal resolution of the font
		-- Has an integer value.
		-- Can be `*` for any value.

	resolution_y: STRING
		-- Vertical resolution of the font
		-- Has an integer value.
		-- Can be `*` for any value.

	spacing: STRING
		-- Spacing in the font
		-- Can be `*` for any value.

	average_width: STRING
		-- average_width of a character in the font
		-- Has an integer value.
		-- Can be `*` for any value.

	charset: STRING
		-- Current charset of the font
		-- Can be `*` for any value.

feature -- Element change

	set_foundry (str: STRING) is
		-- Make 'str' the new foundry.
		do
			foundry := str
		end

	set_family (str: STRING) is
			-- Make 'str' the new family.
		do
			family := str
		end

	set_weight (str: STRING) is
			-- Make 'str' the new weight.
		do
			weight := str
		end

	set_slant (str: STRING) is
			-- Make 'str' the new slant.
		do
			slant := str
		end

	set_setwidth (str: STRING) is
			-- Make 'str' the new width.
		do
			setwidth:= str
		end

	set_add_style (str: STRING) is
			-- Make 'str' the new style.
		do
			add_style := str
		end

	set_pixel_size (str: STRING) is
			-- Make 'str' the new pixel_size.
		do
			pixel_size := str
		end

	set_point_size (str: STRING) is
			-- Make 'str' the new point_size.
		do
			point_size := str
		end

	set_resolution_x (str: STRING) is
			-- Make 'str' the new resolution_x.
		do
			resolution_x := str
		end

	set_resolution_y (str: STRING) is
			-- Make 'str' the new resolution_y.
		do
			resolution_y := str
		end

	set_spacing (str: STRING) is
			-- Make 'str' the new spacing.
		do
			spacing := str
		end

	set_average_width (str: STRING) is
			-- Make 'str' the new width.
		do
			average_width := str
		end

	set_charset (str: STRING) is
			-- Make 'str' the new charset.
		do
			charset := str
		end

feature -- Basic operations

	basic_name: STRING is
			-- A basic name with the minimum of information to
			-- retrieve a font.
		do
			Result := "-"
			Result.append (foundry)
			Result.append ("-")
			Result.append (family)
			Result.append ("-")
			Result.append (weight)
			Result.append ("-")
			Result.append (slant)
			Result.append ("-")
			Result.append ("*")
			Result.append ("-")
			Result.append ("*")
			Result.append ("-")
			Result.append ("*")
			Result.append ("-")
			Result.append (point_size)
			Result.append ("-")
			Result.append ("*")
			Result.append ("-")
			Result.append ("*")
			Result.append ("-")
			Result.append ("*")
			Result.append ("-")
			Result.append ("*")
			Result.append ("-")
			Result.append ("*")
		end

	system_name: STRING is
			-- Return the system name of the font.
		do
			Result := "-"
			Result.append (foundry)
			Result.append ("-")
			Result.append (family)
			Result.append ("-")
			Result.append (weight)
			Result.append ("-")
			Result.append (slant)
			Result.append ("-")
			Result.append (setwidth)
			Result.append ("-")
			Result.append (add_style)
			Result.append ("-")
			Result.append (pixel_size)
			Result.append ("-")
			Result.append (point_size)
			Result.append ("-")
			Result.append (resolution_x)
			Result.append ("-")
			Result.append (resolution_y)
			Result.append ("-")
			Result.append (spacing)
			Result.append ("-")
			Result.append (average_width)
			Result.append ("-")
			Result.append (charset)
		end

	parse_name (str: STRING) is
			-- Fill the parameters according to the given system name.
		local
			pos, pos_end: INTEGER
		do
			pos := 2
			pos_end := str.index_of ('-', pos)
			foundry := str.substring (pos, pos_end - 1)

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			family := str.substring (pos, pos_end - 1)

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			weight := str.substring (pos, pos_end - 1)

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			slant := str.substring (pos, pos_end - 1)

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			setwidth := str.substring (pos, pos_end - 1)

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			add_style := str.substring (pos, pos_end - 1)

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			pixel_size := str.substring (pos, pos_end - 1)

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			point_size := str.substring (pos, pos_end - 1)

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			resolution_x := str.substring (pos, pos_end - 1)

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			resolution_y := str.substring (pos, pos_end - 1)

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			spacing := str.substring (pos, pos_end - 1)

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			average_width := str.substring (pos, pos_end - 1)

			pos := pos_end + 1
			pos_end := str.count + 1
			charset := str.substring (pos, pos_end - 1)
		end

end -- class EV_FONT_NAME_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2001/06/14 20:12:16  king
--| Removed unused local
--|
--| Revision 1.7  2001/06/07 23:08:05  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.4.2  2000/09/06 23:18:42  king
--| Reviewed
--|
--| Revision 1.4.4.1  2000/05/03 19:08:42  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/02/22 18:39:36  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:29  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.3  2000/02/04 04:56:29  oconnor
--| released
--|
--| Revision 1.4.6.2  2000/01/27 19:29:33  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.1  1999/11/24 17:29:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.3  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
