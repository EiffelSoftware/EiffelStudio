indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.RepeatInfo"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_REPEATINFO

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.WebControls.RepeatInfo"
		end

feature -- Access

	frozen get_repeat_layout: SYSTEM_WEB_UI_WEBCONTROLS_REPEATLAYOUT is
		external
			"IL signature (): System.Web.UI.WebControls.RepeatLayout use System.Web.UI.WebControls.RepeatInfo"
		alias
			"get_RepeatLayout"
		end

	frozen get_repeat_columns: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.RepeatInfo"
		alias
			"get_RepeatColumns"
		end

	frozen get_repeat_direction: SYSTEM_WEB_UI_WEBCONTROLS_REPEATDIRECTION is
		external
			"IL signature (): System.Web.UI.WebControls.RepeatDirection use System.Web.UI.WebControls.RepeatInfo"
		alias
			"get_RepeatDirection"
		end

	frozen get_outer_table_implied: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.RepeatInfo"
		alias
			"get_OuterTableImplied"
		end

feature -- Element Change

	frozen set_repeat_columns (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.RepeatInfo"
		alias
			"set_RepeatColumns"
		end

	frozen set_repeat_direction (value: SYSTEM_WEB_UI_WEBCONTROLS_REPEATDIRECTION) is
		external
			"IL signature (System.Web.UI.WebControls.RepeatDirection): System.Void use System.Web.UI.WebControls.RepeatInfo"
		alias
			"set_RepeatDirection"
		end

	frozen set_outer_table_implied (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.RepeatInfo"
		alias
			"set_OuterTableImplied"
		end

	frozen set_repeat_layout (value: SYSTEM_WEB_UI_WEBCONTROLS_REPEATLAYOUT) is
		external
			"IL signature (System.Web.UI.WebControls.RepeatLayout): System.Void use System.Web.UI.WebControls.RepeatInfo"
		alias
			"set_RepeatLayout"
		end

feature -- Basic Operations

	frozen render_repeater (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER; user: SYSTEM_WEB_UI_WEBCONTROLS_IREPEATINFOUSER; control_style: SYSTEM_WEB_UI_WEBCONTROLS_STYLE; base_control: SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter, System.Web.UI.WebControls.IRepeatInfoUser, System.Web.UI.WebControls.Style, System.Web.UI.WebControls.WebControl): System.Void use System.Web.UI.WebControls.RepeatInfo"
		alias
			"RenderRepeater"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_REPEATINFO
