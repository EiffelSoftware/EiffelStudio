class
	LINE_THICKNESS_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_control_command
		end

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Make the line thickness window.
		do
			make_child (a_parent, "Line thickness")
			move_and_resize (20, 20, 210, 104, True)
			!! static.make (Current, "Width", 14, 18, 38, 13, -1)
			!! edit.make (Current, "", 14, 33, 52, 19, -1)
			!! ok_button.make (Current, "OK", 98, 12, 87, 23, -1)
			!! cancel_button.make (Current, "Cancel", 98, 45, 87, 23, -1)
			pen_width := 1
		end

feature -- Access

	edit: WEL_SINGLE_LINE_EDIT
			-- Edit control to enter pen width

	ok_button: WEL_PUSH_BUTTON
			-- Button to validate the value

	cancel_button: WEL_PUSH_BUTTON
			-- Button to cancel the value

	static: WEL_STATIC
			-- "Width" static text

	pen_width: INTEGER
			-- Pen width entered

feature -- Basic operations

	activate is
			-- Activate the window.
		local
			s: STRING
		do
			!! s.make (0)
			s.append_integer (pen_width)
			edit.set_text (s)
			show
		end

feature {NONE} -- Implementation

	on_control_command (control: WEL_CONTROL) is
			-- Process `ok_button' and `cancel_button' selection.
		local
			p: MAIN_WINDOW
		do
			if control = ok_button then
				if edit.text.is_integer then
					pen_width := edit.text.to_integer
					p ?= parent
					if p /= Void then
						p.set_pen_width (pen_width)
					end
					hide
				end
			elseif control = cancel_button then
				hide
			end
		end

end -- class LINE_THICKNESS_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
