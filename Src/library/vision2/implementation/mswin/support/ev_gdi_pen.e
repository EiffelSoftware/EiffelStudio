indexing
	description: 
		"EiffelVision implentation for retrieving a WEL_PEN"
	status: "See notice at end of class"
	date: "$Date:"
	revision: "$Revision:"

class
	EV_GDI_PEN

inherit
	EV_GDI_OBJECT
		redefine
			item
		end

creation
	make_with_values

feature -- Initialization

	make_with_values (a_dashed_mode: INTEGER; a_width: INTEGER;
		a_color: WEL_COLOR_REF) is
			-- Set the style of the pen to `a_dashed_mode',
			-- the line width to `a_width' and the color
			-- to `a_color'.
		do
			set_values(a_dashed_mode, a_width, a_color)
		end

feature -- Access

	hash_code: INTEGER is
			-- Hash code value.
		local
			color_hash_value: REAL
		do
			if computed_hash_code = 0 then
				color_hash_value :=
					262144.0*color_red +
					4096.0*color_green +
					64.0*color_blue
				computed_hash_code := (
					color_hash_value.abs.floor +
					line_width * 2 +
					dashed_line_mode
				).abs
			end
			Result := computed_hash_code
		end

	dashed_line_mode: INTEGER
			-- Style of the pen.

	line_width: INTEGER
			-- Width of the pen.

	color_red: INTEGER
			-- Color of the pen (red component).

	color_blue: INTEGER
			-- Color of the pen (blue component).

	color_green: INTEGER
			-- Color of the pen (green component).

	item: WEL_PEN
			-- WEL Pen object.

feature -- Comparison

	is_equal(other: like Current): BOOLEAN is
			-- Does `Current' look the same as `other'?
		do
			Result := 
				dashed_line_mode = other.dashed_line_mode and then
				line_width = other.line_width and then
				color_red = other.color_red and then
				color_green = other.color_green and then
				color_blue = other.color_blue
		end

feature -- Element change

	set_values (a_dashed_mode: INTEGER; a_width: INTEGER;
		a_color: WEL_COLOR_REF) is
			-- Set the style of the pen to `a_dashed_mode',
			-- the line width to `a_width' and the color
			-- to `a_color'.
		do
			dashed_line_mode := a_dashed_mode
			line_width := a_width
			color_red := a_color.red
			color_blue := a_color.blue
			color_green := a_color.green
		end

end -- class EV_GDI_PEN

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.5  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.4  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.2.3  2000/10/16 14:27:35  pichery
--| Improved WEL_BRUSH and WEL_PEN caching
--|
--| Revision 1.3.2.2  2000/08/15 16:38:51  rogers
--| Removed fixme not_reviewed. Comments, Added copyright clause and CVS log.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
