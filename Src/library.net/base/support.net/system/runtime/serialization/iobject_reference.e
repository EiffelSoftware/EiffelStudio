indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.IObjectReference"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IOBJECT_REFERENCE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_real_object (context: STREAMING_CONTEXT): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Runtime.Serialization.StreamingContext): System.Object use System.Runtime.Serialization.IObjectReference"
		alias
			"GetRealObject"
		end

end -- class IOBJECT_REFERENCE
