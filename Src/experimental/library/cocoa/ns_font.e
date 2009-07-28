note
	description: "Wrapper for NSFont."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT

inherit
	NS_OBJECT

create
	font_with_name_size,
	font_with_descriptor,
	font_with_descriptor_text_transform,
	font_with_name_matrix,
	user_font_of_size,
	user_fixed_pitch_font_of_size,
	bold_system_font_of_size,
	control_content_font_of_size,
	label_font_of_size,
	menu_font_of_size,
	menu_bar_font_of_size,
	message_font_of_size,
	palette_font_of_size,
	system_font_of_size,
	title_bar_font_of_size,
	tool_tips_font_of_size
create {NS_OBJECT}
	make_from_pointer,
	share_from_pointer

feature -- Creating Arbitrary Fonts

	font_with_name_size (a_font_name: NS_STRING; a_font_size: REAL)
			-- Creates a font object for the specified font name and font size.
		do
			make_from_pointer ({NS_FONT_API}.font_with_name_size (a_font_name.item, a_font_size.item))
		end

	font_with_descriptor (a_font_descriptor: NS_FONT_DESCRIPTOR; a_font_size: REAL)
			-- Returns a font object for the specified font descriptor and font size.
		do
			make_from_pointer ({NS_FONT_API}.font_with_descriptor_size (a_font_descriptor.item, a_font_size.item))
		end

	font_with_descriptor_text_transform (a_font_descriptor: NS_FONT_DESCRIPTOR; a_text_transform: NS_AFFINE_TRANSFORM)
			-- Returns a font object for the specified font descriptor and text transform.
		do
			make_from_pointer ({NS_FONT_API}.font_with_descriptor_text_transform (a_font_descriptor.item, a_text_transform.item))
		end

	font_with_name_matrix (a_font_name: NS_STRING; a_font_matrix: POINTER)
			-- Returns a font object for the specified font name and matrix.
		do
			make_from_pointer ({NS_FONT_API}.font_with_name_matrix (a_font_name.item, a_font_matrix))
		end

feature -- Creating User Fonts

	user_font_of_size (a_font_size: REAL)
			-- Returns the font used by default for documents and other text under the user`s control (that is, text whose font the user can normally change), in the specified size.
		do
			make_from_pointer ({NS_FONT_API}.user_font_of_size (a_font_size.item))
		end

	user_fixed_pitch_font_of_size (a_font_size: REAL)
			-- Returns the font used by default for documents and other text under the user`s control (that is, text whose font the user can normally change), when that font should be fixed-pitch, in the specified size.
		do
			make_from_pointer ({NS_FONT_API}.user_fixed_pitch_font_of_size (a_font_size.item))
		end

feature -- Creating System Fonts

	bold_system_font_of_size (a_font_size: REAL)
			-- Returns the Aqua system font used for standard interface items that are rendered in boldface type in the specified size.
		do
			make_from_pointer ({NS_FONT_API}.bold_system_font_of_size (a_font_size.item))
		end

	control_content_font_of_size (a_font_size: REAL)
			-- Returns the font used for the content of controls in the specified size.
		do
			make_from_pointer ({NS_FONT_API}.control_content_font_of_size (a_font_size.item))
		end

	label_font_of_size (a_font_size: REAL)
			-- Returns the Aqua font used for standard interface labels in the specified size.
		do
			make_from_pointer ({NS_FONT_API}.label_font_of_size (a_font_size.item))
		end

	menu_font_of_size (a_font_size: REAL)
			-- Returns the font used for menu items, in the specified size.
		do
			make_from_pointer ({NS_FONT_API}.menu_font_of_size (a_font_size.item))
		end

	menu_bar_font_of_size (a_font_size: REAL)
			-- Returns the font used for menu bar items, in the specified size.
		do
			make_from_pointer ({NS_FONT_API}.menu_bar_font_of_size (a_font_size.item))
		end

	message_font_of_size (a_font_size: REAL)
			-- Returns the font used for standard interface items, such as button labels, menu items, and so on, in the specified size.
		do
			make_from_pointer ({NS_FONT_API}.message_font_of_size (a_font_size.item))
		end

	palette_font_of_size (a_font_size: REAL)
			-- Returns the font used for palette window title bars, in the specified size.
		do
			make_from_pointer ({NS_FONT_API}.palette_font_of_size (a_font_size.item))
		end

	system_font_of_size (a_font_size: REAL)
			-- Returns the Aqua system font used for standard interface items, such as button labels, menu items, and so on, in the specified size.
		do
			make_from_pointer ({NS_FONT_API}.system_font_of_size (a_font_size.item))
		end

	title_bar_font_of_size (a_font_size: REAL)
			-- Returns the font used for window title bars, in the specified size.
		do
			make_from_pointer ({NS_FONT_API}.title_bar_font_of_size (a_font_size.item))
		end

	tool_tips_font_of_size (a_font_size: REAL)
			-- Returns the font used for tool tips labels, in the specified size.
		do
			make_from_pointer ({NS_FONT_API}.tool_tips_font_of_size (a_font_size.item))
		end

feature -- Using a Font to Draw

	set
			-- Establishes the receiver as the current font for PostScript <code>show</code> and other text-drawing operators.
		do
			{NS_FONT_API}.set (item)
		end

	set_in_context (a_graphics_context: NS_GRAPHICS_CONTEXT)
			-- Establishes the receiver as the current font for the specified graphics context.
		do
			{NS_FONT_API}.set_in_context (item, a_graphics_context.item)
		end

feature -- Getting General Font Information

--	covered_character_set: NS_CHARACTER_SET
--			-- Returns an <code>NSCharacterSet</code> object containing all of the nominal characters renderable by the receiver, which is all of the entries mapped in the receiver`s E2E2E2808080989898<code>cmap</code>` table.
--		do
--			create Result.share_from_pointer ({NS_FONT_API}.covered_character_set (item))
--		end

	font_descriptor: NS_FONT_DESCRIPTOR
			-- Returns the receiver`s font descriptor.
		do
			create Result.share_from_pointer ({NS_FONT_API}.font_descriptor (item))
		end

	is_fixed_pitch: BOOLEAN
			-- Returns a Boolean value indicating whether all glyphs in the receiver have the same advancement.
		do
			Result := {NS_FONT_API}.is_fixed_pitch (item)
		end

	most_compatible_string_encoding: NATURAL
			-- Returns the string encoding that works best with the receiver, where there are the fewest possible unmatched characters in the string encoding and glyphs in the font.
		do
			Result := {NS_FONT_API}.most_compatible_string_encoding (item)
		end

	rendering_mode: INTEGER
			-- Returns the rendering mode of the receiver.
		do
			Result := {NS_FONT_API}.rendering_mode (item)
		end

feature -- Getting Information About Glyphs

	glyph_with_name (a_name: NS_STRING): INTEGER
			-- Returns the named encoded glyph, or -1 if the receiver contains no such glyph.
		do
			Result := {NS_FONT_API}.glyph_with_name (item, a_name.item)
		end

feature -- Getting Metrics Information

	label_font_size: REAL
			-- Returns the size of the standard label font.
		do
			Result := {NS_FONT_API}.label_font_size ()
		end

	small_system_font_size: REAL
			-- Returns the size of the standard small system font.
		do
			Result := {NS_FONT_API}.small_system_font_size ()
		end

	system_font_size: REAL
			-- Returns the size of the standard system font.
		do
			Result := {NS_FONT_API}.system_font_size ()
		end

	system_font_size_for_control_size (a_control_size: NATURAL): REAL
			-- Returns the font size used for the specified control size.
		do
			Result := {NS_FONT_API}.system_font_size_for_control_size (a_control_size)
		end

	advancement_for_glyph (a_ag: INTEGER): NS_SIZE
			-- Returns the nominal spacing for the given glyph--the distance the current point moves after showing the glyph--accounting for the receiver`s size.
		do
			create Result.make
			{NS_FONT_API}.advancement_for_glyph (item, a_ag.item, Result.item)
		end

	ascender: REAL
			-- Returns the top y-coordinate, offset from the baseline, of the receiver`s longest ascender.
		do
			Result := {NS_FONT_API}.ascender (item)
		end

	bounding_rect_for_font: NS_RECT
			-- Returns the receiver`s bounding rectangle, scaled to the font`s size.
		do
			create Result.make
			{NS_FONT_API}.bounding_rect_for_font (item, Result.item)
		end

	bounding_rect_for_glyph (a_glyph: INTEGER): NS_RECT
			-- Returns the bounding rectangle for the specified glyph, scaled to the receiver`s size.
		do
			create Result.make
			{NS_FONT_API}.bounding_rect_for_glyph (item, a_glyph.item, Result.item)
		end

	cap_height: REAL
			-- Returns the receiver`s cap height.
		do
			Result := {NS_FONT_API}.cap_height (item)
		end

	descender: REAL
			-- Returns the bottom y coordinate, offset from the baseline, of the receiver`s longest descender.
		do
			Result := {NS_FONT_API}.descender (item)
		end

--	get_advancements_for_glyphs_count (a_advancements: NS_SIZE_ARRAY; a_glyphs: INTEGER; a_glyph_count: INTEGER)
--			-- Returns an array of the advancements for the specified glyphs rendered by the receiver.
--		do
--			{NS_FONT_API}.get_advancements_for_glyphs_count (item, a_advancements.item, a_glyphs.item, a_glyph_count.item)
--		end

--	get_advancements_for_packed_glyphs_length (a_advancements: NS_SIZE_ARRAY; a_packed_glyphs: ; a_length: INTEGER)
--			-- Returns an array of the advancements for the specified packed glyphs and rendered by the receiver.
--		do
--			{NS_FONT_API}.get_advancements_for_packed_glyphs_length (item, a_advancements.item, a_packed_glyphs.item, a_length.item)
--		end

--	get_bounding_rects_for_glyphs_count (a_bounds: NS_RECT_ARRAY; a_glyphs: INTEGER; a_glyph_count: INTEGER)
--			-- Returns an array of the bounding rectangles for the specified glyphs rendered by the receiver.
--		do
--			{NS_FONT_API}.get_bounding_rects_for_glyphs_count (item, a_bounds.item, a_glyphs.item, a_glyph_count.item)
--		end

	italic_angle: REAL
			-- Returns the receiver`s italic angle, the amount that the font is slanted in degrees counterclockwise from the vertical, as read from its AFM file. Because the slant is measured counterclockwise, English italic fonts typically return a negative value.
		do
			Result := {NS_FONT_API}.italic_angle (item)
		end

	leading: REAL
			-- Returns the receiver`s leading.
		do
			Result := {NS_FONT_API}.leading (item)
		end

	matrix: POINTER
			-- Returns the receiver`s font matrix, a standard six-element transformation matrix as used in the PostScript language, specifically with the <code>makefont</code> operator.
		do
			Result := {NS_FONT_API}.matrix (item)
		end

	maximum_advancement: NS_SIZE
			-- Returns the greatest advancement of any of the receiver`s glyphs.
		do
			create Result.make
			{NS_FONT_API}.maximum_advancement (item, Result.item)
		end

	number_of_glyphs: INTEGER
			-- Returns the number of glyphs in the receiver.
		do
			Result := {NS_FONT_API}.number_of_glyphs (item)
		end

	point_size: REAL
			-- Returns the receiver`s point size, or the effective vertical point size for a font with a nonstandard matrix.
		do
			Result := {NS_FONT_API}.point_size (item)
		end

	text_transform: NS_AFFINE_TRANSFORM
			-- Returns the current transformation matrix for the receiver.
		do
			create Result.share_from_pointer ({NS_FONT_API}.text_transform (item))
		end

	underline_position: REAL
			-- Returns the baseline offset that should be used when drawing underlines with the receiver, as determined by the font`s AFM file.
		do
			Result := {NS_FONT_API}.underline_position (item)
		end

	underline_thickness: REAL
			-- Returns the thickness that should be used when drawing underlines with the receiver, as determined by the font`s AFM file.
		do
			Result := {NS_FONT_API}.underline_thickness (item)
		end

	x_height: REAL
			-- Returns the x-height of the receiver.
		do
			Result := {NS_FONT_API}.x_height (item)
		end

feature -- Getting Font Names

	display_name: NS_STRING
			-- Returns the name, including family and face, used to represent the font in the user interface, typically localized for the user`s language.
		do
			create Result.share_from_pointer ({NS_FONT_API}.display_name (item))
		end

	family_name: NS_STRING
			-- Returns the receiver`s family name--for example, E2E2E28080809C9C9CTimesE2E2E28080809D9D9D or E2E2E28080809C9C9CHelvetica.E2E2E28080809D9D9D
		do
			create Result.share_from_pointer ({NS_FONT_API}.family_name (item))
		end

	font_name: NS_STRING
			-- Returns the receiver`s full font name, as used in PostScript language code--for example, E2E2E28080809C9C9CTimes-RomanE2E2E28080809D9D9D or E2E2E28080809C9C9CHelvetica-Oblique.E2E2E28080809D9D9D
		do
			create Result.share_from_pointer ({NS_FONT_API}.font_name (item))
		end

feature -- Setting User Fonts

	set_user_font (a_font: NS_FONT)
			-- Sets the font used by default for documents and other text under the user`s control to the specified font.
		do
			{NS_FONT_API}.set_user_font (a_font.item)
		end

	set_user_fixed_pitch_font (a_font: NS_FONT)
			-- Sets the font used by default for documents and other text under the user`s control, when that font should be fixed-pitch, to the specified font.
		do
			{NS_FONT_API}.set_user_fixed_pitch_font (a_font.item)
		end

feature -- Getting Corresponding Device Fonts

	printer_font: NS_FONT
			-- Returns the scalable PostScript font corresponding to itself.
		do
			create Result.share_from_pointer ({NS_FONT_API}.printer_font (item))
		end

	screen_font: NS_FONT
			-- Returns the bitmapped screen font corresponding to itself.
		do
			create Result.share_from_pointer ({NS_FONT_API}.screen_font (item))
		end

	screen_font_with_rendering_mode (a_rendering_mode: INTEGER): NS_FONT
			-- Returns a bitmapped screen font, when sent to a font object representing a scalable PostScript font, with the specified rendering mode, matching the receiver in typeface and matrix (or size), or <code>nil</code> if such a font can`t be found.
		do
			create Result.share_from_pointer ({NS_FONT_API}.screen_font_with_rendering_mode (item, a_rendering_mode))
		end

end
