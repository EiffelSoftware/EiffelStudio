indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.IHashCodeProvider"

deferred external class
	SYSTEM_COLLECTIONS_IHASHCODEPROVIDER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_hash_code_object (obj: ANY): INTEGER is
		external
			"IL deferred signature (System.Object): System.Int32 use System.Collections.IHashCodeProvider"
		alias
			"GetHashCode"
		end

end -- class SYSTEM_COLLECTIONS_IHASHCODEPROVIDER
