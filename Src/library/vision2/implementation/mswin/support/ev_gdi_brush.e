indexing
	description: 
		"EiffelVision implentation for retrieving a WEL_BRUSH"
	status: "See notice at end of class"
	date: "$Date:"
	revision: "$Revision:"

class
	EV_GDI_BRUSH

inherit
	EV_GDI_OBJECT
		redefine
			item
		end

creation
	default_create, make_with_values

feature -- Initialization

	make_with_values (a_pattern: WEL_BITMAP; a_color: WEL_COLOR_REF) is
			-- Set the pattern of the brush to `a_pattern' (can
			-- be equal to Void if no pattern is defined), and
			-- the color to `a_color'.
		do
			set_values (a_pattern, a_color)
		end

feature -- Access

	hash_code: INTEGER is
			-- Hash code value.
		local
			color_hash_value: REAL
		do
			color_hash_value :=
				262144.0 * color_red +
				4096.0 *color_green +
				64.0 * color_blue
			Result := color_hash_value.abs.floor

			if pattern /= Void then
				Result := Result + pattern.item.hash_code
			end
		end

	pattern: WEL_BITMAP
			-- Pattern of the brush

	color_red: INTEGER
			-- Color of the pen (red component)

	color_blue: INTEGER
			-- Color of the pen (blue component)

	color_green: INTEGER
			-- Color of the pen (green component)

	item: WEL_BRUSH
			-- WEL Brush object

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does `Current' look the same as `other'?
		local
			equal_color: BOOLEAN -- are colors equal ?
			equal_pattern: BOOLEAN -- are pattern equal ?
		do
			equal_color := other.color_red = color_red and
				other.color_blue = color_blue and
				other.color_green = color_green

			if pattern /= Void then
				equal_pattern := 
					other.pattern /= Void and then
					pattern.item.hash_code = other.pattern.item.hash_code
			else
				equal_pattern := other.pattern = Void
			end

			Result := equal_color and equal_pattern
		end

feature -- Element change

	set_values (a_pattern: WEL_BITMAP; a_color: WEL_COLOR_REF) is
			-- Set the pattern of the brush to `a_pattern' (can
			-- be equal to Void if no pattern is defined), and
			-- the color to `a_color'.
		do
			pattern := a_pattern
			if a_color /= Void then
				color_red := a_color.red
				color_blue := a_color.blue
				color_green := a_color.green
			else
				color_red := -1
				color_blue := -1
				color_green := -1
			end				
		end

end -- class EV_GDI_BRUSH
