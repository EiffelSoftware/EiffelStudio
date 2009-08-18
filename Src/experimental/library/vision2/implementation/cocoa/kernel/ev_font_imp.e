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
			string_size
		end

	EV_ANY_IMP
		redefine
			interface
		end

	NS_STRING_CONSTANTS

	EV_FONT_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make
			-- Set up `Current'
		local
			--l_app_imp: like app_implementation
		do
			create font.system_font_of_size (0)

			--l_app_imp := app_implementation
			create preferred_families
			--set_height_in_points (l_app_imp.default_font_point_height_internal)
			set_shape (shape_regular)
			set_weight (weight_regular)
			set_family (family_screen)
			--preferred_families.internal_add_actions.extend (agent update_preferred_faces)
			--preferred_families.internal_remove_actions.extend (preferred_families.internal_add_actions.first)
			height := {NS_FONT_API}.system_font_size.rounded
			height_in_points := height
			set_is_initialized (True)
			shape := Shape_regular
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

	height_in_points: INTEGER
			-- Preferred font height measured in points.

feature -- Element change

	set_family (a_family: INTEGER)
			-- Set `a_family' as preferred font category.
		do
			family := a_family
			calculate_font_metrics
		end

	set_face_name (a_face: STRING_GENERAL)
			-- Set the face name for current.
		do
			--name := a_face
			calculate_font_metrics
		end

	set_weight (a_weight: INTEGER)
			-- Set `a_weight' as preferred font thickness.
		do
			weight := a_weight
			calculate_font_metrics
		end

	set_shape (a_shape: INTEGER)
			-- Set `a_shape' as preferred font slant.
		do
			shape := a_shape
			calculate_font_metrics
		end

	set_height (a_height: INTEGER)
			-- Set `a_height' as preferred font size in screen pixels
		do
			height := a_height
			height_in_points := a_height
			calculate_font_metrics
		end

	set_height_in_points (a_height: INTEGER)
			-- Set `a_height' as preferred font size in screen pixels
		do
			height_in_points := a_height
			height := a_height
			calculate_font_metrics
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

	ignore_font_metric_calculation: BOOLEAN
			-- Should the font metric calculation be ignored?

	calculate_font_metrics
			-- Calculate metrics for font
		do
			ascent := 1
			descent := 1
			update_font_face
		end

	ascent: INTEGER
			-- Vertical distance from the origin of the drawing operation to the top of the drawn character.

	descent: INTEGER
			-- Vertical distance from the origin of the drawing operation to the bottom of the drawn character.

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

	string_size (a_string: STRING_GENERAL): TUPLE [width: INTEGER; height: INTEGER; left_offset: INTEGER; right_offset: INTEGER]
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
			Result.width := l_size.width
			Result.height := l_size.height
		end

	string_width (a_string: STRING_GENERAL): INTEGER
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
			--Result:= font.is_fixed_pitch
		end

feature {NONE} -- Implementation

	update_font_face
		local
			font_descriptor: NS_FONT_DESCRIPTOR
		do
			create font_descriptor.make
			font_descriptor.set_size (height)
			if weight > weight_regular then
				font_descriptor.set_trait ({NS_FONT_DESCRIPTOR}.bold_trait)
			end
			create font.font_with_descriptor (font_descriptor, height)
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
