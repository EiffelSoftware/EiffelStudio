indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.MonthCalendar"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_MONTH_CALENDAR

inherit
	WINFORMS_CONTROL
		redefine
			wnd_proc,
			set_bounds_core,
			on_handle_created,
			on_fore_color_changed,
			on_font_changed,
			on_back_color_changed,
			is_input_key,
			create_handle,
			set_text,
			get_text,
			set_fore_color,
			get_fore_color,
			get_default_size,
			get_default_ime_mode,
			get_create_params,
			set_background_image,
			get_background_image,
			set_back_color,
			get_back_color,
			dispose_boolean,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISYNCHRONIZE_INVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	WINFORMS_IWIN32_WINDOW

create
	make_winforms_month_calendar

feature {NONE} -- Initialization

	frozen make_winforms_month_calendar is
		external
			"IL creator use System.Windows.Forms.MonthCalendar"
		end

feature -- Access

	frozen get_single_month_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.MonthCalendar"
		alias
			"get_SingleMonthSize"
		end

	frozen get_annually_bolded_dates: NATIVE_ARRAY [SYSTEM_DATE_TIME] is
		external
			"IL signature (): System.DateTime[] use System.Windows.Forms.MonthCalendar"
		alias
			"get_AnnuallyBoldedDates"
		end

	frozen get_calendar_dimensions: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.MonthCalendar"
		alias
			"get_CalendarDimensions"
		end

	frozen get_show_today: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.MonthCalendar"
		alias
			"get_ShowToday"
		end

	frozen get_trailing_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.MonthCalendar"
		alias
			"get_TrailingForeColor"
		end

	frozen get_monthly_bolded_dates: NATIVE_ARRAY [SYSTEM_DATE_TIME] is
		external
			"IL signature (): System.DateTime[] use System.Windows.Forms.MonthCalendar"
		alias
			"get_MonthlyBoldedDates"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.MonthCalendar"
		alias
			"get_Text"
		end

	get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.MonthCalendar"
		alias
			"get_BackColor"
		end

	frozen get_today_date: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.MonthCalendar"
		alias
			"get_TodayDate"
		end

	frozen get_scroll_change: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MonthCalendar"
		alias
			"get_ScrollChange"
		end

	get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.MonthCalendar"
		alias
			"get_ForeColor"
		end

	frozen get_title_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.MonthCalendar"
		alias
			"get_TitleBackColor"
		end

	frozen get_first_day_of_week: WINFORMS_DAY is
		external
			"IL signature (): System.Windows.Forms.Day use System.Windows.Forms.MonthCalendar"
		alias
			"get_FirstDayOfWeek"
		end

	frozen get_show_today_circle: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.MonthCalendar"
		alias
			"get_ShowTodayCircle"
		end

	frozen get_selection_range: WINFORMS_SELECTION_RANGE is
		external
			"IL signature (): System.Windows.Forms.SelectionRange use System.Windows.Forms.MonthCalendar"
		alias
			"get_SelectionRange"
		end

	frozen get_selection_start: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.MonthCalendar"
		alias
			"get_SelectionStart"
		end

	frozen get_selection_end: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.MonthCalendar"
		alias
			"get_SelectionEnd"
		end

	frozen get_bolded_dates: NATIVE_ARRAY [SYSTEM_DATE_TIME] is
		external
			"IL signature (): System.DateTime[] use System.Windows.Forms.MonthCalendar"
		alias
			"get_BoldedDates"
		end

	frozen get_title_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.MonthCalendar"
		alias
			"get_TitleForeColor"
		end

	get_background_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.MonthCalendar"
		alias
			"get_BackgroundImage"
		end

	frozen get_today_date_set: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.MonthCalendar"
		alias
			"get_TodayDateSet"
		end

	frozen get_max_date: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.MonthCalendar"
		alias
			"get_MaxDate"
		end

	frozen get_max_selection_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MonthCalendar"
		alias
			"get_MaxSelectionCount"
		end

	frozen get_show_week_numbers: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.MonthCalendar"
		alias
			"get_ShowWeekNumbers"
		end

	frozen get_ime_mode_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.MonthCalendar"
		alias
			"get_ImeMode"
		end

	frozen get_min_date: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.MonthCalendar"
		alias
			"get_MinDate"
		end

feature -- Element Change

	frozen add_double_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"add_DoubleClick"
		end

	frozen add_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"add_Click"
		end

	frozen set_first_day_of_week (value: WINFORMS_DAY) is
		external
			"IL signature (System.Windows.Forms.Day): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_FirstDayOfWeek"
		end

	frozen set_min_date (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_MinDate"
		end

	frozen set_selection_start (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_SelectionStart"
		end

	frozen set_selection_range (value: WINFORMS_SELECTION_RANGE) is
		external
			"IL signature (System.Windows.Forms.SelectionRange): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_SelectionRange"
		end

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_Text"
		end

	set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_BackColor"
		end

	frozen set_monthly_bolded_dates (value: NATIVE_ARRAY [SYSTEM_DATE_TIME]) is
		external
			"IL signature (System.DateTime[]): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_MonthlyBoldedDates"
		end

	frozen set_show_week_numbers (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_ShowWeekNumbers"
		end

	frozen remove_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"remove_Paint"
		end

	frozen remove_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"remove_Click"
		end

	frozen remove_double_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"remove_DoubleClick"
		end

	frozen set_scroll_change (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_ScrollChange"
		end

	frozen set_selection_end (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_SelectionEnd"
		end

	set_background_image (value: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_BackgroundImage"
		end

	frozen add_date_selected (value: WINFORMS_DATE_RANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DateRangeEventHandler): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"add_DateSelected"
		end

	frozen remove_date_selected (value: WINFORMS_DATE_RANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DateRangeEventHandler): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"remove_DateSelected"
		end

	frozen set_max_selection_count (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_MaxSelectionCount"
		end

	frozen set_show_today_circle (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_ShowTodayCircle"
		end

	frozen set_calendar_dimensions (value: DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_CalendarDimensions"
		end

	frozen set_title_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_TitleForeColor"
		end

	frozen set_max_date (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_MaxDate"
		end

	set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_ForeColor"
		end

	frozen set_annually_bolded_dates (value: NATIVE_ARRAY [SYSTEM_DATE_TIME]) is
		external
			"IL signature (System.DateTime[]): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_AnnuallyBoldedDates"
		end

	frozen set_title_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_TitleBackColor"
		end

	frozen set_trailing_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_TrailingForeColor"
		end

	frozen set_today_date (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_TodayDate"
		end

	frozen remove_date_changed (value: WINFORMS_DATE_RANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DateRangeEventHandler): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"remove_DateChanged"
		end

	frozen set_show_today (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_ShowToday"
		end

	frozen set_ime_mode_ime_mode (value: WINFORMS_IME_MODE) is
		external
			"IL signature (System.Windows.Forms.ImeMode): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_ImeMode"
		end

	frozen set_bolded_dates (value: NATIVE_ARRAY [SYSTEM_DATE_TIME]) is
		external
			"IL signature (System.DateTime[]): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"set_BoldedDates"
		end

	frozen add_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"add_Paint"
		end

	frozen add_date_changed (value: WINFORMS_DATE_RANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DateRangeEventHandler): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"add_DateChanged"
		end

feature -- Basic Operations

	frozen remove_all_bolded_dates is
		external
			"IL signature (): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"RemoveAllBoldedDates"
		end

	frozen set_selection_range_date_time (date1: SYSTEM_DATE_TIME; date2: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime, System.DateTime): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"SetSelectionRange"
		end

	frozen add_bolded_date (date: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"AddBoldedDate"
		end

	frozen set_calendar_dimensions_int32 (x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"SetCalendarDimensions"
		end

	frozen add_monthly_bolded_date (date: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"AddMonthlyBoldedDate"
		end

	frozen remove_all_monthly_bolded_dates is
		external
			"IL signature (): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"RemoveAllMonthlyBoldedDates"
		end

	frozen get_display_range (visible: BOOLEAN): WINFORMS_SELECTION_RANGE is
		external
			"IL signature (System.Boolean): System.Windows.Forms.SelectionRange use System.Windows.Forms.MonthCalendar"
		alias
			"GetDisplayRange"
		end

	frozen hit_test_int32 (x: INTEGER; y: INTEGER): WINFORMS_HIT_TEST_INFO_IN_WINFORMS_MONTH_CALENDAR is
		external
			"IL signature (System.Int32, System.Int32): System.Windows.Forms.MonthCalendar+HitTestInfo use System.Windows.Forms.MonthCalendar"
		alias
			"HitTest"
		end

	frozen set_date (date: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"SetDate"
		end

	frozen remove_annually_bolded_date (date: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"RemoveAnnuallyBoldedDate"
		end

	frozen remove_bolded_date (date: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"RemoveBoldedDate"
		end

	frozen update_bolded_dates is
		external
			"IL signature (): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"UpdateBoldedDates"
		end

	frozen remove_monthly_bolded_date (date: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"RemoveMonthlyBoldedDate"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.MonthCalendar"
		alias
			"ToString"
		end

	frozen hit_test (point: DRAWING_POINT): WINFORMS_HIT_TEST_INFO_IN_WINFORMS_MONTH_CALENDAR is
		external
			"IL signature (System.Drawing.Point): System.Windows.Forms.MonthCalendar+HitTestInfo use System.Windows.Forms.MonthCalendar"
		alias
			"HitTest"
		end

	frozen add_annually_bolded_date (date: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"AddAnnuallyBoldedDate"
		end

	frozen remove_all_annually_bolded_dates is
		external
			"IL signature (): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"RemoveAllAnnuallyBoldedDates"
		end

feature {NONE} -- Implementation

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.MonthCalendar"
		alias
			"get_DefaultSize"
		end

	on_font_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"OnFontChanged"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.MonthCalendar"
		alias
			"get_CreateParams"
		end

	create_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"CreateHandle"
		end

	is_input_key (key_data: WINFORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.MonthCalendar"
		alias
			"IsInputKey"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"Dispose"
		end

	on_date_changed (drevent: WINFORMS_DATE_RANGE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.DateRangeEventArgs): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"OnDateChanged"
		end

	on_fore_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"OnForeColorChanged"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: WINFORMS_BOUNDS_SPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"SetBoundsCore"
		end

	get_default_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.MonthCalendar"
		alias
			"get_DefaultImeMode"
		end

	on_date_selected (drevent: WINFORMS_DATE_RANGE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.DateRangeEventArgs): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"OnDateSelected"
		end

	on_handle_created (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"OnHandleCreated"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"WndProc"
		end

	on_back_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.MonthCalendar"
		alias
			"OnBackColorChanged"
		end

end -- class WINFORMS_MONTH_CALENDAR
