indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.Stack"

external class
	SYSTEM_COLLECTIONS_STACK

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_ICLONEABLE

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (col: SYSTEM_COLLECTIONS_ICOLLECTION) is
		external
			"IL creator signature (System.Collections.ICollection) use System.Collections.Stack"
		end

	frozen make is
		external
			"IL creator use System.Collections.Stack"
		end

	frozen make_1 (initial_capacity: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Collections.Stack"
		end

feature -- Access

	get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Stack"
		alias
			"get_IsSynchronized"
		end

	get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.Stack"
		alias
			"get_SyncRoot"
		end

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Stack"
		alias
			"get_Count"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Stack"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.Stack"
		alias
			"ToString"
		end

	push (obj: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.Stack"
		alias
			"Push"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Stack"
		alias
			"GetHashCode"
		end

	pop: ANY is
		external
			"IL signature (): System.Object use System.Collections.Stack"
		alias
			"Pop"
		end

	copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.Stack"
		alias
			"CopyTo"
		end

	clone: ANY is
		external
			"IL signature (): System.Object use System.Collections.Stack"
		alias
			"Clone"
		end

	to_array: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Collections.Stack"
		alias
			"ToArray"
		end

	clear is
		external
			"IL signature (): System.Void use System.Collections.Stack"
		alias
			"Clear"
		end

	has (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Stack"
		alias
			"Contains"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Stack"
		alias
			"Equals"
		end

	get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Stack"
		alias
			"GetEnumerator"
		end

	frozen synchronized (stack: SYSTEM_COLLECTIONS_STACK): SYSTEM_COLLECTIONS_STACK is
		external
			"IL static signature (System.Collections.Stack): System.Collections.Stack use System.Collections.Stack"
		alias
			"Synchronized"
		end

	peek: ANY is
		external
			"IL signature (): System.Object use System.Collections.Stack"
		alias
			"Peek"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.Stack"
		alias
			"Finalize"
		end

end -- class SYSTEM_COLLECTIONS_STACK
