note
	description	: "Example demonstrating WEL_SPLIT_AREA"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature {NONE} -- Initialization

	make
		local
			char_format: WEL_CHARACTER_FORMAT
			l_rich_edit: WEL_RICH_EDIT
			l_split_area: like split_area
		do
			make_top (Title)

			create char_format.make
			char_format.set_face_name ("Arial")
			char_format.set_height_in_points (25)

			create l_split_area.make (Current, "", 0, 0, 440, 390, 220)
			split_area := l_split_area

				-- Create the left RichEdit control
			create l_rich_edit.make (l_split_area, "", 7, 7, 200, 300, -1)
			l_rich_edit.set_character_format_selection (char_format)
			l_rich_edit.set_text ("Left RichEdit control")
			l_split_area.set_left_control (l_rich_edit)
				-- For GC tracking
			rich_edit_right := l_rich_edit

				-- Create the right  RichEdit control
			create l_rich_edit.make (l_split_area, "", 207, 7, 200, 300, -1)
			l_rich_edit.set_character_format_selection (char_format)
			l_rich_edit.set_text ("Right RichEdit control")
			l_split_area.set_right_control (l_rich_edit)
				-- For GC tracking
			rich_edit_left := l_rich_edit

			resize (450, 400)
		end

feature -- Access

	split_area: ?WEL_SPLIT_AREA
			-- Our split area !!

	rich_edit_left: ?WEL_RICH_EDIT
			-- The left RichEdit control

	rich_edit_right: ?WEL_RICH_EDIT
			-- The right RichEdit control

	background_brush: WEL_BRUSH
			-- Dialog boxes background color is the same than
			-- button color.
		do
			create Result.make_by_sys_color (Color_btnface + 1)
		end

feature {NONE} -- Implementation

	on_size (size_type: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Wm_size message handle
		do
				-- Reposition & Resize the split area
			if {l_split_area: like split_area} split_area then
				l_split_area.move_and_resize (0, 0, a_width, a_height, True)
			end
		end

	Title: STRING = "WEL SplitArea Example (c) ISE 2000-2001";
			-- Window's title

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class SPLIT_AREA_WINDOW

