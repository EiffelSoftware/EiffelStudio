indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.RepeaterItemEventArgs"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_REPEATERITEMEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_repeateritemeventargs

feature {NONE} -- Initialization

	frozen make_repeateritemeventargs (item: SYSTEM_WEB_UI_WEBCONTROLS_REPEATERITEM) is
		external
			"IL creator signature (System.Web.UI.WebControls.RepeaterItem) use System.Web.UI.WebControls.RepeaterItemEventArgs"
		end

feature -- Access

	frozen get_item: SYSTEM_WEB_UI_WEBCONTROLS_REPEATERITEM is
		external
			"IL signature (): System.Web.UI.WebControls.RepeaterItem use System.Web.UI.WebControls.RepeaterItemEventArgs"
		alias
			"get_Item"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_REPEATERITEMEVENTARGS
