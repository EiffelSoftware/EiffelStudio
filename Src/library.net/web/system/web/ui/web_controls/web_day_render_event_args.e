indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.DayRenderEventArgs"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_DAY_RENDER_EVENT_ARGS

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (cell: WEB_TABLE_CELL; day: WEB_CALENDAR_DAY) is
		external
			"IL creator signature (System.Web.UI.WebControls.TableCell, System.Web.UI.WebControls.CalendarDay) use System.Web.UI.WebControls.DayRenderEventArgs"
		end

feature -- Access

	frozen get_cell: WEB_TABLE_CELL is
		external
			"IL signature (): System.Web.UI.WebControls.TableCell use System.Web.UI.WebControls.DayRenderEventArgs"
		alias
			"get_Cell"
		end

	frozen get_day: WEB_CALENDAR_DAY is
		external
			"IL signature (): System.Web.UI.WebControls.CalendarDay use System.Web.UI.WebControls.DayRenderEventArgs"
		alias
			"get_Day"
		end

end -- class WEB_DAY_RENDER_EVENT_ARGS
