indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.SystemPens"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_SYSTEM_PENS

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_highlight_text: DRAWING_PEN is
		external
			"IL static signature (): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"get_HighlightText"
		end

	frozen get_window_frame: DRAWING_PEN is
		external
			"IL static signature (): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"get_WindowFrame"
		end

	frozen get_gray_text: DRAWING_PEN is
		external
			"IL static signature (): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"get_GrayText"
		end

	frozen get_highlight: DRAWING_PEN is
		external
			"IL static signature (): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"get_Highlight"
		end

	frozen get_control: DRAWING_PEN is
		external
			"IL static signature (): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"get_Control"
		end

	frozen get_inactive_caption_text: DRAWING_PEN is
		external
			"IL static signature (): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"get_InactiveCaptionText"
		end

	frozen get_control_dark_dark: DRAWING_PEN is
		external
			"IL static signature (): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"get_ControlDarkDark"
		end

	frozen get_control_dark: DRAWING_PEN is
		external
			"IL static signature (): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"get_ControlDark"
		end

	frozen get_control_light: DRAWING_PEN is
		external
			"IL static signature (): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"get_ControlLight"
		end

	frozen get_control_text: DRAWING_PEN is
		external
			"IL static signature (): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"get_ControlText"
		end

	frozen get_control_light_light: DRAWING_PEN is
		external
			"IL static signature (): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"get_ControlLightLight"
		end

	frozen get_menu_text: DRAWING_PEN is
		external
			"IL static signature (): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"get_MenuText"
		end

	frozen get_info_text: DRAWING_PEN is
		external
			"IL static signature (): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"get_InfoText"
		end

	frozen get_active_caption_text: DRAWING_PEN is
		external
			"IL static signature (): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"get_ActiveCaptionText"
		end

	frozen get_window_text: DRAWING_PEN is
		external
			"IL static signature (): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"get_WindowText"
		end

feature -- Basic Operations

	frozen from_system_color (c: DRAWING_COLOR): DRAWING_PEN is
		external
			"IL static signature (System.Drawing.Color): System.Drawing.Pen use System.Drawing.SystemPens"
		alias
			"FromSystemColor"
		end

end -- class DRAWING_SYSTEM_PENS
