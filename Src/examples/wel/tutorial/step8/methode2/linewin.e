class
	LINE_THICKNESS_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_control_command,
			background_brush
		end

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Make the line thickness window.
		do
			make_child (a_parent, "Line thickness")
			move_and_resize (20, 20, 190, 104, True)

				-- set a "dialog box" style
			set_style(style + Ws_popup - Ws_minimizebox - Ws_maximizebox)

			create static.make (Current, "Width", 14, 18, 38, 13, -1)
			create edit.make (Current, "", 14, 33, 52, 21, -1)
			create ok_button.make (Current, "OK", 98, 12, 77, 23, -1)
			create cancel_button.make (Current, "Cancel", 98, 45, 77, 23, -1)
			pen_width := 1

				-- Change the font from `System_font' to `Default_gui_font' (the
				-- 'Default_gui_font' is the default font used to draw dialogs
			static.set_font(gui_font)
			ok_button.set_font(gui_font)
			cancel_button.set_font(gui_font)
			edit.set_font(gui_font)
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

	background_brush: WEL_BRUSH is
			-- Dialog boxes background color is the same than
			-- button color.
		once
			create Result.make_by_sys_color (Color_btnface + 1)
		end

feature -- Basic operations

	activate is
			-- Activate the window.
		local
			s: STRING
		do
			create s.make (0)
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

	gui_font: WEL_DEFAULT_GUI_FONT is
			-- Default font to draw dialogs.
		once
			create Result.make
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
