indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.ParameterModifier"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	PARAMETER_MODIFIER

inherit
	VALUE_TYPE

feature -- Initialization

	frozen make_parameter_modifier (paramater_count: INTEGER) is
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

	frozen set_item (index: INTEGER; value: BOOLEAN) is
		external
			"IL signature (System.Int32, System.Boolean): System.Void use System.Reflection.ParameterModifier"
		alias
			"set_Item"
		end

end -- class PARAMETER_MODIFIER
