note
	description: "Eiffel Vision font. Carbon implementation."
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

	DISPOSABLE

create
	make

feature {NONE} -- Initialization

 	make (an_interface: like interface)
 			-- Create the default font.
		do
			base_make (an_interface)
		end


	initialize
			-- Set up `Current'
		local
			l_app_imp: like app_implementation
		do
			--l_app_imp := app_implementation
			create preferred_families
			set_family (family_sans)
			set_face_name ("Arial") --l_app_imp.default_font_name
			--set_height_in_points (l_app_imp.default_font_point_height_internal)
			set_shape (shape_regular)
			set_weight (weight_regular)
			--preferred_families.internal_add_actions.extend (agent update_preferred_faces)
			--preferred_families.internal_remove_actions.extend (preferred_families.internal_add_actions.first)
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
			name := a_face
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
		end

	minimum_width: INTEGER
			-- Width of the smallest character in the font.
		do
		end

	maximum_width: INTEGER
			-- Width of the biggest character in the font.
		do
		end

	string_size (a_string: STRING_GENERAL): TUPLE [INTEGER, INTEGER, INTEGER, INTEGER, INTEGER]
			-- `Result' is [width, height, left_offset, right_offset] in pixels of `a_string' in the
			-- current font, taking into account line breaks ('%N').
		do
			create Result.default_create
		end

	reusable_string_size_tuple: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER, INTEGER]
			-- Reusable tuple for `string_size'.
		once
		end

	string_width (a_string: STRING_GENERAL): INTEGER
			-- Width in pixels of `a_string' in the current font.
		do
		end

	reusable_pango_rectangle_struct: POINTER
			-- PangoRectangle that may be reused to prevent memory allocation, must not be freed
		once
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
		end

feature {NONE} -- Implementation

	update_preferred_faces (a_face: STRING_32)
		do
		end

	update_font_face
		do
		end

feature {EV_FONT_IMP, EV_CHARACTER_FORMAT_IMP, EV_RICH_TEXT_IMP, EV_DRAWABLE_IMP} -- Implementation

	monospace_string: STRING = "monospace"
	serif_string: STRING = "serif"
	courier_string: STRING ="courier"
	sans_string: STRING = "sans"
	lucida_string: STRING = "lucida"
		-- Font string constants

feature {EV_ANY_IMP, EV_DRAWABLE_IMP, EV_APPLICATION_IMP} -- Implementation

	font_description: POINTER
		-- Pointer to the PangoFontDescription struct

feature {NONE} -- Implementation

	app_implementation: EV_APPLICATION_IMP
			-- Return the instance of EV_APPLICATION_IMP.
		once
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_FONT
		-- Interface coupling object for `Current'

	destroy
			-- Flag `Current' as destroyed
		do
		end

	dispose
			-- Clean up `Current'
		do
		end

note
	copyright:	"Copyright (c) 2007, The Eiffel.Mac Team"
end -- class EV_FONT_IMP

