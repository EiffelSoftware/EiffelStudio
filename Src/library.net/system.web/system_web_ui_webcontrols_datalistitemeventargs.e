indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataListItemEventArgs"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEMEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_datalistitemeventargs

feature {NONE} -- Initialization

	frozen make_datalistitemeventargs (item: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEM) is
		external
			"IL creator signature (System.Web.UI.WebControls.DataListItem) use System.Web.UI.WebControls.DataListItemEventArgs"
		end

feature -- Access

	frozen get_item: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEM is
		external
			"IL signature (): System.Web.UI.WebControls.DataListItem use System.Web.UI.WebControls.DataListItemEventArgs"
		alias
			"get_Item"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEMEVENTARGS
