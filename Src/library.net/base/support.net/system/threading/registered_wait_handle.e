indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.RegisteredWaitHandle"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	REGISTERED_WAIT_HANDLE

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize
		end

create {NONE}

feature -- Basic Operations

	frozen unregister (wait_object: WAIT_HANDLE): BOOLEAN is
		external
			"IL signature (System.Threading.WaitHandle): System.Boolean use System.Threading.RegisteredWaitHandle"
		alias
			"Unregister"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Threading.RegisteredWaitHandle"
		alias
			"Finalize"
		end

end -- class REGISTERED_WAIT_HANDLE
