indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.BitArray"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	BIT_ARRAY

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
	make_5,
	make_4,
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_5 (bits: BIT_ARRAY) is
		external
			"IL creator signature (System.Collections.BitArray) use System.Collections.BitArray"
		end

	frozen make_4 (values: NATIVE_ARRAY [INTEGER]) is
		external
			"IL creator signature (System.Int32[]) use System.Collections.BitArray"
		end

	frozen make_3 (values: NATIVE_ARRAY [BOOLEAN]) is
		external
			"IL creator signature (System.Boolean[]) use System.Collections.BitArray"
		end

	frozen make_2 (bytes: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Collections.BitArray"
		end

	frozen make (length: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Collections.BitArray"
		end

	frozen make_1 (length: INTEGER; default_value: BOOLEAN) is
		external
			"IL creator signature (System.Int32, System.Boolean) use System.Collections.BitArray"
		end

feature -- Access

	frozen get_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.BitArray"
		alias
			"get_Length"
		end

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.BitArray"
		alias
			"get_IsSynchronized"
		end

	frozen get_item (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Collections.BitArray"
		alias
			"get_Item"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.BitArray"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.BitArray"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.BitArray"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	frozen set_length (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.BitArray"
		alias
			"set_Length"
		end

	frozen set_item (index: INTEGER; value: BOOLEAN) is
		external
			"IL signature (System.Int32, System.Boolean): System.Void use System.Collections.BitArray"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.BitArray"
		alias
			"ToString"
		end

	frozen and_ (value: BIT_ARRAY): BIT_ARRAY is
		external
			"IL signature (System.Collections.BitArray): System.Collections.BitArray use System.Collections.BitArray"
		alias
			"And"
		end

	frozen or_ (value: BIT_ARRAY): BIT_ARRAY is
		external
			"IL signature (System.Collections.BitArray): System.Collections.BitArray use System.Collections.BitArray"
		alias
			"Or"
		end

	frozen get (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Collections.BitArray"
		alias
			"Get"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.BitArray"
		alias
			"Clone"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.BitArray"
		alias
			"CopyTo"
		end

	frozen xor_ (value: BIT_ARRAY): BIT_ARRAY is
		external
			"IL signature (System.Collections.BitArray): System.Collections.BitArray use System.Collections.BitArray"
		alias
			"Xor"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.BitArray"
		alias
			"GetEnumerator"
		end

	frozen set_all (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Collections.BitArray"
		alias
			"SetAll"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.BitArray"
		alias
			"Equals"
		end

	frozen not_: BIT_ARRAY is
		external
			"IL signature (): System.Collections.BitArray use System.Collections.BitArray"
		alias
			"Not"
		end

	frozen set (index: INTEGER; value: BOOLEAN) is
		external
			"IL signature (System.Int32, System.Boolean): System.Void use System.Collections.BitArray"
		alias
			"Set"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.BitArray"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.BitArray"
		alias
			"Finalize"
		end

end -- class BIT_ARRAY
