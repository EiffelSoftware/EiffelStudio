indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.IComparer"

deferred external class
	SYSTEM_COLLECTIONS_ICOMPARER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	compare (x: ANY; y: ANY): INTEGER is
		external
			"IL deferred signature (System.Object, System.Object): System.Int32 use System.Collections.IComparer"
		alias
			"Compare"
		end

end -- class SYSTEM_COLLECTIONS_ICOMPARER
