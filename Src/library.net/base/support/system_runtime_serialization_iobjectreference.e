indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Serialization.IObjectReference"

deferred external class
	SYSTEM_RUNTIME_SERIALIZATION_IOBJECTREFERENCE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_real_object (context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT): ANY is
		external
			"IL deferred signature (System.Runtime.Serialization.StreamingContext): System.Object use System.Runtime.Serialization.IObjectReference"
		alias
			"GetRealObject"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_IOBJECTREFERENCE
