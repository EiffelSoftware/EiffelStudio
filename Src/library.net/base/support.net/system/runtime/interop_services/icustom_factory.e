indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ICustomFactory"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICUSTOM_FACTORY

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	create_instance (server_type: TYPE): MARSHAL_BY_REF_OBJECT is
		external
			"IL deferred signature (System.Type): System.MarshalByRefObject use System.Runtime.InteropServices.ICustomFactory"
		alias
			"CreateInstance"
		end

end -- class ICUSTOM_FACTORY
