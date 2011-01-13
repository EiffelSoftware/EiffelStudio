note
	description: "Eiffel Vision font. Cocoa implementation."
	author:	"Daniel Furrer"
	keywords: "character, face, height, family, weight, shape, bold, italic"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_IMP

inherit
 	EV_FONT_I
		redefine
			interface,
			string_size,
			line_height
		end

	EV_ANY_IMP
		redefine
			interface
		end

	NS_STRING_CONSTANTS

	EV_FONT_CONSTANTS

	NS_ENVIRONEMENT

create
	make

feature {NONE} -- Initialization

	make
			-- Set up `Current'
		do
			create font.system_font_of_size (0)

			create preferred_families
			set_shape (shape_regular)
			set_weight (weight_regular)
			set_family (family_screen)
			set_is_initialized (True)

			--preferred_families.internal_add_actions.extend (agent update_preferred_faces)
			--preferred_families.internal_remove_actions.extend (preferred_families.internal_add_actions.first)
		end

feature -- Access

	family: INTEGER
			-- Preferred font category.

	char_set: INTEGER
			-- Charset

	weight: INTEGER
			-- Preferred font thickness.

	shape: INTEGER
			-- Preferred font slant.

	height: INTEGER
			-- Preferred font height measured in screen pixels.
		do
			Result := font.point_size.rounded
		end

	height_in_points: INTEGER
			-- Preferred font height measured in points.
		do
			Result := font.point_size.rounded
		end

	line_height: INTEGER
			-- <Precursor>
		do
			Result := font.point_size.rounded
		end

feature -- Element change

	set_family (a_family: INTEGER)
			-- Set `a_family' as preferred font category.
		do
			family := a_family
			--font := shared_font_manager.convert_font_to_family (font, ...)
		end

	set_face_name (a_face: READABLE_STRING_GENERAL)
			-- Set the face name for current.
		do
			font := shared_font_manager.convert_font_to_face (font, a_face)
		end

	set_weight (a_weight: INTEGER)
			-- Set `a_weight' as preferred font thickness.
		do
			weight := a_weight
			if weight > weight_regular then
				font := shared_font_manager.convert_font_to_have_trait (font, {NS_FONT_DESCRIPTOR}.bold_trait)
			else
				font := shared_font_manager.convert_font_to_not_have_trait (font, {NS_FONT_DESCRIPTOR}.bold_trait)
			end
		end

	set_shape (a_shape: INTEGER)
			-- Set `a_shape' as preferred font slant.
		do
			shape := a_shape
			if shape = Shape_italic then
				font := shared_font_manager.convert_font_to_have_trait (font, {NS_FONT_DESCRIPTOR}.italic_trait)
			else
				font := shared_font_manager.convert_font_to_not_have_trait (font, {NS_FONT_DESCRIPTOR}.italic_trait)
			end
		end

	set_height (a_height: INTEGER)
			-- Set `a_height' as preferred font size in screen pixels
		do
			font := shared_font_manager.convert_font_to_size (font, a_height.to_real)
		end

	set_height_in_points (a_height: INTEGER)
			-- Set `a_height' as preferred font size in screen pixels
		do
			font := shared_font_manager.convert_font_to_size (font, a_height.to_real)
		end

feature -- Status report

	name: STRING_32
			-- Face name chosen by toolkit.
		local
			i: INTEGER
		do
			Result := font.font_name
			-- The OS X font name may be ...-Bold, but we're just interested in the first part.
			i := Result.index_of ('-', 1)
			if i /= 0 then
				Result.keep_head (i - 1)
			end
		end

	ascent: INTEGER
			-- Vertical distance from the origin of the drawing operation to the top of the drawn character.
		do
			Result := font.ascender.floor
		end

	descent: INTEGER
			-- Vertical distance from the origin of the drawing operation to the bottom of the drawn character.
		do
			Result := - font.descender.floor
		end

	width: INTEGER
			-- Character width of current fixed-width font.
		do
			Result := string_width ("x")
		end

	minimum_width: INTEGER
			-- Width of the smallest character in the font.
		do
			Result := string_width ("1")
		end

	maximum_width: INTEGER
			-- Width of the biggest character in the font.
		do
			Result := string_width ("W")
		end

	string_size (a_string: READABLE_STRING_GENERAL): TUPLE [width: INTEGER; height: INTEGER; left_offset: INTEGER; right_offset: INTEGER]
			-- `Result' is [width, height, left_offset, right_offset] in pixels of `a_string' in the
			-- current font, taking into account line breaks ('%N').
		local
			l_string: NS_STRING
			l_attributes: NS_DICTIONARY
			l_size: NS_SIZE
		do
			create l_string.make_with_string (a_string)
			create l_attributes.make_with_object_for_key (font, font_attribute_name)
			l_size := l_string.size_with_attributes (l_attributes)

			create Result.default_create
			Result.width := l_size.width.rounded
			Result.height := l_size.height.rounded
		end

	string_width (a_string: READABLE_STRING_GENERAL): INTEGER
			-- Width in pixels of `a_string' in the current font.
		do
			Result := string_size (a_string).width
		end

	horizontal_resolution: INTEGER
			-- Horizontal resolution of screen for which the font is designed.
		do
		end

	vertical_resolution: INTEGER
			-- Vertical resolution of screen for which the font is designed.
		do
		end

	is_proportional: BOOLEAN
			-- Can characters in the font have different sizes?
		do
			Result:= font.is_fixed_pitch
		end

feature {NONE} -- Implementation

	update_font_face
		do
		end

	update_preferred_faces (a_face: STRING_32)
		do
		end

feature {EV_ANY_I} -- Implementation

	font: NS_FONT;

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_FONT note option: stable attribute end

invariant
	shape_valid: shape = Shape_regular or shape = Shape_italic
end -- class EV_FONT_IMP
