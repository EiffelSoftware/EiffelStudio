indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	RICH_WINDOW

inherit
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
			set_text ("Bonjour,%N%NJe m'appelle Leila.%N%
			%Je suis bien heureuse de pouvoir tester les rich-edit.%N%
			%%NA plus.")
			!! color.make_rgb (180, 180, 180)
			set_background_color (color)
			apply_format (make_format)
			set_parent (par)

			append_text ("append")
			prepend_text ("prepend")
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
			format.set_underline (True)
			set_character_format (format)
			Result.add_character_format_with_regions (format, <<1, 8, 87, 87, 93, 93>>)		

			!! format.make
			!! font.make_by_name ("tahoma")
			font.set_height (8)
			format.set_font (font)
			!! color.make_rgb (255, 0, 0)
			format.set_color (color)
			format.set_italic (True)
			set_character_format (format)
			Result.add_character_format_with_regions (format, <<11, 84, 89, 92>>)
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
			format.set_underline (False)
			!! ft.make_by_name ("Symbol")
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
