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
			--font := label.font
			--font.set_height (30)
			--label.set_font (font)
			--label.set_default_minimum_size

			create cmd.make (~timeout_action)
			create timeout.make (150, cmd, Void)

			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			create tab_list.make
			tab_list.extend (timeout_tab)
			create action_window.make (timeout, tab_list)
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

end -- class CURSOR_WINDOW

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

