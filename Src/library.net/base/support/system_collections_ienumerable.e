indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.IEnumerable"

deferred external class
	SYSTEM_COLLECTIONS_IENUMERABLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL deferred signature (): System.Collections.IEnumerator use System.Collections.IEnumerable"
		alias
			"GetEnumerator"
		end

end -- class SYSTEM_COLLECTIONS_IENUMERABLE
