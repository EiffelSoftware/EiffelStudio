indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.TypeLibFuncAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBFUNCATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_typelibfuncattribute,
	make_typelibfuncattribute_1

feature {NONE} -- Initialization

	frozen make_typelibfuncattribute (flags: SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBFUNCFLAGS) is
		external
			"IL creator signature (System.Runtime.InteropServices.TypeLibFuncFlags) use System.Runtime.InteropServices.TypeLibFuncAttribute"
		end

	frozen make_typelibfuncattribute_1 (flags: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.TypeLibFuncAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBFUNCFLAGS is
		external
			"IL signature (): System.Runtime.InteropServices.TypeLibFuncFlags use System.Runtime.InteropServices.TypeLibFuncAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBFUNCATTRIBUTE
