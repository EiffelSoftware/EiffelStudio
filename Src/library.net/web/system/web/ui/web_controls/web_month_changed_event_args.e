indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.MonthChangedEventArgs"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_MONTH_CHANGED_EVENT_ARGS

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (new_date: SYSTEM_DATE_TIME; previous_date: SYSTEM_DATE_TIME) is
		external
			"IL creator signature (System.DateTime, System.DateTime) use System.Web.UI.WebControls.MonthChangedEventArgs"
		end

feature -- Access

	frozen get_previous_date: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Web.UI.WebControls.MonthChangedEventArgs"
		alias
			"get_PreviousDate"
		end

	frozen get_new_date: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Web.UI.WebControls.MonthChangedEventArgs"
		alias
			"get_NewDate"
		end

end -- class WEB_MONTH_CHANGED_EVENT_ARGS
