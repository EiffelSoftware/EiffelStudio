indexing
	description:
		" Objects that represent the name of a font%
		% on gtk"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_NAME_IMP

creation
	make_empty,
	make_by_name,
	make_by_system_name

feature -- Initialization

	make_empty is
			-- Create the object with empty attributes.
		do
		end

	make_by_name (str: STRING) is
			-- Create the default font with name
		do
			foundry := ""
			family := ""
			weight := "medium"
			slant := "roman"
			set_width := "normal"
			add_style := "(nil)"
			pixel_size := 14
			point_size := 140
			resolution_x := 75
			resolution_y := 75
			spacing := "proportional"
			average_width := 74
			charset := "iso8859-1"
		end

	make_by_system_name (str: STRING) is
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

	slant: STRING
		-- Slant of the font

	set_width: STRING
		-- ??

	add_style: STRING
		-- ??

	pixel_size: INTEGER
		-- Size in pixel of the font

	point_size: INTEGER
		-- Size in points of the font

	resolution_x: INTEGER
		-- Horizontal resolution of the font

	resolution_y: INTEGER
		-- Vertical resolution of the font

	spacing: STRING
		-- Spacing in the font

	average_width: INTEGER
		-- average_width of the font

	charset: STRING
		-- Current charset of the font

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

	set_set_width (str: STRING) is
			-- Make 'str' the new width.
		do
			set_width:= str
		end

	set_add_style (str: STRING) is
			-- Make 'str' the new style.
		do
			add_style := str
		end

	set_pixel_size (value: INTEGER) is
			-- Make 'value' the new pixel_size.
		do
			pixel_size := value
		end

	set_point_size (value: INTEGER) is
			-- Make 'value' the new point_size.
		do
			point_size := value
		end

	set_resolution_x (value: INTEGER) is
			-- Make 'value' the new resolution_x.
		do
			resolution_x := value
		end

	set_resolution_y (value: INTEGER) is
			-- Make 'value' the new resolution_y.
		do
			resolution_y := value
		end

	set_spacing (str: STRING) is
			-- Make 'str' the new spacing.
		do
			spacing := str
		end

	set_average_width (value: INTEGER) is
			-- Make 'value' the new width.
		do
			average_width := value
		end

	set_charset (str: STRING) is
			-- Make 'value' the new charset.
		do
			charset := str
		end

feature -- Basic operations

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
			Result.append (set_width) --To change
			Result.append ("-")
			Result.append (add_style)
			Result.append ("-")
			Result.append (pixel_size.out)
			Result.append ("-")
			Result.append (point_size.out)
			Result.append ("-")
			Result.append (resolution_x.out)
			Result.append ("-")
			Result.append (resolution_y.out)
			Result.append ("-")
			Result.append (spacing)
			Result.append ("-")
			Result.append (average_width.out)
			Result.append ("-")
			Result.append (charset)
		end

	parse_name (str: STRING) is
			-- Fill the parameters according to the given system name.
		local
			pos, pos_end: INTEGER
			number: INTEGER
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
			set_width := str.substring (pos, pos_end - 1)

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			add_style := str.substring (pos, pos_end - 1)

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			pixel_size := (str.substring (pos, pos_end - 1)).to_integer

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			point_size := (str.substring (pos, pos_end - 1)).to_integer

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			resolution_x := (str.substring (pos, pos_end - 1)).to_integer

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			resolution_y := (str.substring (pos, pos_end - 1)).to_integer

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			spacing := str.substring (pos, pos_end - 1)

			pos := pos_end + 1
			pos_end := str.index_of ('-', pos)
			average_width := (str.substring (pos, pos_end - 1)).to_integer

			pos := pos_end + 1
			pos_end := str.count + 1
			charset := str.substring (pos, pos_end - 1)
		end

feature -- Assertion features

	valid_weight (str: STRING): BOOLEAN is
			-- Is 'str' a valid weight value?
		do
			Result := (str = "(nil)") or (str = "black") or (str = "bold")
						or (str = "demibold") or (str = "medium")
						or (str = "regular")
		end

	valid_slant (str: STRING): BOOLEAN is
			-- Is 'str' a valid slant value?
		do
			Result := (str = "(nil)") or (str = "italic") or (str = "oblique")
						or (str = "roman")
		end

	valid_set_width (str: STRING): BOOLEAN is
			-- Is 'str' a valid set_width value?

		do
			Result := (str = "(nil)") or (str = "normal")
						or (str = "semicondensed")
		end


	valid_spacing (str: STRING): BOOLEAN is
			-- Is 'str' a valid spacing value?
		do
			Result := (str = "char cell") or (str = "monospaced")
						or (str = "proportional")
		end

end -- class EV_FONT_NAME_IMP

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

