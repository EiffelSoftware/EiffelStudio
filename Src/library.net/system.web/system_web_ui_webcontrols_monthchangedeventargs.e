indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.MonthChangedEventArgs"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_MONTHCHANGEDEVENTARGS

create
	make

feature {NONE} -- Initialization

	frozen make (new_date: SYSTEM_DATETIME; previous_date: SYSTEM_DATETIME) is
		external
			"IL creator signature (System.DateTime, System.DateTime) use System.Web.UI.WebControls.MonthChangedEventArgs"
		end

feature -- Access

	frozen get_previous_date: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Web.UI.WebControls.MonthChangedEventArgs"
		alias
			"get_PreviousDate"
		end

	frozen get_new_date: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Web.UI.WebControls.MonthChangedEventArgs"
		alias
			"get_NewDate"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_MONTHCHANGEDEVENTARGS
