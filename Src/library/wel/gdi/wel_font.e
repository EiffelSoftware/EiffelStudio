indexing
	description: "Object font which can be selected into a DC."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FONT

inherit
	WEL_GDI_ANY

creation 
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

feature -- Re-initialisation

	set_indirect (a_log_font: WEL_LOG_FONT) is
			-- Reset the current font the 'a_log_font' without
			-- creating new object
		require
			a_log_font_not_void: a_log_font /= Void
		local
			object_destroyed: BOOLEAN
		do
				-- we delete the current C item
			debug ("GDI_COUNT")
				decrease_gdi_objects_count
			end
			object_destroyed := cwin_delete_object (item)
			check
				c_object_destroyed: object_destroyed
			end
			item := Default_pointer

			check
				c_object_destroyed: not exists
			end

				-- Then we retrieve an new C item.
			item := cwin_create_font_indirect (a_log_font.item)
			debug ("GDI_COUNT")
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
			-- Preferred font height measured in screen pixels.
			-- NOTE: this function may return 0, which means that
			--       the font has been created without any particular
			--       height restriction - Windows use the best value
			--       and we can't know what height it is. Too bad !
		do
			Result := log_font.height.abs
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

	string_size (a_string: STRING): TUPLE [INTEGER, INTEGER] is
			-- [width, height] of `a_string'.
		local
			cur_width, cur_height: INTEGER
			index, n: INTEGER
			screen_dc: WEL_SCREEN_DC
			extent: WEL_SIZE
		do
			create screen_dc
			screen_dc.get
			screen_dc.select_font (Current)
			from
				n := 1
			until
				n > a_string.count
			loop
				index := a_string.index_of ('%N', n)
				if index > 0 then
					extent := screen_dc.string_size (
						a_string.substring (n, index - 1)
					)
					n := index + 1
				else
					extent := screen_dc.string_size (
						a_string.substring (n, a_string.count)
					)
					n := a_string.count + 1
				end
				cur_width := cur_width.max (extent.width)
				cur_height := cur_height + extent.height
			end
			screen_dc.unselect_font
			screen_dc.quick_release
			Result := [cur_width, cur_height]
		end

feature {NONE} -- Implementation

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
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

