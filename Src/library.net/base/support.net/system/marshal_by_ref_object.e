indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.MarshalByRefObject"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	MARSHAL_BY_REF_OBJECT

inherit
	SYSTEM_OBJECT

feature -- Basic Operations

	initialize_lifetime_service: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.MarshalByRefObject"
		alias
			"InitializeLifetimeService"
		end

	create_obj_ref (requested_type: TYPE): OBJ_REF is
		external
			"IL signature (System.Type): System.Runtime.Remoting.ObjRef use System.MarshalByRefObject"
		alias
			"CreateObjRef"
		end

	frozen get_lifetime_service: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.MarshalByRefObject"
		alias
			"GetLifetimeService"
		end

end -- class MARSHAL_BY_REF_OBJECT
