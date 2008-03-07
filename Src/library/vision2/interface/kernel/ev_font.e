indexing
	description:
		"[
			Representation of a typeface.
			Appearance is specified in terms of font family, height, shape and
			weight. The local system font closest to the specification will be
			displayed. A specific font name may optionally be specified. See `set_preferred_face'"

			There are two available queries for a font height, `height' and `height_in_points'.
			Changing one, changes the other accordingly. `height' is given in pixels while
			`height_in_points' is in points or 1/72 of an inch. Using `height_in_points' ensures
			that on different screen resolutions `Current' has the same physical size, although
			the pixel height may differ to achieve this.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "character, face, height, family, weight, shape, bold, italic"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT

inherit
	EV_ANY
		redefine
			implementation,
			is_equal,
			copy,
			is_in_default_state
		end

	EV_FONT_CONSTANTS
		export
			{NONE} all
			{ANY} valid_family, valid_weight, valid_shape
		undefine
			default_create,
			is_equal,
			copy
		end

create
	default_create,
	make_with_values

feature {NONE} -- Initialization

	make_with_values (a_family, a_weight, a_shape, a_height: INTEGER) is
			-- Create with `a_family', `a_weight', `a_shape' and `a_height'.
		require
			a_family_valid: valid_family (a_family)
			a_weight_valid: valid_weight (a_weight)
			a_shape_valid: valid_shape (a_shape)
			a_height_bigger_than_zero: a_height > 0
		do
			default_create
			implementation.set_values (
				a_family,
				a_weight,
				a_shape,
				a_height,
				preferred_families
			)
		ensure
			a_family_set: family = a_family
			a_weight_set: weight = a_weight
			a_shape_set: shape = a_shape
			a_height_set: height = a_height
		end

feature -- Access

	family: INTEGER is
			-- Font category. Can be any of the Family_* constants
			-- defined in EV_FONT_CONSTANTS.
			-- Default: Family_sans
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.family
		ensure
			bridge_ok: Result = implementation.family
		end

	char_set: INTEGER is
			-- Charset of the font.
			-- Only meaningful on windows.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.char_set
		ensure
			bridge_ok: Result = implementation.char_set
		end

	weight: INTEGER is
			-- Preferred font thickness. Can be any of the Weight_*
			-- constants defined in EV_FONT_CONSTANTS.
			-- Default: Weight_regular
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.weight
		ensure
			bridge_ok: Result = implementation.weight
		end

	shape: INTEGER is
			-- Preferred font slant. Can be any of the Shape_*
			-- constants defined in EV_FONT_CONSTANTS.
			-- Default: Shape_regular
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.shape
		ensure
			bridge_ok: Result = implementation.shape
		end

	height: INTEGER is
			-- Preferred font height in pixels.
			-- Default: 8
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.height
		ensure
			bridge_ok: Result = implementation.height
		end

	height_in_points: INTEGER is
			-- Preferred font height in points.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.height_in_points
		ensure
			bridge_ok: Result = implementation.height_in_points
		end

	line_height: INTEGER is
			-- Preferred text editor line height in pixels for `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.line_height
		ensure
			bridge_ok: Result = implementation.line_height
		end

	preferred_families: EV_ACTIVE_LIST [STRING_32] is
			-- Preferred familys. The first one in the list
			-- will be tried first. If it does not exists on
			-- the system, the second will be tried, etc.
			--
			-- Overrides `family' if found on current system.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.preferred_families
		ensure
			bridge_ok: Result = implementation.preferred_families
			Result_not_void: Result /= Void
		end

feature -- Element change

	set_family (a_family: INTEGER) is
			-- Assign  `a_family' to `family'.
		require
			not_destroyed: not is_destroyed
			a_family_valid: valid_family (a_family)
		do
			implementation.set_family (a_family)
		ensure
			family_assigned: family = a_family
		end

	set_weight (a_weight: INTEGER) is
			-- Set `a_weight' to `weight'.
		require
			not_destroyed: not is_destroyed
			a_weight_valid: valid_weight (a_weight)
		do
			implementation.set_weight (a_weight)
		ensure
			weight_assigned: weight = a_weight
		end

	set_shape (a_shape: INTEGER) is
			-- Set `a_shape' to `shape'.
		require
			not_destroyed: not is_destroyed
			a_shape_valid: valid_shape (a_shape)
		do
			implementation.set_shape (a_shape)
		ensure
			shape_assigned: shape = a_shape
		end

	set_height (a_height: INTEGER) is
			-- Set `a_height' to `height'.
			-- `height_in_points' changes accordingly based on screen resolution.
		require
			not_destroyed: not is_destroyed
			a_height_bigger_than_zero: a_height > 0
		do
			implementation.set_height (a_height)
		ensure
			height_assigned: height = a_height
		end

	set_height_in_points (a_height: INTEGER) is
			-- Set `height_in_points' to `a_height'.
			-- `height' changes accordingly based on screen resolution.
		require
			not_destroyed: not is_destroyed
			a_height_bigger_than_zero: a_height > 0
		do
			implementation.set_height_in_points (a_height)
		ensure
			height_assigned: height_in_points = a_height
		end

feature -- Status report

	name: STRING_32 is
			-- Face name chosen by toolkit.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.name
		ensure
			bridge_ok: Result.is_equal (implementation.name)
		end

	ascent: INTEGER is
			-- Vertical distance from the origin of the drawing
			-- operation to the top of the drawn character.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.ascent
		ensure
			bridge_ok: Result = implementation.ascent
		end

	descent: INTEGER is
			-- Vertical distance from the origin of the drawing
			-- operation to the bottom of the drawn character.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.descent
		ensure
			bridge_ok: Result = implementation.descent
		end

	width: INTEGER is
			-- Character width of current fixed-width font.
			-- If font is proportional, returns the average width.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.width
		ensure
			bridge_ok: Result = implementation.width
		end

	minimum_width: INTEGER is
			-- Width of the smallest character in the font.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.minimum_width
		ensure
			bridge_ok: Result = implementation.minimum_width
		end

	maximum_width: INTEGER is
			-- Width of the biggest character in the font.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.maximum_width
		ensure
			bridge_ok: Result = implementation.maximum_width
		end

	string_width (a_string: STRING_GENERAL): INTEGER is
			-- Width in pixels of `a_string' in the current font.
		require
			not_destroyed: not is_destroyed
			a_string_not_void: a_string /= Void
		do
			Result := implementation.string_width (a_string)
		ensure
			bridge_ok: Result = implementation.string_width (a_string)
			positive: Result >= 0
		end

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font is designed.
			-- Measured in dots per inch. If return value is zero, the
			-- resolution is not known.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.horizontal_resolution
		ensure
			bridge_ok: Result = implementation.horizontal_resolution
		end

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font is designed.
			-- Measured in dots per inch. If return value is zero, the
			-- resolution is not known.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.vertical_resolution
		ensure
			bridge_ok: Result = implementation.vertical_resolution
		end

	is_proportional: BOOLEAN is
			-- Can characters in the font have different widths?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_proportional
		ensure
			bridge_ok: Result = implementation.is_proportional
		end

	string_size (a_string: STRING_GENERAL): TUPLE [width: INTEGER; height: INTEGER; left_offset: INTEGER; right_offset: INTEGER] is
			-- [width, height, left_offset, right_offset] in pixels of `a_string' in the current font,
			-- taking into account line breaks ('%N').
			-- `width' and `height' correspond to the rectange used to bound `a_string', and
			-- should be used when placing strings next to each as part of a text.
			-- On some fonts, characters may extend outside of the bounds given by `width' and `height',
			-- for example certain italic letters may overhang other letters. Use `left_offset' and
			-- `right_offset' to determine if there is any overhang for `a_string'. a negative `left_offset'
			-- indicates overhang to the left, while a positive `right_offset' indicates an overhang to the right.
			-- To determine the complete bounding rectangle for `a_string' add negative `left_offset'
			-- and positive `right_offset' to `width'.
		require
			not_destroyed: not is_destroyed
			a_string_not_void: a_string /= Void
		do
			Result := implementation.string_size (a_string)
		ensure
			result_not_void: Result /= Void
			bridge_ok: Result.width.is_equal (implementation.string_size (a_string).width) and
				Result.height.is_equal (implementation.string_size (a_string).height)
		end

feature -- Basic operations

	is_equal (other: like Current): BOOLEAN is
			-- Does `other' have same appearance?
		do
			Result := family = other.family and then
				weight = other.weight and then
				shape = other.shape and then
				height_in_points = other.height_in_points
		end

	copy (other: like Current) is
			-- Update `Current' with all attributes of `other'.
		do
			if implementation = Void then
				default_create
			end
			implementation.copy_font (other)
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.

		do
			Result := Precursor {EV_ANY} and then
				preferred_families /= Void and then preferred_families.is_empty
		end

feature {EV_ANY, EV_ANY_I, EV_ANY_HANDLER} -- Implementation

	implementation: EV_FONT_I
			-- Responsible for interaction with native graphics
			-- toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of drawing area.
		do
			create {EV_FONT_IMP} implementation.make (Current)
		end

invariant
	family_valid: is_initialized implies valid_family (family)
	weight_valid: is_initialized implies valid_weight (weight)
	shape_valid: is_initialized implies valid_shape (shape)
	height_positive: is_initialized implies height > 0
	height_in_points_positive: is_initialized implies height_in_points > 0
	ascent_not_negative: is_initialized implies ascent >= 0
	descent_not_negative: is_initialized implies descent >= 0
	width_of_empty_string_equals_zero: is_initialized implies string_width("") = 0
	horizontal_resolution_non_negative: is_initialized implies horizontal_resolution >= 0
	vertical_resolution_non_negative: is_initialized implies vertical_resolution >= 0

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_FONT

