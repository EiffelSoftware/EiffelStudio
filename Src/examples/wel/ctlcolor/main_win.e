class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_background,
			class_icon,
			closeable,
			on_color_control
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
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
			!! color.make_rgb (0, 255, 0)
			bkgnd_ctlcolor := color
			!! color.make_rgb (0, 0, 255)
			frgnd_ctlcolor := color
			
			!! frame.make (Current, "Color Controls", 5, 5, 305, 275, 0)
			!! static.make (Current, "Color Static", 50, 50, 100, 30, 1)
			!! sedit.make (Current, "Color Edit", 160, 50, 100, 30, 2)
			!! lbox.make (Current, 50, 90, 100, 100, 3)
			lbox.add_string ("Item 1")
			lbox.add_string ("Item 2")
			!! medit.make (Current, "Color Multiple Selection Edit", 160, 90, 100, 100, 4)
			!! sbar.make_horizontal (Current, 50, 200, 210, 30, 5)

			!! button.make (Current, "Foreground Color", 30, 290, 120, 25, 6, 1)
			!! button.make (Current, "Background Color", 170, 290, 120, 25, 7, 2)
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
			!! brush.make_solid (bkgnd_ctlcolor)
			set_message_return_value (brush.to_integer)
			disable_default_processing
		end

	closeable: BOOLEAN is
		local
			msg_box: WEL_MSG_BOX
		do
			!!msg_box.make
			msg_box.question_message_box (Current, "Do you want to exit?", "Exit")
			Result := msg_box.message_box_result = Idyes
		end

	class_background: WEL_BRUSH is
			-- background color
		once
			!! Result.make_by_sys_color (Color_background)
		end

	class_icon: WEL_ICON is
			-- Window's icon
		once
			!! Result.make_by_id (1)
		end

end -- class MAIN_WINDOW

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
