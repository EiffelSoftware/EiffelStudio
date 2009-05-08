note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MAIN_WINDOW

inherit
	WEL_COLOR_CONSTANTS
	WEL_FRAME_WINDOW
		redefine
			background_brush,
			closeable,
			on_color_control
		end

create
	make

feature -- Initialization

	make
			-- Make the main window
		local
			l_frame: WEL_GROUP_BOX
			l_button: MY_BUTTON
			l_static: WEL_STATIC
			l_medit: WEL_MULTIPLE_LINE_EDIT
			l_sedit: WEL_SINGLE_LINE_EDIT
			l_lbox: WEL_SINGLE_SELECTION_LIST_BOX
		do
			create bkgnd_ctlcolor.make_rgb (0, 255, 0)
			create frgnd_ctlcolor.make_rgb (0, 0, 255)
			make_top ("WEL Color Controls")
			resize (330, 360)

			create l_frame.make (Current, "Color Controls", 5, 5, 305, 275, 0)
			frame := l_frame
			l_frame.set_font(gui_font)
			create l_static.make (Current, "Color Static", 50, 50, 100, 30, 1)
			static := l_static
			l_static.set_font(gui_font)
			create l_sedit.make (Current, "Color Edit", 160, 50, 100, 30, 2)
			sedit := l_sedit
			l_sedit.set_font(gui_font)
			create l_lbox.make (Current, 50, 90, 100, 100, 3)
			lbox := l_lbox
			l_lbox.set_font(gui_font)
			l_lbox.add_string ("Item 1")
			l_lbox.add_string ("Item 2")
			create l_medit.make (Current, "Color Multiple Selection Edit", 160, 90, 100, 100, 4)
			medit := l_medit
			l_medit.set_font(gui_font)
			create sbar.make_horizontal (Current, 50, 200, 210, 30, 5)

			create l_button.make (Current, "Foreground Color", 30, 290, 120, 25, 6, 1)
			foreground_button := l_button
			l_button.set_font(gui_font)

			create l_button.make (Current, "Background Color", 170, 290, 120, 25, 7, 2)
			background_button := l_button
			l_button.set_font(gui_font)
		end

feature -- Access

	bkgnd_ctlcolor: WEL_COLOR_REF
			-- Color used for the background of the controls

	frgnd_ctlcolor: WEL_COLOR_REF
			-- Color used for the foreground of the controls

	background_brush: WEL_BRUSH
			-- background color
		do
			create Result.make_by_sys_color (Color_btnface + 1)
		end

feature -- Element change

	set_frgnd_ctlcolor (a_color: WEL_COLOR_REF)
			-- Make `a_color' the new `frgnd_ctlcolor'.
		do
			frgnd_ctlcolor := a_color
		end

	set_bkgnd_ctlcolor (a_color: WEL_COLOR_REF)
			-- Make `a_color' the new `bkgnd_ctlcolor'.
		do
			bkgnd_ctlcolor := a_color
		end

feature {NONE} -- GC tracking

	frame: detachable WEL_GROUP_BOX
	foreground_button, background_button: detachable MY_BUTTON
	static: detachable WEL_STATIC
	medit: detachable WEL_MULTIPLE_LINE_EDIT
	sedit: detachable WEL_SINGLE_LINE_EDIT
	lbox: detachable WEL_SINGLE_SELECTION_LIST_BOX
	sbar: detachable WEL_SCROLL_BAR

feature {NONE} -- Implementation

	on_color_control (control: WEL_COLOR_CONTROL; paint_dc: WEL_PAINT_DC)
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
			set_message_return_value (brush.item)
			disable_default_processing
		end

	closeable: BOOLEAN
		local
			msg_box: WEL_MSG_BOX
		do
			create msg_box.make
			msg_box.question_message_box (Current, "Do you want to exit?", "Exit")
			Result := msg_box.message_box_result = Idyes
		end

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


end -- class PRECOMP_MAIN_WINDOW

