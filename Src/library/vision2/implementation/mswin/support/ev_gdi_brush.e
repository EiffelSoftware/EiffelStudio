--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision implentation for retrieving a WEL_BRUSH"
	status: "See notice at end of class"
	id: "$Id:"
	date: "$Date:"
	revision: "$Revision:"

class
	EV_GDI_BRUSH

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
	default_create, make_with_values

feature -- Initialization

	make_with_values(a_pattern: WEL_BITMAP; a_color: WEL_COLOR_REF) is
			-- Set the pattern of the brush to `a_pattern' (can
			-- be equal to Void if no pattern is defined), and
			-- the color to `a_color'.
		do
			set_values(a_pattern, a_color)
		end

feature -- Access

	hash_code: INTEGER is
			-- Hash code value
		local
			color_hash_value: REAL
		do
			if color /= Void then
				color_hash_value :=
					262144.0 * color.red +
					4096.0 *color.green +
					64.0 * color.blue
				Result := color_hash_value.abs.floor
			end
			if pattern /= Void then
				Result := Result + pattern.item.hash_code
			end
		end

	pattern: WEL_BITMAP
			-- Pattern of the brush

	color: WEL_COLOR_REF
			-- Color of the brush

	item: WEL_BRUSH
			-- WEL Brush object

feature -- Comparison

	is_equal(other: like Current): BOOLEAN is
			-- Does `Current' look the same as `other'?
		local
			equal_color: BOOLEAN -- are colors equal ?
			equal_pattern: BOOLEAN -- are pattern equal ?
		do
			if color /= Void then
				equal_color := other.color /= Void
					and then color.is_equal (other.color)
			else
				equal_color := other.color = Void
			end

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

	set_values(a_pattern: WEL_BITMAP; a_color: WEL_COLOR_REF) is
			-- Set the pattern of the brush to `a_pattern' (can
			-- be equal to Void if no pattern is defined), and
			-- the color to `a_color'.
		do
			pattern := a_pattern
			color := a_color
		end

	set_item(a_brush: WEL_BRUSH) is
			-- Set the item value to `a_brush'
		do
			item := a_brush
		end

end -- class EV_GDI_BRUSH
