indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ControlPaint"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_CONTROL_PAINT

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_contrast_control_dark: DRAWING_COLOR is
		external
			"IL static signature (): System.Drawing.Color use System.Windows.Forms.ControlPaint"
		alias
			"get_ContrastControlDark"
		end

feature -- Basic Operations

	frozen draw_scroll_button (graphics: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE; button: WINFORMS_SCROLL_BUTTON; state: WINFORMS_BUTTON_STATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.ScrollButton, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawScrollButton"
		end

	frozen draw_border3_d_graphics_int32_int32_int32_int32 (graphics: DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder3D"
		end

	frozen draw_mixed_check_box (graphics: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE; state: WINFORMS_BUTTON_STATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawMixedCheckBox"
		end

	frozen light_color_single (base_color: DRAWING_COLOR; perc_of_light_light: REAL): DRAWING_COLOR is
		external
			"IL static signature (System.Drawing.Color, System.Single): System.Drawing.Color use System.Windows.Forms.ControlPaint"
		alias
			"Light"
		end

	frozen draw_radio_button_graphics_int32 (graphics: DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; state: WINFORMS_BUTTON_STATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawRadioButton"
		end

	frozen light_light (base_color: DRAWING_COLOR): DRAWING_COLOR is
		external
			"IL static signature (System.Drawing.Color): System.Drawing.Color use System.Windows.Forms.ControlPaint"
		alias
			"LightLight"
		end

	frozen draw_radio_button (graphics: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE; state: WINFORMS_BUTTON_STATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawRadioButton"
		end

	frozen draw_reversible_frame (rectangle: DRAWING_RECTANGLE; back_color: DRAWING_COLOR; style: WINFORMS_FRAME_STYLE) is
		external
			"IL static signature (System.Drawing.Rectangle, System.Drawing.Color, System.Windows.Forms.FrameStyle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawReversibleFrame"
		end

	frozen draw_check_box (graphics: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE; state: WINFORMS_BUTTON_STATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawCheckBox"
		end

	frozen create_hbitmap_color_mask (bitmap: DRAWING_BITMAP; monochrome_mask: POINTER): POINTER is
		external
			"IL static signature (System.Drawing.Bitmap, System.IntPtr): System.IntPtr use System.Windows.Forms.ControlPaint"
		alias
			"CreateHBitmapColorMask"
		end

	frozen draw_size_grip (graphics: DRAWING_GRAPHICS; back_color: DRAWING_COLOR; bounds: DRAWING_RECTANGLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Color, System.Drawing.Rectangle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawSizeGrip"
		end

	frozen draw_focus_rectangle_graphics_rectangle_color (graphics: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE; fore_color: DRAWING_COLOR; back_color: DRAWING_COLOR) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Drawing.Color, System.Drawing.Color): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawFocusRectangle"
		end

	frozen draw_border3_d (graphics: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder3D"
		end

	frozen draw_border (graphics: DRAWING_GRAPHICS; bounds: DRAWING_RECTANGLE; color: DRAWING_COLOR; style: WINFORMS_BUTTON_BORDER_STYLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Drawing.Color, System.Windows.Forms.ButtonBorderStyle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder"
		end

	frozen dark (base_color: DRAWING_COLOR): DRAWING_COLOR is
		external
			"IL static signature (System.Drawing.Color): System.Drawing.Color use System.Windows.Forms.ControlPaint"
		alias
			"Dark"
		end

	frozen light (base_color: DRAWING_COLOR): DRAWING_COLOR is
		external
			"IL static signature (System.Drawing.Color): System.Drawing.Color use System.Windows.Forms.ControlPaint"
		alias
			"Light"
		end

	frozen draw_button_graphics_int32 (graphics: DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; state: WINFORMS_BUTTON_STATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawButton"
		end

	frozen draw_border_graphics_rectangle_color_int32 (graphics: DRAWING_GRAPHICS; bounds: DRAWING_RECTANGLE; left_color: DRAWING_COLOR; left_width: INTEGER; left_style: WINFORMS_BUTTON_BORDER_STYLE; top_color: DRAWING_COLOR; top_width: INTEGER; top_style: WINFORMS_BUTTON_BORDER_STYLE; right_color: DRAWING_COLOR; right_width: INTEGER; right_style: WINFORMS_BUTTON_BORDER_STYLE; bottom_color: DRAWING_COLOR; bottom_width: INTEGER; bottom_style: WINFORMS_BUTTON_BORDER_STYLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Drawing.Color, System.Int32, System.Windows.Forms.ButtonBorderStyle, System.Drawing.Color, System.Int32, System.Windows.Forms.ButtonBorderStyle, System.Drawing.Color, System.Int32, System.Windows.Forms.ButtonBorderStyle, System.Drawing.Color, System.Int32, System.Windows.Forms.ButtonBorderStyle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder"
		end

	frozen draw_selection_frame (graphics: DRAWING_GRAPHICS; active: BOOLEAN; outside_rect: DRAWING_RECTANGLE; inside_rect: DRAWING_RECTANGLE; back_color: DRAWING_COLOR) is
		external
			"IL static signature (System.Drawing.Graphics, System.Boolean, System.Drawing.Rectangle, System.Drawing.Rectangle, System.Drawing.Color): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawSelectionFrame"
		end

	frozen create_hbitmap16_bit (bitmap: DRAWING_BITMAP; background: DRAWING_COLOR): POINTER is
		external
			"IL static signature (System.Drawing.Bitmap, System.Drawing.Color): System.IntPtr use System.Windows.Forms.ControlPaint"
		alias
			"CreateHBitmap16Bit"
		end

	frozen draw_check_box_graphics_int32 (graphics: DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; state: WINFORMS_BUTTON_STATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawCheckBox"
		end

	frozen dark_color_single (base_color: DRAWING_COLOR; perc_of_dark_dark: REAL): DRAWING_COLOR is
		external
			"IL static signature (System.Drawing.Color, System.Single): System.Drawing.Color use System.Windows.Forms.ControlPaint"
		alias
			"Dark"
		end

	frozen draw_scroll_button_graphics_int32 (graphics: DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; button: WINFORMS_SCROLL_BUTTON; state: WINFORMS_BUTTON_STATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.ScrollButton, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawScrollButton"
		end

	frozen dark_dark (base_color: DRAWING_COLOR): DRAWING_COLOR is
		external
			"IL static signature (System.Drawing.Color): System.Drawing.Color use System.Windows.Forms.ControlPaint"
		alias
			"DarkDark"
		end

	frozen draw_focus_rectangle (graphics: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawFocusRectangle"
		end

	frozen create_hbitmap_transparency_mask (bitmap: DRAWING_BITMAP): POINTER is
		external
			"IL static signature (System.Drawing.Bitmap): System.IntPtr use System.Windows.Forms.ControlPaint"
		alias
			"CreateHBitmapTransparencyMask"
		end

	frozen draw_container_grab_handle (graphics: DRAWING_GRAPHICS; bounds: DRAWING_RECTANGLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawContainerGrabHandle"
		end

	frozen draw_mixed_check_box_graphics_int32 (graphics: DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; state: WINFORMS_BUTTON_STATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawMixedCheckBox"
		end

	frozen draw_combo_button_graphics_int32 (graphics: DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; state: WINFORMS_BUTTON_STATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawComboButton"
		end

	frozen draw_size_grip_graphics_color_int32 (graphics: DRAWING_GRAPHICS; back_color: DRAWING_COLOR; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Color, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawSizeGrip"
		end

	frozen draw_caption_button_graphics_int32 (graphics: DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; button: WINFORMS_CAPTION_BUTTON; state: WINFORMS_BUTTON_STATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.CaptionButton, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawCaptionButton"
		end

	frozen draw_border3_d_graphics_int32_int32_int32_int32_border3_dstyle_border3_dside (graphics: DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; style: WINFORMS_BORDER3_DSTYLE; sides: WINFORMS_BORDER3_DSIDE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.Border3DStyle, System.Windows.Forms.Border3DSide): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder3D"
		end

	frozen draw_grid (graphics: DRAWING_GRAPHICS; area: DRAWING_RECTANGLE; pixels_between_dots: DRAWING_SIZE; back_color: DRAWING_COLOR) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Drawing.Size, System.Drawing.Color): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawGrid"
		end

	frozen draw_string_disabled (graphics: DRAWING_GRAPHICS; s: SYSTEM_STRING; font: DRAWING_FONT; color: DRAWING_COLOR; layout_rectangle: DRAWING_RECTANGLE_F; format: DRAWING_STRING_FORMAT) is
		external
			"IL static signature (System.Drawing.Graphics, System.String, System.Drawing.Font, System.Drawing.Color, System.Drawing.RectangleF, System.Drawing.StringFormat): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawStringDisabled"
		end

	frozen draw_grab_handle (graphics: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE; primary: BOOLEAN; enabled: BOOLEAN) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Boolean, System.Boolean): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawGrabHandle"
		end

	frozen draw_caption_button (graphics: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE; button: WINFORMS_CAPTION_BUTTON; state: WINFORMS_BUTTON_STATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.CaptionButton, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawCaptionButton"
		end

	frozen draw_menu_glyph_graphics_int32 (graphics: DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; glyph: WINFORMS_MENU_GLYPH) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.MenuGlyph): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawMenuGlyph"
		end

	frozen draw_combo_button (graphics: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE; state: WINFORMS_BUTTON_STATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawComboButton"
		end

	frozen draw_border3_d_graphics_rectangle_border3_dstyle_border3_dside (graphics: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE; style: WINFORMS_BORDER3_DSTYLE; sides: WINFORMS_BORDER3_DSIDE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.Border3DStyle, System.Windows.Forms.Border3DSide): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder3D"
		end

	frozen draw_button (graphics: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE; state: WINFORMS_BUTTON_STATE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.ButtonState): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawButton"
		end

	frozen draw_border3_d_graphics_rectangle_border3_dstyle (graphics: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE; style: WINFORMS_BORDER3_DSTYLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.Border3DStyle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder3D"
		end

	frozen fill_reversible_rectangle (rectangle: DRAWING_RECTANGLE; back_color: DRAWING_COLOR) is
		external
			"IL static signature (System.Drawing.Rectangle, System.Drawing.Color): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"FillReversibleRectangle"
		end

	frozen draw_locked_frame (graphics: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE; primary: BOOLEAN) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Boolean): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawLockedFrame"
		end

	frozen draw_reversible_line (start: DRAWING_POINT; end_: DRAWING_POINT; back_color: DRAWING_COLOR) is
		external
			"IL static signature (System.Drawing.Point, System.Drawing.Point, System.Drawing.Color): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawReversibleLine"
		end

	frozen draw_image_disabled (graphics: DRAWING_GRAPHICS; image: DRAWING_IMAGE; x: INTEGER; y: INTEGER; background: DRAWING_COLOR) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Image, System.Int32, System.Int32, System.Drawing.Color): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawImageDisabled"
		end

	frozen draw_border3_d_graphics_int32_int32_int32_int32_border3_dstyle (graphics: DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; style: WINFORMS_BORDER3_DSTYLE) is
		external
			"IL static signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.Border3DStyle): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawBorder3D"
		end

	frozen draw_menu_glyph (graphics: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE; glyph: WINFORMS_MENU_GLYPH) is
		external
			"IL static signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.MenuGlyph): System.Void use System.Windows.Forms.ControlPaint"
		alias
			"DrawMenuGlyph"
		end

end -- class WINFORMS_CONTROL_PAINT
