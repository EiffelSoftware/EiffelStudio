indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	RICH_WINDOW

inherit
	DEMO_WINDOW

	EV_RICH_TEXT
		redefine
			make
		end

	EV_COMMAND

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			color: EV_COLOR
		do
			{EV_RICH_TEXT} Precursor (Void)
			add_button_release_command (3, Current, Void)
			set_minimum_size (200, 200)
			set_text ("Hello,%N%NThis is a rich edit.%N%
			%You can choose the color, the font, the size...%
			%%Nof each word.%N%NHave a good day.%N")
			apply_format (make_format)
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_primitive_tabs
			tab_list.extend(text_component_tab)
			tab_list.extend(text_tab)
			tab_list.extend(rich_tab)
			create action_window.make(Current, tab_list)
		end

feature -- Access

	format: EV_CHARACTER_FORMAT
			-- A format for the text

feature -- Basic operation

	make_format: EV_TEXT_FORMAT is
			-- Create a text format.
		local
			s, e: ARRAYED_LIST [INTEGER]
			color: EV_COLOR
			font: EV_FONT
		do
			!! Result.make

			!! format.make
			!! color.make_rgb (0, 0, 255)
			format.set_color (color)
			set_character_format (format)
			Result.add_character_format_with_regions (format, <<1, 8, 86, 89, 93, 108>>)		

			!! format.make
			!! font.make_by_system_name ("tahoma,24,400,,default,dontcare,ansi,0,0,0,draft,stroke,default")
			format.set_font (font)
			!! color.make_rgb (255, 0, 0)
			format.set_color (color)
			format.set_italic (True)
			set_character_format (format)
			Result.add_character_format_with_regions (format, <<9, 84, 90, 90>>)
		end

feature -- Command execution

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when the mouse button is released.
		local
			ft: EV_FONT
			colors: EV_BASIC_COLORS
		do
			format.set_bold (False)
			format.set_italic (False)
		--	!! ft.make_by_name ("Symbol")
			create ft.make_by_name ("Times New Roman")
			!! colors
			format.set_color (colors.black)
			format.set_font (ft)
			set_character_format (format)
		end

end -- class BUTTON_WINDOW

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
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
