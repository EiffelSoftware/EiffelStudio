indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.PropertyConverter"

frozen external class
	SYSTEM_WEB_UI_PROPERTYCONVERTER

create {NONE}

feature -- Basic Operations

	frozen enum_to_string (enum_type: SYSTEM_TYPE; enum_value: ANY): STRING is
		external
			"IL static signature (System.Type, System.Object): System.String use System.Web.UI.PropertyConverter"
		alias
			"EnumToString"
		end

	frozen enum_from_string (enum_type: SYSTEM_TYPE; value: STRING): ANY is
		external
			"IL static signature (System.Type, System.String): System.Object use System.Web.UI.PropertyConverter"
		alias
			"EnumFromString"
		end

	frozen object_from_string (obj_type: SYSTEM_TYPE; property_info: SYSTEM_REFLECTION_MEMBERINFO; value: STRING): ANY is
		external
			"IL static signature (System.Type, System.Reflection.MemberInfo, System.String): System.Object use System.Web.UI.PropertyConverter"
		alias
			"ObjectFromString"
		end

end -- class SYSTEM_WEB_UI_PROPERTYCONVERTER
