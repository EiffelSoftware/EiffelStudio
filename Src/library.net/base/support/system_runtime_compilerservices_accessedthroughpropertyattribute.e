indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.CompilerServices.AccessedThroughPropertyAttribute"

frozen external class
	SYSTEM_RUNTIME_COMPILERSERVICES_ACCESSEDTHROUGHPROPERTYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_accessed_through_property_attribute

feature {NONE} -- Initialization

	frozen make_accessed_through_property_attribute (propertyName2: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.CompilerServices.AccessedThroughPropertyAttribute"
		end

feature -- Access

	frozen get_property_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.CompilerServices.AccessedThroughPropertyAttribute"
		alias
			"get_PropertyName"
		end

end -- class SYSTEM_RUNTIME_COMPILERSERVICES_ACCESSEDTHROUGHPROPERTYATTRIBUTE
