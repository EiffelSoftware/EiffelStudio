indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.StateItem"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_STATE_ITEM

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_is_dirty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.StateItem"
		alias
			"get_IsDirty"
		end

	frozen get_value: SYSTEM_OBJECT is
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

	frozen set_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.StateItem"
		alias
			"set_Value"
		end

end -- class WEB_STATE_ITEM
