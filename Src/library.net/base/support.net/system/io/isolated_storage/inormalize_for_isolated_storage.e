indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.IsolatedStorage.INormalizeForIsolatedStorage"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	INORMALIZE_FOR_ISOLATED_STORAGE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	normalize: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.IO.IsolatedStorage.INormalizeForIsolatedStorage"
		alias
			"Normalize"
		end

end -- class INORMALIZE_FOR_ISOLATED_STORAGE
