indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.ICustomFactory"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_ICUSTOMFACTORY

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	create_instance (server_type: SYSTEM_TYPE): SYSTEM_MARSHALBYREFOBJECT is
		external
			"IL deferred signature (System.Type): System.MarshalByRefObject use System.Runtime.InteropServices.ICustomFactory"
		alias
			"CreateInstance"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_ICUSTOMFACTORY
