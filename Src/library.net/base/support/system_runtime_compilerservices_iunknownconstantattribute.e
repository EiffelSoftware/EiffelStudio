indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.CompilerServices.IUnknownConstantAttribute"

frozen external class
	SYSTEM_RUNTIME_COMPILERSERVICES_IUNKNOWNCONSTANTATTRIBUTE

inherit
	SYSTEM_RUNTIME_COMPILERSERVICES_CUSTOMCONSTANTATTRIBUTE

create
	make_iunknownconstantattribute

feature {NONE} -- Initialization

	frozen make_iunknownconstantattribute is
		external
			"IL creator use System.Runtime.CompilerServices.IUnknownConstantAttribute"
		end

feature -- Access

	get_value: ANY is
		external
			"IL signature (): System.Object use System.Runtime.CompilerServices.IUnknownConstantAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_COMPILERSERVICES_IUNKNOWNCONSTANTATTRIBUTE
