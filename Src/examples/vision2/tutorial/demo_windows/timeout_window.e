indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	TIMEOUT_WINDOW

inherit
	DEMO_WINDOW

	EV_VERTICAL_BOX
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			basic: EV_BASIC_COLORS
			hbox: EV_HORIZONTAL_BOX
			button: EV_BUTTON
			cmd: EV_ROUTINE_COMMAND
			sep: EV_HORIZONTAL_SEPARATOR
			font: EV_FONT
		do
			{EV_VERTICAL_BOX} Precursor (Void)
			create basic
			color := basic.all_colors
			color.start

			create label.make_with_text (Current, "Nothing exists")
			label.set_vertical_resize (False)
			label.set_horizontal_resize (False)
			label.set_center_alignment
			label.set_minimum_width (100)
			font := label.font
			font.set_height (30)
			label.set_font (font)
			label.set_default_minimum_size

			create sep.make (Current)
			create hbox.make (Current)
			hbox.set_expand (False)
			hbox.set_border_width (20)
			create button.make_with_text (hbox, "Create timeout")
			button.set_horizontal_resize (False)
			create cmd.make (~create_timeout)
			button.add_click_command (cmd, Void)
			create button.make_with_text (hbox, "Destroy timeout")
			button.set_horizontal_resize (False)
			create cmd.make (~destroy_timeout)
			button.add_click_command (cmd, Void)

			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
		end

feature -- Access

	label: EV_LABEL
		-- A label to display the count.

	color: LINKED_LIST [EV_COLOR]
		-- Colors used for the label.

	timeout: EV_TIMEOUT
		-- The timeout for the demo

feature -- Execution features

	timeout_action (arg: EV_ARGUMENT1 [EV_TIMEOUT]; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
			label.set_foreground_color (color.item)
			label.set_text (timeout.count.out)
			if color.islast then
 				color.start
			else
				color.forth
			end
		end

	create_timeout (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		local
			cmd: EV_ROUTINE_COMMAND
		do
			destroy_timeout (Void, Void)
			create cmd.make (~timeout_action)
			create timeout.make (150, cmd, Void)
		end

	destroy_timeout (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
			if timeout /= Void then
				timeout.destroy
				timeout := Void
			end
		end

end -- class CURSOR_WINDOW

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
