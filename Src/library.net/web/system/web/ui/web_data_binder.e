indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.DataBinder"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_DATA_BINDER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.DataBinder"
		end

feature -- Basic Operations

	frozen get_indexed_property_value (container: SYSTEM_OBJECT; expr: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.Object, System.String): System.Object use System.Web.UI.DataBinder"
		alias
			"GetIndexedPropertyValue"
		end

	frozen get_indexed_property_value_object_string_string (container: SYSTEM_OBJECT; prop_name: SYSTEM_STRING; format: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.Object, System.String, System.String): System.String use System.Web.UI.DataBinder"
		alias
			"GetIndexedPropertyValue"
		end

	frozen eval_object_string_string (container: SYSTEM_OBJECT; expression: SYSTEM_STRING; format: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.Object, System.String, System.String): System.String use System.Web.UI.DataBinder"
		alias
			"Eval"
		end

	frozen get_property_value_object_string_string (container: SYSTEM_OBJECT; prop_name: SYSTEM_STRING; format: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.Object, System.String, System.String): System.String use System.Web.UI.DataBinder"
		alias
			"GetPropertyValue"
		end

	frozen get_property_value (container: SYSTEM_OBJECT; prop_name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.Object, System.String): System.Object use System.Web.UI.DataBinder"
		alias
			"GetPropertyValue"
		end

	frozen eval (container: SYSTEM_OBJECT; expression: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.Object, System.String): System.Object use System.Web.UI.DataBinder"
		alias
			"Eval"
		end

end -- class WEB_DATA_BINDER
