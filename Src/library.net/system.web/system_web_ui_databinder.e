indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.DataBinder"

frozen external class
	SYSTEM_WEB_UI_DATABINDER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.DataBinder"
		end

feature -- Basic Operations

	frozen get_indexed_property_value (container: ANY; expr: STRING): ANY is
		external
			"IL static signature (System.Object, System.String): System.Object use System.Web.UI.DataBinder"
		alias
			"GetIndexedPropertyValue"
		end

	frozen get_indexed_property_value_object_string_string (container: ANY; prop_name: STRING; format: STRING): STRING is
		external
			"IL static signature (System.Object, System.String, System.String): System.String use System.Web.UI.DataBinder"
		alias
			"GetIndexedPropertyValue"
		end

	frozen eval_object_string_string (container: ANY; expression: STRING; format: STRING): STRING is
		external
			"IL static signature (System.Object, System.String, System.String): System.String use System.Web.UI.DataBinder"
		alias
			"Eval"
		end

	frozen get_property_value_object_string_string (container: ANY; prop_name: STRING; format: STRING): STRING is
		external
			"IL static signature (System.Object, System.String, System.String): System.String use System.Web.UI.DataBinder"
		alias
			"GetPropertyValue"
		end

	frozen get_property_value (container: ANY; prop_name: STRING): ANY is
		external
			"IL static signature (System.Object, System.String): System.Object use System.Web.UI.DataBinder"
		alias
			"GetPropertyValue"
		end

	frozen eval (container: ANY; expression: STRING): ANY is
		external
			"IL static signature (System.Object, System.String): System.Object use System.Web.UI.DataBinder"
		alias
			"Eval"
		end

end -- class SYSTEM_WEB_UI_DATABINDER
