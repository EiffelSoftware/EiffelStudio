indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Collections.Queue"

external class
	QUEUE

inherit
	ANY
		redefine
			Finalize,
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

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Queue"
		alias
			"get_IsReadOnly"
		end

	get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.Queue"
		alias
			"get_SyncRoot"
		end

	get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Queue"
		alias
			"get_IsSynchronized"
		end

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Queue"
		alias
			"get_Count"
		end

feature -- Basic Operations

	copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.Queue"
		alias
			"CopyTo"
		end

	wipe_out is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.Queue"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Queue"
		alias
			"Equals"
		end

	linear_representation: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Collections.Queue"
		alias
			"ToArray"
		end

	remove: ANY is
		external
			"IL signature (): System.Object use System.Collections.Queue"
		alias
			"Dequeue"
		end

	frozen synchronized (queue: QUEUE): QUEUE is
		external
			"IL static signature (System.Collections.Queue): System.Collections.Queue use System.Collections.Queue"
		alias
			"Synchronized"
		end

	clone: ANY is
		external
			"IL signature (): System.Object use System.Collections.Queue"
		alias
			"Clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Queue"
		alias
			"GetHashCode"
		end

	item: ANY is
		external
			"IL signature (): System.Object use System.Collections.Queue"
		alias
			"Peek"
		end

	get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Queue"
		alias
			"GetEnumerator"
		end

	put (obj: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.Queue"
		alias
			"Enqueue"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.Queue"
		alias
			"Finalize"
		end

end -- class QUEUE
