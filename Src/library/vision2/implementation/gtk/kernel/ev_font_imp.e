indexing
	description: "Eiffel Vision font. GTK implementation."
	status: "See notice at end of class"
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
		do	
			font_description := {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_new
			create preferred_families
			family := Family_sans
			set_face_name (app_implementation.default_font_name)
			set_height_in_points (App_implementation.default_font_point_height_internal)
			set_shape (App_implementation.default_font_style_internal)
			set_weight (App_implementation.default_font_weight_internal)
			preferred_families.internal_add_actions.extend (agent update_preferred_faces)
			preferred_families.internal_remove_actions.extend (preferred_families.internal_add_actions.first)
			set_is_initialized (True)
		end

feature {EV_FONTABLE_IMP} -- Implementation

	font_is_default: BOOLEAN is
			-- Does `Current' have the characteristics of the default application font?
		do
			Result := 
					family = Family_sans and then
					weight = app_implementation.default_font_weight_internal and then
					shape = app_implementation.default_font_style_internal and then
					name.is_equal (app_implementation.default_font_name_internal) and then
					height_in_points = app_implementation.default_font_point_height_internal
		end

feature -- Access

	family: INTEGER
			-- Preferred font category.

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
			family := a_family
			update_font_face
		end
	
	set_face_name (a_face: STRING) is
			-- Set the face name for current.
		local
			propvalue: EV_GTK_C_STRING
		do
			name := a_face
			--create propvalue.make (a_face)
			propvalue := app_implementation.c_string_from_eiffel_string (a_face)
				-- Change this code back when we get UTF16 support
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_set_family (font_description, propvalue.item)	
			calculate_font_metrics
		end

	set_weight (a_weight: INTEGER) is
			-- Set `a_weight' as preferred font thickness.
		do
			weight := a_weight
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_set_weight (font_description, pango_weight)
			calculate_font_metrics
		end

	set_shape (a_shape: INTEGER) is
			-- Set `a_shape' as preferred font slant.
		do
			shape := a_shape
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_set_style (font_description, pango_style)
			calculate_font_metrics
		end

	set_height (a_height: INTEGER) is
			-- Set `a_height' as preferred font size in screen pixels
		do
			height_in_points := app_implementation.point_value_from_pixel_value (a_height)
			height  := a_height
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_set_size (font_description, height_in_points * {EV_GTK_DEPENDENT_EXTERNALS}.pango_scale)
			calculate_font_metrics
		end

	set_height_in_points (a_height: INTEGER) is
			-- Set `a_height' as preferred font size in screen pixels
		do
			height_in_points := a_height
			height := app_implementation.pixel_value_from_point_value (a_height)
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_set_size (font_description, height_in_points * {EV_GTK_DEPENDENT_EXTERNALS}.pango_scale)
			calculate_font_metrics
		end

	set_values (a_family, a_weight, a_shape, a_height: INTEGER;
		a_preferred_families: like preferred_families) is
			-- Set `a_family', `a_weight', `a_shape' `a_height' and
			-- `a_preferred_face' at the same time for speed.
		local
			a_agent: PROCEDURE [EV_FONT_IMP, TUPLE [STRING]]
		do
			ignore_font_metric_calculation := True
			a_agent := agent update_preferred_faces
			preferred_families.add_actions.wipe_out
			preferred_families.remove_actions.wipe_out
			preferred_families := a_preferred_families
			preferred_families.internal_add_actions.extend (a_agent)
			preferred_families.internal_remove_actions.extend (a_agent)
			set_family (a_family)
			set_weight (a_weight)
			set_shape (a_shape)
			set_height (a_height)
			ignore_font_metric_calculation := False
			calculate_font_metrics
		end

feature -- Status report

	name: STRING
			-- Face name chosen by toolkit.

	ignore_font_metric_calculation: BOOLEAN
			-- Should the font metric calculation be ignored?

	calculate_font_metrics is
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

	width: INTEGER is
			-- Character width of current fixed-width font.
		do
			Result := string_width (once "x")
		end

	minimum_width: INTEGER is
			-- Width of the smallest character in the font.
		do
			Result := string_width (once "l")
		end

	maximum_width: INTEGER is
			-- Width of the biggest character in the font.
		do
			Result := string_width (once "W")
		end

	string_size (a_string: STRING): TUPLE [INTEGER, INTEGER, INTEGER, INTEGER, INTEGER] is
			-- `Result' is [width, height, left_offset, right_offset] in pixels of `a_string' in the
			-- current font, taking into account line breaks ('%N').
		local
			a_cs: EV_GTK_C_STRING
			a_pango_layout, a_pango_iter,  ink_rect, log_rect: POINTER
			log_x, log_y, log_width, log_height, ink_x, ink_y,  ink_width, ink_height, a_width, a_height, left_off, right_off: INTEGER
			a_baseline: INTEGER
			l_app_imp: like app_implementation
		do
				
			l_app_imp := app_implementation
			a_cs := l_app_imp.c_string_from_eiffel_string (a_string)
			
			a_pango_layout := l_app_imp.pango_layout
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_set_text (a_pango_layout, a_cs.item, a_cs.string_length)
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_set_font_description (a_pango_layout, font_description)
			
			ink_rect := {EV_GTK_DEPENDENT_EXTERNALS}.c_pango_rectangle_struct_allocate
			log_rect := reusable_pango_rectangle_struct
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_get_pixel_extents (a_pango_layout, ink_rect, log_rect)
			
			a_pango_iter := l_app_imp.pango_iter
			a_baseline := {EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_iter_get_baseline (a_pango_iter) // {EV_GTK_DEPENDENT_EXTERNALS}.pango_scale
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_iter_free (a_pango_iter)
			
			log_x := {EV_GTK_DEPENDENT_EXTERNALS}.pango_rectangle_struct_x (log_rect)
			log_y := {EV_GTK_DEPENDENT_EXTERNALS}.pango_rectangle_struct_y (log_rect)
			log_width := {EV_GTK_DEPENDENT_EXTERNALS}.pango_rectangle_struct_width (log_rect)
			log_height := {EV_GTK_DEPENDENT_EXTERNALS}.pango_rectangle_struct_height (log_rect)
			
			ink_x := {EV_GTK_DEPENDENT_EXTERNALS}.pango_rectangle_struct_x (ink_rect)
			ink_y := {EV_GTK_DEPENDENT_EXTERNALS}.pango_rectangle_struct_y (ink_rect)
			ink_width := {EV_GTK_DEPENDENT_EXTERNALS}.pango_rectangle_struct_width (ink_rect)
			ink_height := {EV_GTK_DEPENDENT_EXTERNALS}.pango_rectangle_struct_height (ink_rect)
			
			a_width := log_width
			a_height := log_height
			
			if ink_width > 0 then
				left_off := ink_x
				right_off := ink_width - log_width
			end
			
			Result := reusable_string_size_tuple
			Result.put_integer (a_width.max (1), 1)
			Result.put_integer (a_height.max (1), 2)
			Result.put_integer (left_off, 3)
			Result.put_integer (right_off, 4)
			Result.put_integer (a_baseline, 5)

			ink_rect.memory_free
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_set_font_description (a_pango_layout, default_pointer)
		end

	reusable_string_size_tuple: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER, INTEGER] is
			-- Reusable tuple for `string_size'.
		once
			create Result
		end

	string_width (a_string: STRING): INTEGER is
			-- Width in pixels of `a_string' in the current font.
		local
			a_pango_layout: POINTER
			a_cs: EV_GTK_C_STRING
			temp_height: INTEGER
			l_app_imp: like App_implementation
		do
			l_app_imp := App_implementation
			a_cs := l_app_imp.c_string_from_eiffel_string (a_string)
			a_pango_layout := l_app_imp.pango_layout
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_set_text (a_pango_layout, a_cs.item, a_cs.string_length)
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_set_font_description (a_pango_layout, font_description)
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_get_pixel_size (a_pango_layout, $Result, $temp_height)
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_set_font_description (a_pango_layout, default_pointer)
		end

	reusable_pango_rectangle_struct: POINTER is
			-- PangoRectangle that may be reused to prevent memory allocation, must not be freed
		once
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.c_pango_rectangle_struct_allocate
		end

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font is designed.
		do
			Result := 75
		end

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font is designed.
		do
			Result := 75
		end

	is_proportional: BOOLEAN is
			-- Can characters in the font have different sizes?
		do
			Result := True
		end
 
feature {NONE} -- Implementation

	update_preferred_faces (a_face: STRING) is
		do
			update_font_face
		end
		
	update_font_face is
		do
			set_face_name (pango_family_string)
			calculate_font_metrics
		end

feature {EV_FONT_IMP, EV_CHARACTER_FORMAT_IMP, EV_RICH_TEXT_IMP, EV_DRAWABLE_IMP} -- Implementation
		
	pango_family_string: STRING is
			-- Get standard string to represent family.
		do
			if not preferred_families.is_empty then
				from
					preferred_families.start
				until
					Result /= Void or else preferred_families.off
				loop
					if preferred_families.item /= Void and then app_implementation.font_names_on_system_as_lower.has (preferred_families.item.as_lower) then
						Result := preferred_families.item.twin
					end
					preferred_families.forth
				end				
			end
			if Result = Void then
				-- We have not found a preferred family
				if font_is_default then
					-- If the use has made no setting changes we use default gtk
					Result := app_implementation.default_font_name
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
			end
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
			if shape = shape_italic then
				Result := 2
			else
				Result := 0
			end
		end

	pango_weight: INTEGER is
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

	set_weight_from_pango_weight (a_pango_weight: INTEGER) is
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
			Result ?= (create {EV_ENVIRONMENT}).application.implementation
		end		

feature {EV_ANY_I} -- Implementation

	interface: EV_FONT
		-- Interface coupling object for `Current'
			
	destroy is
			-- Flag `Current' as destroyed
		do
			set_is_destroyed (True)
		end

	dispose is
			-- Clean up `Current'
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_set_family (font_description, default_pointer)	
			{EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_free (font_description)
		end

end -- class EV_FONT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

