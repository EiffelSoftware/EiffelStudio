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
			interface,
			set_values
		end

	EV_C_UTIL

create
	make

feature {NONE} -- Initialization

 	make (an_interface: like interface) is
 			-- Create the default font.
		do
			create C
			base_make (an_interface)
			family := Family_sans
			weight := Weight_regular
			shape := Shape_regular
			height := 12

			create preferred_faces
			preferred_faces.add_actions.extend (~update_preferred_faces)
			preferred_faces.remove_actions.extend (~update_preferred_faces)

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

-- FIXME ARNAUD
--	preferred_face: STRING
--			-- Preferred user font.
--			-- `family' will be ignored when not Void.

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
			-- Set `a_height' as preferred font size in screen pixels
		do
			height := a_height
			update_font_face
		end

	set_values (a_family, a_weight, a_shape, a_height: INTEGER;
		a_preferred_faces: like preferred_faces) is
			-- Set `a_family', `a_weight', `a_shape' `a_height' and
			-- `a_preferred_face' at the same time for speed.
		do
			family := a_family
			weight := a_weight
			shape := a_shape
			height := a_height
			preferred_faces.add_actions.wipe_out
			preferred_faces.remove_actions.wipe_out
			preferred_faces := a_preferred_faces
			preferred_faces.add_actions.extend (~update_preferred_faces)
			preferred_faces.remove_actions.extend (~update_preferred_faces)
			update_font_face
		end

feature -- Status report

	name: STRING
			-- Face name chosen by toolkit.

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

	try_font (a_try_string: STRING; a_try_face: STRING): EV_GDK_FONT is
		local
			exp_name: STRING
		do
			if preloaded.has (a_try_string) then
				Result := preloaded.item (a_try_string)
				name := a_try_face
			else
				exp_name := match_name (a_try_string)
				if exp_name /= Void then
					create Result.make (exp_name)
					preloaded.put (Result, a_try_string)
					name := a_try_face
				end
			end
		end

	match_preferred_face (
		try_string_creator: FUNCTION[EV_FONT_IMP, TUPLE [EV_FONT_IMP, STRING], STRING]
	): EV_GDK_FONT is
			-- Match the preferred face using the font 
			-- string creator `try_string_creator'
		local
			temp_font: EV_GDK_FONT
			a_try_string: STRING
			curr_face: STRING
		do
			if preferred_faces.is_empty then
				curr_face := family_string
				a_try_string := try_string_creator.item ([Current, curr_face])
				temp_font := try_font (a_try_string, curr_face)
			else
				from
					preferred_faces.start
				until
					temp_font /= Void or
					preferred_faces.after
				loop
					curr_face := preferred_faces.item
					a_try_string := try_string_creator.item ([Current, curr_face])
					temp_font := try_font (a_try_string, curr_face)
					preferred_faces.forth
				end
					-- Impossible to match the font with the given faces, try with the
					-- family.
				if temp_font = Void then
					curr_face := family_string
					a_try_string := try_string_creator.item ([Current, curr_face])
					temp_font := try_font (a_try_string, curr_face)
				end
			end
			Result := temp_font
		end

	update_preferred_faces (a_face: STRING) is
		do
			update_font_face
		end

	update_font_face is
			-- Look up font and if not in list, find best match.
		local
			temp_font: EV_GDK_FONT
			i: INTEGER
		do
			from
				i := try_string_array.lower
			until
				temp_font /= Void or i > try_string_array.upper
			loop
				temp_font := match_preferred_face (try_string_array.item (i))
				i := i + 1
			end

			if temp_font = Void then
				name := ""
				io.put_string ("Error: no fonts installed%N")
				--| FIXME Raise exception?
			end

			full_name := temp_font.full_name
			c_object := temp_font.c_object
		end

	match_name (pattern: STRING): STRING is
			-- Get the expanded font name for `pattern'.
			-- Void if no match is found.
		require
			pattern_not_void: pattern /= Void
		local
			c_expanded_name_pointer: POINTER
		do
			
			c_expanded_name_pointer :=
				C.c_match_font_name (eiffel_to_c (pattern))
			if c_expanded_name_pointer /= NULL then
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
				char_pointer := pointer_array_i_th (array_pointer, i)
				create s.make (0)
				s.from_c (char_pointer)
				Result.extend (s)
				i := i + 1
			end
			C.x_free_font_names (array_pointer)
		end

feature {EV_FONT_DIALOG_IMP} -- Implementation

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

	weight_from_string (a_string: STRING): INTEGER is
			-- Return appropriate weight code from string.
		do
			if equal (a_string, "bold") then
				Result := Weight_bold
			elseif equal (a_string, "black") then
				Result := Weight_black
			else
				Result := Weight_regular
			end
		end

	shape_from_string (a_string: STRING): INTEGER is
			-- Return appropriate shape code from string.
		do
			if equal (a_string, "o") then
				Result := Shape_italic
			else
				Result := Shape_regular
			end
		end

feature {NONE} -- Implementation

	--| String-routines to facilitate in searching the best matching font.

	try_string_array: ARRAY [FUNCTION [EV_FONT_IMP, TUPLE [EV_FONT_IMP, STRING], STRING]] is
				-- Create and setup the preferred font face mechanism
		once
			create Result.make (1, 6)
			Result.put ({EV_FONT_IMP}~try_string, 1)
			Result.put ({EV_FONT_IMP}~rescue_string_one, 2)
			Result.put ({EV_FONT_IMP}~rescue_string_two, 3)
			Result.put ({EV_FONT_IMP}~non_optimal, 4)
			Result.put ({EV_FONT_IMP}~last_resort_match, 5)
			Result.put ({EV_FONT_IMP}~default_font, 6)
		end

	family_string: STRING is
			-- Get standard string to represent family.
		do
			check valid_family (family) end
			inspect family
			when Family_screen then
				Result := "fixed"
			when Family_roman then
				Result := "times"
			when Family_typewriter then
				Result := "courier"
			when Family_sans then
				Result := "helvetica"
			when Family_modern then
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
			when Weight_thin then
				Result := "medium"
			when Weight_regular then
				Result := "medium"
			when Weight_bold then
				Result := "bold"
			when Weight_black then
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
			when Shape_regular then
				Result := "r"
			when Shape_italic then
				Result := "o"
			else
				Result := "*"
			end
		end

	setwidth_string: STRING is
			-- Get standard string to represent shape.
		do
			if weight = Weight_thin then
				Result := "narrow"
			else
				Result := "normal"
			end
		end

	addstyle_string: STRING is
			-- Get standard string to represent addstyle.
		do
			if family = Family_sans then
				Result := "sans"
			else
				Result := "*"
			end
		end

	try_string (a_name: STRING): STRING is
			-- Font with wildcards, trying to get the best match
			-- for the current attributes and the font face name
			-- `a_name'.
		do
			Result := "-*-" + a_name + "-" + weight_string + "-"
				+ shape_string + "-" + setwidth_string + "-"
				+ addstyle_string + "-" + height.out
				+ "-*-*-*-*-*-iso8859-*"
		end

	rescue_string_one (a_name: STRING): STRING is
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
			Result := "-*-" + a_name + "-" + wgt + "-"
				+ shape_string + "-normal-*-" + height.out
				+ "-*-*-*-*-*-iso8859-*"
		end

	rescue_string_two (a_name: STRING): STRING is
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
			Result := "-*-" + a_name + "-" + wgt + "-"
				+ shp + "-*-*-" + height.out
				+ "-*-*-*-*-*-iso8859-*"
		end

	non_optimal (a_name: STRING): STRING is
			-- If there is no optimal match: too bad!
			-- Try this and get at least the right size and family.
		do
			Result := "-*-" + a_name + "-*-"
				+ "*-*-*-" + height.out
				+ "-*-*-*-*-*-*-*"
		end

	last_resort_match (a_font_name: STRING): STRING is
			-- This is getting painful. Try to get a font with only
			-- the right name and you'll be OK.
		do
			Result := "-*-" + a_font_name + "-*-*-*-**-*-*-*-*-*-*-*"
		end	

	default_font (a_font_name: STRING): STRING is 
			-- If this font does not give a match, there is not
			-- a single font installed on the system.
		do
			Result := "-misc-fixed-*-*-*-*-*-*-*-*-*-*-*-*"
		end

feature {EV_ANY_IMP, EV_DRAWABLE_IMP, EV_APPLICATION_IMP} -- Implementation

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
	c_object_not_null: is_initialized implies c_object /= NULL
	full_name_not_void: is_initialized implies full_name /= Void
	
end -- class EV_FONT_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.17  2001/06/07 23:08:03  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.10.4.16  2001/04/26 18:58:11  king
--| Changed last matchable font to terminal to avoid chinese on some systems
--|
--| Revision 1.10.4.15  2001/04/20 00:12:37  king
--| Updated set_height comment
--|
--| Revision 1.10.4.14  2001/04/14 00:01:14  king
--| Added app_imp to export clause of c_object
--|
--| Revision 1.10.4.13  2001/04/06 18:01:45  xavier
--| Modifying the preferred faces of the font used not to update the actual font.
--|
--| Revision 1.10.4.12  2000/12/15 19:39:58  king
--| Changed .empty to .is_empty
--|
--| Revision 1.10.4.11  2000/10/05 19:17:49  oconnor
--| fixed constant names
--|
--| Revision 1.10.4.10  2000/09/07 22:34:15  king
--| Added is_initialized to font invariants
--|
--| Revision 1.10.4.9  2000/09/04 18:22:49  oconnor
--| make try_string_array once
--|
--| Revision 1.10.4.8  2000/07/28 00:25:42  king
--| Removed unused locals, default height of font is now 12, like GTK
--|
--| Revision 1.10.4.7  2000/07/25 20:25:12  king
--| Added functions to return vision font codes
--|
--| Revision 1.10.4.6  2000/06/19 17:45:09  king
--| Moved update_face_name post cond into imp int
--|
--| Revision 1.10.4.5  2000/06/16 00:31:53  oconnor
--| fixed action sequence names
--|
--| Revision 1.10.4.4  2000/06/15 19:06:43  pichery
--| Changed the implementation of `last_resort_string' in order to make the
--| face name more important than the font size.
--|
--| Revision 1.10.4.3  2000/06/15 07:23:51  pichery
--| Adapted the class so that it handle multiple preferred faces.
--|
--| Revision 1.10.4.2  2000/06/15 03:51:35  pichery
--| Removed `preferred_face' and replaced it with
--| `preferred_faces'.
--|
--| Revision 1.10.4.1  2000/05/03 19:08:38  oconnor
--| mergred from HEAD
--|
--| Revision 1.16  2000/05/02 18:55:21  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.15  2000/04/18 19:36:03  oconnor
--| renamed get_pointer_from_array_by_index->pointer_array_i_th
--|
--| Revision 1.14  2000/03/28 21:51:41  brendel
--| Redefined set_values for optimization purpose.
--| update_font_face uses local variable for speed optimization.
--|
--| Revision 1.13  2000/03/08 17:09:05  brendel
--| Replaced `extend' with `put' on hash-table.
--|
--| Revision 1.12  2000/02/22 18:39:35  oconnor
--| updated copyright date and formatting
--|
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

