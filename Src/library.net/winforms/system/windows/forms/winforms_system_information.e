indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.SystemInformation"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_SYSTEM_INFORMATION

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_vertical_scroll_bar_width: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Windows.Forms.SystemInformation"
		alias
			"get_VerticalScrollBarWidth"
		end

	frozen get_horizontal_scroll_bar_arrow_width: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Windows.Forms.SystemInformation"
		alias
			"get_HorizontalScrollBarArrowWidth"
		end

	frozen get_vertical_scroll_bar_thumb_height: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Windows.Forms.SystemInformation"
		alias
			"get_VerticalScrollBarThumbHeight"
		end

	frozen get_right_aligned_menus: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_RightAlignedMenus"
		end

	frozen get_boot_mode: WINFORMS_BOOT_MODE is
		external
			"IL static signature (): System.Windows.Forms.BootMode use System.Windows.Forms.SystemInformation"
		alias
			"get_BootMode"
		end

	frozen get_caption_button_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_CaptionButtonSize"
		end

	frozen get_max_window_track_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_MaxWindowTrackSize"
		end

	frozen get_dbcs_enabled: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_DbcsEnabled"
		end

	frozen get_mouse_buttons_swapped: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_MouseButtonsSwapped"
		end

	frozen get_frame_border_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_FrameBorderSize"
		end

	frozen get_working_area: DRAWING_RECTANGLE is
		external
			"IL static signature (): System.Drawing.Rectangle use System.Windows.Forms.SystemInformation"
		alias
			"get_WorkingArea"
		end

	frozen get_virtual_screen: DRAWING_RECTANGLE is
		external
			"IL static signature (): System.Drawing.Rectangle use System.Windows.Forms.SystemInformation"
		alias
			"get_VirtualScreen"
		end

	frozen get_fixed_frame_border_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_FixedFrameBorderSize"
		end

	frozen get_primary_monitor_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_PrimaryMonitorSize"
		end

	frozen get_monitors_same_display_format: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_MonitorsSameDisplayFormat"
		end

	frozen get_border3_dsize: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_Border3DSize"
		end

	frozen get_debug_os: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_DebugOS"
		end

	frozen get_min_window_track_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_MinWindowTrackSize"
		end

	frozen get_border_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_BorderSize"
		end

	frozen get_mid_east_enabled: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_MidEastEnabled"
		end

	frozen get_high_contrast: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_HighContrast"
		end

	frozen get_pen_windows: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_PenWindows"
		end

	frozen get_arrange_starting_position: WINFORMS_ARRANGE_STARTING_POSITION is
		external
			"IL static signature (): System.Windows.Forms.ArrangeStartingPosition use System.Windows.Forms.SystemInformation"
		alias
			"get_ArrangeStartingPosition"
		end

	frozen get_menu_height: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Windows.Forms.SystemInformation"
		alias
			"get_MenuHeight"
		end

	frozen get_mouse_buttons: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Windows.Forms.SystemInformation"
		alias
			"get_MouseButtons"
		end

	frozen get_double_click_time: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Windows.Forms.SystemInformation"
		alias
			"get_DoubleClickTime"
		end

	frozen get_user_interactive: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_UserInteractive"
		end

	frozen get_horizontal_scroll_bar_thumb_width: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Windows.Forms.SystemInformation"
		alias
			"get_HorizontalScrollBarThumbWidth"
		end

	frozen get_native_mouse_wheel_support: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_NativeMouseWheelSupport"
		end

	frozen get_minimized_window_spacing_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_MinimizedWindowSpacingSize"
		end

	frozen get_cursor_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_CursorSize"
		end

	frozen get_computer_name: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Windows.Forms.SystemInformation"
		alias
			"get_ComputerName"
		end

	frozen get_tool_window_caption_button_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_ToolWindowCaptionButtonSize"
		end

	frozen get_double_click_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_DoubleClickSize"
		end

	frozen get_tool_window_caption_height: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Windows.Forms.SystemInformation"
		alias
			"get_ToolWindowCaptionHeight"
		end

	frozen get_icon_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_IconSize"
		end

	frozen get_menu_button_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_MenuButtonSize"
		end

	frozen get_minimum_window_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_MinimumWindowSize"
		end

	frozen get_drag_full_windows: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_DragFullWindows"
		end

	frozen get_user_domain_name: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Windows.Forms.SystemInformation"
		alias
			"get_UserDomainName"
		end

	frozen get_primary_monitor_maximized_window_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_PrimaryMonitorMaximizedWindowSize"
		end

	frozen get_user_name: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Windows.Forms.SystemInformation"
		alias
			"get_UserName"
		end

	frozen get_menu_font: DRAWING_FONT is
		external
			"IL static signature (): System.Drawing.Font use System.Windows.Forms.SystemInformation"
		alias
			"get_MenuFont"
		end

	frozen get_caption_height: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Windows.Forms.SystemInformation"
		alias
			"get_CaptionHeight"
		end

	frozen get_mouse_wheel_scroll_lines: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Windows.Forms.SystemInformation"
		alias
			"get_MouseWheelScrollLines"
		end

	frozen get_minimized_window_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_MinimizedWindowSize"
		end

	frozen get_drag_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_DragSize"
		end

	frozen get_secure: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_Secure"
		end

	frozen get_network: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_Network"
		end

	frozen get_icon_spacing_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_IconSpacingSize"
		end

	frozen get_kanji_window_height: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Windows.Forms.SystemInformation"
		alias
			"get_KanjiWindowHeight"
		end

	frozen get_small_icon_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_SmallIconSize"
		end

	frozen get_show_sounds: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_ShowSounds"
		end

	frozen get_monitor_count: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Windows.Forms.SystemInformation"
		alias
			"get_MonitorCount"
		end

	frozen get_menu_check_size: DRAWING_SIZE is
		external
			"IL static signature (): System.Drawing.Size use System.Windows.Forms.SystemInformation"
		alias
			"get_MenuCheckSize"
		end

	frozen get_mouse_present: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_MousePresent"
		end

	frozen get_vertical_scroll_bar_arrow_height: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Windows.Forms.SystemInformation"
		alias
			"get_VerticalScrollBarArrowHeight"
		end

	frozen get_arrange_direction: WINFORMS_ARRANGE_DIRECTION is
		external
			"IL static signature (): System.Windows.Forms.ArrangeDirection use System.Windows.Forms.SystemInformation"
		alias
			"get_ArrangeDirection"
		end

	frozen get_mouse_wheel_present: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.SystemInformation"
		alias
			"get_MouseWheelPresent"
		end

	frozen get_horizontal_scroll_bar_height: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Windows.Forms.SystemInformation"
		alias
			"get_HorizontalScrollBarHeight"
		end

end -- class WINFORMS_SYSTEM_INFORMATION
