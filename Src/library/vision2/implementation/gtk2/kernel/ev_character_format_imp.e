indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHARACTER_FORMAT_IMP

inherit
	EV_CHARACTER_FORMAT_I
		undefine
			copy, is_equal
		end
	
	IDENTIFIED

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create character format 
		do
			base_make (an_interface)
		end
	
	initialize is
			-- Do nothing
		do
			is_initialized := True
		end
		
feature -- Access

	font: EV_FONT is
			-- Font of the current format
		do
			if internal_font_imp /= Void then
				Result := internal_font_imp.interface
			else
				create Result
			end
		end
	
	color: EV_COLOR is
			-- Color of the current format
		do
			if internal_color_imp /= Void then
				Result := internal_color_imp.interface
			else
				Result := (create {EV_STOCK_COLORS}).black
			end
		end

	background_color: EV_COLOR is
			-- Background Color of the current format
		do
			if internal_background_color_imp /= Void then
				Result := internal_background_color_imp.interface
			else
				Result := (create {EV_STOCK_COLORS}).white
			end
		end
		
	effects: EV_CHARACTER_FORMAT_EFFECTS is
			-- Character format effects applicable to `font'
		do
			if internal_effects /= Void then
				Result := internal_effects.twin
			else
				create Result
			end
		end

feature -- Status setting
		
	set_font (a_font: EV_FONT) is
			-- Make `value' the new font
		do
			internal_font_imp ?= a_font.implementation
		end

	set_color (a_color: EV_COLOR) is
			-- Make `value' the new color
		do
			internal_color_imp ?= a_color.implementation
		end

	set_background_color (a_color: EV_COLOR) is
			-- Make `value' the new color
		do
			internal_background_color_imp ?= a_color.implementation
		end
		
	set_effects (an_effect: EV_CHARACTER_FORMAT_EFFECTS) is
			-- Make `an_effect' the new `effects'
		do
			internal_effects := an_effect.twin
		end

feature {EV_RICH_TEXT_IMP} -- Implementation

	new_text_tag: POINTER is
			-- Create a new text tag based on state of `Current'
		do
			Result := new_text_tag_from_applicable_attributes (dummy_character_format_range_information)
		end
		
	dummy_character_format_range_information: EV_CHARACTER_FORMAT_RANGE_INFORMATION is
			-- Used for creating a fully set GtkTextTag
		local
			a: INTEGER
		once
			create Result.make_with_flags (
				feature {EV_CHARACTER_FORMAT_CONSTANTS}.font_family
				| feature {EV_CHARACTER_FORMAT_CONSTANTS}.font_weight
				| feature {EV_CHARACTER_FORMAT_CONSTANTS}.font_shape
				| feature {EV_CHARACTER_FORMAT_CONSTANTS}.font_height
				| feature {EV_CHARACTER_FORMAT_CONSTANTS}.color
				| feature {EV_CHARACTER_FORMAT_CONSTANTS}.background_color
				| feature {EV_CHARACTER_FORMAT_CONSTANTS}.effects_striked_out
				| feature {EV_CHARACTER_FORMAT_CONSTANTS}.effects_underlined
				| feature {EV_CHARACTER_FORMAT_CONSTANTS}.effects_double_underlined
				| feature {EV_CHARACTER_FORMAT_CONSTANTS}.effects_vertical_offset
			)
		end

	new_text_tag_from_applicable_attributes (applicable_attributes: EV_CHARACTER_FORMAT_RANGE_INFORMATION): POINTER is
			-- Create a new text tag based on state of `Current'
		local
			color_struct: POINTER
			font_desc: POINTER
			propname, propvalue: EV_GTK_C_STRING
			a_font_imp: EV_FONT_IMP
			a_color_imp: EV_COLOR_IMP
			a_effects: EV_CHARACTER_FORMAT_EFFECTS
		do
			
			Result := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_tag_new (default_pointer)
			
			if (applicable_attributes.font_family or else applicable_attributes.font_height or else applicable_attributes.font_shape or else applicable_attributes.font_weight) then
				a_font_imp ?= font.implementation
				if applicable_attributes.font_family then
					create propname.make ("family")
					create propvalue.make (a_font_imp.pango_family_string)
					feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_string (Result, propname.item, propvalue.item)					
				end
				if applicable_attributes.font_height then
					create propname.make ("size")
					feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_integer (Result, propname.item, a_font_imp.pango_height)	
				end
				if applicable_attributes.font_shape then
					create propname.make ("style")
					feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_integer (Result, propname.item, a_font_imp.pango_style)		
				end
				if applicable_attributes.font_weight then
					create propname.make ("weight")
					feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_integer (Result, propname.item, a_font_imp.pango_weight)					
				end
			end

			if applicable_attributes.color then
				a_color_imp ?= color.implementation
				create propname.make ("foreground-gdk")
				color_struct := feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color_struct, a_color_imp.red_16_bit)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color_struct, a_color_imp.green_16_bit)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color_struct, a_color_imp.blue_16_bit)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_pointer (Result, propname.item, color_struct, default_pointer)
				color_struct.memory_free				
			end

			if applicable_attributes.background_color then
				a_color_imp ?= background_color.implementation
				create propname.make ("background-gdk")
				color_struct := feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color_struct, a_color_imp.red_16_bit)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color_struct, a_color_imp.green_16_bit)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color_struct, a_color_imp.blue_16_bit)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_pointer (Result, propname.item, color_struct, default_pointer)
				color_struct.memory_free				
			end

			if (applicable_attributes.effects_striked_out or else applicable_attributes.effects_underlined or else applicable_attributes.effects_vertical_offset) then
				a_effects := effects
				if applicable_attributes.effects_striked_out then
					create propname.make ("strikethrough")
					feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_boolean (Result, propname.item, a_effects.is_striked_out)
				end
				if applicable_attributes.effects_underlined then
					create propname.make ("underline")
					feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_boolean (Result, propname.item, a_effects.is_underlined)
				end
				if applicable_attributes.effects_vertical_offset then
					create propname.make ("rise")
					feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_integer (Result, propname.item, a_effects.vertical_offset)
				end
			end
		end


feature {NONE} -- Implementation

	internal_font_imp: EV_FONT_IMP
			-- Font of the current format
	
	internal_color_imp: EV_COLOR_IMP
			-- Color of the current format
		
	internal_background_color_imp: EV_COLOR_IMP
			-- Background Color of the current format
	
	internal_effects: EV_CHARACTER_FORMAT_EFFECTS
			-- Character format effects applicable to `font'

	destroy is
			-- Clean up
		do
			internal_font_imp := Void
			internal_color_imp := Void
			internal_background_color_imp := Void
			internal_effects := Void
		end

end -- class EV_CHARACTER_FORMAT_IMP
