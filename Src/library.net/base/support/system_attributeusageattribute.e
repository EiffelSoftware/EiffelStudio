indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.AttributeUsageAttribute"

frozen external class
	SYSTEM_ATTRIBUTEUSAGEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_attributeusageattribute

feature {NONE} -- Initialization

	frozen make_attributeusageattribute (valid_on: SYSTEM_ATTRIBUTETARGETS) is
		external
			"IL creator signature (System.AttributeTargets) use System.AttributeUsageAttribute"
		end

feature -- Access

	frozen get_valid_on: SYSTEM_ATTRIBUTETARGETS is
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

end -- class SYSTEM_ATTRIBUTEUSAGEATTRIBUTE
