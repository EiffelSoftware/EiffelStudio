indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.CompilerServices.RequiredAttributeAttribute"

frozen external class
	SYSTEM_RUNTIME_COMPILERSERVICES_REQUIREDATTRIBUTEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_requiredattributeattribute

feature {NONE} -- Initialization

	frozen make_requiredattributeattribute (required_contract: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Runtime.CompilerServices.RequiredAttributeAttribute"
		end

feature -- Access

	frozen get_required_contract: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Runtime.CompilerServices.RequiredAttributeAttribute"
		alias
			"get_RequiredContract"
		end

end -- class SYSTEM_RUNTIME_COMPILERSERVICES_REQUIREDATTRIBUTEATTRIBUTE
