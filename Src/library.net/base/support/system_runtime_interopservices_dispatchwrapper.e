indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.DispatchWrapper"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_DISPATCHWRAPPER

create
	make

feature {NONE} -- Initialization

	frozen make (obj: ANY) is
		external
			"IL creator signature (System.Object) use System.Runtime.InteropServices.DispatchWrapper"
		end

feature -- Access

	frozen get_wrapped_object: ANY is
		external
			"IL signature (): System.Object use System.Runtime.InteropServices.DispatchWrapper"
		alias
			"get_WrappedObject"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_DISPATCHWRAPPER
