indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Serialization.IDeserializationCallback"

deferred external class
	SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	on_deserialization (sender: ANY) is
		external
			"IL deferred signature (System.Object): System.Void use System.Runtime.Serialization.IDeserializationCallback"
		alias
			"OnDeserialization"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK
