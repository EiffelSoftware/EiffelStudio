indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IComparable"

deferred external class
	SYSTEM_ICOMPARABLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	compare_to (obj: ANY): INTEGER is
		external
			"IL deferred signature (System.Object): System.Int32 use System.IComparable"
		alias
			"CompareTo"
		end

end -- class SYSTEM_ICOMPARABLE
