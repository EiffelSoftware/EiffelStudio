indexing
	description	: "Example demonstrating WEL_SPLIT_AREA"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "2000/05/04"
	revision	: "0.99"

class
	SPLIT_AREA_DEMO

inherit
	WEL_FRAME_WINDOW
		redefine
			on_size,
			background_brush
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
		local
			char_format: WEL_CHARACTER_FORMAT
		do
			make_top (Title)

			create char_format.make
			char_format.set_face_name ("Arial")
			char_format.set_height (25)

			create split_area.make (Current, "", 0, 0, 440, 390, 220)

				-- Create the left RichEdit control
			create rich_edit_left.make (split_area, "", 7, 7, 200, 300, -1)
			rich_edit_left.set_character_format_selection (char_format)
			rich_edit_left.set_text ("Left RichEdit control")

				-- Create the right  RichEdit control
			create rich_edit_right.make (split_area, "", 207, 7, 200, 300, -1)
			rich_edit_right.set_character_format_selection (char_format)
			rich_edit_right.set_text ("Right RichEdit control")

			split_area.set_left_control (rich_edit_left)
			split_area.set_right_control (rich_edit_right)

			resize (450, 400)
		end

feature -- Access

	split_area: WEL_SPLIT_AREA
			-- Our split area !!

	rich_edit_left: WEL_RICH_EDIT
			-- The left RichEdit control

	rich_edit_right: WEL_RICH_EDIT
			-- The right RichEdit control

feature {NONE} -- Implementation

	background_brush: WEL_BRUSH is
			-- Dialog boxes background color is the same than
			-- button color.
		do
			create Result.make_by_sys_color (Color_btnface + 1)
		end

	on_size (size_type: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Wm_size message handle
		do
				-- Reposition & Resize the split area
			split_area.move_and_resize (0, 0, a_width, a_height, True)
		end

	Title: STRING is "WEL SplitArea Example (c) ISE 2000-2001"
			-- Window's title

end -- class SPLIT_AREA_WINDOW

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

