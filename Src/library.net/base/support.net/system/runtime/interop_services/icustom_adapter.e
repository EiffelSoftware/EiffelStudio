indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ICustomAdapter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICUSTOM_ADAPTER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_underlying_object: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.Runtime.InteropServices.ICustomAdapter"
		alias
			"GetUnderlyingObject"
		end

end -- class ICUSTOM_ADAPTER
