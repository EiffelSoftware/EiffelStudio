indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.Queue"

external class
	SYSTEM_COLLECTIONS_QUEUE

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
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (col: SYSTEM_COLLECTIONS_ICOLLECTION) is
		external
			"IL creator signature (System.Collections.ICollection) use System.Collections.Queue"
		end

	frozen make_2 (capacity: INTEGER; grow_factor: REAL) is
		external
			"IL creator signature (System.Int32, System.Single) use System.Collections.Queue"
		end

	frozen make is
		external
			"IL creator use System.Collections.Queue"
		end

	frozen make_1 (capacity: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Collections.Queue"
		end

feature -- Access

	get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Queue"
		alias
			"get_IsSynchronized"
		end

	get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.Queue"
		alias
			"get_SyncRoot"
		end

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Queue"
		alias
			"get_Count"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Queue"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.Queue"
		alias
			"ToString"
		end

	dequeue: ANY is
		external
			"IL signature (): System.Object use System.Collections.Queue"
		alias
			"Dequeue"
		end

	enqueue (obj: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.Queue"
		alias
			"Enqueue"
		end

	copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.Queue"
		alias
			"CopyTo"
		end

	clone: ANY is
		external
			"IL signature (): System.Object use System.Collections.Queue"
		alias
			"Clone"
		end

	to_array: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Collections.Queue"
		alias
			"ToArray"
		end

	clear is
		external
			"IL signature (): System.Void use System.Collections.Queue"
		alias
			"Clear"
		end

	has (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Queue"
		alias
			"Contains"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Queue"
		alias
			"Equals"
		end

	get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Queue"
		alias
			"GetEnumerator"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Queue"
		alias
			"GetHashCode"
		end

	frozen synchronized (queue: SYSTEM_COLLECTIONS_QUEUE): SYSTEM_COLLECTIONS_QUEUE is
		external
			"IL static signature (System.Collections.Queue): System.Collections.Queue use System.Collections.Queue"
		alias
			"Synchronized"
		end

	peek: ANY is
		external
			"IL signature (): System.Object use System.Collections.Queue"
		alias
			"Peek"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.Queue"
		alias
			"Finalize"
		end

end -- class SYSTEM_COLLECTIONS_QUEUE
