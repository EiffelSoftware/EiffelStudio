indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.CompilerServices.AccessedThroughPropertyAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ACCESSED_THROUGH_PROPERTY_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_accessed_through_property_attribute

feature {NONE} -- Initialization

	frozen make_accessed_through_property_attribute (property_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.CompilerServices.AccessedThroughPropertyAttribute"
		end

feature -- Access

	frozen get_property_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.CompilerServices.AccessedThroughPropertyAttribute"
		alias
			"get_PropertyName"
		end

end -- class ACCESSED_THROUGH_PROPERTY_ATTRIBUTE
