indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.PropertyConverter"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_PROPERTY_CONVERTER

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen enum_to_string (enum_type: TYPE; enum_value: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL static signature (System.Type, System.Object): System.String use System.Web.UI.PropertyConverter"
		alias
			"EnumToString"
		end

	frozen enum_from_string (enum_type: TYPE; value: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.String): System.Object use System.Web.UI.PropertyConverter"
		alias
			"EnumFromString"
		end

	frozen object_from_string (obj_type: TYPE; property_info: MEMBER_INFO; value: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.Reflection.MemberInfo, System.String): System.Object use System.Web.UI.PropertyConverter"
		alias
			"ObjectFromString"
		end

end -- class WEB_PROPERTY_CONVERTER
