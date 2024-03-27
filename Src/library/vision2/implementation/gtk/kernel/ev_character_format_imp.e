note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		undefine
			out
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create character format
		do
			assign_interface (an_interface)
		end

	make
			-- Do nothing
		local
			app_imp: like app_implementation
		do
			bcolor := 0xFFFFFF -- White
			fcolor := 0 -- Black

			app_imp := app_implementation
			set_font_attributes
				(
					app_imp.default_font_name,
					{EV_FONT_CONSTANTS}.family_sans,
					app_imp.default_font_point_height_internal,
					app_imp.default_font_weight_internal,
					{EV_FONT_CONSTANTS}.shape_regular,
					0
				)
			set_is_initialized (True)
		end

feature -- Access

	font: EV_FONT
			-- Font of the current format
		do
			create Result
			Result.set_family (family)
			Result.set_height_in_points (height_in_points)
			Result.set_weight (weight)
			Result.set_shape (shape)
			Result.preferred_families.extend (name)
		end

	color: EV_COLOR
			-- Color of the current format
		local
			a_color: INTEGER
		do
			a_color := fcolor
			create Result
			Result.set_red_with_8_bit (a_color & 0x000000FF)
			Result.set_green_with_8_bit ((a_color & 0x0000FF00) |>> 8)
			Result.set_blue_with_8_bit (a_color |>> 16)
		end

	background_color: EV_COLOR
			-- Background Color of the current format
		local
			a_color: INTEGER
		do
			a_color := bcolor
			create Result
			Result.set_red_with_8_bit (a_color & 0x000000FF)
			Result.set_green_with_8_bit ((a_color & 0x0000FF00) |>> 8)
			Result.set_blue_with_8_bit (a_color |>> 16)
		end

	effects: EV_CHARACTER_FORMAT_EFFECTS
			-- Character format effects applicable to `font'
		do
			create Result
			if is_underlined then
				Result.enable_underlined
			end
			if is_striked_out then
				Result.enable_striked_out
			end
			Result.set_vertical_offset (vertical_offset)
		end

feature -- Status setting

	set_font (a_font: EV_FONT)
			-- Make `value' the new font
		do
			set_font_attributes
				(
					a_font.name,
					a_font.family,
					a_font.height_in_points,
					a_font.weight,
					a_font.shape,
					0
				)
		end

	set_font_attributes (a_name: READABLE_STRING_GENERAL; a_family, a_point_height, a_weight, a_shape, a_charset: INTEGER)
			-- Set internal font attributes
		do
			name := a_name.as_string_32
			family := a_family
			height_in_points := a_point_height
			weight := a_weight
			shape := a_shape
			char_set := a_charset
		end

	set_color (a_color: EV_COLOR)
			-- Make `value' the new color
		do
			set_fcolor (a_color.red_8_bit, a_color.green_8_bit, a_color.blue_8_bit)
		end

	set_fcolor (a_red, a_green, a_blue: INTEGER)
			-- Pack `fcolor' with `a_red', `a_green' and `a_blue'
		do
			fcolor := a_blue;
			fcolor := fcolor |<< 8
			fcolor := fcolor + a_green
			fcolor := fcolor |<< 8
			fcolor := fcolor + a_red
		end

	set_bcolor (a_red, a_green, a_blue: INTEGER)
			-- Pack `bcolor' with `a_red', `a_green' and `a_blue'
		do
			bcolor := a_blue;
			bcolor := bcolor |<< 8
			bcolor := bcolor + a_green
			bcolor := bcolor |<< 8
			bcolor := bcolor + a_red
			bcolor_set := True
		end

	set_background_color (a_color: EV_COLOR)
			-- Make `value' the new color
		do
			set_bcolor (a_color.red_8_bit, a_color.green_8_bit, a_color.blue_8_bit)
		end

	set_effects (an_effect: EV_CHARACTER_FORMAT_EFFECTS)
			-- Make `an_effect' the new `effects'
		do
			set_effects_internal (an_effect.is_underlined, an_effect.is_striked_out, an_effect.vertical_offset)
		end

	set_effects_internal (a_underlined, a_striked_out: BOOLEAN; a_vertical_offset: INTEGER)
			--
		do
			is_underlined := a_underlined
			is_striked_out := a_striked_out
			vertical_offset := a_vertical_offset
		end

feature {EV_RICH_TEXT_IMP} -- Implementation

	dummy_character_format_range_information: EV_CHARACTER_FORMAT_RANGE_INFORMATION
			-- Used for creating a fully set GtkTextTag
		once
			create Result.make_with_flags (
				{EV_CHARACTER_FORMAT_CONSTANTS}.font_family
				| {EV_CHARACTER_FORMAT_CONSTANTS}.font_weight
				| {EV_CHARACTER_FORMAT_CONSTANTS}.font_shape
				| {EV_CHARACTER_FORMAT_CONSTANTS}.font_height
				| {EV_CHARACTER_FORMAT_CONSTANTS}.color
				| {EV_CHARACTER_FORMAT_CONSTANTS}.background_color
				| {EV_CHARACTER_FORMAT_CONSTANTS}.effects_striked_out
				| {EV_CHARACTER_FORMAT_CONSTANTS}.effects_underlined
				| {EV_CHARACTER_FORMAT_CONSTANTS}.effects_vertical_offset
			)
		end

	apply_character_format_to_text_buffer (applicable_attributes: EV_CHARACTER_FORMAT_RANGE_INFORMATION; a_text_buffer, a_start_iter, a_end_iter: POINTER)
			-- Apply `Current' to `a_text_buffer' to the region bounded by `a_start_iter' and `a_end_iter'
		local
			a_tag_table: POINTER
			a_text_tag: POINTER
			a_text_tag_name: EV_GTK_C_STRING
			prop_value_int: INTEGER
			app_imp: like app_implementation
		do
			a_tag_table := {GTK2}.gtk_text_buffer_get_tag_table (a_text_buffer)
			app_imp := app_implementation

			if applicable_attributes.font_family then
				a_text_tag_name := app_imp.c_string_from_eiffel_string (name)
				a_text_tag := {GTK2}.gtk_text_tag_table_lookup (a_tag_table, a_text_tag_name.item)
				if a_text_tag = default_pointer then
					a_text_tag := {GTK2}.gtk_text_tag_new (a_text_tag_name.item)
					{GOBJECT}.g_object_set_string (a_text_tag, family_string.item, a_text_tag_name.item)
					{GTK2}.gtk_text_tag_table_add (a_tag_table, a_text_tag)
				end
				{GTK2}.gtk_text_buffer_apply_tag (a_text_buffer, a_text_tag, a_start_iter, a_end_iter)
			end

			if applicable_attributes.font_height then
				a_text_tag_name := app_imp.c_string_from_eiffel_string (once "fh" + height_in_points.out)
				a_text_tag := {GTK2}.gtk_text_tag_table_lookup (a_tag_table, a_text_tag_name.item)
				if a_text_tag = default_pointer then
					a_text_tag := {GTK2}.gtk_text_tag_new (a_text_tag_name.item)
					{GOBJECT}.g_object_set_integer (a_text_tag, size_string.item, height_in_points * {GTK2}.pango_scale)
					{GTK2}.gtk_text_tag_table_add (a_tag_table, a_text_tag)
				end
				{GTK2}.gtk_text_buffer_apply_tag (a_text_buffer, a_text_tag, a_start_iter, a_end_iter)
			end

			if applicable_attributes.font_shape then
				if shape = {EV_FONT_CONSTANTS}.shape_italic then
					a_text_tag_name := app_imp.c_string_from_eiffel_string (once "fsi")
					prop_value_int := 2
				else
					a_text_tag_name := app_imp.c_string_from_eiffel_string (once "fsr")
					prop_value_int := 0
				end
				a_text_tag := {GTK2}.gtk_text_tag_table_lookup (a_tag_table, a_text_tag_name.item)
				if a_text_tag = default_pointer then
					a_text_tag := {GTK2}.gtk_text_tag_new (a_text_tag_name.item)
					{GOBJECT}.g_object_set_integer (a_text_tag, style_string.item, prop_value_int)
					{GTK2}.gtk_text_tag_table_add (a_tag_table, a_text_tag)
				end
				{GTK2}.gtk_text_buffer_apply_tag (a_text_buffer, a_text_tag, a_start_iter, a_end_iter)
			end


			if applicable_attributes.font_weight then
				inspect
					weight
				when
					{EV_FONT_CONSTANTS}.weight_bold
				then
					a_text_tag_name := app_imp.c_string_from_eiffel_string (once "fwb")
					prop_value_int := {EV_FONT_IMP}.pango_weight_bold
				when
					{EV_FONT_CONSTANTS}.weight_regular
				then
					a_text_tag_name := app_imp.c_string_from_eiffel_string (once "fwr")
					prop_value_int := {EV_FONT_IMP}.pango_weight_normal
				when
					{EV_FONT_CONSTANTS}.weight_thin
				then
					a_text_tag_name := app_imp.c_string_from_eiffel_string (once "fwt")
					prop_value_int := {EV_FONT_IMP}.pango_weight_ultra_light
				when
					{EV_FONT_CONSTANTS}.weight_black
				then
					a_text_tag_name := app_imp.c_string_from_eiffel_string (once "fwb")
					prop_value_int := {EV_FONT_IMP}.pango_weight_heavy
				end
				a_text_tag := {GTK2}.gtk_text_tag_table_lookup (a_tag_table, a_text_tag_name.item)
				if a_text_tag = default_pointer then
					a_text_tag := {GTK2}.gtk_text_tag_new (a_text_tag_name.item)
					{GOBJECT}.g_object_set_integer (a_text_tag, weight_string.item, prop_value_int)
					{GTK2}.gtk_text_tag_table_add (a_tag_table, a_text_tag)
				end
				{GTK2}.gtk_text_buffer_apply_tag (a_text_buffer, a_text_tag, a_start_iter, a_end_iter)
			end


			if applicable_attributes.color then
				a_text_tag_name := app_imp.c_string_from_eiffel_string (once "fg" + fcolor.out)
				a_text_tag := {GTK2}.gtk_text_tag_table_lookup (a_tag_table, a_text_tag_name.item)
				if a_text_tag = default_pointer then
					a_text_tag := {GTK2}.gtk_text_tag_new (a_text_tag_name.item)

					{GTK}.set_gdk_color_struct_blue (App_implementation.reusable_color_struct, (fcolor |>> 16) * 257)
					{GTK}.set_gdk_color_struct_green (App_implementation.reusable_color_struct, ((fcolor |<< 16) |>> 24) * 257)
					{GTK}.set_gdk_color_struct_red (App_implementation.reusable_color_struct, ((fcolor |<< 24) |>> 24) * 257)
					{GOBJECT}.g_object_set_pointer (a_text_tag, foreground_gdk_string.item, App_implementation.reusable_color_struct, default_pointer)
					{GTK2}.gtk_text_tag_table_add (a_tag_table, a_text_tag)
				end
				{GTK2}.gtk_text_buffer_apply_tag (a_text_buffer, a_text_tag, a_start_iter, a_end_iter)
			end

			if applicable_attributes.background_color then
				a_text_tag_name := app_imp.c_string_from_eiffel_string ("bg" + bcolor.out)
				a_text_tag := {GTK2}.gtk_text_tag_table_lookup (a_tag_table, a_text_tag_name.item)
				if a_text_tag = default_pointer then
					a_text_tag := {GTK2}.gtk_text_tag_new (a_text_tag_name.item)

					{GTK}.set_gdk_color_struct_blue (App_implementation.reusable_color_struct, (bcolor |>> 16) * 257)
					{GTK}.set_gdk_color_struct_green (App_implementation.reusable_color_struct, ((bcolor |<< 16) |>> 24) * 257)
					{GTK}.set_gdk_color_struct_red (App_implementation.reusable_color_struct, ((bcolor |<< 24) |>> 24) * 257)
					{GOBJECT}.g_object_set_pointer (a_text_tag, background_gdk_string.item, App_implementation.reusable_color_struct, default_pointer)
					{GTK2}.gtk_text_tag_table_add (a_tag_table, a_text_tag)
				end
				{GTK2}.gtk_text_buffer_apply_tag (a_text_buffer, a_text_tag, a_start_iter, a_end_iter)
			end

			if applicable_attributes.effects_striked_out then
				if is_striked_out then
					a_text_tag_name := app_imp.c_string_from_eiffel_string ("sot")
				else
					a_text_tag_name := app_imp.c_string_from_eiffel_string ("sof")
				end
				a_text_tag := {GTK2}.gtk_text_tag_table_lookup (a_tag_table, a_text_tag_name.item)
				if a_text_tag = default_pointer then
					a_text_tag := {GTK2}.gtk_text_tag_new (a_text_tag_name.item)
					{GOBJECT}.g_object_set_boolean (a_text_tag, strikethrough_string.item, is_striked_out)
					{GTK2}.gtk_text_tag_table_add (a_tag_table, a_text_tag)
				end
				{GTK2}.gtk_text_buffer_apply_tag (a_text_buffer, a_text_tag, a_start_iter, a_end_iter)
			end

			if applicable_attributes.effects_underlined then
				if is_underlined then
					a_text_tag_name := app_imp.c_string_from_eiffel_string ("ut")
				else
					a_text_tag_name := app_imp.c_string_from_eiffel_string ("uf")
				end
				a_text_tag := {GTK2}.gtk_text_tag_table_lookup (a_tag_table, a_text_tag_name.item)
				if a_text_tag = default_pointer then
					a_text_tag := {GTK2}.gtk_text_tag_new (a_text_tag_name.item)
					{GOBJECT}.g_object_set_boolean (a_text_tag, underline_string.item, is_underlined)
					{GTK2}.gtk_text_tag_table_add (a_tag_table, a_text_tag)
				end
				{GTK2}.gtk_text_buffer_apply_tag (a_text_buffer, a_text_tag, a_start_iter, a_end_iter)
			end

			if applicable_attributes.effects_vertical_offset then
				a_text_tag_name := app_imp.c_string_from_eiffel_string ("vo" + vertical_offset.out)
				a_text_tag := {GTK2}.gtk_text_tag_table_lookup (a_tag_table, a_text_tag_name.item)
				if a_text_tag = default_pointer then
					a_text_tag := {GTK2}.gtk_text_tag_new (a_text_tag_name.item)
					{GOBJECT}.g_object_set_integer (a_text_tag, rise_string.item, vertical_offset)
					{GTK2}.gtk_text_tag_table_add (a_tag_table, a_text_tag)
				end
				{GTK2}.gtk_text_buffer_apply_tag (a_text_buffer, a_text_tag, a_start_iter, a_end_iter)
			end
		end


	new_text_tag_from_applicable_attributes (applicable_attributes: EV_CHARACTER_FORMAT_RANGE_INFORMATION): POINTER
			-- Create a new text tag based on state of `Current'
		local
			color_struct: POINTER
			propvalue: EV_GTK_C_STRING
			a_red, a_green, a_blue: INTEGER
			temp_string: STRING_32
		do

			Result := {GTK2}.gtk_text_tag_new (default_pointer)

			if (applicable_attributes.font_family or else applicable_attributes.font_height or else applicable_attributes.font_shape or else applicable_attributes.font_weight) then
				if applicable_attributes.font_family then
					propvalue := (name)
					{GOBJECT}.g_object_set_string (Result, family_string.item, propvalue.item)
				end
				if applicable_attributes.font_height then
					{GOBJECT}.g_object_set_integer (Result, size_string.item, height_in_points * {GTK2}.pango_scale)
				end
				if applicable_attributes.font_shape then
					if shape = {EV_FONT_CONSTANTS}.shape_italic then
						{GOBJECT}.g_object_set_integer (Result, style_string.item, 2)
					else
						{GOBJECT}.g_object_set_integer (Result, style_string.item, 0)
					end
				end
				if applicable_attributes.font_weight then
					inspect
						weight
					when
						{EV_FONT_CONSTANTS}.weight_bold
					then
						{GOBJECT}.g_object_set_integer (Result, weight_string.item, {EV_FONT_IMP}.pango_weight_bold)
					when
						{EV_FONT_CONSTANTS}.weight_regular
					then
						{GOBJECT}.g_object_set_integer (Result, weight_string.item, {EV_FONT_IMP}.pango_weight_normal)
					when
						{EV_FONT_CONSTANTS}.weight_thin
					then
						{GOBJECT}.g_object_set_integer (Result, weight_string.item, {EV_FONT_IMP}.pango_weight_ultra_light)
					when
						{EV_FONT_CONSTANTS}.weight_black
					then
						{GOBJECT}.g_object_set_integer (Result, weight_string.item, {EV_FONT_IMP}.pango_weight_heavy)
					end
				end
			end

			color_struct := App_implementation.reusable_color_struct
			if applicable_attributes.color then
				a_red := (fcolor & 0x000000FF) |<< 16
				a_green := (fcolor & 0x0000FF00)
				a_blue := fcolor |>> 16
				create temp_string.make_from_string_general ((a_red + a_green + a_blue).to_hex_string)
				temp_string.keep_tail (6)
				temp_string.prepend_character ('#')
				propvalue := temp_string
				{GOBJECT}.g_object_set_string (Result, foreground_string.item, propvalue.item)

				--feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color_struct, (fcolor |>> 16) * 257)
				--feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color_struct, ((fcolor |<< 16) |>> 24) * 257)
				--feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color_struct, ((fcolor |<< 24) |>> 24) * 257)
				--feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_pointer (Result, foreground_gdk_string.item, color_struct, default_pointer)

			end

			if applicable_attributes.background_color then
				a_red := (bcolor & 0x000000FF) |<< 16
				a_green := (bcolor & 0x0000FF00)
				a_blue := bcolor |>> 16
				create temp_string.make_from_string_general ((a_red + a_green + a_blue).to_hex_string)
				temp_string.keep_tail (6)
				temp_string.prepend_character ('#')
				propvalue := temp_string
				{GOBJECT}.g_object_set_string (Result, background_string.item, propvalue.item)
			end

			if (applicable_attributes.effects_striked_out or else applicable_attributes.effects_underlined or else applicable_attributes.effects_vertical_offset) then
				if applicable_attributes.effects_striked_out then
					{GOBJECT}.g_object_set_boolean (Result, strikethrough_string.item, is_striked_out)
				end
				if applicable_attributes.effects_underlined then
					if is_underlined then
						{GOBJECT}.g_object_set_integer (Result, underline_string.item, {GTK2}.pango_underline_single_enum)
					else
						{GOBJECT}.g_object_set_integer (Result, underline_string.item, {GTK2}.pango_underline_none_enum)
					end
				end
				if applicable_attributes.effects_vertical_offset then
					{GOBJECT}.g_object_set_integer (Result, rise_string.item, vertical_offset)
				end
			end
		end

	family_string: EV_GTK_C_STRING
			-- String optimization
		once
			Result := ("family")
		end

	size_string: EV_GTK_C_STRING
			-- String optimization
		once
			Result := ("size")
		end

	style_string: EV_GTK_C_STRING
			-- String optimization
		once
			Result := ("style")
		end

	weight_string: EV_GTK_C_STRING
			-- String optimization
		once
			Result := ("weight")
		end

	foreground_string: EV_GTK_C_STRING
			-- String optimization
		once
			Result := ("foreground")
		end

	background_string: EV_GTK_C_STRING
			-- String optimization
		once
			Result := ("background")
		end

	foreground_gdk_string: EV_GTK_C_STRING
			-- String optimization
		once
			Result := ("foreground-gdk")
		end

	background_gdk_string: EV_GTK_C_STRING
			-- String optimization
		once
			Result := ("background-gdk")
		end

	underline_string: EV_GTK_C_STRING
			-- String optimization
		once
			Result := ("underline")
		end

	strikethrough_string: EV_GTK_C_STRING
			-- String optimization
		once
			Result := ("strikethrough")
		end

	rise_string: EV_GTK_C_STRING
			-- String optimization
		once
			Result := ("rise")
		end

feature {NONE} -- Implementation

	app_implementation: EV_APPLICATION_IMP
			-- App implementation object
		local
			l_result: detachable EV_APPLICATION_IMP
		once
			l_result ?= (create {EV_ENVIRONMENT}).implementation.application_i
			check l_result /= Void then end
			Result := l_result
		end

	name: STRING_32
			-- Face name used by `Current'.

	family: INTEGER
			-- Family used by `Current'.

	height: INTEGER
			--  Height of `Current' in screen pixels.
		do
			Result := app_implementation.pixel_value_from_point_value (height_in_points)
		end

	height_in_points: INTEGER
			-- Height of `Current' in points.

	weight: INTEGER
			-- Weight of `Current'.

	is_bold: BOOLEAN
			-- Is `Current' bold?
		do
			Result := (weight = {EV_FONT_CONSTANTS}.weight_bold)
		end

	shape: INTEGER
			-- Shape of `Current'.

	char_set: INTEGER
			-- Char set used by `Current'.

	is_underlined: BOOLEAN
			-- Is `Current' underlined?

	is_striked_out: BOOLEAN
			-- Is `Current' striken out?

	vertical_offset: INTEGER
			-- Vertical offset of `Current'.

	fcolor: INTEGER
			-- foreground color BGR packed into 24 bit.

	bcolor: INTEGER
			-- background color BGR packed into 24 bit.

	bcolor_set: BOOLEAN
			-- <Precursor>

	destroy
			-- Clean up
		do
			set_is_destroyed (True)
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_CHARACTER_FORMAT_IMP











