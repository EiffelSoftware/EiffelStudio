indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Collections.BitArray"

frozen external class
	SYSTEM_COLLECTIONS_BITARRAY

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
	make_5,
	make_4,
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_5 (bits: SYSTEM_COLLECTIONS_BITARRAY) is
		external
			"IL creator signature (System.Collections.BitArray) use System.Collections.BitArray"
		end

	frozen make_4 (values: ARRAY [INTEGER]) is
		external
			"IL creator signature (System.Int32[]) use System.Collections.BitArray"
		end

	frozen make_3 (values: ARRAY [BOOLEAN]) is
		external
			"IL creator signature (System.Boolean[]) use System.Collections.BitArray"
		end

	frozen make_2 (bytes: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Collections.BitArray"
		end

	frozen make (length2: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Collections.BitArray"
		end

	frozen make_1 (length2: INTEGER; defaultValue: BOOLEAN) is
		external
			"IL creator signature (System.Int32, System.Boolean) use System.Collections.BitArray"
		end

feature -- Access

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.BitArray"
		alias
			"get_IsReadOnly"
		end

	frozen get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.BitArray"
		alias
			"get_SyncRoot"
		end

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.BitArray"
		alias
			"get_IsSynchronized"
		end

	frozen get_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.BitArray"
		alias
			"get_Length"
		end

	frozen get_item (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Collections.BitArray"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.BitArray"
		alias
			"get_Count"
		end

feature -- Element Change

	frozen set_length (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.BitArray"
		alias
			"set_Length"
		end

	frozen put_i_th (index: INTEGER; value: BOOLEAN) is
		external
			"IL signature (System.Int32, System.Boolean): System.Void use System.Collections.BitArray"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen set_all (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Collections.BitArray"
		alias
			"SetAll"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.BitArray"
		alias
			"CopyTo"
		end

	frozen not_: SYSTEM_COLLECTIONS_BITARRAY is
		external
			"IL signature (): System.Collections.BitArray use System.Collections.BitArray"
		alias
			"Not"
		end

	frozen get (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Collections.BitArray"
		alias
			"Get"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.BitArray"
		alias
			"Equals"
		end

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.Collections.BitArray"
		alias
			"Clone"
		end

	frozen xor_ (value: SYSTEM_COLLECTIONS_BITARRAY): SYSTEM_COLLECTIONS_BITARRAY is
		external
			"IL signature (System.Collections.BitArray): System.Collections.BitArray use System.Collections.BitArray"
		alias
			"Xor"
		end

	frozen or_ (value: SYSTEM_COLLECTIONS_BITARRAY): SYSTEM_COLLECTIONS_BITARRAY is
		external
			"IL signature (System.Collections.BitArray): System.Collections.BitArray use System.Collections.BitArray"
		alias
			"Or"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.BitArray"
		alias
			"ToString"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.BitArray"
		alias
			"GetEnumerator"
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

	frozen and_ (value: SYSTEM_COLLECTIONS_BITARRAY): SYSTEM_COLLECTIONS_BITARRAY is
		external
			"IL signature (System.Collections.BitArray): System.Collections.BitArray use System.Collections.BitArray"
		alias
			"And"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.BitArray"
		alias
			"Finalize"
		end

end -- class SYSTEM_COLLECTIONS_BITARRAY
