indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.ICustomAdapter"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_ICUSTOMADAPTER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_underlying_object: ANY is
		external
			"IL deferred signature (): System.Object use System.Runtime.InteropServices.ICustomAdapter"
		alias
			"GetUnderlyingObject"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_ICUSTOMADAPTER
