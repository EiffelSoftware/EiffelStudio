indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.CompilerServices.RequiredAttributeAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	REQUIRED_ATTRIBUTE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_required_attribute_attribute

feature {NONE} -- Initialization

	frozen make_required_attribute_attribute (required_contract: TYPE) is
		external
			"IL creator signature (System.Type) use System.Runtime.CompilerServices.RequiredAttributeAttribute"
		end

feature -- Access

	frozen get_required_contract: TYPE is
		external
			"IL signature (): System.Type use System.Runtime.CompilerServices.RequiredAttributeAttribute"
		alias
			"get_RequiredContract"
		end

end -- class REQUIRED_ATTRIBUTE_ATTRIBUTE
