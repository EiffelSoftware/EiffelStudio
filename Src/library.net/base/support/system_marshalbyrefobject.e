indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.MarshalByRefObject"

deferred external class
	SYSTEM_MARSHALBYREFOBJECT

feature -- Basic Operations

	initialize_lifetime_service: ANY is
		external
			"IL signature (): System.Object use System.MarshalByRefObject"
		alias
			"InitializeLifetimeService"
		end

	create_obj_ref (requested_type: SYSTEM_TYPE): SYSTEM_RUNTIME_REMOTING_OBJREF is
		external
			"IL signature (System.Type): System.Runtime.Remoting.ObjRef use System.MarshalByRefObject"
		alias
			"CreateObjRef"
		end

	frozen get_lifetime_service: ANY is
		external
			"IL signature (): System.Object use System.MarshalByRefObject"
		alias
			"GetLifetimeService"
		end

end -- class SYSTEM_MARSHALBYREFOBJECT
