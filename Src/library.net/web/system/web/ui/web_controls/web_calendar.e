indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.Calendar"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_CALENDAR

inherit
	WEB_WEB_CONTROL
		redefine
			track_view_state,
			create_control_collection,
			render,
			save_view_state,
			on_pre_render,
			load_view_state
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	WEB_IPARSER_ACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	WEB_IDATA_BINDINGS_ACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end
	WEB_IATTRIBUTE_ACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	WEB_IPOST_BACK_EVENT_HANDLER
		rename
			raise_post_back_event as system_web_ui_ipost_back_event_handler_raise_post_back_event
		end

create
	make_web_calendar

feature {NONE} -- Initialization

	frozen make_web_calendar is
		external
			"IL creator use System.Web.UI.WebControls.Calendar"
		end

feature -- Access

	frozen get_selected_dates: WEB_SELECTED_DATES_COLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.SelectedDatesCollection use System.Web.UI.WebControls.Calendar"
		alias
			"get_SelectedDates"
		end

	frozen get_selection_mode: WEB_CALENDAR_SELECTION_MODE is
		external
			"IL signature (): System.Web.UI.WebControls.CalendarSelectionMode use System.Web.UI.WebControls.Calendar"
		alias
			"get_SelectionMode"
		end

	frozen get_todays_date: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Web.UI.WebControls.Calendar"
		alias
			"get_TodaysDate"
		end

	frozen get_title_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.Calendar"
		alias
			"get_TitleStyle"
		end

	frozen get_show_day_header: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.Calendar"
		alias
			"get_ShowDayHeader"
		end

	frozen get_day_header_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.Calendar"
		alias
			"get_DayHeaderStyle"
		end

	frozen get_other_month_day_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.Calendar"
		alias
			"get_OtherMonthDayStyle"
		end

	frozen get_cell_padding: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.Calendar"
		alias
			"get_CellPadding"
		end

	frozen get_show_title: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.Calendar"
		alias
			"get_ShowTitle"
		end

	frozen get_select_month_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Calendar"
		alias
			"get_SelectMonthText"
		end

	frozen get_next_prev_format: WEB_NEXT_PREV_FORMAT is
		external
			"IL signature (): System.Web.UI.WebControls.NextPrevFormat use System.Web.UI.WebControls.Calendar"
		alias
			"get_NextPrevFormat"
		end

	frozen get_title_format: WEB_TITLE_FORMAT is
		external
			"IL signature (): System.Web.UI.WebControls.TitleFormat use System.Web.UI.WebControls.Calendar"
		alias
			"get_TitleFormat"
		end

	frozen get_first_day_of_week: WEB_FIRST_DAY_OF_WEEK is
		external
			"IL signature (): System.Web.UI.WebControls.FirstDayOfWeek use System.Web.UI.WebControls.Calendar"
		alias
			"get_FirstDayOfWeek"
		end

	frozen get_prev_month_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Calendar"
		alias
			"get_PrevMonthText"
		end

	frozen get_show_next_prev_month: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.Calendar"
		alias
			"get_ShowNextPrevMonth"
		end

	frozen get_visible_date: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Web.UI.WebControls.Calendar"
		alias
			"get_VisibleDate"
		end

	frozen get_selected_date: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Web.UI.WebControls.Calendar"
		alias
			"get_SelectedDate"
		end

	frozen get_selected_day_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.Calendar"
		alias
			"get_SelectedDayStyle"
		end

	frozen get_weekend_day_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.Calendar"
		alias
			"get_WeekendDayStyle"
		end

	frozen get_select_week_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Calendar"
		alias
			"get_SelectWeekText"
		end

	frozen get_today_day_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.Calendar"
		alias
			"get_TodayDayStyle"
		end

	frozen get_selector_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.Calendar"
		alias
			"get_SelectorStyle"
		end

	frozen get_day_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.Calendar"
		alias
			"get_DayStyle"
		end

	frozen get_cell_spacing: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.Calendar"
		alias
			"get_CellSpacing"
		end

	frozen get_next_prev_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.Calendar"
		alias
			"get_NextPrevStyle"
		end

	frozen get_day_name_format: WEB_DAY_NAME_FORMAT is
		external
			"IL signature (): System.Web.UI.WebControls.DayNameFormat use System.Web.UI.WebControls.Calendar"
		alias
			"get_DayNameFormat"
		end

	frozen get_show_grid_lines: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.Calendar"
		alias
			"get_ShowGridLines"
		end

	frozen get_next_month_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Calendar"
		alias
			"get_NextMonthText"
		end

feature -- Element Change

	frozen set_show_grid_lines (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_ShowGridLines"
		end

	frozen remove_day_render (value: WEB_DAY_RENDER_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DayRenderEventHandler): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"remove_DayRender"
		end

	frozen set_prev_month_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_PrevMonthText"
		end

	frozen remove_selection_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"remove_SelectionChanged"
		end

	frozen add_selection_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"add_SelectionChanged"
		end

	frozen set_select_week_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_SelectWeekText"
		end

	frozen set_cell_padding (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_CellPadding"
		end

	frozen set_todays_date (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_TodaysDate"
		end

	frozen set_visible_date (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_VisibleDate"
		end

	frozen set_selected_date (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_SelectedDate"
		end

	frozen set_selection_mode (value: WEB_CALENDAR_SELECTION_MODE) is
		external
			"IL signature (System.Web.UI.WebControls.CalendarSelectionMode): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_SelectionMode"
		end

	frozen add_day_render (value: WEB_DAY_RENDER_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.DayRenderEventHandler): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"add_DayRender"
		end

	frozen set_first_day_of_week (value: WEB_FIRST_DAY_OF_WEEK) is
		external
			"IL signature (System.Web.UI.WebControls.FirstDayOfWeek): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_FirstDayOfWeek"
		end

	frozen set_show_next_prev_month (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_ShowNextPrevMonth"
		end

	frozen remove_visible_month_changed (value: WEB_MONTH_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.MonthChangedEventHandler): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"remove_VisibleMonthChanged"
		end

	frozen set_next_prev_format (value: WEB_NEXT_PREV_FORMAT) is
		external
			"IL signature (System.Web.UI.WebControls.NextPrevFormat): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_NextPrevFormat"
		end

	frozen set_show_title (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_ShowTitle"
		end

	frozen set_show_day_header (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_ShowDayHeader"
		end

	frozen set_cell_spacing (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_CellSpacing"
		end

	frozen set_next_month_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_NextMonthText"
		end

	frozen set_title_format (value: WEB_TITLE_FORMAT) is
		external
			"IL signature (System.Web.UI.WebControls.TitleFormat): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_TitleFormat"
		end

	frozen add_visible_month_changed (value: WEB_MONTH_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.MonthChangedEventHandler): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"add_VisibleMonthChanged"
		end

	frozen set_select_month_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_SelectMonthText"
		end

	frozen set_day_name_format (value: WEB_DAY_NAME_FORMAT) is
		external
			"IL signature (System.Web.UI.WebControls.DayNameFormat): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"set_DayNameFormat"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_ipost_back_event_handler_raise_post_back_event (event_argument: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"System.Web.UI.IPostBackEventHandler.RaisePostBackEvent"
		end

	load_view_state (saved_state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"LoadViewState"
		end

	on_selection_changed is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"OnSelectionChanged"
		end

	frozen has_week_selectors (selection_mode: WEB_CALENDAR_SELECTION_MODE): BOOLEAN is
		external
			"IL signature (System.Web.UI.WebControls.CalendarSelectionMode): System.Boolean use System.Web.UI.WebControls.Calendar"
		alias
			"HasWeekSelectors"
		end

	on_visible_month_changed (new_date: SYSTEM_DATE_TIME; previous_date: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime, System.DateTime): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"OnVisibleMonthChanged"
		end

	on_day_render (cell: WEB_TABLE_CELL; day: WEB_CALENDAR_DAY) is
		external
			"IL signature (System.Web.UI.WebControls.TableCell, System.Web.UI.WebControls.CalendarDay): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"OnDayRender"
		end

	render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"Render"
		end

	save_view_state: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.Calendar"
		alias
			"SaveViewState"
		end

	on_pre_render (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"OnPreRender"
		end

	track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.Calendar"
		alias
			"TrackViewState"
		end

	create_control_collection: WEB_CONTROL_COLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.WebControls.Calendar"
		alias
			"CreateControlCollection"
		end

end -- class WEB_CALENDAR
