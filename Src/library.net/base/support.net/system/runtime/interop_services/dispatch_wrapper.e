indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.DispatchWrapper"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DISPATCH_WRAPPER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (obj: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object) use System.Runtime.InteropServices.DispatchWrapper"
		end

feature -- Access

	frozen get_wrapped_object: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.InteropServices.DispatchWrapper"
		alias
			"get_WrappedObject"
		end

end -- class DISPATCH_WRAPPER
