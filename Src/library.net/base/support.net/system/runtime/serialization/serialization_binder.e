indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.SerializationBinder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SERIALIZATION_BINDER

inherit
	SYSTEM_OBJECT

feature -- Basic Operations

	bind_to_type (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING): TYPE is
		external
			"IL deferred signature (System.String, System.String): System.Type use System.Runtime.Serialization.SerializationBinder"
		alias
			"BindToType"
		end

end -- class SERIALIZATION_BINDER
