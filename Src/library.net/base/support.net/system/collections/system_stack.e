indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.Stack"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_STACK

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICOLLECTION
	IENUMERABLE
	ICLONEABLE

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (col: ICOLLECTION) is
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

	get_sync_root: SYSTEM_OBJECT is
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

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.Stack"
		alias
			"ToString"
		end

	push (obj: SYSTEM_OBJECT) is
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

	clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.Stack"
		alias
			"Clone"
		end

	pop: SYSTEM_OBJECT is
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

	to_array: NATIVE_ARRAY [SYSTEM_OBJECT] is
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

	contains (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Stack"
		alias
			"Contains"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Stack"
		alias
			"Equals"
		end

	get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Stack"
		alias
			"GetEnumerator"
		end

	frozen synchronized (stack: SYSTEM_STACK): SYSTEM_STACK is
		external
			"IL static signature (System.Collections.Stack): System.Collections.Stack use System.Collections.Stack"
		alias
			"Synchronized"
		end

	peek: SYSTEM_OBJECT is
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

end -- class SYSTEM_STACK
