indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.IEnumerable"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IENUMERABLE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_enumerator: IENUMERATOR is
		external
			"IL deferred signature (): System.Collections.IEnumerator use System.Collections.IEnumerable"
		alias
			"GetEnumerator"
		end

end -- class IENUMERABLE
