indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.ListItem"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_LIST_ITEM

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	WEB_ISTATE_MANAGER
		rename
			save_view_state as system_web_ui_istate_manager_save_view_state,
			track_view_state as system_web_ui_istate_manager_track_view_state,
			load_view_state as system_web_ui_istate_manager_load_view_state,
			get_is_tracking_view_state as system_web_ui_istate_manager_get_is_tracking_view_state
		end
	WEB_IPARSER_ACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	WEB_IATTRIBUTE_ACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (text: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Web.UI.WebControls.ListItem"
		end

	frozen make is
		external
			"IL creator use System.Web.UI.WebControls.ListItem"
		end

	frozen make_1 (text: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.WebControls.ListItem"
		end

feature -- Access

	frozen get_selected: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ListItem"
		alias
			"get_Selected"
		end

	frozen get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ListItem"
		alias
			"get_Text"
		end

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ListItem"
		alias
			"get_Value"
		end

	frozen get_attributes: WEB_ATTRIBUTE_COLLECTION is
		external
			"IL signature (): System.Web.UI.AttributeCollection use System.Web.UI.WebControls.ListItem"
		alias
			"get_Attributes"
		end

feature -- Element Change

	frozen set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ListItem"
		alias
			"set_Text"
		end

	frozen set_selected (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.ListItem"
		alias
			"set_Selected"
		end

	frozen set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ListItem"
		alias
			"set_Value"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.ListItem"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ListItem"
		alias
			"ToString"
		end

	frozen from_string (s: SYSTEM_STRING): WEB_LIST_ITEM is
		external
			"IL static signature (System.String): System.Web.UI.WebControls.ListItem use System.Web.UI.WebControls.ListItem"
		alias
			"FromString"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.ListItem"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_iattribute_accessor_get_attribute (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.WebControls.ListItem"
		alias
			"System.Web.UI.IAttributeAccessor.GetAttribute"
		end

	frozen system_web_ui_iattribute_accessor_set_attribute (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.WebControls.ListItem"
		alias
			"System.Web.UI.IAttributeAccessor.SetAttribute"
		end

	frozen system_web_ui_istate_manager_track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.ListItem"
		alias
			"System.Web.UI.IStateManager.TrackViewState"
		end

	frozen system_web_ui_istate_manager_save_view_state: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.ListItem"
		alias
			"System.Web.UI.IStateManager.SaveViewState"
		end

	frozen system_web_ui_istate_manager_load_view_state (state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.ListItem"
		alias
			"System.Web.UI.IStateManager.LoadViewState"
		end

	frozen system_web_ui_iparser_accessor_add_parsed_sub_object (obj: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.ListItem"
		alias
			"System.Web.UI.IParserAccessor.AddParsedSubObject"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.ListItem"
		alias
			"Finalize"
		end

	frozen system_web_ui_istate_manager_get_is_tracking_view_state: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ListItem"
		alias
			"System.Web.UI.IStateManager.get_IsTrackingViewState"
		end

end -- class WEB_LIST_ITEM
