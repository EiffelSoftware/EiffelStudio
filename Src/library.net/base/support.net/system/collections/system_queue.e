indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.Queue"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_QUEUE

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
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (col: ICOLLECTION) is
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

	get_sync_root: SYSTEM_OBJECT is
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

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.Queue"
		alias
			"ToString"
		end

	get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Queue"
		alias
			"GetEnumerator"
		end

	dequeue: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.Queue"
		alias
			"Dequeue"
		end

	enqueue (obj: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Collections.Queue"
		alias
			"Enqueue"
		end

	clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.Queue"
		alias
			"Clone"
		end

	copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.Queue"
		alias
			"CopyTo"
		end

	to_array: NATIVE_ARRAY [SYSTEM_OBJECT] is
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

	contains (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Queue"
		alias
			"Contains"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Queue"
		alias
			"Equals"
		end

	trim_to_size is
		external
			"IL signature (): System.Void use System.Collections.Queue"
		alias
			"TrimToSize"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Queue"
		alias
			"GetHashCode"
		end

	frozen synchronized (queue: SYSTEM_QUEUE): SYSTEM_QUEUE is
		external
			"IL static signature (System.Collections.Queue): System.Collections.Queue use System.Collections.Queue"
		alias
			"Synchronized"
		end

	peek: SYSTEM_OBJECT is
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

end -- class SYSTEM_QUEUE
