indexing
	description: "Object font which can be selected into a DC."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FONT

inherit
	WEL_GDI_ANY

	WEL_UNIT_CONVERSION
		export
			{NONE} all
		end

	WEL_DT_CONSTANTS
		export
			{NONE} all
		end
		
create 
	make,
	make_indirect,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_height, a_width, escapement, orientation, weight, 
			italic, underline, strike_out, charset,
			output_precision, clip_precision, quality,
			pitch_and_family: INTEGER; a_face_name: STRING) is
			-- Make font named `a_face_name'.
		require
			a_face_name_not_void: a_face_name /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_face_name)
			item := cwin_create_font (a_height, a_width, escapement,
				orientation, weight, italic, underline,
				strike_out, charset, output_precision,
				clip_precision, quality, pitch_and_family, a_wel_string.item)
			gdi_make
		end

	make_indirect (a_log_font: WEL_LOG_FONT) is
			-- Make a font using `a_log_font'.
		require
			a_log_font_not_void: a_log_font /= Void
		do
			item := cwin_create_font_indirect (a_log_font.item)
			gdi_make
		end

feature -- Setting

	set_height (a_height: INTEGER) is
			-- Set `height' with `a_height'.
		require
			a_height_bigger_than_zero: a_height > 0
		local
			l: like log_font
			screen_dc: WEL_SCREEN_DC
		do
			create screen_dc
			screen_dc.get
			l := log_font
			l.set_height (-pixel_to_logical (screen_dc, a_height))
			screen_dc.release

			set_indirect (l)
		end

feature -- Re-initialisation

	set_indirect (a_log_font: WEL_LOG_FONT) is
			-- Reset the current font the 'a_log_font' without
			-- creating new object
		require
			a_log_font_not_void: a_log_font /= Void
		local
			object_destroyed: BOOLEAN
			a_default_pointer: POINTER
		do
				-- we delete the current C item
			debug ("WEL_GDI_COUNT")
				decrease_gdi_objects_count
			end
			object_destroyed := cwin_delete_object (item)
			check
				c_object_destroyed: object_destroyed
			end
			item := a_default_pointer

			check
				c_object_destroyed: not exists
			end

				-- Then we retrieve an new C item.
			item := cwin_create_font_indirect (a_log_font.item)
			debug ("WEL_GDI_COUNT")
				increase_gdi_objects_count
			end
		end

feature -- Access

	log_font: WEL_LOG_FONT is
			-- Log font structure associated to `Current'
		require
			exists
		do
			create Result.make_by_font (Current)
		ensure
			result_not_void: Result /= Void
		end

	width: INTEGER is
			-- Character width of current fixed-width font.
		do
			Result := string_width ("x")
		end

	height: INTEGER is
			-- Size of font measured in pixels.
		local
			screen_dc: WEL_SCREEN_DC
		do
			check
				height_negative: log_font.height < 0
			end
			create screen_dc
			screen_dc.get
			Result := logical_to_pixel (screen_dc, -log_font.height)
			screen_dc.release
		ensure
			Result_bigger_than_zero: Result > 0
		end

	point: INTEGER is
			-- Size of font in points (1 point = 1/72 of an inch)
		local
			screen_dc: WEL_SCREEN_DC
		do
			check
				height_negative: log_font.height < 0
			end
			create screen_dc
			screen_dc.get
			Result := pixel_to_point (screen_dc, -log_font.height)
			screen_dc.release
		end

	string_width (a_string: STRING): INTEGER is
			-- Width of `a_string'.
		do
			Result := string_size (a_string).integer_item (1)
		end

	string_height (a_string: STRING): INTEGER is
			-- Height of `a_string'.
		do
			Result := string_size (a_string).integer_item (2)
		end
		
	string_size_extended (a_string: STRING): TUPLE [INTEGER, INTEGER, INTEGER, INTEGER] is
			-- [width, height, leading overhang, trailing overhang] of `a_string'.
			-- Not all fonts have characters that fit completely within the bounds of
			-- the standard `string_size'. See `char_abc_widths' from WEL_DC which
			-- retrives information regarding Windows ABC structures for truetype
			-- fonts. If a character has a negative "a" or "c" value which causes it
			-- to extended past the boundaries of the rectange specified by the first two 
			-- INTEGER values, use the final two INTEGER values to determine the number
			-- of pixels the characters extend in either direction past the bounds. This
			-- is necessary to completely encompass the string in a rectangle.
			-- The third INTEGER value of `Result' corresponds to the maximum character extent
			-- to the left hand side (before the string), with a negative value specifying a protuding point.
			-- The fourth integer value of `Result' corresponds to the maximum character extent
			-- to the right hand side (after the string), with a negative value indicating that it protudes)
		local
			cur_width, cur_height: INTEGER
			screen_dc: WEL_SCREEN_DC
			bounding_rect: WEL_RECT
			wel_string: WEL_STRING
			counter: INTEGER
			count: INTEGER
			line_start_index: INTEGER
			greatest_a, greatest_c: INTEGER
			pointer: POINTER
			error_code: INTEGER
			current_c: INTEGER
			area: SPECIAL [CHARACTER]
			screen_dc_pointer: POINTER
			bounding_rect_pointer: POINTER
			bounding_rect_width: INTEGER
			current_character: CHARACTER
			text_format: INTEGER
		do
			if a_string.is_empty then
				cur_width := 0
				cur_height := 0
			else
				create wel_string.make (a_string)
				area := a_string.area
				pointer := wel_string.item
				create bounding_rect.make (0, 0, 32767, 32767)
				create screen_dc
				screen_dc.get
				screen_dc.select_font (Current)
				count := wel_string.count
				text_format := Dt_calcrect | Dt_expandtabs | Dt_noprefix
				
					-- Store pointers to structures for quicker access.
				screen_dc_pointer := screen_dc.item
				bounding_rect_pointer := bounding_rect.item
				
				from
					counter := 1
					line_start_index := 1
						-- Assign an arbitarily large value, as if we use the
						-- default value of 0, we cannot return a negative value.
					greatest_a := 32000
						-- Retrieve the greatest a value for the first character before iteration.
					greatest_a := greatest_a.min (get_char_a_width (screen_dc, area.item (counter - 1).code))
				until
					counter > count
				loop
					current_character := area.item (counter - 1)
					if current_character = '%N' then
						if counter < count - 1 then
								-- Ensure that we do not check a character if the string ends in '%N'.
							greatest_a := greatest_a.min (get_char_a_width (screen_dc, area.item (counter + 1).code))
						end
						if counter < count then
							current_c := get_char_c_width (screen_dc, area.item (counter - 1).code)
						end
						error_code := screen_dc.cwin_draw_text (screen_dc_pointer, pointer + (line_start_index - 1), counter - line_start_index, bounding_rect_pointer, text_format)
						bounding_rect_width := bounding_rect.width
						
						if current_c < 0 then
							greatest_c := greatest_c.max (bounding_rect_width + current_c.abs)
						else
							greatest_c := greatest_c.max (bounding_rect_width)
						end

						cur_width := bounding_rect_width.max (cur_width)
						cur_height := cur_height + bounding_rect.height
						line_start_index := counter + 1
					end
					counter := counter + 1
				end
				
					-- Now check the final character of the last line.
				error_code := screen_dc.cwin_draw_text (screen_dc_pointer, pointer + (line_start_index - 1), counter - line_start_index, bounding_rect_pointer, text_format)
				bounding_rect_width := bounding_rect.width
				
				current_c := get_char_c_width (screen_dc, area.item (counter - 2).code)
				if current_c < 0 then
					greatest_c := greatest_c.max (bounding_rect_width + current_c.abs)
				else
					greatest_c := greatest_c.max (bounding_rect_width)
				end
				cur_width := bounding_rect_width.max (cur_width)
				cur_height := cur_height + bounding_rect.height
				
				greatest_c := cur_width - greatest_c


				screen_dc.unselect_font
				screen_dc.quick_release
			end

			Result := [cur_width, cur_height, greatest_a, greatest_c]
		end

	string_size (a_string: STRING): TUPLE [INTEGER, INTEGER] is
			-- [width, height] of `a_string'.
		local
			cur_width, cur_height: INTEGER
			screen_dc: WEL_SCREEN_DC
			bounding_rect: WEL_RECT
		do
			if a_string.is_empty then
				cur_width := 0
				cur_height := 0
			else
				create bounding_rect.make (0, 0, 32767, 32767)
				create screen_dc
				screen_dc.get
				screen_dc.select_font (Current)

				screen_dc.draw_text (a_string, bounding_rect, Dt_calcrect | Dt_expandtabs | Dt_noprefix)
				cur_width := bounding_rect.width
				cur_height := bounding_rect.height
				
				screen_dc.unselect_font
				screen_dc.quick_release
			end

			Result := [cur_width, cur_height]
		end

feature {NONE} -- Implementation

	get_char_a_width (dc: WEL_DC; character_code: INTEGER): INTEGER is
			-- `Result' is "a" width from truetype font character `character_code'.
		require
			dc_not_void: dc /= Void
			character_code_positive: character_code > 0
		do
			Result := dc.char_abc_widths (character_code, character_code).i_th (1).a
		end
		
	get_char_c_width (dc: WEL_DC; character_code: INTEGER): INTEGER is
			-- `Result' is "c" width from truetype font character `character_code'.
		require
			dc_not_void: dc /= Void
			character_code_positive: character_code > 0
		do
			Result := dc.char_abc_widths (character_code, character_code).i_th (1).c
		end

	cwin_create_font (a_height, a_width, escapement, orientation, weight,
			italic, underline, strike_out,
			charset, output_precision, clip_precision,
			quality, pitch_and_family: INTEGER;
			face: POINTER): POINTER is
			-- SDK CreateFont
		external
			"C [macro <wel.h>] (int, int, int, int, int, DWORD, %
				%DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, %
				%DWORD, LPCSTR): EIF_POINTER"
		alias
			"CreateFont"
		end

	cwin_create_font_indirect (ptr: POINTER): POINTER is
			-- SDK CreateFontIndirect
		external
			"C [macro <wel.h>] (LOGFONT *): EIF_POINTER"
		alias
			"CreateFontIndirect"
		end

end -- class WEL_FONT


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

