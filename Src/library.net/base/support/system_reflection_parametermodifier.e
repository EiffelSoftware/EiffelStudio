indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.ParameterModifier"

frozen expanded external class
	SYSTEM_REFLECTION_PARAMETERMODIFIER

inherit
	VALUE_TYPE

feature -- Initialization

	frozen make_parametermodifier (paramater_count: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Reflection.ParameterModifier"
		end

feature -- Access

	frozen get_item (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Reflection.ParameterModifier"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen put_i_th (index: INTEGER; value: BOOLEAN) is
		external
			"IL signature (System.Int32, System.Boolean): System.Void use System.Reflection.ParameterModifier"
		alias
			"set_Item"
		end

end -- class SYSTEM_REFLECTION_PARAMETERMODIFIER
