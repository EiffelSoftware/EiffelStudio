indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.RepeatInfo"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_REPEAT_INFO

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.WebControls.RepeatInfo"
		end

feature -- Access

	frozen get_repeat_layout: WEB_REPEAT_LAYOUT is
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

	frozen get_repeat_direction: WEB_REPEAT_DIRECTION is
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

	frozen set_repeat_direction (value: WEB_REPEAT_DIRECTION) is
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

	frozen set_repeat_layout (value: WEB_REPEAT_LAYOUT) is
		external
			"IL signature (System.Web.UI.WebControls.RepeatLayout): System.Void use System.Web.UI.WebControls.RepeatInfo"
		alias
			"set_RepeatLayout"
		end

feature -- Basic Operations

	frozen render_repeater (writer: WEB_HTML_TEXT_WRITER; user: WEB_IREPEAT_INFO_USER; control_style: WEB_STYLE; base_control: WEB_WEB_CONTROL) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter, System.Web.UI.WebControls.IRepeatInfoUser, System.Web.UI.WebControls.Style, System.Web.UI.WebControls.WebControl): System.Void use System.Web.UI.WebControls.RepeatInfo"
		alias
			"RenderRepeater"
		end

end -- class WEB_REPEAT_INFO
