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
			text_tag := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_tag_new (default_pointer)
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
		local
			propname, propvalue: C_STRING
		do
			internal_font_imp ?= a_font.implementation
			create propname.make ("font")
			create propvalue.make (internal_font_imp.name + " " + internal_font_imp.height.out)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set (text_tag, propname.item, propvalue.item, default_pointer)
		end

	set_color (a_color: EV_COLOR) is
			-- Make `value' the new color
		local
			propname, propvalue: C_STRING
			color_struct: POINTER
			tempbool: BOOLEAN
		do
			internal_color_imp ?= a_color.implementation
			create propname.make ("foreground-gdk")
			color_struct := feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
			feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color_struct, internal_color_imp.red_16_bit)
			feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color_struct, internal_color_imp.green_16_bit)
			feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color_struct, internal_color_imp.blue_16_bit)
			tempbool := feature {EV_GTK_EXTERNALS}.gdk_colormap_alloc_color (feature {EV_GTK_EXTERNALS}.gdk_rgb_get_cmap, color_struct, False, True)
			check
				color_has_been_allocated: tempbool
			end
			feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set (text_tag, propname.item, color_struct, default_pointer)
			color_struct.memory_free
		end
		
	set_effects (an_effect: EV_CHARACTER_FORMAT_EFFECTS) is
			-- Make `an_effect' the new `effects'
		local
			propname, propvalue: C_STRING
		do
			internal_effects := an_effect.twin
			create propname.make ("strikethrough")
			feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_boolean (text_tag, propname.item, internal_effects.is_striked_out)
			create propname.make ("underline")
			feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_boolean (text_tag, propname.item, internal_effects.is_underlined)
		end

feature {EV_RICH_TEXT_IMP} -- Implementation

	text_tag: POINTER
			-- The GtkTextTag associated with `Current'

feature {NONE} -- Implementation

	internal_font_imp: EV_FONT_IMP
			-- Font of the current format
	
	internal_color_imp: EV_COLOR_IMP
			-- Color of the current format
		
	internal_effects: EV_CHARACTER_FORMAT_EFFECTS
			-- Character format effects applicable to `font'

	destroy is
			-- Clean up
		do
			internal_font_imp := Void
			internal_color_imp := Void
			internal_effects := Void
		end

end -- class EV_CHARACTER_FORMAT_IMP
