indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ControlPaint"

frozen external class
	SYSTEM_WINDOWS_FORMS_CONTROLPAINT

create {NONE}

feature -- Access

	frozen get_contrast_control_dark: SYSTEM_DRAWING_COLOR is
		external
			"IL static signature (): System.Drawing.Color use System.Windows.Forms.ControlPaint"
		alias
			"get_ContrastControlDark"
		end

feature -- Basic Operations

	frozen draw_scroll_button (graphics: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE; button: SYSTEM_WINDOWS_FORMS_SCROLLBUTTON; state: SYSTEM_WINDOWS_FORMS_BUTTONSTATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.ScrollButton, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawScrollButton"
		end

	frozen draw_border3_d_graphics_int32_int32_int32_int32 (graphics: SYSTEM_DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder3D"
		end

	frozen draw_mixed_check_box (graphics: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE; state: SYSTEM_WINDOWS_FORMS_BUTTONSTATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawMixedCheckBox"
		end

	frozen light_color_single (base_color: SYSTEM_DRAWING_COLOR; perc_of_light_light: REAL): SYSTEM_DRAWING_COLOR is
		external
			"IL static signature (System.Drawing.Color, System.Single): System.Drawing.Color use System.Windows.Forms.ControlPaint"
		alias
			"Light"
		end

	frozen draw_radio_button_graphics_int32 (graphics: SYSTEM_DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; state: SYSTEM_WINDOWS_FORMS_BUTTONSTATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawRadioButton"
		end

	frozen light_light (base_color: SYSTEM_DRAWING_COLOR): SYSTEM_DRAWING_COLOR is
		external
			"IL static signature (System.Drawing.Color): System.Drawing.Color use System.Windows.Forms.ControlPaint"
		alias
			"LightLight"
		end

	frozen draw_radio_button (graphics: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE; state: SYSTEM_WINDOWS_FORMS_BUTTONSTATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawRadioButton"
		end

	frozen draw_reversible_frame (rectangle: SYSTEM_DRAWING_RECTANGLE; back_color: SYSTEM_DRAWING_COLOR; style: SYSTEM_WINDOWS_FORMS_FRAMESTYLE) is
		external
			"IL static signature (System.Drawing.Rectangle, System.Drawing.Color, System.Windows.Forms.FrameStyle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawReversibleFrame"
		end

	frozen draw_check_box (graphics: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE; state: SYSTEM_WINDOWS_FORMS_BUTTONSTATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawCheckBox"
		end

	frozen create_hbitmap_color_mask (bitmap: SYSTEM_DRAWING_BITMAP; monochrome_mask: POINTER): POINTER is
		external
			"IL static signature (System.Drawing.Bitmap, System.IntPtr): System.IntPtr use System.Windows.Forms.ControlPaint"
		alias
			"CreateHBitmapColorMask"
		end

	frozen draw_size_grip (graphics: SYSTEM_DRAWING_GRAPHICS; back_color: SYSTEM_DRAWING_COLOR; bounds: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Color, System.Drawing.Rectangle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawSizeGrip"
		end

	frozen draw_focus_rectangle_graphics_rectangle_color (graphics: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE; fore_color: SYSTEM_DRAWING_COLOR; back_color: SYSTEM_DRAWING_COLOR) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Drawing.Color, System.Drawing.Color): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawFocusRectangle"
		end

	frozen draw_border3_d (graphics: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder3D"
		end

	frozen draw_border (graphics: SYSTEM_DRAWING_GRAPHICS; bounds: SYSTEM_DRAWING_RECTANGLE; color: SYSTEM_DRAWING_COLOR; style: SYSTEM_WINDOWS_FORMS_BUTTONBORDERSTYLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Drawing.Color, System.Windows.Forms.ButtonBorderStyle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder"
		end

	frozen dark (base_color: SYSTEM_DRAWING_COLOR): SYSTEM_DRAWING_COLOR is
		external
			"IL static signature (System.Drawing.Color): System.Drawing.Color use System.Windows.Forms.ControlPaint"
		alias
			"Dark"
		end

	frozen light (base_color: SYSTEM_DRAWING_COLOR): SYSTEM_DRAWING_COLOR is
		external
			"IL static signature (System.Drawing.Color): System.Drawing.Color use System.Windows.Forms.ControlPaint"
		alias
			"Light"
		end

	frozen draw_button_graphics_int32 (graphics: SYSTEM_DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; state: SYSTEM_WINDOWS_FORMS_BUTTONSTATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawButton"
		end

	frozen draw_border_graphics_rectangle_color_int32 (graphics: SYSTEM_DRAWING_GRAPHICS; bounds: SYSTEM_DRAWING_RECTANGLE; left_color: SYSTEM_DRAWING_COLOR; left_width: INTEGER; left_style: SYSTEM_WINDOWS_FORMS_BUTTONBORDERSTYLE; top_color: SYSTEM_DRAWING_COLOR; top_width: INTEGER; top_style: SYSTEM_WINDOWS_FORMS_BUTTONBORDERSTYLE; right_color: SYSTEM_DRAWING_COLOR; right_width: INTEGER; right_style: SYSTEM_WINDOWS_FORMS_BUTTONBORDERSTYLE; bottom_color: SYSTEM_DRAWING_COLOR; bottom_width: INTEGER; bottom_style: SYSTEM_WINDOWS_FORMS_BUTTONBORDERSTYLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Drawing.Color, System.Int32, System.Windows.Forms.ButtonBorderStyle, System.Drawing.Color, System.Int32, System.Windows.Forms.ButtonBorderStyle, System.Drawing.Color, System.Int32, System.Windows.Forms.ButtonBorderStyle, System.Drawing.Color, System.Int32, System.Windows.Forms.ButtonBorderStyle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder"
		end

	frozen draw_selection_frame (graphics: SYSTEM_DRAWING_GRAPHICS; active: BOOLEAN; outside_rect: SYSTEM_DRAWING_RECTANGLE; inside_rect: SYSTEM_DRAWING_RECTANGLE; back_color: SYSTEM_DRAWING_COLOR) is
		external
			"IL static signature (System.Drawing.Graphics, System.Boolean, System.Drawing.Rectangle, System.Drawing.Rectangle, System.Drawing.Color): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawSelectionFrame"
		end

	frozen create_hbitmap16_bit (bitmap: SYSTEM_DRAWING_BITMAP; background: SYSTEM_DRAWING_COLOR): POINTER is
		external
			"IL static signature (System.Drawing.Bitmap, System.Drawing.Color): System.IntPtr use System.Windows.Forms.ControlPaint"
		alias
			"CreateHBitmap16Bit"
		end

	frozen draw_check_box_graphics_int32 (graphics: SYSTEM_DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; state: SYSTEM_WINDOWS_FORMS_BUTTONSTATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawCheckBox"
		end

	frozen dark_color_single (base_color: SYSTEM_DRAWING_COLOR; perc_of_dark_dark: REAL): SYSTEM_DRAWING_COLOR is
		external
			"IL static signature (System.Drawing.Color, System.Single): System.Drawing.Color use System.Windows.Forms.ControlPaint"
		alias
			"Dark"
		end

	frozen draw_scroll_button_graphics_int32 (graphics: SYSTEM_DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; button: SYSTEM_WINDOWS_FORMS_SCROLLBUTTON; state: SYSTEM_WINDOWS_FORMS_BUTTONSTATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.ScrollButton, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawScrollButton"
		end

	frozen dark_dark (base_color: SYSTEM_DRAWING_COLOR): SYSTEM_DRAWING_COLOR is
		external
			"IL static signature (System.Drawing.Color): System.Drawing.Color use System.Windows.Forms.ControlPaint"
		alias
			"DarkDark"
		end

	frozen draw_focus_rectangle (graphics: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawFocusRectangle"
		end

	frozen create_hbitmap_transparency_mask (bitmap: SYSTEM_DRAWING_BITMAP): POINTER is
		external
			"IL static signature (System.Drawing.Bitmap): System.IntPtr use System.Windows.Forms.ControlPaint"
		alias
			"CreateHBitmapTransparencyMask"
		end

	frozen draw_container_grab_handle (graphics: SYSTEM_DRAWING_GRAPHICS; bounds: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawContainerGrabHandle"
		end

	frozen draw_mixed_check_box_graphics_int32 (graphics: SYSTEM_DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; state: SYSTEM_WINDOWS_FORMS_BUTTONSTATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawMixedCheckBox"
		end

	frozen draw_combo_button_graphics_int32 (graphics: SYSTEM_DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; state: SYSTEM_WINDOWS_FORMS_BUTTONSTATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawComboButton"
		end

	frozen draw_size_grip_graphics_color_int32 (graphics: SYSTEM_DRAWING_GRAPHICS; back_color: SYSTEM_DRAWING_COLOR; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Color, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawSizeGrip"
		end

	frozen draw_caption_button_graphics_int32 (graphics: SYSTEM_DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; button: SYSTEM_WINDOWS_FORMS_CAPTIONBUTTON; state: SYSTEM_WINDOWS_FORMS_BUTTONSTATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.CaptionButton, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawCaptionButton"
		end

	frozen draw_border3_d_graphics_int32_int32_int32_int32_border3_dstyle_border3_dside (graphics: SYSTEM_DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; style: SYSTEM_WINDOWS_FORMS_BORDER3DSTYLE; sides: SYSTEM_WINDOWS_FORMS_BORDER3DSIDE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.Border3DStyle, System.Windows.Forms.Border3DSide): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder3D"
		end

	frozen draw_grid (graphics: SYSTEM_DRAWING_GRAPHICS; area: SYSTEM_DRAWING_RECTANGLE; pixels_between_dots: SYSTEM_DRAWING_SIZE; back_color: SYSTEM_DRAWING_COLOR) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Drawing.Size, System.Drawing.Color): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawGrid"
		end

	frozen draw_string_disabled (graphics: SYSTEM_DRAWING_GRAPHICS; s: STRING; font: SYSTEM_DRAWING_FONT; color: SYSTEM_DRAWING_COLOR; layout_rectangle: SYSTEM_DRAWING_RECTANGLEF; format: SYSTEM_DRAWING_STRINGFORMAT) is
		external
			"IL static signature (System.Drawing.Graphics, System.String, System.Drawing.Font, System.Drawing.Color, System.Drawing.RectangleF, System.Drawing.StringFormat): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawStringDisabled"
		end

	frozen draw_grab_handle (graphics: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE; primary: BOOLEAN; enabled: BOOLEAN) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Boolean, System.Boolean): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawGrabHandle"
		end

	frozen draw_caption_button (graphics: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE; button: SYSTEM_WINDOWS_FORMS_CAPTIONBUTTON; state: SYSTEM_WINDOWS_FORMS_BUTTONSTATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.CaptionButton, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawCaptionButton"
		end

	frozen draw_menu_glyph_graphics_int32 (graphics: SYSTEM_DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; glyph: SYSTEM_WINDOWS_FORMS_MENUGLYPH) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.MenuGlyph): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawMenuGlyph"
		end

	frozen draw_combo_button (graphics: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE; state: SYSTEM_WINDOWS_FORMS_BUTTONSTATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawComboButton"
		end

	frozen draw_border3_d_graphics_rectangle_border3_dstyle_border3_dside (graphics: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE; style: SYSTEM_WINDOWS_FORMS_BORDER3DSTYLE; sides: SYSTEM_WINDOWS_FORMS_BORDER3DSIDE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.Border3DStyle, System.Windows.Forms.Border3DSide): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder3D"
		end

	frozen draw_button (graphics: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE; state: SYSTEM_WINDOWS_FORMS_BUTTONSTATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawButton"
		end

	frozen draw_border3_d_graphics_rectangle_border3_dstyle (graphics: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE; style: SYSTEM_WINDOWS_FORMS_BORDER3DSTYLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.Border3DStyle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder3D"
		end

	frozen fill_reversible_rectangle (rectangle: SYSTEM_DRAWING_RECTANGLE; back_color: SYSTEM_DRAWING_COLOR) is
		external
			"IL static signature (System.Drawing.Rectangle, System.Drawing.Color): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"FillReversibleRectangle"
		end

	frozen draw_locked_frame (graphics: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE; primary: BOOLEAN) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Boolean): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawLockedFrame"
		end

	frozen draw_reversible_line (start: SYSTEM_DRAWING_POINT; end_: SYSTEM_DRAWING_POINT; back_color: SYSTEM_DRAWING_COLOR) is
		external
			"IL static signature (System.Drawing.Point, System.Drawing.Point, System.Drawing.Color): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawReversibleLine"
		end

	frozen draw_image_disabled (graphics: SYSTEM_DRAWING_GRAPHICS; image: SYSTEM_DRAWING_IMAGE; x: INTEGER; y: INTEGER; background: SYSTEM_DRAWING_COLOR) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Image, System.Int32, System.Int32, System.Drawing.Color): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawImageDisabled"
		end

	frozen draw_border3_d_graphics_int32_int32_int32_int32_border3_dstyle (graphics: SYSTEM_DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; style: SYSTEM_WINDOWS_FORMS_BORDER3DSTYLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.Border3DStyle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder3D"
		end

	frozen draw_menu_glyph (graphics: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE; glyph: SYSTEM_WINDOWS_FORMS_MENUGLYPH) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.MenuGlyph): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawMenuGlyph"
		end

end -- class SYSTEM_WINDOWS_FORMS_CONTROLPAINT
