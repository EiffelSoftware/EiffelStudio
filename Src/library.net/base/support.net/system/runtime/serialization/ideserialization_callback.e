indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.IDeserializationCallback"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IDESERIALIZATION_CALLBACK

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	on_deserialization (sender: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use System.Runtime.Serialization.IDeserializationCallback"
		alias
			"OnDeserialization"
		end

end -- class IDESERIALIZATION_CALLBACK
