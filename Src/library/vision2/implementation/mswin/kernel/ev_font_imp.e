--| FIXME Not for release
indexing
	description: "Eiffel Vision font. Mswindows implementation."
	status: "See notice at end of class"
	keywords: "character, face, height, family, weight, shape, bold, italic"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_IMP

inherit
	EV_FONT_I

	EV_FONT_CONSTANTS

	WEL_CAPABILITIES_CONSTANTS
		rename
			vertical_resolution as sceeen_vertical_resolution,
			horizontal_resolution as screen_horizontal_resolution
		export
			{NONE} all
		end

create
	make

feature {EV_FONTABLE_IMP, EV_FONT_DIALOG_IMP} -- Initialization

	--| Note on implementation. VB 10 jan 2000
	--| All information is stored in wel_log_font, although
	--| wel_font is the actual font object. Every time there is
	--| is an update on wel_log_font, the wel_font has to be created
	--| again by: wel_font.set_indirect (wel_log_font). In the creation
	--| procedure, first the wel_font is created, because wel_log_font
	--| cannot be instantiated without arguments.

	make (an_interface: like interface) is
			-- Create a font.
		do
			base_make (an_interface)
			create {WEL_SYSTEM_FONT} wel_font.make
			create wel_log_font.make_by_font (wel_font)
			create wel_font.make_indirect (wel_log_font)
			wel_log_font.set_width (0)
			set_family (Ev_font_family_sans)
			set_weight (Ev_font_weight_regular)
			set_shape (Ev_font_shape_regular)
			set_height (8)
		end

	initialize is
		do
			is_initialized := True
		end

feature -- Access

	family: INTEGER
			-- Preferred font category.

	weight: INTEGER
			-- Preferred font thickness.

	shape: INTEGER
			-- Preferred font slant.

	height: INTEGER is
			-- Preferred font height measured in screen pixels.
		do
			Result := wel_log_font.height
		end

	preferred_face: STRING
			-- Preferred user font.
			-- `family' will be ignored when not Void.

feature -- Element change

	set_family (a_family: INTEGER) is
			-- Set `a_family' as preferred font category.
		do
			family := a_family
			update_font_face
		end

	set_weight (a_weight: INTEGER) is
			-- Set `a_weight' as preferred font thickness.
		do
			weight := a_weight
			inspect weight
			when Ev_font_weight_thin then
				wel_log_font.set_weight (100)
			when Ev_font_weight_regular then
				wel_log_font.set_weight (400)
			when Ev_font_weight_bold then
				wel_log_font.set_weight (700)
			when Ev_font_weight_black then
				wel_log_font.set_weight (1000)
			else
				check impossible: False end
			end
			wel_font.set_indirect (wel_log_font)
		end

	set_shape (a_shape: INTEGER) is
			-- Set `a_shape' as preferred font slant.
		do
			shape := a_shape
			inspect shape
			when Ev_font_shape_regular then
				wel_log_font.set_not_italic
			when Ev_font_shape_italic then
				wel_log_font.set_italic
			else
				check impossible: False end
			end
			wel_font.set_indirect (wel_log_font)
		end

	set_height (a_height: INTEGER) is
			-- Set `a_height' as preferred font size.
		do
			wel_log_font.set_height (a_height)
			wel_font.set_indirect (wel_log_font)
		end

	set_preferred_face (a_preferred_face: STRING) is
			-- Set `a_preferred_face' as preferred font face.
		do
			preferred_face := a_preferred_face
			update_font_face
		end

	remove_preferred_face is
			-- Set `a_preferred_face' to Void.
		do
			preferred_face := Void
			update_font_face
		end

feature -- Status report

	name: STRING is
			-- Face name chosen by toolkit.
		do
			Result := wel_log_font.face_name
		end

	ascent: INTEGER is
			-- Vertical distance from the origin of the drawing
			-- operation to the top of the drawn character. 
		do
			Result := text_metrics.ascent
		end

	descent: INTEGER is
			-- Vertical distance from the origin of the drawing
			-- operation to the bottom of the drawn character. 
		do
			Result := text_metrics.descent
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
			Result := string_width ("w")
		end

	string_width (a_string: STRING): INTEGER is
			-- Width in pixels of `a_string' in the current font.
		local
			screen_dc: WEL_SCREEN_DC
			ww: WEL_WINDOW
			number_of_lines: INTEGER
		do
			if a_string /= Void and then not a_string.empty then
				create screen_dc
				screen_dc.get
				screen_dc.select_font (wel_font)
				number_of_lines := a_string.occurrences ('%N') + 1
				if number_of_lines > 1 then
					Result := maximum_line_width (screen_dc, a_string, number_of_lines)
				else
					Result := screen_dc.string_width (a_string)
				end
				screen_dc.unselect_font
				screen_dc.release
			end
		end

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font is designed.
		do
			check
				to_be_implemented: False
			end
			Result := 1
		end

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font is designed.
		do
			check
				to_be_implemented: False
			end
			Result := 1
		end

	is_proportional: BOOLEAN is
			-- Can characters in the font have different sizes?
		do
			check
				to_be_implemented: False
			end
			Result := True
		end
 
feature -- Obsolete

	system_name: STRING is
			-- Platform dependent font name.
		do
			Result := "Obsolete"
		end

 	is_standard: BOOLEAN is True
 			-- Is the font standard and informations available (except for name) ?

feature {EV_ANY_I} -- Access

	wel_font: WEL_FONT
			-- Basic WEL font.

	wel_log_font: WEL_LOG_FONT
			-- More detail added to WEL font.

feature {EV_FONTABLE_IMP} -- Access

	set_by_wel_font (wf: WEL_FONT) is
			-- Set state by passing an already created WEL_FONT.
		obsolete
			"This is not the way we do things in vision2."
		do
			wel_font := wf
			create wel_log_font.make_by_font (wel_font)
			family := 0
			weight := 0
			shape := 0
			preferred_face := Void
		end

feature {NONE} -- Implementation

	destroy is
			-- Destroy WEL font.
		do
			wel_font.delete
		end

	update_font_face is
			-- Find a font face based on properties
			-- `preferred_face' and `family'.
		do
			--| FIXME NOTE
			--| There seems to be a bug in WEL:
			--| postcondition violation in set_family.

			if preferred_face /= Void then
				set_name (preferred_face)
			else
				inspect family
				when Ev_font_family_screen then
					set_name ("System")
				when Ev_font_family_roman then
					set_name ("Times New Roman")
				when Ev_font_family_sans then
					set_name ("MS Sans Serif")
				when Ev_font_family_typewriter then
					set_name ("Courier New")
				when Ev_font_family_modern then
					set_name ("Modern")
				else
					check impossible: False end
				end
			end
		end

	set_name (str: STRING) is
			-- sets the name of the current font
		do
			wel_log_font.set_face_name (str)
			wel_font.set_indirect (wel_log_font)
		end

	remove_name is
			-- Set face name on WEL font to NULL.
			-- Let toolkit find the best matching name.
		do
			--| FIXME VB
			--| WEL-expert? Please check this code:
			--cwel_log_font_set_facename (wel_log_font.item, Default_pointer)
		end

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

	text_metrics: WEL_TEXT_METRIC is
			-- Text metric object for current WEL font.
			--| Used to get `ascent' and `descent'.
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

feature {NONE} -- Not used

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

	OLD_set_family (a_family: STRING) is
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


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.17  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.16.6.13  2000/01/27 19:30:10  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.16.6.12  2000/01/21 23:13:45  brendel
--| Changed moment at which default values are set.
--|
--| Revision 1.16.6.11  2000/01/19 23:42:09  rogers
--| In make, changed wel_log_font.make_with_font to wel_log_font.make_by_font.
--|
--| Revision 1.16.6.10  2000/01/19 22:15:05  king
--| Changed export status of set_by_wel_font.
--|
--| Revision 1.16.6.9  2000/01/19 22:00:27  king
--| Added function `set_by_wel_font'.
--| This does not set the variables of EV_FONT!
--|
--| Revision 1.16.6.8  2000/01/12 00:34:36  king
--| Nicer default font.
--|
--| Revision 1.16.6.7  2000/01/11 01:23:42  king
--| Fixed minor bug regarding widths of fonts.
--|
--| Revision 1.16.6.6  2000/01/11 00:50:35  king
--| Changed behaviour of set_family, so that it has a nice
--| default value.
--| Fixed minor bug in set_weight.
--|
--| Revision 1.16.6.5  2000/01/10 20:20:48  rogers
--| Stengthend  pre-condition on string_width.
--|
--| Revision 1.16.6.4  2000/01/10 19:14:06  king
--| Changed interface.
--| Improved comments.
--| Improved contracts.
--| set_name is now obsolete.
--|
--| Revision 1.16.6.3  2000/01/10 17:11:58  rogers
--| strngthened pre-condition on string width.
--|
--| Revision 1.16.6.2  1999/12/17 17:24:32  rogers
--| Altered to fit in with the review branch.Make procedures have been changed temporarily, not final.
--|
--| Revision 1.16.6.1  1999/11/24 17:30:18  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.16.2.3  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
