class
	PRECOMP_MAIN_WINDOW

inherit
	WEL_COLOR_CONSTANTS
	WEL_FRAME_WINDOW
		redefine
			background_brush,
			closeable,
			on_color_control
		end

creation
	make

feature -- Initialization

	make is
			-- Make the main window
		local
			frame: WEL_GROUP_BOX
			button: MY_BUTTON
			static: WEL_STATIC
			medit: WEL_MULTIPLE_LINE_EDIT
			sedit: WEL_SINGLE_LINE_EDIT
			lbox: WEL_SINGLE_SELECTION_LIST_BOX
			sbar: WEL_SCROLL_BAR
			color: WEL_COLOR_REF
		do
			make_top ("WEL Color Controls")
			resize (330, 360)
			create color.make_rgb (0, 255, 0)
			bkgnd_ctlcolor := color
			create color.make_rgb (0, 0, 255)
			frgnd_ctlcolor := color
			
			create frame.make (Current, "Color Controls", 5, 5, 305, 275, 0)
			frame.set_font(gui_font)
			create static.make (Current, "Color Static", 50, 50, 100, 30, 1)
			static.set_font(gui_font)
			create sedit.make (Current, "Color Edit", 160, 50, 100, 30, 2)
			sedit.set_font(gui_font)
			create lbox.make (Current, 50, 90, 100, 100, 3)
			lbox.set_font(gui_font)
			lbox.add_string ("Item 1")
			lbox.add_string ("Item 2")
			create medit.make (Current, "Color Multiple Selection Edit", 160, 90, 100, 100, 4)
			medit.set_font(gui_font)
			create sbar.make_horizontal (Current, 50, 200, 210, 30, 5)

			create button.make (Current, "Foreground Color", 30, 290, 120, 25, 6, 1)
			button.set_font(gui_font)

			create button.make (Current, "Background Color", 170, 290, 120, 25, 7, 2)
			button.set_font(gui_font)
		end

feature -- Access

	bkgnd_ctlcolor: WEL_COLOR_REF
			-- Color used for the background of the controls

	frgnd_ctlcolor: WEL_COLOR_REF
			-- Color used for the foreground of the controls

feature -- Element change

	set_frgnd_ctlcolor (a_color: WEL_COLOR_REF) is
			-- Make `a_color' the new `frgnd_ctlcolor'.
		do
			frgnd_ctlcolor := a_color
		end

	set_bkgnd_ctlcolor (a_color: WEL_COLOR_REF) is
			-- Make `a_color' the new `bkgnd_ctlcolor'.
		do
			bkgnd_ctlcolor := a_color
		end

feature {NONE} -- Implementation

	on_color_control (control: WEL_COLOR_CONTROL; paint_dc: WEL_PAINT_DC) is
			-- Wm_ctlcolorstatic, Wm_ctlcoloredit, Wm_ctlcolorlistbox
			-- and Wm_ctlcolorscrollbar messages.
			-- To change its default colors, the color-control `control'
			-- needs :
			-- 1. a background color and a foreground color to be selected
			--    in the `paint_dc',
			-- 2. a backgound brush to be return to the system.
		local
			brush: WEL_BRUSH
		do
			paint_dc.set_text_color (frgnd_ctlcolor)
			paint_dc.set_background_color (bkgnd_ctlcolor)
			create brush.make_solid (bkgnd_ctlcolor)
			set_message_return_value (brush.to_integer)
			disable_default_processing
		end

	closeable: BOOLEAN is
		local
			msg_box: WEL_MSG_BOX
		do
			create msg_box.make
			msg_box.question_message_box (Current, "Do you want to exit?", "Exit")
			Result := msg_box.message_box_result = Idyes
		end

	background_brush: WEL_BRUSH is
			-- background color
		do
			create Result.make_by_sys_color (Color_btnface + 1)
		end

	gui_font: WEL_DEFAULT_GUI_FONT is
			-- Default font used to draw dialogs.
		once
			create Result.make
		end

end -- class PRECOMP_MAIN_WINDOW

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
