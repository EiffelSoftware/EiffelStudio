indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IDisposable"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IDISPOSABLE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	dispose is
		external
			"IL deferred signature (): System.Void use System.IDisposable"
		alias
			"Dispose"
		end

end -- class IDISPOSABLE
