indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Threading.RegisteredWaitHandle"

frozen external class
	SYSTEM_THREADING_REGISTEREDWAITHANDLE

inherit
	ANY
		redefine
			finalize
		end

create {NONE}

feature -- Basic Operations

	frozen unregister (wait_object: SYSTEM_THREADING_WAITHANDLE): BOOLEAN is
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

end -- class SYSTEM_THREADING_REGISTEREDWAITHANDLE
