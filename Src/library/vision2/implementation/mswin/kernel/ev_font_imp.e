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
		redefine
			string_size
		end

	EV_FONT_CONSTANTS

	WEL_SHARED_FONTS
		export
			{NONE} all
		end

	WEL_FONT_FAMILY_CONSTANTS
		export
			{NONE} all
		end

	WEL_FONT_PITCH_CONSTANTS
		export
			{NONE} all
		end

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

	--|----------------------------------------------------------------
	--| Note on implementation. VB 10 jan 2000
	--|----------------------------------------------------------------
	--| All information is stored in wel_log_font, although
	--| wel_font is the actual font object. Every time there is
	--| is an update on wel_log_font, the wel_font has to be created
	--| again by: wel_font.set_indirect (wel_log_font). In the creation
	--| procedure, first the wel_font is created, because wel_log_font
	--| cannot be instantiated without arguments.
	--|----------------------------------------------------------------

	make (an_interface: like interface) is
			-- Create `Current'.
		do
			base_make (an_interface)
			create wel_font.make_indirect (default_wel_log_font)

				-- Create and setup the preferred font face mechanism
			create preferred_families
			preferred_families.add_actions.extend (~update_preferred_faces)
			preferred_families.remove_actions.extend (~update_preferred_faces)

				-- Retrieve shape, weight and family from
				-- the default font returned by Windows.
			shape := convert_font_shape(default_wel_log_font.italic)
			weight := convert_font_weight(default_wel_log_font.weight)
			family := family_screen
			internal_face_name := default_wel_log_font.face_name
			update_internal_is_proportional(default_wel_log_font)
		end


	initialize is
			-- Initialize `Current'.
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
			Result := wel_font.height
		end

feature -- Element change

	set_family (a_family: INTEGER) is
			-- Set `a_family' as preferred font category.
		do
				-- retrieve current values
			wel_log_font.update_by_font(wel_font)

				-- change value
			family := a_family

				-- commit changes to `wel_log_font' into `wel_font'.
			update_font_face
		end

	set_weight (a_weight: INTEGER) is
			-- Set `a_weight' as preferred font thickness.
		do
				-- retrieve current values
			wel_log_font.update_by_font(wel_font)

				-- change value
			weight := a_weight
			inspect weight
			when weight_thin then
				wel_log_font.set_weight (100)
			when weight_regular then
				wel_log_font.set_weight (400)
			when weight_bold then
				wel_log_font.set_weight (700)
			when weight_black then
				wel_log_font.set_weight (900)
			else
				check impossible: False end
			end

				-- commit changes to `wel_log_font' into `wel_font'.
			wel_font.set_indirect (wel_log_font)
		end

	set_shape (a_shape: INTEGER) is
			-- Set `a_shape' as preferred font slant.
		do
				-- retrieve current values
			wel_log_font.update_by_font(wel_font)

				-- change value
			shape := a_shape
			inspect shape
			when shape_regular then
				wel_log_font.set_not_italic
			when shape_italic then
				wel_log_font.set_italic
			else
				check impossible: False end
			end

				-- commit changes to `wel_log_font' into `wel_font'.
			wel_font.set_indirect (wel_log_font)
		end

	set_height (a_height: INTEGER) is
			-- Set `a_height' as preferred font size in pixels.
		do
			wel_font.set_height (a_height)
			wel_log_font.update_by_font (wel_font) 
		end

feature -- Status report

	name: STRING is
			-- Face name chosen by toolkit.
		do
			Result := internal_face_name
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
			Result := wel_font.width
		end

	minimum_width: INTEGER is
			-- Width of the smallest character in the font.
		do
			Result := wel_font.string_width ("l")
		end

	maximum_width: INTEGER is
			-- Width of the biggest character in the font.
		do
			Result := wel_font.string_width ("W")
		end

	string_width (a_string: STRING): INTEGER is
			-- Width in pixels of `a_string' in the current font.
		do
			Result := wel_font.string_width (a_string)
		end

	string_size (a_string: STRING): TUPLE [INTEGER, INTEGER] is
			-- [width, height] in pixels of `a_string' in the current font,
			-- taking into account line breaks ('%N').
		do
			Result := wel_font.string_size (a_string)
				--| FIXME The Result from `wel_font' is not correctly being
				--| returned when `Current' is italic. The width is smaller
				--| than the displayed width. I believe the overhang from
				--| text_metric should be taken into account, but when
				--| queried, this would always return 0. See TEXTMETRIC from
				--| MSDN. For now, if `Current' is italic then we add 1/6 of the
				--| height. Julian 11/01/2001
			if shape = shape_italic then
				Result.force (Result.integer_item (2) // 6 +
					Result.integer_item (1), 1)
			end
		end

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font is designed.
		do
			Result := text_metrics.digitized_aspect_x
		end

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font is designed.
		do
			Result := text_metrics.digitized_aspect_y
		end

	is_proportional: BOOLEAN is
			-- Can characters in the font have different sizes?
		do
			Result := internal_is_proportional
		end
 
feature {EV_ANY_I} -- Access

	wel_font: WEL_FONT
			-- Basic WEL font.

feature {EV_FONTABLE_IMP, EV_FONT_DIALOG_IMP} -- Access

	set_by_wel_font (wf: WEL_FONT) is
			-- Set state by passing an already created WEL_FONT.
		do
			wel_font := wf
			wel_log_font.update_by_font (wel_font)
			shape := convert_font_shape(wel_log_font.italic)
			weight := convert_font_weight(wel_log_font.weight)
			family := convert_font_family(wel_log_font.family,
				wel_log_font.pitch)
			preferred_families.wipe_out
			preferred_families.extend (clone(wel_log_font.face_name))
		end

feature {EV_ANY_I} -- Implementation

	wel_log_font: WEL_LOG_FONT is
			-- Structure used to specify font characteristics.
		once
			create Result.make_by_font (gui_font)
		end

	default_wel_log_font: WEL_LOG_FONT is
			-- Structure used to initialize fonts.
		once
			create Result.make_by_font (gui_font)
				
				-- set the WEL family associated to Vision2 Screen fonts.
			wel_screen_font_family := Result.family
			wel_screen_font_pitch := Result.pitch
		end

	destroy is
			-- Destroy `Current'.
		do
			wel_font.delete
			wel_font := Void
		end

	update_preferred_faces (a_face: STRING) is
		do
				-- retrieve current values
			wel_log_font.update_by_font(wel_font)

				-- commit changes to `wel_log_font' into `wel_font'.
			update_font_face
		end

	update_font_face is
			-- Find a font face based on properties
			-- `preferred_face' and `family'.
		local
			lower_face: STRING
			found: BOOLEAN
		do
				-- First, set the family
			inspect family
			when family_screen then
				wel_log_font.set_family(wel_screen_font_family)
				wel_log_font.set_pitch(wel_screen_font_pitch)

			when family_roman then
				wel_log_font.set_roman_family
				wel_log_font.set_variable_pitch

			when family_sans then
				wel_log_font.set_swiss_family
				wel_log_font.set_variable_pitch

			when family_typewriter then
				wel_log_font.set_modern_family
				wel_log_font.set_fixed_pitch

			when family_modern then
				wel_log_font.set_modern_family
				wel_log_font.set_variable_pitch
			else
				check impossible: False end
			end

				-- Then, set the face name (if any)
			if not preferred_families.is_empty then
				from
					preferred_families.start
				until
					found or preferred_families.after
				loop
					lower_face := clone(preferred_families.item)
					lower_face.to_lower
					found := Font_enumerator.font_faces.has (lower_face)
					preferred_families.forth
				end
				if found then
					wel_log_font.set_face_name (lower_face)
				else
						-- Preferred face not found, leave Windows do
						-- its best.
					wel_log_font.set_face_name ("")
				end
			else
					-- Leave Windows choose the font that best
					-- match our attributes.
				wel_log_font.set_face_name ("")
			end

				-- commit changes to `wel_log_font' into `wel_font'.
			wel_font.set_indirect (wel_log_font)

				-- retrieve values set by windows
			wel_log_font.update_by_font(wel_font)

				-- Update internal attributes.
			internal_face_name := clone(wel_log_font.face_name)
			update_internal_is_proportional(wel_log_font)
		end

	set_name (str: STRING) is
			-- sets the name of the current font
		do
				-- retrieve current values
			wel_log_font.update_by_font(wel_font)

				-- change value
			wel_log_font.set_face_name (str)

				-- commit changes to `wel_log_font' into `wel_font'.
			update_font_face
		end

	remove_name is
			-- Set face name on WEL font to NULL.
			-- Let toolkit find the best matching name.
		do
				-- retrieve current values
			wel_log_font.update_by_font(wel_font)

				-- change value (Leave windows choose the font)
			wel_log_font.set_face_name ("")

				-- commit changes to `wel_log_font' into `wel_font'.
			update_font_face
		end

	internal_face_name: STRING
		-- Font face name.

	internal_is_proportional: BOOLEAN
		-- Is the font proportional? (or fixed).

	update_internal_is_proportional(logfont: WEL_LOG_FONT) is
		do	
			if logfont.pitch = Default_pitch then
				internal_is_proportional := not (logfont.family = Ff_modern)
						
			elseif logfont.pitch = Fixed_pitch then
				internal_is_proportional := False

			elseif logfont.pitch = Variable_pitch then
				internal_is_proportional := True
			end
		end

	maximum_line_width (dc: WEL_DC; str: STRING; number_of_lines: INTEGER):
		INTEGER is
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
			--| Used to get `ascent' and `descent', horizontal_resolution
			--| and vertical_resolution.
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

	wel_screen_font_family: INTEGER
			-- Windows Family (Ff_roman, Ff_swiss, ...) associated
			-- to family_screen.

	wel_screen_font_pitch: INTEGER
			-- Windows Pitch (Ff_roman, Ff_swiss, ...) associated
			-- to family_screen.


	convert_font_family(wel_family: INTEGER; wel_pitch: INTEGER): INTEGER is
			-- Convert a Windows Font Family into a Vision2 Font Family.
		do
			if wel_family = wel_screen_font_family then
				Result := family_screen
			elseif wel_family = Ff_roman then
				Result := family_roman
			elseif wel_family = Ff_swiss then
				Result := family_sans
			elseif wel_family = Ff_modern then
				if wel_pitch = Variable_pitch then
					Result := family_modern
				else
					Result := family_typewriter
				end
			else
					-- none of the above match, so we take
					-- an arbitrary family
				Result := family_sans
			end
		end

	convert_font_weight(wel_weight: INTEGER): INTEGER is
			-- Convert `wel_weight' (weight of a WEL_FONT) into
			-- a vision2 weight constant.
		do
			inspect wel_weight
			when 1..249 then
				Result := weight_thin
			when 250..549 then
				Result := weight_regular
			when 550..799 then
				Result := weight_bold
			when 800..1000 then
				Result := weight_black
			else
				check impossible: False end
			end
		end

	convert_font_shape(wel_italic: BOOLEAN): INTEGER is
			-- Convert `wel_italic' (italic of a WEL_LOG_FONT) into
			-- a vision2 shape constant.
		do
			if wel_italic then
				Result := shape_italic
			else
				Result := shape_regular
			end
		end

feature {EV_TEXTABLE_IMP} -- Implementation

	string_width_and_height_ignore_new_line (a_string: STRING):
		TUPLE [INTEGER, INTEGER] is
			-- [width, height] of `a_string'.
			-- Treat `%N' as a character.
		require
			a_string_not_void: a_string /= Void
		local
			screen_dc: WEL_SCREEN_DC
			extent: WEL_SIZE
		do
			create screen_dc
			screen_dc.get
			screen_dc.select_font (wel_font)
			extent := screen_dc.string_size (a_string)
			screen_dc.unselect_font
			screen_dc.quick_release
			Result := [extent.width, extent.height]
		end

	Font_enumerator: EV_WEL_FONT_ENUMERATOR_IMP is
			-- Enumerate Installed fonts
		once
			create Result
		end

feature -- Obsolete

	string_width_and_height (a_string: STRING): TUPLE [INTEGER, INTEGER] is
			-- [width, height] of `a_string'.
		obsolete
			"Use `string_size'."
		do
			Result := wel_font.string_size (a_string)
		end

feature {NONE} -- Not used

	set_charset (a_charset: STRING) is
			-- Set the charset to a value based on `a_charset'.
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
			-- Set the clip precision based on `a_clip_precision'.
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
			-- Set escapement based on value of `an_escapement'.
		do
			if an_escapement /= Void and an_escapement.is_integer then
				wel_log_font.set_escapement (an_escapement.to_integer)
			else	
				wel_log_font.set_escapement (0)
			end
		end

	set_orientation (an_orientation: STRING) is
			-- Set the orientation based on the value of `an_orientation'.
		do
			if an_orientation /= Void and then an_orientation.is_integer then
				wel_log_font.set_orientation (an_orientation.to_integer)
			else
				wel_log_font.set_orientation (0)
			end
		end

	set_out_precision (a_precision: STRING) is
			-- Set the precision based on the value of `a_precision'.
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
			-- Set pitch based on value in `a_pitch'.
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
			-- Set quality based on value in `a_quality'.
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
			-- Set the style based on values in `styles'.
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

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------


--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.38  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.37  2001/06/14 18:45:32  rogers
--| Corrected spelling mistake. familys is now families.
--|
--| Revision 1.36  2001/06/14 17:23:02  rogers
--| Renamed preferred_faces to preferred_familys.
--|
--| Revision 1.35  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.16.4.17  2001/01/31 23:41:57  rogers
--| Removed old_set_family as redundent.
--|
--| Revision 1.16.4.15  2001/01/11 19:28:41  rogers
--| Fixed bug in string_size, so the size returned will cover `Current' when it
--| is italic. Formatting.
--|
--| Revision 1.16.4.14  2000/12/11 18:13:31  pichery
--| Removed useless obsolete message since the feature is really
--| used.
--|
--| Revision 1.16.4.13  2000/12/08 03:09:07  manus
--| Use `height' and `set_height' from WEL_FONT instead of implementing it
--| here.
--|
--| Revision 1.16.4.13  2000/12/08 02:55:29  manus
--| Use `height' and `set_height' from WEL_FONT instead of reimplementing
--| something the same code everywhere.
--|
--| Revision 1.16.4.12  2000/11/29 00:46:19  rogers
--| Changed empty to is_empty.
--|
--| Revision 1.16.4.11  2000/11/07 22:34:55  king
--| Accounted for font constants name change
--|
--| Revision 1.16.4.10  2000/10/28 01:02:59  manus
--| Removed code from EV_FONT_IMP (width, height, string_width, string_height,
--| string_size) and put it in WEL_FONT. Therefore I adapted the code to take
--| this into account.
--|
--| Revision 1.16.4.9  2000/10/16 14:21:45  pichery
--| - Removed obsolete features
--| - Replaced `dispose' with `delete'.
--|
--| Revision 1.16.4.8  2000/10/12 15:50:23  pichery
--| Added reference tracking for GDI objects to decrease
--| the number of GDI objects alive.
--|
--| Revision 1.16.4.7  2000/08/11 19:14:54  rogers
--| Fixed copyright clause. Now use ! instead of |.
--|
--| Revision 1.16.4.6  2000/08/08 00:36:07  manus
--| `wel_log_font' is now exported to all windows implementations
--|
--| Revision 1.16.4.5  2000/07/27 17:21:42  pichery
--| Removed obsolete call
--|
--| Revision 1.16.4.4  2000/06/25 18:01:52  brendel
--| Obsoleted string_width_and_height, now called string_size.
--| Cosmetics for string_size.
--|
--| Revision 1.16.4.3  2000/06/15 17:24:07  rogers
--| Make now calls add_actions and remove_actions on preferred faces, instead
--| of added_actions and removed_actions, due to a name change.
--|
--| Revision 1.16.4.2  2000/06/15 03:41:41  pichery
--| Remove `preferred_face'
--| Added features to select the best font among
--| `preferred_faces'.
--|
--| Revision 1.16.4.1  2000/05/03 19:09:13  oconnor
--| mergred from HEAD
--|
--| Revision 1.34  2000/05/01 23:37:11  rogers
--| Column formatting.
--|
--| Revision 1.33  2000/05/01 23:30:01  rogers
--| Implemented horizontal_resolution and vertical_resolution.
--| Comments and formatting.
--|
--| Revision 1.32  2000/04/11 19:29:45  pichery
--| cosmetics
--|
--| Revision 1.31  2000/03/09 16:14:59  brendel
--| Improved comment and implementation of string_width_and_height.
--|
--| Revision 1.30  2000/03/03 17:03:46  brendel
--| Added `string_width_and_height_ignore_new_line'. Used in EV_BUTTON_IMP.
--|
--| Revision 1.29  2000/03/03 02:37:48  pichery
--| - Optimizated feature `name'.
--| - Implemented feature `is_proportional'
--|
--| Revision 1.28  2000/03/03 01:37:45  brendel
--| Removed calculate_text_extent.
--| Added string_width_and_height.
--|
--| Revision 1.27  2000/03/03 01:23:52  brendel
--| Improved implementation of calculate_text_extent.
--|
--| Revision 1.26  2000/03/03 01:06:53  brendel
--| Improved implementation of calculate_text_extent.
--|
--| Revision 1.25  2000/03/03 00:53:27  brendel
--| Attempt to improve string_width. Testing required.
--|
--| Revision 1.24  2000/02/24 05:00:32  pichery
--| Fixed a bug: The default creation procedure created a new font using the
--| characteristics of the last font used instead of creating a fresh new font
--| with the default values.
--|
--| Revision 1.23  2000/02/23 02:31:10  pichery
--| Removed a useless local variable. No big deal !
--|
--| Revision 1.22  2000/02/22 21:22:32  pichery
--| The default creation of EV_FONT under Windows now creates the
--| WEL_DEFAULT_GUI_FONT and set family, weight and shape according to
--| the retrieved font.
--|
--| Revision 1.21  2000/02/22 19:51:50  rogers
--| set_height in make now takes 15 as the argument for the font height as
--| height is now measured in pixels rather than the previous implementation,
--| using points.
--|
--| Revision 1.20  2000/02/21 20:02:39  pichery
--| Changed implementation of EV_FONT under Windows. Now we only keep one
--| WEL_LOG_FONT structure in memory for all EV_FONT objects (wel_log_font is
--| a once feature). This avoid the creation of a lot of Windows objects.
--|
--| Revision 1.19  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.18  2000/02/15 17:36:18  brendel
--| Changed re-creation of wel_font object to resetting using newly improved
--| WEL_FONT.set_indirect.
--|
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
--| Altered to fit in with the review branch. Make procedures have been
--| changed temporarily, not final.
--|
--| Revision 1.16.6.1  1999/11/24 17:30:18  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.16.2.3  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
