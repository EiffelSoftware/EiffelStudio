indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.ObjectConverter"

frozen external class
	SYSTEM_WEB_UI_OBJECTCONVERTER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.ObjectConverter"
		end

feature -- Basic Operations

	frozen convert_value (value: ANY; to_type: SYSTEM_TYPE; format_string: STRING): ANY is
		external
			"IL static signature (System.Object, System.Type, System.String): System.Object use System.Web.UI.ObjectConverter"
		alias
			"ConvertValue"
		end

end -- class SYSTEM_WEB_UI_OBJECTCONVERTER
