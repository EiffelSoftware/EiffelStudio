indexing
	description: "Object font which can be selected into a DC."
	legal: "See notice at end of class."
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

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WEL_TMPF_CONSTANTS
		export
			{NONE} all
		end

	WEL_SHARED_TEMPORARY_OBJECTS
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
			pitch_and_family: INTEGER; a_face_name: STRING_GENERAL) is
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

	set_height_in_points (a_height_in_points: INTEGER) is
			-- Set `height' based on `a_height_in_points'.
		local
			l: like log_font
			screen_dc: WEL_SCREEN_DC
		do
			create screen_dc
			screen_dc.get
			l := log_font
			l.set_height (- point_to_logical (screen_dc, a_height_in_points, 1))
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
			create screen_dc
			screen_dc.get
			Result := pixel_to_point (screen_dc, -log_font.height)
			screen_dc.release
		end

	string_width (a_string: STRING_GENERAL): INTEGER is
			-- Width of `a_string'.
		do
			Result := string_size (a_string).width
		end

	string_height (a_string: STRING_GENERAL): INTEGER is
			-- Height of `a_string'.
		do
			Result := string_size (a_string).height
		end

	string_size_extended (a_string: STRING_GENERAL): TUPLE [width: INTEGER; height: INTEGER; leading_overhang: INTEGER; trailing_overhang: INTEGER] is
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
			counter: INTEGER
			count: INTEGER
			greatest_a, greatest_c: INTEGER
			pointer: POINTER
			current_c: INTEGER
			screen_dc_pointer: POINTER
			abc_struct: WEL_ABC_STRUCT
			abc_struct_size: INTEGER
			managed_pointer: MANAGED_POINTER
			char_pointer: POINTER
			character_code: NATURAL_32
			a, b, c: INTEGER
			current_width: INTEGER
			advance_width: INTEGER
			text_metric: WEL_TEXT_METRIC
			metric_height: INTEGER
			last_newline_index: INTEGER
			optimize_for_short_strings: BOOLEAN
			standard_result: like string_size
		do
			if a_string.is_empty then
				cur_width := 0
				cur_height := 0
			else
				wel_string.set_string (a_string)
				pointer := wel_string.item
				create screen_dc
				screen_dc.get
				screen_dc.select_font (Current)
				count := wel_string.count

					-- Create a text metric structure from `screen_dc' providing information
					-- regarding selected font.
				create text_metric.make (screen_dc)
					-- We only need to perform the accurate calculations for true type fonts.
					-- If a font is not truetype, we can simply use `string_size'.
				if flag_set (text_metric.pitch_and_family, tmpf_truetype) then

						-- Store height returned by metrics for quick access.
					metric_height := text_metric.height

						-- It is quicker to perform different implementations
						-- based on the string length. The value of 48 is an approximate
						-- value where in testing, the relative merits of each approach becomes
						-- apparent. This value should not be changed without proper testing. Julian
					optimize_for_short_strings := count < 48

					create abc_struct.make
					abc_struct_size := abc_struct.structure_size
					if not optimize_for_short_strings then
							-- If we are dealing with a large string, we retrieve
							-- all characters from 0-255, for subsequent look up
							-- as it is quicker.
						create managed_pointer.make (256 * abc_struct_size)
						screen_dc.cwel_get_char_abc_widths (screen_dc.item, 0, 255, managed_pointer.item)
						char_pointer := managed_pointer.item
					end

						-- Store pointers to structures for quicker access.
					screen_dc_pointer := screen_dc.item

					greatest_a := 1000
					greatest_c := -1000
					from
						counter := 1
						current_c := 0
					until
						counter > count
					loop
						character_code := a_string.code (counter)
						check character_code_not_too_big: character_code <= {INTEGER}.max_value.to_natural_32 end
						if character_code = ('%N').code.to_natural_32 then
							cur_width := cur_width.max (current_width)
							greatest_c := greatest_c.max (current_width - current_c)
							current_c := 0
							current_width := 0
							cur_height := cur_height + metric_height
							last_newline_index := counter
						else
							if optimize_for_short_strings or else character_code > 255 then
									-- It is quicker to retrieve the item multiple times, rather than
									-- retrieve all 255 character indexes for short strings.
									-- The size should also be calculated one-by-one for characters
									-- above those for which the size has been retrieved.
								screen_dc.cwel_get_char_abc_widths (screen_dc.item, character_code, character_code, abc_struct.item)
							else
									-- As we are not optimizing for short strings, look up the character
									-- in the prefetched table.
								create abc_struct.make_by_pointer (char_pointer + character_code.to_integer_32 * abc_struct_size)
							end

							a := abc_struct.a
							b := abc_struct.b
							c := abc_struct.c
							advance_width := a + b + c
							current_c := (current_c + advance_width).min (1000)
							current_c := current_c.min (c)
							current_width := current_width + advance_width
							if last_newline_index = counter - 1 or counter = 1 then
								greatest_a := greatest_a.min (a)
							end
						end
						counter := counter + 1
					end
					cur_height := cur_height + metric_height
					cur_width := cur_width.max (current_width)
					greatest_c := greatest_c.max (current_width - current_c)
					greatest_c := cur_width - greatest_c


					screen_dc.unselect_font
					screen_dc.quick_release
				else
						-- We are not dealing with a true type font, so
						-- use `string_size' to return the best approximation.
						-- The third and fourth values of the result will be 0.
					standard_result := string_size (a_string)
					cur_width := standard_result.width
					cur_height := standard_result.height
				end
			end
			Result := [cur_width, cur_height, greatest_a, greatest_c]
		ensure
			Result_not_void: Result /= Void
		end

	string_size (a_string: STRING_GENERAL): TUPLE [width: INTEGER; height: INTEGER] is
			-- [width, height] of `a_string'.
		local
			cur_width, cur_height: INTEGER
			screen_dc: WEL_SCREEN_DC
		do
			if a_string.is_empty then
				cur_width := 0
				cur_height := 0
			else

				wel_rect.set_rect (0, 0, 32767, 32767)
				create screen_dc
				screen_dc.get
				screen_dc.select_font (Current)

				screen_dc.draw_text (a_string, wel_rect, Dt_calcrect | Dt_expandtabs | Dt_noprefix)
				cur_width := wel_rect.width
				cur_height := wel_rect.height

				screen_dc.unselect_font
				screen_dc.quick_release
			end

			Result := [cur_width, cur_height]
		end

feature {NONE} -- Implementation

	get_char_a_width (dc: WEL_DC; character_code: NATURAL_32): INTEGER is
			-- `Result' is "a" width from truetype font character `character_code'.
		require
			dc_not_void: dc /= Void
			character_code_positive: character_code > 0
		do
			Result := dc.char_abc_widths (character_code, character_code).i_th (1).a
		end

	get_char_c_width (dc: WEL_DC; character_code: NATURAL_32): INTEGER is
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
				%DWORD, LPCTSTR): EIF_POINTER"
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




end -- class WEL_FONT

