indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.StateItem"

frozen external class
	SYSTEM_WEB_UI_STATEITEM

create {NONE}

feature -- Access

	frozen get_is_dirty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.StateItem"
		alias
			"get_IsDirty"
		end

	frozen get_value: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.StateItem"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_is_dirty (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.StateItem"
		alias
			"set_IsDirty"
		end

	frozen set_value (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.StateItem"
		alias
			"set_Value"
		end

end -- class SYSTEM_WEB_UI_STATEITEM
