note
	description: "Eiffel Vision font. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "character, face, height, family, weight, shape, bold, italic"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_IMP

inherit
 	EV_FONT_I
		redefine
			interface,
			set_values,
			string_size
		end

	EV_ANY_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

 	make (an_interface: like interface)
 			-- Create the default font.
		do
			base_make (an_interface)
			create font.system_font_of_size (0)
			cocoa_item := font
		end


	initialize
			-- Set up `Current'
		local
			--l_app_imp: like app_implementation
		do
			--l_app_imp := app_implementation
			create preferred_families
			--set_height_in_points (l_app_imp.default_font_point_height_internal)
			set_shape (shape_regular)
			set_weight (weight_regular)
			set_family ({EV_FONT_CONSTANTS}.family_screen)
			--preferred_families.internal_add_actions.extend (agent update_preferred_faces)
			--preferred_families.internal_remove_actions.extend (preferred_families.internal_add_actions.first)
			height := 10
			height_in_points := 10
			set_is_initialized (True)
		end

feature {EV_FONTABLE_IMP} -- Implementation

	font_is_default: BOOLEAN
			-- Does `Current' have the characteristics of the default application font?
		do
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
			calculate_font_metrics
		end

	set_height_in_points (a_height: INTEGER)
			-- Set `a_height' as preferred font size in screen pixels
		do
			calculate_font_metrics
		end

	set_values (a_family, a_weight, a_shape, a_height: INTEGER;
		a_preferred_families: like preferred_families)
			-- Set `a_family', `a_weight', `a_shape' `a_height' and
			-- `a_preferred_face' at the same time for speed.
		do
			calculate_font_metrics
		end

feature -- Status report

	name: STRING_32
			-- Face name chosen by toolkit.
		do
			Result := font.font_name
		end

	ignore_font_metric_calculation: BOOLEAN
			-- Should the font metric calculation be ignored?

	calculate_font_metrics
			-- Calculate metrics for font
		do
			ascent := 1
			descent := 1
		end

	ascent: INTEGER
			-- Vertical distance from the origin of the drawing operation to the top of the drawn character.

	descent: INTEGER
			-- Vertical distance from the origin of the drawing operation to the bottom of the drawn character.

	width: INTEGER
			-- Character width of current fixed-width font.
		do
			Result := string_width("x")
		end

	minimum_width: INTEGER
			-- Width of the smallest character in the font.
		do
			Result := string_width("1")
		end

	maximum_width: INTEGER
			-- Width of the biggest character in the font.
		do
			Result := string_width("W")
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
			create l_attributes.dictionary_with_object_for_key (cocoa_item, cocoa_item.font_attribute_name)
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
		do
		end

	update_preferred_faces (a_face: STRING_32)
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_FONT;
		-- Interface coupling object for `Current'

	font: NS_FONT;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_FONT_IMP

