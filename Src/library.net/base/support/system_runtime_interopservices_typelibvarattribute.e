indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.TypeLibVarAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBVARATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_typelibvarattribute,
	make_typelibvarattribute_1

feature {NONE} -- Initialization

	frozen make_typelibvarattribute (flags: SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBVARFLAGS) is
		external
			"IL creator signature (System.Runtime.InteropServices.TypeLibVarFlags) use System.Runtime.InteropServices.TypeLibVarAttribute"
		end

	frozen make_typelibvarattribute_1 (flags: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.TypeLibVarAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBVARFLAGS is
		external
			"IL signature (): System.Runtime.InteropServices.TypeLibVarFlags use System.Runtime.InteropServices.TypeLibVarAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBVARATTRIBUTE
