indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.IObjectHandle"

deferred external class
	SYSTEM_RUNTIME_REMOTING_IOBJECTHANDLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	unwrap: ANY is
		external
			"IL deferred signature (): System.Object use System.Runtime.Remoting.IObjectHandle"
		alias
			"Unwrap"
		end

end -- class SYSTEM_RUNTIME_REMOTING_IOBJECTHANDLE
