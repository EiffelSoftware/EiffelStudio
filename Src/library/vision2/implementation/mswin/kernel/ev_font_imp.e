indexing
	description: "EiffelVision font, mswindow implementation."
	note: "This class represents a WEL_LOG_FONT";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_FONT_IMP
	
inherit
	EV_FONT_I 

	WEL_CAPABILITIES_CONSTANTS
		rename
			vertical_resolution as sceeen_vertical_resolution,
			horizontal_resolution as screen_horizontal_resolution
		export
			{NONE} all
		end
	
creation
	make,
	make_by_name,
	make_by_system_name,
	make_by_wel

feature {EV_FONTABLE_IMP, EV_FONT_DIALOG_IMP} -- Initialization

	make is
			-- Create a font
		do
			create {WEL_SYSTEM_FONT} wel_font.make
			create wel_log_font.make_by_font (wel_font)
		end

	make_by_name (str: STRING) is
			-- Create a font from the given face name
		require
			valid_name: str /= Void and not str.empty
			face_name_only: str.occurrences (',') = 0
		do
			create wel_log_font.make (0, str)
			allocate
		end


	make_by_system_name (str: STRING) is
			-- Create the font corresponding to the given system
			-- name.
			-- The font is directly readed on a file.
		require
			valid_arguments_count: str.occurrences (',') = 12
			valid_name: str /= Void and not str.empty
		do
			make
			parse_font_string (str)
		end

	make_by_wel (a_wel_font: WEL_FONT) is
			-- Create a font given `a_wel_font'
		require
			a_wel_font_exists: a_wel_font /= Void
		do
			wel_font := a_wel_font
			create wel_log_font.make_by_font (wel_font)
		end

feature -- Access

	name:STRING is
			-- Face name.
		do
			Result := wel_log_font.face_name
		end

	system_name: STRING is
			-- String form of font details
		local
			size_in_point: INTEGER
			screen_dc: WEL_SCREEN_DC
		do
			create Result.make (60)
				-- face name
			Result.append (wel_log_font.face_name)
			Result.extend (',')
				-- point size
			size_in_point := -wel_log_font.height
			create screen_dc
			screen_dc.get
			size_in_point := mul_div (size_in_point, 72,
								get_device_caps (screen_dc.item, logical_pixels_y))
			screen_dc.release

			Result.append_integer (size_in_point)
			Result.extend (',')
				-- weight
			Result.append_integer (wel_log_font.weight)
			Result.extend (',')
				-- styles
			if wel_log_font.italic then
				Result.extend ('i')
			end
			if wel_log_font.strike_out then
				Result.extend ('s')
			end
			if wel_log_font.underlined then
				Result.extend ('u')
			end
			Result.extend (',')
				-- pitch
			if wel_log_font.has_fixed_pitch then
				Result.append ("fixed")
			elseif wel_log_font.has_variable_pitch then
				Result.append ("variable")
			else
				Result.append ("default")
			end
			Result.extend (',')
				-- Family
			if wel_log_font.is_decorative_family then
				Result.append ("decorative")
			elseif wel_log_font.is_modern_family then
				Result.append ("modern")
			elseif wel_log_font.is_script_family then
				Result.append ("script")
			elseif wel_log_font.is_swiss_family then
				Result.append ("swiss")
			elseif wel_log_font.is_roman_family then
				Result.append ("roman")
			else
				Result.append ("dontcare")
			end
			Result.extend (',')
				-- charset
			if wel_log_font.has_ansi_character_set then
				Result.append ("ansi")
			elseif wel_log_font.has_oem_character_set then
				Result.append ("oem")
			elseif wel_log_font.has_symbol_character_set then
				Result.append ("symbol")
			else
				Result.append ("default")
			end
			Result.extend (',')
				-- orientation
			Result.append_integer (wel_log_font.orientation)
			Result.extend (',')
				-- escapement
			Result.append_integer (wel_log_font.escapement)
			Result.extend (',')
				-- width
			Result.append_integer (wel_log_font.width)
			Result.extend (',')
				-- quality
			if wel_log_font.has_proof_quality then
				Result.append ("proof")
			elseif wel_log_font.has_draft_quality then
				Result.append ("draft")
			else
				Result.append ("default")
			end
			Result.extend (',')
				-- clip_precision
			if wel_log_font.has_character_clipping_precision then
				Result.append ("character")
			elseif wel_log_font.has_stroke_clipping_precision then
				Result.append ("stroke")
			else
				Result.append ("default")
			end
			Result.extend (',')
				-- out_precision
			if wel_log_font.has_character_output_precision then
				Result.append ("character")
			elseif wel_log_font.has_string_output_precision then
				Result.append ("string")
			elseif wel_log_font.has_stroke_output_precision then
				Result.append ("stroke")
			else
				Result.append ("default")
			end
		end

	ascent: INTEGER is
			-- Ascent value in pixel of the font loaded.
		do
			Result := text_metrics.ascent
		end

	descent: INTEGER is
			-- Descent value in pixel of the font loaded.
		do
			Result := text_metrics.descent
		end

feature -- Measurement

	height: INTEGER is
			-- Height of the font
			-- Result in points
		do
			Result := wel_log_font.height
		end

	width: INTEGER is
			-- Average width of the current font
		do
			Result := wel_log_font.width
		end

	maximum_width: INTEGER is
			-- Width of the widest character in the font
		do
			Result := text_metrics.maximum_character_width
		end

	string_width (str: STRING): INTEGER is
		local
			screen_dc: WEL_SCREEN_DC
			ww: WEL_WINDOW
			number_of_lines: INTEGER
		do
			if not str.empty then
				create screen_dc
				screen_dc.get
				screen_dc.select_font (wel_font)
				number_of_lines := str.occurrences ('%N') + 1
				if number_of_lines > 1 then
					Result := maximum_line_width (screen_dc, str, number_of_lines)
				else
					Result := screen_dc.string_width (str)
				end
				screen_dc.unselect_font
				screen_dc.release
			end
		end

	horizontal_resolution: INTEGER
			-- Horizontal resolution of screen for which
			-- the font is designed

	vertical_resolution: INTEGER
			-- Vertical resolution of screen for which the font is designed

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?  
		do
			Result := not wel_font.exists
		end

	is_proportional: BOOLEAN
			-- Is the font proportional ?

	is_standard: BOOLEAN is True
			-- Is the font standard and information available?

	weight: STRING is
			-- Weight of font (Bold, Medium...)
		do
			Result := "*" 
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			wel_font.delete
			wel_font := Void
			wel_log_font := Void
		end

feature -- Element change

	set_name (str: STRING) is
			-- sets the name of the current font
		local
			h: INTEGER
		do
			if not allocated then
				h := height
				create wel_log_font.make (h, str)
				allocate
			else
				wel_log_font.set_face_name (str)
				re_allocate
			end
		end

	parse_font_string (str: STRING) is
			-- parses the `str' and calls the other set routines
		require
			valid_name: str /= Void and not str.empty
			valid_arguments_count: str.occurrences (',') = 12
		local
			pos, new_pos: INTEGER
			number: INTEGER
			parsed: ARRAY [STRING]
		do
			from
				create parsed.make (1, 13)
				number :=1
			until
				number > 13
			loop
				parsed.put ("", number)
				number := number + 1
			end
			from
				pos := 0
				new_pos := 1
				number := 1
			variant
				str.count - pos + 1
			until
				(pos > str.count) or (number = 13) or (new_pos = 0)
			loop
				new_pos := str.index_of (',', pos + 1)
				if pos < new_pos-1 then
					parsed.put (str.substring (pos+1, new_pos-1), number)
					parsed.item (number).left_adjust
					parsed.item (number).right_adjust
					if number > 1 then
						parsed.item (number).to_lower
					end
				end
				number := number+1
				pos := new_pos
			end
			if not (parsed @ 1).empty then
				wel_log_font.set_face_name (parsed @ 1)
			end
			set_height (to_integer (parsed @ 2))
			set_weight (to_integer (parsed @ 3))
			set_styles (parsed @ 4)
			set_pitch (parsed @ 5)
			set_family (parsed @ 6)
			set_charset (parsed @ 7)
			set_orientation (parsed @ 8)
			set_escapement (parsed @ 9)
			set_width (to_integer (parsed @ 10))
			set_quality (parsed @ 11)
			set_clip_precision (parsed @ 12)
			set_out_precision (parsed @ 13)
			allocate
		end

	set_width (value: INTEGER) is
			-- Make `value' the new width.
		do
			wel_log_font.set_width (value)
		end

	set_height (value: INTEGER) is
			-- Make `value' the new height.
			-- height is in points.
		local
			screen_dc: WEL_SCREEN_DC
			real_size: INTEGER
		do
			if value > 0 then
					-- Compute the real size of the font which depends of the
					-- specified size `a_height' and from the screen resolution:
					-- (height in point * Number of pixels per logical inch
					-- along the display height) / 72 pixels per inch
			--	create screen_dc
			--	screen_dc.get
			--	real_size :=   mul_div (value,
			--					get_device_caps (screen_dc.item, logical_pixels_y), 72)
			--	screen_dc.release

					-- Set the computed font height.
				wel_log_font.set_height (value)
			else
					-- Set the default height to the current font.
				wel_log_font.set_height (0)
			end
			re_allocate
		end

	set_weight (value: INTEGER) is
			-- Make `value' the new weight.
		do
			wel_log_font.set_weight (value)
		end

feature -- Implementation

	wel_font: WEL_FONT
			-- WEL font

	wel_log_font: WEL_LOG_FONT
			-- WEL_LOG_FONT to hold details

feature {NONE} -- Implementation

	text_metrics: WEL_TEXT_METRIC is
		local
			sdc: WEL_SCREEN_DC
		do
			create sdc
			sdc.get
			sdc.select_font (wel_font)
			create Result.make (sdc)
			sdc.unselect_font
			sdc.release
		ensure
			result_exists: Result /= Void
		end

feature {NONE} -- Bizarre

	allocated: BOOLEAN
			-- Has a new font been allocated?

	maximum_character_width: INTEGER is
			-- Width of the widest character in the font
		do
			Result := text_metrics.maximum_character_width
		end

	--XX Are the three following features usefull ?
	--XX And anyway, what does it do ?

	character_set: STRING is
			-- (iso8859-1, ...)
		do
			Result := "*-*" 
		end

	family: STRING is
			-- Family name (courier, Helvetica...)
		do
			Result := "*" 
		end

	foundry: STRING is
			-- Foundry name (Adobe...)
		do
			Result := "*" 
		end

	--XX

	is_specified: BOOLEAN is True
			-- Is the font specified ?

	maximum_line_width (dc: WEL_DC; str: STRING; number_of_lines: INTEGER): INTEGER is
			-- Calculate the width of the longest %N delimited string in
			-- `str' on `dc' given there are `number_of_lines' lines
		require
			efficient: number_of_lines > 1
		local
			i, pos, new_pos: INTEGER
			line: STRING
		do
			from
				i := 1
				pos := 0
			until
				i > number_of_lines or pos + 1 > str.count
			loop
				new_pos := str.index_of ('%N', pos +1)
				if new_pos = 0 then
					line := str.substring (pos+1, str.count)
					Result := Result.max (dc.string_width (line))
				elseif new_pos /= pos + 1 then
					line := str.substring (pos+1, new_pos-1)
					Result := Result.max (dc.string_width (line))
					pos := new_pos
				else
					pos := pos + 1
				end
				i := i + 1
			end
		end

	point: INTEGER
			-- Size of font in tenth of points (1 point = 1/72 of an inch)

-- XX is this usefull ?
	slant: CHARACTER is
			-- Slant of font (o, r, i...)
		do
			Result := '*' 
		end

	allocate is
			-- Allocate the WEL_FONT
		do
			create wel_font.make_indirect (wel_log_font)
			allocated := True
		end

	re_allocate is
			-- Re-allocate the WEL_FONT (doesn't make new object)
		do
			wel_font.set_indirect (wel_log_font)
			allocated := True
		end

	set_charset (a_charset: STRING) is
			-- Set the charset to a value based on `a_charset'
		do
			if a_charset.is_equal ("ansi") then
				wel_log_font.set_ansi_character_set
			elseif a_charset.is_equal ("oem") then
				wel_log_font.set_oem_character_set
			elseif a_charset.is_equal ("symbol") then
				wel_log_font.set_symbol_character_set
			elseif a_charset.is_equal ("unicode") then
				wel_log_font.set_unicode_character_set
			else
				wel_log_font.set_default_character_set
			end
		end

	set_clip_precision (a_clip_precision: STRING) is
			-- Set the clip precision based on `a_clip_precision'
		do
			if a_clip_precision.is_equal ("character") then
				wel_log_font.set_character_clipping_precision
			elseif a_clip_precision.is_equal ("stroke") then
				wel_log_font.set_stroke_clipping_precision
			else
				wel_log_font.set_default_clipping_precision
			end
		end

	set_escapement (an_escapement: STRING) is
			-- Set escapement based on value of `an_escapement'
		do
			if an_escapement /= Void and an_escapement.is_integer then
				wel_log_font.set_escapement (an_escapement.to_integer)
			else	
				wel_log_font.set_escapement (0)
			end
		end

	set_family (a_family: STRING) is
			-- Set family based on a value in `a_family'
		do
			if a_family.is_equal ("decorative") then
				wel_log_font.set_decorative_family 
			elseif a_family.is_equal ("modern") then
				wel_log_font.set_modern_family 
			elseif a_family.is_equal ("script") then
				wel_log_font.set_script_family 
			elseif a_family.is_equal ("roman") then
				wel_log_font.set_roman_family
			elseif a_family.is_equal ("swiss") then
				wel_log_font.set_swiss_family
			else
				wel_log_font.set_dont_care_family
			end
		end

	set_orientation (an_orientation: STRING) is
			-- Set the orientation based om the value of `an_orientation'
		do
			if an_orientation /= Void and then an_orientation.is_integer then
				wel_log_font.set_orientation (an_orientation.to_integer)
			else
				wel_log_font.set_orientation (0)
			end
		end

	set_out_precision (a_precision: STRING) is
			-- Set the precision based on the value of `a_precision'
		do
			if a_precision.is_equal ("character") then
				wel_log_font.set_character_output_precision
			elseif a_precision.is_equal ("string") then
				wel_log_font.set_string_output_precision
			elseif a_precision.is_equal ("stroke") then
				wel_log_font.set_stroke_output_precision
			else
				wel_log_font.set_default_output_precision
			end
		end

	set_pitch (a_pitch: STRING) is
			-- Set pitch based on value in `a_pitch'
		do
			if a_pitch.is_equal ("fixed") then
				wel_log_font.set_fixed_pitch
			elseif a_pitch.is_equal ("variable") then
				wel_log_font.set_variable_pitch
			else
				wel_log_font.set_default_pitch
			end
		end

	set_quality (a_quality: STRING) is
			-- Set quality based on value in `a_quality'
		do
			if a_quality.is_equal ("draft") then
				wel_log_font.set_draft_quality
			elseif a_quality.is_equal ("proof") then
				wel_log_font.set_proof_quality
			else
				wel_log_font.set_default_quality
			end
		end

	set_styles (styles: STRING) is
			-- Set the style based on values in `styles'
		do
			wel_log_font.set_not_italic
			wel_log_font.set_not_underlined
			wel_log_font.set_not_strike_out
			if styles /= Void then
				if styles.has ('i') then
					wel_log_font.set_italic
				end
				if styles.has ('u') then
					wel_log_font.set_underlined
				end
				if styles.has ('s') then
					wel_log_font.set_strike_out
				end
			end
		end

feature {NONE} -- Implementation

	to_integer (s: STRING): INTEGER is
			-- Convert `s' to its integer representation.
			-- 0 if `s' is not an integer.
		do
			if s /= Void and then s.is_integer then
				Result := s.to_integer
			end
		end

	mul_div (i,j,k: INTEGER): INTEGER is
			-- Does `i * j / k' but in a safe manner where the 64 bits integer
			-- obtained by `i * j' is not truncated.
		external
			"C [macro <windows.h>] (int, int, int): EIF_INTEGER"
		alias
			"MulDiv"
		end

	get_device_caps (p: POINTER; i: INTEGER): INTEGER is
			-- Retrieves device-specific information about a specified device.
		external
			"C [macro <windows.h>] (HDC, int): EIF_INTEGER"
		alias
			"GetDeviceCaps"
		end

invariant
	wel_log_font_exists: wel_log_font /= Void
	wel_font_exists: wel_font /= Void

end -- class EV_FONT_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

