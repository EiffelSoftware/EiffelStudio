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
			create wel_font.make_indirect (Default_wel_log_font)

				-- Create and setup the preferred font face mechanism
			create preferred_families
			preferred_families.add_actions.extend (~update_preferred_faces)
			preferred_families.remove_actions.extend (~update_preferred_faces)

				-- Retrieve shape, weight and family from
				-- the default font returned by Windows.
			shape := convert_font_shape(Default_wel_log_font.italic)
			weight := convert_font_weight(Default_wel_log_font.weight)
			family := family_screen
			internal_face_name := Default_wel_log_font.face_name
			update_internal_is_proportional(Default_wel_log_font)
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
			Wel_log_font.update_by_font(wel_font)

				-- change value
			family := a_family

				-- commit changes to `Wel_log_font' into `wel_font'.
			update_font_face
		end

	set_weight (a_weight: INTEGER) is
			-- Set `a_weight' as preferred font thickness.
		do
				-- retrieve current values
			Wel_log_font.update_by_font(wel_font)

				-- change value
			weight := a_weight
			inspect weight
			when weight_thin then
				Wel_log_font.set_weight (100)
			when weight_regular then
				Wel_log_font.set_weight (400)
			when weight_bold then
				Wel_log_font.set_weight (700)
			when weight_black then
				Wel_log_font.set_weight (900)
			else
				check impossible: False end
			end

				-- commit changes to `Wel_log_font' into `wel_font'.
			wel_font.set_indirect (Wel_log_font)
		end

	set_shape (a_shape: INTEGER) is
			-- Set `a_shape' as preferred font slant.
		do
				-- retrieve current values
			Wel_log_font.update_by_font(wel_font)

				-- change value
			shape := a_shape
			inspect shape
			when shape_regular then
				Wel_log_font.set_not_italic
			when shape_italic then
				Wel_log_font.set_italic
			else
				check impossible: False end
			end

				-- commit changes to `Wel_log_font' into `wel_font'.
			wel_font.set_indirect (Wel_log_font)
		end

	set_height (a_height: INTEGER) is
			-- Set `a_height' as preferred font size in pixels.
		do
			wel_font.set_height (a_height)
			Wel_log_font.update_by_font (wel_font) 
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
			Wel_log_font.update_by_font (wel_font)
			shape := convert_font_shape(Wel_log_font.italic)
			weight := convert_font_weight(Wel_log_font.weight)
			family := convert_font_family(Wel_log_font.family,
				Wel_log_font.pitch)
			preferred_families.wipe_out
			preferred_families.extend (clone(Wel_log_font.face_name))
		end

feature {EV_ANY_I} -- Implementation

	Wel_log_font: WEL_LOG_FONT is
			-- Structure used to specify font characteristics.
		once
			create Result.make_by_font (gui_font)
		end

	Default_wel_log_font: WEL_LOG_FONT is
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
			Wel_log_font.update_by_font(wel_font)

				-- commit changes to `Wel_log_font' into `wel_font'.
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
				Wel_log_font.set_family(wel_screen_font_family)
				Wel_log_font.set_pitch(wel_screen_font_pitch)

			when family_roman then
				Wel_log_font.set_roman_family
				Wel_log_font.set_variable_pitch

			when family_sans then
				Wel_log_font.set_swiss_family
				Wel_log_font.set_variable_pitch

			when family_typewriter then
				Wel_log_font.set_modern_family
				Wel_log_font.set_fixed_pitch

			when family_modern then
				Wel_log_font.set_modern_family
				Wel_log_font.set_variable_pitch
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
					Wel_log_font.set_face_name (lower_face)
				else
						-- Preferred face not found, leave Windows do
						-- its best.
					Wel_log_font.set_face_name ("")
				end
			else
					-- Leave Windows choose the font that best
					-- match our attributes.
				Wel_log_font.set_face_name ("")
			end

				-- commit changes to `Wel_log_font' into `wel_font'.
			wel_font.set_indirect (Wel_log_font)

				-- retrieve values set by windows
			Wel_log_font.update_by_font(wel_font)

				-- Update internal attributes.
			internal_face_name := clone(Wel_log_font.face_name)
			update_internal_is_proportional(Wel_log_font)
		end

	set_name (str: STRING) is
			-- sets the name of the current font
		do
				-- retrieve current values
			Wel_log_font.update_by_font(wel_font)

				-- change value
			Wel_log_font.set_face_name (str)

				-- commit changes to `Wel_log_font' into `wel_font'.
			update_font_face
		end

	remove_name is
			-- Set face name on WEL font to NULL.
			-- Let toolkit find the best matching name.
		do
				-- retrieve current values
			Wel_log_font.update_by_font(wel_font)

				-- change value (Leave windows choose the font)
			Wel_log_font.set_face_name ("")

				-- commit changes to `Wel_log_font' into `wel_font'.
			update_font_face
		end

	internal_face_name: STRING
		-- Font face name.

	internal_is_proportional: BOOLEAN
		-- Is the font proportional? (or fixed).

	update_internal_is_proportional(logfont: Wel_log_font) is
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
				Wel_log_font.set_ansi_character_set
			elseif a_charset.is_equal ("oem") then
				Wel_log_font.set_oem_character_set
			elseif a_charset.is_equal ("symbol") then
				Wel_log_font.set_symbol_character_set
			elseif a_charset.is_equal ("unicode") then
				Wel_log_font.set_unicode_character_set
			else
				Wel_log_font.set_default_character_set
			end
		end

	set_clip_precision (a_clip_precision: STRING) is
			-- Set the clip precision based on `a_clip_precision'.
		do
			if a_clip_precision.is_equal ("character") then
				Wel_log_font.set_character_clipping_precision
			elseif a_clip_precision.is_equal ("stroke") then
				Wel_log_font.set_stroke_clipping_precision
			else
				Wel_log_font.set_default_clipping_precision
			end
		end

	set_escapement (an_escapement: STRING) is
			-- Set escapement based on value of `an_escapement'.
		do
			if an_escapement /= Void and an_escapement.is_integer then
				Wel_log_font.set_escapement (an_escapement.to_integer)
			else	
				Wel_log_font.set_escapement (0)
			end
		end

	set_orientation (an_orientation: STRING) is
			-- Set the orientation based on the value of `an_orientation'.
		do
			if an_orientation /= Void and then an_orientation.is_integer then
				Wel_log_font.set_orientation (an_orientation.to_integer)
			else
				Wel_log_font.set_orientation (0)
			end
		end

	set_out_precision (a_precision: STRING) is
			-- Set the precision based on the value of `a_precision'.
		do
			if a_precision.is_equal ("character") then
				Wel_log_font.set_character_output_precision
			elseif a_precision.is_equal ("string") then
				Wel_log_font.set_string_output_precision
			elseif a_precision.is_equal ("stroke") then
				Wel_log_font.set_stroke_output_precision
			else
				Wel_log_font.set_default_output_precision
			end
		end

	set_pitch (a_pitch: STRING) is
			-- Set pitch based on value in `a_pitch'.
		do
			if a_pitch.is_equal ("fixed") then
				Wel_log_font.set_fixed_pitch
			elseif a_pitch.is_equal ("variable") then
				Wel_log_font.set_variable_pitch
			else
				Wel_log_font.set_default_pitch
			end
		end

	set_quality (a_quality: STRING) is
			-- Set quality based on value in `a_quality'.
		do
			if a_quality.is_equal ("draft") then
				Wel_log_font.set_draft_quality
			elseif a_quality.is_equal ("proof") then
				Wel_log_font.set_proof_quality
			else
				Wel_log_font.set_default_quality
			end
		end

	set_styles (styles: STRING) is
			-- Set the style based on values in `styles'.
		do
			Wel_log_font.set_not_italic
			Wel_log_font.set_not_underlined
			Wel_log_font.set_not_strike_out
			if styles /= Void then
				if styles.has ('i') then
					Wel_log_font.set_italic
				end
				if styles.has ('u') then
					Wel_log_font.set_underlined
				end
				if styles.has ('s') then
					Wel_log_font.set_strike_out
				end
			end
		end

invariant
	wel_log_font_exists: Wel_log_font /= Void
	wel_font_exists: wel_font /= Void

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

