indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.ObjectConverter"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_OBJECT_CONVERTER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.ObjectConverter"
		end

feature -- Basic Operations

	frozen convert_value (value: SYSTEM_OBJECT; to_type: TYPE; format_string: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.Object, System.Type, System.String): System.Object use System.Web.UI.ObjectConverter"
		alias
			"ConvertValue"
		end

end -- class WEB_OBJECT_CONVERTER
