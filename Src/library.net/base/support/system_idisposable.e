indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IDisposable"

deferred external class
	SYSTEM_IDISPOSABLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	dispose is
		external
			"IL deferred signature (): System.Void use System.IDisposable"
		alias
			"Dispose"
		end

end -- class SYSTEM_IDISPOSABLE
