indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.ObjectHandle"

external class
	SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			initialize_lifetime_service
		end
	SYSTEM_RUNTIME_REMOTING_IOBJECTHANDLE

create
	make_objecthandle

feature {NONE} -- Initialization

	frozen make_objecthandle (o: ANY) is
		external
			"IL creator signature (System.Object) use System.Runtime.Remoting.ObjectHandle"
		end

feature -- Basic Operations

	frozen unwrap: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.ObjectHandle"
		alias
			"Unwrap"
		end

	initialize_lifetime_service: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.ObjectHandle"
		alias
			"InitializeLifetimeService"
		end

end -- class SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE
