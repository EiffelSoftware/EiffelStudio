indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataGridItemEventArgs"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEMEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_datagriditemeventargs

feature {NONE} -- Initialization

	frozen make_datagriditemeventargs (item: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEM) is
		external
			"IL creator signature (System.Web.UI.WebControls.DataGridItem) use System.Web.UI.WebControls.DataGridItemEventArgs"
		end

feature -- Access

	frozen get_item: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEM is
		external
			"IL signature (): System.Web.UI.WebControls.DataGridItem use System.Web.UI.WebControls.DataGridItemEventArgs"
		alias
			"get_Item"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEMEVENTARGS
