indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.IObjectHandle"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IOBJECT_HANDLE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	unwrap: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.Runtime.Remoting.IObjectHandle"
		alias
			"Unwrap"
		end

end -- class IOBJECT_HANDLE
