indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.CalendarDay"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_CALENDAR_DAY

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (date: SYSTEM_DATE_TIME; is_weekend: BOOLEAN; is_today: BOOLEAN; is_selected: BOOLEAN; is_other_month: BOOLEAN; day_number_text: SYSTEM_STRING) is
		external
			"IL creator signature (System.DateTime, System.Boolean, System.Boolean, System.Boolean, System.Boolean, System.String) use System.Web.UI.WebControls.CalendarDay"
		end

feature -- Access

	frozen get_date: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Web.UI.WebControls.CalendarDay"
		alias
			"get_Date"
		end

	frozen get_is_other_month: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.CalendarDay"
		alias
			"get_IsOtherMonth"
		end

	frozen get_is_weekend: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.CalendarDay"
		alias
			"get_IsWeekend"
		end

	frozen get_day_number_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.CalendarDay"
		alias
			"get_DayNumberText"
		end

	frozen get_is_selected: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.CalendarDay"
		alias
			"get_IsSelected"
		end

	frozen get_is_today: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.CalendarDay"
		alias
			"get_IsToday"
		end

	frozen get_is_selectable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.CalendarDay"
		alias
			"get_IsSelectable"
		end

feature -- Element Change

	frozen set_is_selectable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.CalendarDay"
		alias
			"set_IsSelectable"
		end

end -- class WEB_CALENDAR_DAY
