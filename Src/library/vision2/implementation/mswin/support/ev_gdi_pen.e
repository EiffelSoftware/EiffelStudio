--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision implentation for retrieving a WEL_PEN"
	status: "See notice at end of class"
	id: "$Id:"
	date: "$Date:"
	revision: "$Revision:"

class
	EV_GDI_PEN

inherit
	ANY
		redefine
			is_equal
		end

	HASHABLE
		undefine
			is_equal
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
			-- Hash code value
		local
			color_hash_value: REAL
		do
			color_hash_value :=
				262144.0*color.red +
				4096.0*color.green +
				64.0*color.blue
			Result := (
				color_hash_value.abs.floor +
				line_width * 2 +
				dashed_line_mode
			).abs
		end

	dashed_line_mode: INTEGER
			-- Style of the pen

	line_width: INTEGER
			-- Width of the pen

	color: WEL_COLOR_REF
			-- Color of the pen

	item: WEL_PEN
			-- WEL Pen object

feature -- Comparison

	is_equal(other: like Current): BOOLEAN is
			-- Does `Current' look the same as `other'?
		do
			Result := 
				dashed_line_mode = other.dashed_line_mode and then
				line_width = other.line_width and then
				color.is_equal(other.color)
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
			color := a_color
		end

	set_item(a_pen: WEL_PEN) is
			-- Set the item value to `a_pen'
		do
			item := a_pen
		end

invariant
	color_not_void: color /= Void

end -- class EV_GDI_PEN
