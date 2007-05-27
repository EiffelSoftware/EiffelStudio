indexing
	description: "Eiffel Vision font. GTK implementation."
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

 	make (an_interface: like interface) is
 			-- Create the default font.
		do
			base_make (an_interface)
		end


initialize is
			-- Set up `Current'
		local
			l_app_imp: like app_implementation
		do
			--l_app_imp := app_implementation
			create preferred_families
			family := Family_sans
			--set_face_name (l_app_imp.default_font_name)
			--set_height_in_points (l_app_imp.default_font_point_height_internal)
			--set_shape (l_app_imp.default_font_style_internal)
			--set_weight (l_app_imp.default_font_weight_internal)
			--preferred_families.internal_add_actions.extend (agent update_preferred_faces)
			--preferred_families.internal_remove_actions.extend (preferred_families.internal_add_actions.first)
			set_is_initialized (True)
		end

feature {EV_FONTABLE_IMP} -- Implementation

	font_is_default: BOOLEAN is
			-- Does `Current' have the characteristics of the default application font?
		do
		end

feature -- Access

	family: INTEGER
			-- Preferred font category.

	char_set: INTEGER
			-- Charset
			-- This is not meaningful on GTK.

	weight: INTEGER
			-- Preferred font thickness.

	shape: INTEGER
			-- Preferred font slant.

	height: INTEGER
			-- Preferred font height measured in screen pixels.

	height_in_points: INTEGER
			-- Preferred font height measured in points.

feature -- Element change

	set_family (a_family: INTEGER) is
			-- Set `a_family' as preferred font category.
		do

		end

	set_face_name (a_face: STRING_GENERAL) is
			-- Set the face name for current.
		do

		end

	set_weight (a_weight: INTEGER) is
			-- Set `a_weight' as preferred font thickness.
		do
			weight := a_weight
		end

	set_shape (a_shape: INTEGER) is
			-- Set `a_shape' as preferred font slant.
		do
			shape := a_shape
		end

	set_height (a_height: INTEGER) is
			-- Set `a_height' as preferred font size in screen pixels
		do
			height := a_height
		end

	set_height_in_points (a_height: INTEGER) is
			-- Set `a_height' as preferred font size in screen pixels
		do

		end

	set_values (a_family, a_weight, a_shape, a_height: INTEGER;
		a_preferred_families: like preferred_families) is
			-- Set `a_family', `a_weight', `a_shape' `a_height' and
			-- `a_preferred_face' at the same time for speed.
		do
		end

feature -- Status report

	name: STRING_32
			-- Face name chosen by toolkit.

	ignore_font_metric_calculation: BOOLEAN
			-- Should the font metric calculation be ignored?

	calculate_font_metrics is
			-- Calculate metrics for font
		do
		end

	ascent: INTEGER
			-- Vertical distance from the origin of the drawing operation to the top of the drawn character.

	descent: INTEGER
			-- Vertical distance from the origin of the drawing operation to the bottom of the drawn character.

	width: INTEGER is
			-- Character width of current fixed-width font.
		do
		end

	minimum_width: INTEGER is
			-- Width of the smallest character in the font.
		do
		end

	maximum_width: INTEGER is
			-- Width of the biggest character in the font.
		do
		end

	string_size (a_string: STRING_GENERAL): TUPLE [INTEGER, INTEGER, INTEGER, INTEGER, INTEGER] is
			-- `Result' is [width, height, left_offset, right_offset] in pixels of `a_string' in the
			-- current font, taking into account line breaks ('%N').
		do
			create Result.default_create
		end

	reusable_string_size_tuple: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER, INTEGER] is
			-- Reusable tuple for `string_size'.
		once
		end

	string_width (a_string: STRING_GENERAL): INTEGER is
			-- Width in pixels of `a_string' in the current font.
		do
		end

	reusable_pango_rectangle_struct: POINTER is
			-- PangoRectangle that may be reused to prevent memory allocation, must not be freed
		once
		end

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font is designed.
		do
		end

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font is designed.
		do
		end

	is_proportional: BOOLEAN is
			-- Can characters in the font have different sizes?
		do
		end

feature {NONE} -- Implementation

	update_preferred_faces (a_face: STRING_32) is
		do
		end

	update_font_face is
		do
		end

feature {EV_FONT_IMP, EV_CHARACTER_FORMAT_IMP, EV_RICH_TEXT_IMP, EV_DRAWABLE_IMP} -- Implementation

	pango_family_string: STRING_32 is
			-- Get standard string to represent family.
		do
		end

	monospace_string: STRING is "monospace"
	serif_string: STRING is "serif"
	courier_string: STRING is"courier"
	sans_string: STRING is "sans"
	lucida_string: STRING is "lucida"
		-- Font string constants

	pango_style: INTEGER is
			-- Pango Style constant of `Current'
		do
		end

	pango_weight: INTEGER is
			-- Pango Weight of `Current'
		do
		end

	set_weight_from_pango_weight (a_pango_weight: INTEGER) is
			-- Set `weight' from Pango weight value `a_pango_weight'.
		do
		end

feature {EV_ANY_IMP, EV_DRAWABLE_IMP, EV_APPLICATION_IMP} -- Implementation

	font_description: POINTER
		-- Pointer to the PangoFontDescription struct

feature {EV_ANY_I} -- Implementation

	frozen pango_weight_ultra_light: INTEGER is 200
	frozen pango_weight_light: INTEGER is 300
	frozen pango_weight_normal: INTEGER is 400
	frozen pango_weight_bold: INTEGER is 700
	frozen pango_weight_ultrabold: INTEGER is 800
	frozen pango_weight_heavy: INTEGER is 900
		-- Pango font weight constants

feature {NONE} -- Implementation

	app_implementation: EV_APPLICATION_IMP is
			-- Return the instance of EV_APPLICATION_IMP.
		once
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_FONT
		-- Interface coupling object for `Current'

	destroy is
			-- Flag `Current' as destroyed
		do
		end

	dispose is
			-- Clean up `Current'
		do
		end

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




end -- class EV_FONT_IMP

