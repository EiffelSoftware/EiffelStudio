indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.MonthCalendar+HitTestInfo"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_HIT_TEST_INFO_IN_WINFORMS_MONTH_CALENDAR

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_time: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.MonthCalendar+HitTestInfo"
		alias
			"get_Time"
		end

	frozen get_hit_area: WINFORMS_HIT_AREA_IN_WINFORMS_MONTH_CALENDAR is
		external
			"IL signature (): System.Windows.Forms.MonthCalendar+HitArea use System.Windows.Forms.MonthCalendar+HitTestInfo"
		alias
			"get_HitArea"
		end

	frozen get_point: DRAWING_POINT is
		external
			"IL signature (): System.Drawing.Point use System.Windows.Forms.MonthCalendar+HitTestInfo"
		alias
			"get_Point"
		end

end -- class WINFORMS_HIT_TEST_INFO_IN_WINFORMS_MONTH_CALENDAR
