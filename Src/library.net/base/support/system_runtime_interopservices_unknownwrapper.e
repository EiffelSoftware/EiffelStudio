indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.UnknownWrapper"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UNKNOWNWRAPPER

create
	make

feature {NONE} -- Initialization

	frozen make (obj: ANY) is
		external
			"IL creator signature (System.Object) use System.Runtime.InteropServices.UnknownWrapper"
		end

feature -- Access

	frozen get_wrapped_object: ANY is
		external
			"IL signature (): System.Object use System.Runtime.InteropServices.UnknownWrapper"
		alias
			"get_WrappedObject"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UNKNOWNWRAPPER
