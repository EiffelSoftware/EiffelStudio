indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.ObjectHandle"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	OBJECT_HANDLE

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			initialize_lifetime_service
		end
	IOBJECT_HANDLE

create
	make_object_handle

feature {NONE} -- Initialization

	frozen make_object_handle (o: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object) use System.Runtime.Remoting.ObjectHandle"
		end

feature -- Basic Operations

	frozen unwrap: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.ObjectHandle"
		alias
			"Unwrap"
		end

	initialize_lifetime_service: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.ObjectHandle"
		alias
			"InitializeLifetimeService"
		end

end -- class OBJECT_HANDLE
