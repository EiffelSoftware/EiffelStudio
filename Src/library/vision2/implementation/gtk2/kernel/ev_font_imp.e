indexing
	description: "Eiffel Vision font. GTK implementation."
	note:
		"Does not inherit from EV_ANY_IMP because c_object is not a %N%
		%GTK object. (type is PangoFontDescription)"
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
			set_values
		end

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
			font_description := feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_new
			create preferred_families
			family := Family_sans
			set_face_name (app_implementation.default_font_name)
			set_height (App_implementation.default_font_size_internal)
			set_shape (App_implementation.default_font_style_internal)
			set_weight (App_implementation.default_font_weight_internal)
			preferred_families.add_actions.extend (agent update_preferred_faces)
			preferred_families.remove_actions.extend (preferred_families.add_actions.first)
			is_initialized := True
		end

	font_is_default: BOOLEAN is
			-- Does `Current' have the characteristics of the default application font?
		do
			Result := 
					family = Family_sans and then
					weight = app_implementation.default_font_weight_internal and then
					shape = app_implementation.default_font_style_internal and then
					name.is_equal (app_implementation.default_font_name_internal) and then
					height = app_implementation.default_font_size_internal
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
			create propvalue.make (a_face)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_set_family (font_description, propvalue.item)			
		end

	set_weight (a_weight: INTEGER) is
			-- Set `a_weight' as preferred font thickness.
		do
			weight := a_weight
			feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_set_weight (font_description, pango_weight)
		end

	set_shape (a_shape: INTEGER) is
			-- Set `a_shape' as preferred font slant.
		do
			shape := a_shape
			feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_set_style (font_description, pango_style)
		end

	set_height (a_height: INTEGER) is
			-- Set `a_height' as preferred font size in screen pixels
		do
			height := a_height
			feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_set_size (font_description, pango_height)
		end

	set_values (a_family, a_weight, a_shape, a_height: INTEGER;
		a_preferred_families: like preferred_families) is
			-- Set `a_family', `a_weight', `a_shape' `a_height' and
			-- `a_preferred_face' at the same time for speed.
		do
			preferred_families.add_actions.wipe_out
			preferred_families.remove_actions.wipe_out
			preferred_families := a_preferred_families
			preferred_families.add_actions.extend (agent update_preferred_faces)
			preferred_families.remove_actions.extend (agent update_preferred_faces)
			set_family (a_family)
			set_weight (a_weight)
			set_shape (a_shape)
			set_height (a_height)
		end

feature -- Status report

	name: STRING
			-- Face name chosen by toolkit.

	ascent: INTEGER is
			-- Vertical distance from the origin of the drawing
			-- operation to the top of the drawn character. 
		local
			a_cs: EV_GTK_C_STRING
			pango_layout, pango_iter: POINTER
		do
			create a_cs.make ("A")
			pango_layout := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_create_pango_layout (app_implementation.default_gtk_window, a_cs.item)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_set_font_description (pango_layout, font_description)
			pango_iter := feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_get_iter (pango_layout)
			Result := feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_iter_get_baseline (pango_iter) // feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_scale
			feature {EV_GTK_DEPENDENT_EXTERNALS}.object_unref (pango_layout)
		end

	descent: INTEGER is
			-- Vertical distance from the origin of the drawing
			-- operation to the bottom of the drawn character. 
		local
			a_cs: EV_GTK_C_STRING
			pango_layout, pango_iter: POINTER
			a_width, a_height: INTEGER
		do
			create a_cs.make ("A")
			pango_layout := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_create_pango_layout (app_implementation.default_gtk_window, a_cs.item)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_set_font_description (pango_layout, font_description)
			pango_iter := feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_get_iter (pango_layout)
			Result := feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_iter_get_baseline (pango_iter) // feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_scale
			feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_get_pixel_size (pango_layout, $a_width, $a_height)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.object_unref (pango_layout)
			Result := a_height - Result
		end

	width: INTEGER is
			-- Character width of current fixed-width font.
		do
			Result := string_width ("x")
		end

	minimum_width: INTEGER is
			-- Width of the smallest character in the font.
		do
			Result := string_width ("l")
		end

	maximum_width: INTEGER is
			-- Width of the biggest character in the font.
		do
			Result := string_width ("W")
		end

	string_width (a_string: STRING): INTEGER is
			-- Width in pixels of `a_string' in the current font.
		local
			a_cs: EV_GTK_C_STRING
			pango_layout: POINTER
			a_width, a_height: INTEGER
		do
			create a_cs.make (a_string)
			pango_layout := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_create_pango_layout (app_implementation.default_gtk_window, a_cs.item)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_set_font_description (pango_layout, font_description)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_get_pixel_size (pango_layout, $a_width, $a_height)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.object_unref (pango_layout)
			Result := a_width
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
		end

feature {EV_FONT_IMP, EV_CHARACTER_FORMAT_IMP, EV_RICH_TEXT_IMP, EV_DRAWABLE_IMP} -- Implementation
		
	font_description_from_values: POINTER is
			-- PangoFontDescription from set values
		do
			Result := feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_copy (font_description)
		end
		
	pango_family_string: STRING is
			-- Get standard string to represent family.
		do
			from
				preferred_families.start
			until
				Result /= Void or else preferred_families.after
			loop
				if app_implementation.font_names_on_system_as_lower.has (preferred_families.item.as_lower) then
					Result := preferred_families.item.twin
				end
				preferred_families.forth
			end
			if Result = Void then
				-- We have not found a preferred family
				if font_is_default then
					-- If the use has made no setting changes we use default gtk
					Result := app_implementation.default_font_name
				else
					create Result.make (0)
					inspect family
					when Family_screen then
						Result.append ("monospace")
					when Family_roman then
						Result.append ("serif")
					when Family_typewriter then
						Result.append ("courier")
					when Family_sans then
						Result.append ("sans")
					when Family_modern then
						Result.append ("lucida")
					end
				end
			end
		end

	pango_height: INTEGER is
			-- Font height in Pango Units
		do
			Result := height * feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_scale
		end

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
				feature {EV_FONT_CONSTANTS}.weight_bold
			then
				Result := pango_weight_bold
			when
				feature {EV_FONT_CONSTANTS}.weight_regular
			then
				Result := pango_weight_normal
			when
				feature {EV_FONT_CONSTANTS}.weight_thin
			then
				Result := pango_weight_ultra_light
			when
				feature {EV_FONT_CONSTANTS}.weight_black
			then
				Result := pango_weight_heavy
			end
		end

	set_weight_from_pango_weight (a_pango_weight: INTEGER) is
			-- Set `weight' from Pango weight value `a_pango_weight'.
		do
			if a_pango_weight <= pango_weight_ultra_light then
				set_weight (feature {EV_FONT_CONSTANTS}.weight_thin)
			elseif a_pango_weight <= pango_weight_normal then
				set_weight (feature {EV_FONT_CONSTANTS}.weight_regular)
			elseif a_pango_weight <= pango_weight_bold then
				set_weight (feature {EV_FONT_CONSTANTS}.weight_bold)
			else
				set_weight (feature {EV_FONT_CONSTANTS}.weight_black)
			end
		end

feature {EV_ANY_IMP, EV_DRAWABLE_IMP, EV_APPLICATION_IMP} -- Implementation
		
	font_description: POINTER
		-- Pointer to the PangoFontDescription struct


feature {NONE} -- Implementation

	pango_weight_ultra_light: INTEGER is 200
	pango_weight_light: INTEGER is 300
	pango_weight_normal: INTEGER is 400
	pango_weight_bold: INTEGER is 700
	pango_weight_ultrabold: INTEGER is 800
	pango_weight_heavy: INTEGER is 900
		-- Pango font weight constants
			
	app_implementation: EV_APPLICATION_IMP is
			-- Return the instance of EV_APPLICATION_IMP.
		once
			Result ?= (create {EV_ENVIRONMENT}).application.implementation
		end		

feature {EV_ANY_I} -- Implementation

	interface: EV_FONT
			
	destroy is
		do
			is_destroyed := True
		end
	
end -- class EV_FONT_IMP


--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

