indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.AttributeUsageAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ATTRIBUTE_USAGE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_attribute_usage_attribute

feature {NONE} -- Initialization

	frozen make_attribute_usage_attribute (valid_on: ATTRIBUTE_TARGETS) is
		external
			"IL creator signature (System.AttributeTargets) use System.AttributeUsageAttribute"
		end

feature -- Access

	frozen get_valid_on: ATTRIBUTE_TARGETS is
		external
			"IL signature (): System.AttributeTargets use System.AttributeUsageAttribute"
		alias
			"get_ValidOn"
		end

	frozen get_allow_multiple: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.AttributeUsageAttribute"
		alias
			"get_AllowMultiple"
		end

	frozen get_inherited: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.AttributeUsageAttribute"
		alias
			"get_Inherited"
		end

feature -- Element Change

	frozen set_allow_multiple (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.AttributeUsageAttribute"
		alias
			"set_AllowMultiple"
		end

	frozen set_inherited (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.AttributeUsageAttribute"
		alias
			"set_Inherited"
		end

end -- class ATTRIBUTE_USAGE_ATTRIBUTE
