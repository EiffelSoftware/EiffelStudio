note
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

 	old_make (an_interface: attached like interface)
 			-- Create the default font.
		do
			assign_interface (an_interface)
		end

	make
			-- Set up `Current'
		local
			l_app_imp: like app_implementation
		do
			l_app_imp := app_implementation
			font_description := {PANGO}.font_description_new
			create preferred_families
			family := Family_sans
			set_face_name (l_app_imp.default_font_name)
			set_height_in_points (l_app_imp.default_font_point_height_internal)
			set_shape (l_app_imp.default_font_style_internal)
			set_weight (l_app_imp.default_font_weight_internal)
			preferred_families.internal_add_actions.extend (agent update_preferred_faces)
			preferred_families.internal_remove_actions.extend (preferred_families.internal_add_actions.first)
			set_is_initialized (True)
		end

feature {EV_FONTABLE_IMP} -- Implementation

	font_is_default: BOOLEAN
			-- Does `Current' have the characteristics of the default application font?
		local
			l_app_imp: like app_implementation
		do
			l_app_imp := app_implementation
			Result :=
					height_in_points = l_app_imp.default_font_point_height_internal and then
					family = Family_sans and then
					weight = l_app_imp.default_font_weight_internal and then
					shape = l_app_imp.default_font_style_internal and then
					name.is_equal (l_app_imp.default_font_name_internal)
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

	set_family (a_family: INTEGER)
			-- Set `a_family' as preferred font category.
		do
			family := a_family
			update_font_face
		end

	set_face_name (a_face: READABLE_STRING_GENERAL)
			-- Set the face name for current.
		local
			propvalue: EV_GTK_C_STRING
		do
			name := a_face.as_string_32
			propvalue := app_implementation.c_string_from_eiffel_string (a_face)
			{PANGO}.font_description_set_family (font_description, propvalue.item)
			calculate_font_metrics
		end

	set_weight (a_weight: INTEGER)
			-- Set `a_weight' as preferred font thickness.
		do
			weight := a_weight
			{PANGO}.font_description_set_weight (font_description, pango_weight)
			calculate_font_metrics
		end

	set_shape (a_shape: INTEGER)
			-- Set `a_shape' as preferred font slant.
		do
			shape := a_shape
			{PANGO}.font_description_set_style (font_description, pango_style)
			calculate_font_metrics
		end

	set_height (a_height: INTEGER)
			-- Set `a_height' as preferred font size in screen pixels
		do
			height_in_points := app_implementation.point_value_from_pixel_value (a_height)
			height  := a_height
			{PANGO}.font_description_set_size (font_description, height_in_points * {PANGO}.scale)
			calculate_font_metrics
		end

	set_height_in_points (a_height: INTEGER)
			-- Set `a_height' as preferred font size in screen pixels
		do
			height_in_points := a_height
			height := app_implementation.pixel_value_from_point_value (a_height)
			{PANGO}.font_description_set_size (font_description, height_in_points * {PANGO}.scale)
			calculate_font_metrics
		end

	set_values (a_family, a_weight, a_shape, a_height: INTEGER;
		a_preferred_families: like preferred_families)
			-- Set `a_family', `a_weight', `a_shape' `a_height' and
			-- `a_preferred_face' at the same time for speed.
		do
			ignore_font_metric_calculation := True
			Precursor (a_family, a_weight, a_shape, a_height, a_preferred_families)
			ignore_font_metric_calculation := False
			calculate_font_metrics
		end

feature -- Status report

	name: STRING_32
			-- Face name chosen by toolkit.

	ignore_font_metric_calculation: BOOLEAN
			-- Should the font metric calculation be ignored?

	calculate_font_metrics
			-- Calculate metrics for font
		local
			a_str_size: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER, INTEGER]
			a_baseline, a_height: INTEGER
		do
			if not ignore_font_metric_calculation then
				a_str_size := string_size (once "Ag")
				a_baseline := a_str_size.integer_32_item (5)
				a_height := a_str_size.integer_32_item (2)
				ascent := a_baseline
				descent := a_height - ascent
			end
		end

	ascent: INTEGER
			-- Vertical distance from the origin of the drawing operation to the top of the drawn character.

	descent: INTEGER
			-- Vertical distance from the origin of the drawing operation to the bottom of the drawn character.

	width: INTEGER
			-- Character width of current fixed-width font.
		do
			Result := string_width (once "x")
		end

	minimum_width: INTEGER
			-- Width of the smallest character in the font.
		do
			Result := string_width (once "l")
		end

	maximum_width: INTEGER
			-- Width of the biggest character in the font.
		do
			Result := string_width (once "W")
		end

	string_size (a_string: READABLE_STRING_GENERAL): like reusable_string_size_tuple
			-- `Result' is [width, height, left_offset, right_offset] in pixels of `a_string' in the
			-- current font, taking into account line breaks ('%N').
		local
			a_cs: EV_GTK_C_STRING
			a_pango_layout, a_pango_iter,  ink_rect, log_rect: POINTER
			log_x, log_y, log_width, log_height, ink_x, ink_y,  ink_width, ink_height, a_width, a_height, left_off, right_off, top_off, bottom_off: INTEGER
			a_baseline: INTEGER
			l_app_imp: like app_implementation
		do

			l_app_imp := app_implementation
			a_cs := l_app_imp.c_string_from_eiffel_string (a_string)

			a_pango_layout := l_app_imp.pango_layout
			{PANGO}.layout_set_text (a_pango_layout, a_cs.item, a_cs.string_length)
			{PANGO}.layout_set_font_description (a_pango_layout, font_description)

			ink_rect := {PANGO}.new_rectangle_struct
			log_rect := reusable_pango_rectangle_struct
			{PANGO}.layout_get_pixel_extents (a_pango_layout, ink_rect, log_rect)

			a_pango_iter := l_app_imp.pango_iter
			a_baseline := {PANGO}.layout_iter_get_baseline (a_pango_iter) // {PANGO}.scale
			{PANGO}.layout_iter_free (a_pango_iter)

			log_x := {PANGO}.rectangle_struct_x (log_rect)
			log_y := {PANGO}.rectangle_struct_y (log_rect)
			log_width := {PANGO}.rectangle_struct_width (log_rect)
			log_height := {PANGO}.rectangle_struct_height (log_rect)

			ink_x := {PANGO}.rectangle_struct_x (ink_rect)
			ink_y := {PANGO}.rectangle_struct_y (ink_rect)
			ink_width := {PANGO}.rectangle_struct_width (ink_rect)
			ink_height := {PANGO}.rectangle_struct_height (ink_rect)

			a_width := log_width
			a_height := log_height

			if ink_width > 0 then
				left_off := ink_x
				right_off := left_off + ink_width - log_width
			end

			if ink_height > 0 then
				top_off := ink_y
				bottom_off := top_off + ink_height - log_height
			end

			Result := reusable_string_size_tuple
			Result.put_integer (a_width.max (1), 1)
			Result.put_integer (a_height.max (1), 2)
			Result.put_integer (left_off, 3)
			Result.put_integer (right_off, 4)
			Result.put_integer (a_baseline, 5)
			Result.put_integer (top_off, 6)
			Result.put_integer (bottom_off, 7)

			ink_rect.memory_free
			{PANGO}.layout_set_font_description (a_pango_layout, default_pointer)
		end

	reusable_string_size_tuple: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER, INTEGER, INTEGER, INTEGER]
			-- Reusable tuple for `string_size'.
		once
			create Result
		end

	string_width (a_string: READABLE_STRING_GENERAL): INTEGER
			-- Width in pixels of `a_string' in the current font.
		local
			a_pango_layout: POINTER
			a_cs: EV_GTK_C_STRING
			temp_height: INTEGER
			l_app_imp: like App_implementation
		do
			if a_string.count > 0 then
				l_app_imp := App_implementation
				a_cs := l_app_imp.c_string_from_eiffel_string (a_string)
				a_pango_layout := l_app_imp.pango_layout
				{PANGO}.layout_set_text (a_pango_layout, a_cs.item, a_cs.string_length)
				{PANGO}.layout_set_font_description (a_pango_layout, font_description)
				{PANGO}.layout_get_pixel_size (a_pango_layout, $Result, $temp_height)
				{PANGO}.layout_set_font_description (a_pango_layout, default_pointer)
			end
		end

	reusable_pango_rectangle_struct: POINTER
			-- PangoRectangle that may be reused to prevent memory allocation, must not be freed
		once
			Result := {PANGO}.new_rectangle_struct
		end

	horizontal_resolution: INTEGER
			-- Horizontal resolution of screen for which the font is designed.
		do
			Result := 75
		end

	vertical_resolution: INTEGER
			-- Vertical resolution of screen for which the font is designed.
		do
			Result := 75
		end

	is_proportional: BOOLEAN
			-- Can characters in the font have different sizes?
		do
			Result := True
		end

feature {NONE} -- Implementation

	update_preferred_faces (a_face: STRING_32)
		do
			update_font_face
		end

	update_font_face
		do
			set_face_name (pango_family_string)
			calculate_font_metrics
		end

feature {EV_FONT_IMP, EV_CHARACTER_FORMAT_IMP, EV_RICH_TEXT_IMP, EV_DRAWABLE_IMP} -- Implementation

	pango_family_string: STRING_32
			-- Get standard string to represent family.
		local
			l_preferred_families: like preferred_families
			l_font_names_on_system_as_lower: ARRAYED_LIST [STRING_32]
			l_item_string: STRING_32
			i, l_preferred_families_count: INTEGER
			l_result: detachable STRING_32
		do
			l_preferred_families := preferred_families

			if not l_preferred_families.is_empty then
				from
					l_font_names_on_system_as_lower := app_implementation.font_names_on_system_as_lower
					l_preferred_families_count := l_preferred_families.count
					i := 1
				until
					l_result /= Void or else i > l_preferred_families_count
				loop
					l_item_string := l_preferred_families [i]
					if l_item_string /= Void and then l_font_names_on_system_as_lower.has (l_item_string.as_lower) then
						l_result := l_item_string.twin
					end
					i := i + 1
				end
			end
			if l_result = Void then
				-- We have not found a preferred family
				if font_is_default then
					-- If the use has made no setting changes we use default gtk
					Result := app_implementation.default_font_name.twin
				else
					create Result.make (10)
					inspect family
					when Family_screen then
						Result.append (monospace_string)
					when Family_roman then
						Result.append (serif_string)
					when Family_typewriter then
						Result.append (courier_string)
					when Family_sans then
						Result.append (sans_string)
					when Family_modern then
						Result.append (lucida_string)
					end
				end
			else
				Result := l_result
			end
		end

	monospace_string: STRING_32 = "monospace"
	serif_string: STRING_32 = "serif"
	courier_string: STRING_32 ="courier"
	sans_string: STRING_32 = "sans"
	lucida_string: STRING_32 = "lucida"
		-- Font string constants

	pango_style: INTEGER
			-- Pango Style constant of `Current'
		do
			if shape = shape_italic then
				Result := 2
			else
				Result := 0
			end
		end

	pango_weight: INTEGER
			-- Pango Weight of `Current'
		do
			inspect
				weight
			when
				{EV_FONT_CONSTANTS}.weight_bold
			then
				Result := pango_weight_bold
			when
				{EV_FONT_CONSTANTS}.weight_regular
			then
				Result := pango_weight_normal
			when
				{EV_FONT_CONSTANTS}.weight_thin
			then
				Result := pango_weight_ultra_light
			when
				{EV_FONT_CONSTANTS}.weight_black
			then
				Result := pango_weight_heavy
			else
				Result := pango_weight_normal
			end
		end

	set_weight_from_pango_weight (a_pango_weight: INTEGER)
			-- Set `weight' from Pango weight value `a_pango_weight'.
		do
			if a_pango_weight <= pango_weight_ultra_light then
				set_weight ({EV_FONT_CONSTANTS}.weight_thin)
			elseif a_pango_weight <= pango_weight_normal then
				set_weight ({EV_FONT_CONSTANTS}.weight_regular)
			elseif a_pango_weight <= pango_weight_bold then
				set_weight ({EV_FONT_CONSTANTS}.weight_bold)
			else
				set_weight ({EV_FONT_CONSTANTS}.weight_black)
			end
		end

feature {EV_ANY_IMP, EV_DRAWABLE_IMP, EV_APPLICATION_IMP, EV_FONTABLE_IMP} -- Implementation

	font_description: POINTER
		-- Pointer to the PangoFontDescription struct

feature {EV_ANY_I} -- Implementation

	frozen pango_weight_ultra_light: INTEGER = 200
	frozen pango_weight_light: INTEGER = 300
	frozen pango_weight_normal: INTEGER = 400
	frozen pango_weight_bold: INTEGER = 700
	frozen pango_weight_ultrabold: INTEGER = 800
	frozen pango_weight_heavy: INTEGER = 900
		-- Pango font weight constants

feature {NONE} -- Implementation

	app_implementation: EV_APPLICATION_IMP
			-- Return the instance of EV_APPLICATION_IMP.
		local
			l_result: detachable EV_APPLICATION_IMP
		once
			l_result ?= (create {EV_ENVIRONMENT}).implementation.application_i
			check l_result /= Void then end
			Result := l_result
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_FONT note option: stable attribute end
		-- Interface coupling object for `Current'

feature {EV_ANY_I} -- Implementation

	destroy
			-- Flag `Current' as destroyed
		do
			set_is_destroyed (True)
		end

	dispose
			-- Clean up `Current'
		do
			{PANGO}.font_description_set_family (font_description, default_pointer)
			{PANGO}.font_description_free (font_description)
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_FONT_IMP











