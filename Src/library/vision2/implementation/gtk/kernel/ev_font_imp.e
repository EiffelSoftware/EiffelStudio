indexing
	description: "Eiffel Vision font. GTK implementation."
	note:
		"Does not inherit from EV_ANY_IMP because c_object is not a %N%
		%GTK object. (type is GdkFont)",
		"All font interaction is done through the system name. This string %N%
		%consists of 14 attributes, separated by dashes. %N%
		%The string looks like: %N%
		%-foundry-family-weight-slant-setwidth-addstyle-pixel-point-resx-resy-spacing-width-charset-encoding %N%
		%Of these attributes, only family, weight, slant and pixel_size %N%
		%are relevant to EiffelVision., %N%
 		%See: http://developer.gnome.org/doc/API/gdk/gdk-fonts.html"
	status: "See notice at end of class"
	keywords: "character, face, height, family, weight, shape, bold, italic"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_IMP 

inherit
 	EV_FONT_I
		redefine
			interface
		end

	EV_C_UTIL

create
	make

feature {NONE} -- Initialization

 	make (an_interface: like interface) is
 			-- Create the default font.
		local
			iname: ANY
			list: LINKED_LIST [STRING]
		do
			create C
			base_make (an_interface)
			family := Ev_font_family_sans
			weight := Ev_font_weight_regular
			shape := Ev_font_shape_regular
			height := 11
			update_font_face
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

	height: INTEGER
			-- Preferred font height measured in screen pixels.

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
			update_font_face
		end

	set_shape (a_shape: INTEGER) is
			-- Set `a_shape' as preferred font slant.
		do
			shape := a_shape
			update_font_face
		end

	set_height (a_height: INTEGER) is
			-- Set `a_height' as preferred font size.
		do
			height := a_height
			update_font_face
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
			if preferred_face /= Void then
				Result := preferred_face
			else
				Result := family_string
			end
		end

	ascent: INTEGER is
			-- Vertical distance from the origin of the drawing
			-- operation to the top of the drawn character. 
		do
			Result := C.c_gdk_font_ascent (c_object)
		end

	descent: INTEGER is
			-- Vertical distance from the origin of the drawing
			-- operation to the bottom of the drawn character. 
		do
			Result := C.c_gdk_font_descent (c_object)
		end

	width: INTEGER is
			-- Character width of current fixed-width font.
		do
			--| FIXME This sometimes returns 0.
			--| Result := substring_dash (full_name, Ev_gdk_font_string_index_width).to_integer
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
			Result := string_width ("W")
		end

	string_width (a_string: STRING): INTEGER is
			-- Width in pixels of `a_string' in the current font.
		do
			Result := C.gdk_string_width (c_object, eiffel_to_c (a_string))
		end

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font is designed.
		do
			Result := substring_dash (full_name, Ev_gdk_font_string_index_resx).to_integer
		end

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font is designed.
		do
			Result := substring_dash (full_name, Ev_gdk_font_string_index_resy).to_integer
		end

	is_proportional: BOOLEAN is
			-- Can characters in the font have different sizes?
		do
			Result := substring_dash (full_name, Ev_gdk_font_string_index_spacing).is_equal ("p")
		end
 
feature {NONE} -- Implementation

	preloaded: HASH_TABLE [EV_GDK_FONT, STRING] is
			-- Previously cached font structures.
		once
			create Result.make (10)
		end

	update_font_face is
			-- Look up font and if not in list, find best match.
		local
			exp_name: STRING
			temp_font: EV_GDK_FONT
		do
			if preloaded.has (try_string) then
				temp_font := preloaded.item (try_string)
			else
				exp_name := match_name (try_string)
				if exp_name = Void then
					if preferred_face /= Void then
						io.put_string ("Warning: no match found for " +
							try_string + "%N")
					end
					exp_name := rescue_match
				end
				create temp_font.make (exp_name)
				preloaded.extend (temp_font, try_string)
			end
			full_name := temp_font.full_name
			c_object := temp_font.c_object
		end

	rescue_match: STRING is
			-- Try to match as good as possible.
		do
			Result := match_name (rescue_string_one)
			if Result = Void then
				Result := match_name (rescue_string_two)
				if Result = Void then
					io.put_string ("Warning: non-optimal font match.%N")
					Result := match_name (non_optimal)
					if Result = Void then		
						Result := match_name (last_resort_string)
						if Result = Void then				
							Result := match_name (any_name)
							if Result = Void then	
								io.put_string ("Error: no fonts installed%N")
								--| FIXME Raise exception?
							end
						end
					end
				end
			end
		ensure
			not_void: Result /= Void
		end

	match_name (pattern: STRING): STRING is
			-- Get the expanded font name for `pattern'.
			-- Void if no match is found.
		require
			pattern_not_void: pattern /= Void
		local
			c_name: ANY
			c_expanded_name_pointer: POINTER
		do
			c_name := pattern.to_c
			c_expanded_name_pointer := C.c_match_font_name ($c_name)
			if c_expanded_name_pointer /= Default_pointer then
				create Result.make (0)
				Result.from_c (c_expanded_name_pointer)
			end
		end

	match_list (pattern: STRING): LINKED_LIST [STRING] is
			-- Return list of all matched fonts. (max 100)
			--| Not used at the moment.
			--| Can be used to get all matching fonts for a
			--| specific pattern. Apply an algorithm on the list
			--| to get the best match.
		local
			actual_size, i: INTEGER
			array_pointer, char_pointer: POINTER
			s: STRING
		do
			array_pointer := C.x_list_fonts (C.gdk_display,
				eiffel_to_c (pattern), 100, $actual_size)
			create Result.make
			from i := 0 until i >= actual_size loop
				char_pointer := get_pointer_from_array_by_index (array_pointer, i)
				create s.make (0)
				s.from_c (char_pointer)
				Result.extend (s)
				i := i + 1
			end
			C.x_free_font_names (array_pointer)
		end

feature {NONE} -- Implementation

	--| Routine for extracting items from a X-font.

	Ev_gdk_font_string_index_foundry: INTEGER is 1
	Ev_gdk_font_string_index_family: INTEGER is 2
	Ev_gdk_font_string_index_weight: INTEGER is 3
	Ev_gdk_font_string_index_slant: INTEGER is 4
	Ev_gdk_font_string_index_setwidth: INTEGER is 5
	Ev_gdk_font_string_index_addstyle: INTEGER is 6
	Ev_gdk_font_string_index_pixel: INTEGER is 7
	Ev_gdk_font_string_index_point: INTEGER is 8
	Ev_gdk_font_string_index_resx: INTEGER is 9
	Ev_gdk_font_string_index_resy: INTEGER is 10
	Ev_gdk_font_string_index_spacing: INTEGER is 11
	Ev_gdk_font_string_index_width: INTEGER is 12
	Ev_gdk_font_string_index_charset: INTEGER is 13
	Ev_gdk_font_string_index_encoding: INTEGER is 14

	substring_dash (s: STRING; index: INTEGER): STRING is
			-- Substring of `s' between the `index'-th and `index + 1'-th dash.
			-- If last dash, returns tail.
		require
			s_not_void: s /= Void
			index_bigger_than_zero: index > 0
			index_not_bigger_than_dash_occurences: index <= s.occurrences ('-')
		local
			cur_index, next_index, str_pos: INTEGER
		do
			str_pos := 0
			from cur_index := 0 until cur_index = index loop
				str_pos := s.index_of ('-', str_pos + 1)
				cur_index := cur_index + 1
			end
			next_index := s.index_of ('-', str_pos + 1)
			if next_index = 0 then
				Result := s.substring (str_pos + 1, s.count)
			else
				Result := s.substring (str_pos + 1, next_index - 1)
			end
		ensure
			not_void: Result /= Void
			no_dashes: Result.occurrences ('-') = 0
		end

feature {NONE} -- Implementation

	--| String-routines to facilitate in searching the best matching font.

	family_string: STRING is
			-- Get standard string to represent family.
		do
			check valid_family (family) end
			inspect family
			when Ev_font_family_screen then
				Result := "fixed"
			when Ev_font_family_roman then
				Result := "times"
			when Ev_font_family_typewriter then
				Result := "courier"
			when Ev_font_family_sans then
				Result := "helvetica"
			when Ev_font_family_modern then
				Result := "lucida"
			else
				Result := "*"
			end
		end

	weight_string: STRING is
			-- Get standard string to represent weight.
		do
			check valid_weight (weight) end
			inspect weight
			when Ev_font_weight_thin then
				Result := "medium"
			when Ev_font_weight_regular then
				Result := "medium"
			when Ev_font_weight_bold then
				Result := "bold"
			when Ev_font_weight_black then
				Result := "black"
			else
				Result := "*"
			end
		end

	shape_string: STRING is
			-- Get standard string to represent shape.
		do
			check valid_shape (shape) end
			inspect shape
			when Ev_font_shape_regular then
				Result := "r"
			when Ev_font_shape_italic then
				Result := "o"
			else
				Result := "*"
			end
		end

	setwidth_string: STRING is
			-- Get standard string to represent shape.
		do
			if weight = Ev_font_weight_thin then
				Result := "narrow"
			else
				Result := "normal"
			end
		end

	addstyle_string: STRING is
			-- Get standard string to represent addstyle.
		do
			if family = Ev_font_family_sans then
				Result := "sans"
			else
				Result := "*"
			end
		end

	try_string: STRING is
			-- Font with wildcards, trying to get the best match
			-- for the current attributes.
		do
			Result := "-*-" + name + "-" + weight_string + "-"
				+ shape_string + "-" + setwidth_string + "-"
				+ addstyle_string + "-" + height.out
				+ "-*-*-*-*-*-iso8859-*"
		end

	rescue_string_one: STRING is
			-- If try_string does not give any matches, use this string.
			-- It replaces "black" with "bold" and does not use a
			-- preferred setwidth or addstyle.
		local
			wgt: STRING 
		do
			wgt := weight_string
			if wgt.is_equal ("black") then
				wgt := "bold"
			end
			Result := "-*-" + name + "-" + wgt + "-"
				+ shape_string + "-normal-*-" + height.out
				+ "-*-*-*-*-*-iso8859-*"
		end

	rescue_string_two: STRING is
			-- If rescue-string-one does not match anything, use this.
			-- It replaces "o" with "i".
		local
			wgt, shp: STRING 
		do
			wgt := weight_string
			if wgt.is_equal ("black") then
				wgt := "bold"
			end
			shp := shape_string
			if shp.is_equal ("o") then
				shp := "i"
			end
			Result := "-*-" + name + "-" + wgt + "-"
				+ shp + "-*-*-" + height.out
				+ "-*-*-*-*-*-iso8859-*"
		end

	non_optimal: STRING is
			-- If there is no optimal match: too bad!
			-- Try this and get at least the right size and family.
		do
			Result := "-*-" + name + "-*-"
				+ "*-*-*-" + height.out
				+ "-*-*-*-*-*-*-*"
		end

	last_resort_string: STRING is
			-- This is getting painful. Try to get a font with only
			-- the right size and you'll be OK.
		do
			Result := "-*-*-*-*-*-*-" + height.out + "-*-*-*-*-*-*-*"
		end

	any_name: STRING is "-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
			-- If this font does not give a match, there is not
			-- a single font installed on the system.

feature {EV_ANY_IMP, EV_DRAWABLE_IMP} -- Implementation

	c_object: POINTER
		-- Reference to the GdkFont object.

feature {NONE} -- Implementation

	C: EV_C_EXTERNALS

	full_name: STRING
			-- The full name of the string.

feature {EV_ANY_I} -- Implementation

	interface: EV_FONT

feature -- Obsolete

	system_name: STRING is
			-- Platform dependent font name.
		do
			Result := full_name
		end

 	is_standard: BOOLEAN is True
 			-- Is the font standard and informations available (except for name) ?
			
	destroy is
		do
		end

invariant
	c_object_not_null: c_object /= Default_pointer
	full_name_not_void: full_name /= Void
	
end -- class EV_FONT_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2000/02/14 11:40:28  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.18  2000/02/04 04:20:42  oconnor
--| released
--|
--| Revision 1.10.6.17  2000/01/27 19:29:28  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.16  2000/01/21 20:14:03  brendel
--| Added check of valid constant value.
--|
--| Revision 1.10.6.15  2000/01/18 22:43:39  brendel
--| Works.
--|
--| Revision 1.10.6.14  2000/01/18 17:00:52  brendel
--| Changed default font size.
--|
--| Revision 1.10.6.13  2000/01/17 22:21:16  brendel
--| Font is again a little bit faster... Noticed?
--|
--| Revision 1.10.6.10  2000/01/17 17:55:31  brendel
--| Started implementing "best match" font system.
--|
--| Revision 1.10.6.8  2000/01/13 01:17:50  brendel
--| Started implementation of font.
--| EV_FONT_NAME_IMP is now obsolete.
--|
--| Revision 1.10.6.7  2000/01/10 21:40:39  king
--| Corrected weight to return int, Correctedstring width to not use eiffel_to_c
--|
--| Revision 1.10.6.6  2000/01/10 19:14:06  king
--| Changed interface.
--| Improved comments.
--| Improved contracts.
--| set_name is now obsolete.
--|
--| Revision 1.10.6.5  1999/12/22 20:17:12  king
--| Removed ev_any_imp
--|
--| Revision 1.10.6.4  1999/12/18 02:13:26  king
--| Removed inheritence from ev_any_imp
--|
--| Revision 1.10.6.3  1999/12/15 19:20:33  king
--| Removed inheritence from ev_any_imp
--| Removed reference to pointer widget (now c_object)
--|
--| Revision 1.10.6.2  1999/12/04 18:35:26  oconnor
--| inherit EV_ANY_IMP, use new externals object
--|
--| Revision 1.10.6.1  1999/11/24 17:29:45  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.3  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

