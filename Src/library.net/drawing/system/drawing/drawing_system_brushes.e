indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.SystemBrushes"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_SYSTEM_BRUSHES

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_highlight: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_Highlight"
		end

	frozen get_control_dark: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_ControlDark"
		end

	frozen get_menu: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_Menu"
		end

	frozen get_inactive_border: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_InactiveBorder"
		end

	frozen get_control: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_Control"
		end

	frozen get_app_workspace: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_AppWorkspace"
		end

	frozen get_inactive_caption: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_InactiveCaption"
		end

	frozen get_window_text: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_WindowText"
		end

	frozen get_highlight_text: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_HighlightText"
		end

	frozen get_control_dark_dark: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_ControlDarkDark"
		end

	frozen get_active_caption: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_ActiveCaption"
		end

	frozen get_control_light_light: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_ControlLightLight"
		end

	frozen get_hot_track: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_HotTrack"
		end

	frozen get_active_caption_text: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_ActiveCaptionText"
		end

	frozen get_info: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_Info"
		end

	frozen get_window: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_Window"
		end

	frozen get_control_text: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_ControlText"
		end

	frozen get_control_light: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_ControlLight"
		end

	frozen get_desktop: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_Desktop"
		end

	frozen get_scroll_bar: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_ScrollBar"
		end

	frozen get_active_border: DRAWING_BRUSH is
		external
			"IL static signature (): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"get_ActiveBorder"
		end

feature -- Basic Operations

	frozen from_system_color (c: DRAWING_COLOR): DRAWING_BRUSH is
		external
			"IL static signature (System.Drawing.Color): System.Drawing.Brush use System.Drawing.SystemBrushes"
		alias
			"FromSystemColor"
		end

end -- class DRAWING_SYSTEM_BRUSHES
