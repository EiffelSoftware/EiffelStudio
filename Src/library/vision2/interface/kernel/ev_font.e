indexing
	description:
		"Representation of a typeface.%N%
		%Appearance is specified in terms of font family, height, shape and%N%
		%weight. The local system font closest to the specification will be%N%
		%displayed. A specific font name may optionally be specified. %
		%See `set_preferred_face'"
	status: "See notice at end of class"
	keywords: "character, face, height, family, weight, shape, bold, italic"
	date: "$Date$"
	revision: "$Revision$"


--| FIXME Fonts need to be reviewed WRT addition of conveniance features
--| for dealing with points.

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
		local
			empty_list: ACTIVE_LIST [STRING]
		do
			default_create
			create empty_list
			implementation.set_values (
				a_family,
				a_weight,
				a_shape,
				a_height,
				empty_list
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

	preferred_familys: ACTIVE_LIST [STRING] is
			-- Preferred familys. The first one in the list
			-- will be tried first. If it does not exists on
			-- the system, the second will be tried, etc.
			--
			-- Overrides `family' if found on current system.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.preferred_familys
		ensure
			bridge_ok: Result = implementation.preferred_familys
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
		require
			not_destroyed: not is_destroyed
			a_height_bigger_than_zero: a_height > 0
		do
			implementation.set_height (a_height)
		ensure
			height_assigned: height = a_height
		end

feature -- Status report

	name: STRING is
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

	string_width (a_string: STRING): INTEGER is
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

	string_size (a_string: STRING): TUPLE [INTEGER, INTEGER] is
			-- [width, height] in pixels of `a_string' in the current font,
			-- taking into account line breaks ('%N').
		require
			not_destroyed: not is_destroyed
			a_string_not_void: a_string /= Void
		do
			Result := implementation.string_size (a_string)
		ensure
			bridge_ok: Result.item (1).is_equal
				(implementation.string_size (a_string).item (1)) and
				Result.item (2).is_equal
				(implementation.string_size (a_string).item (2))
		end

feature -- Basic operations

	is_equal (other: like Current): BOOLEAN is
			-- Does `other' have same appearance?
		do
			Result := family = other.family and then
				weight = other.weight and then
				shape = other.shape and then
				height = other.height-- and then
				--(preferred_faces = other.preferred_faces or else
				--preferred_faces.is_equal (other.preferred_faces))
				--| FIXME IEK PR 2585
		end

	copy (other: like Current) is
			-- Update `Current' with all attributes of `other'.
		do
			if implementation = Void then
				default_create
			end
			implementation.set_values (
				other.family,
				other.weight,
				other.shape,
				other.height,
				other.preferred_familys
			)
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := Precursor {EV_ANY} and then
				family = ev_default_fonts.Screen_font.family and then
				weight = ev_default_fonts.Screen_font.weight and then
				shape = ev_default_fonts.Screen_font.shape and then
				height = ev_default_fonts.Screen_font.height and then
				preferred_familys /= Void and then preferred_familys.is_empty
		end

	Ev_default_fonts: EV_STOCK_FONTS is
		once
			create Result
		end
		
feature {EV_ANY_I} -- Implementation

	implementation: EV_FONT_I
			-- Responsible for interaction with the underlying native graphics
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
	height_bigger_than_zero: is_initialized implies height > 0
	ascent_bigger_than_zero: is_initialized implies ascent > 0
	descent_bigger_than_zero: is_initialized implies descent > 0
	height_positive: is_initialized implies height > 0
	ascent_positive: is_initialized implies ascent > 0
	descent_positive: is_initialized implies descent > 0
	width_of_empty_string_equals_zero: is_initialized implies string_width("") = 0
	horizontal_resolution_non_negative: is_initialized implies horizontal_resolution >= 0
	vertical_resolution_non_negative: is_initialized implies vertical_resolution >= 0

end -- class EV_FONT

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
