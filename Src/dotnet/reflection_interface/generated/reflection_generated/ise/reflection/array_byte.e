indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAY_BYTE"

deferred external class
	ARRAY_BYTE

inherit
	BAG_BYTE
	BOUNDED_BYTE
	TO_SPECIAL_BYTE
		rename
			put as put_byte_int322
		end
	TABLE_BYTE_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end
	COLLECTION_BYTE
	FINITE_BYTE
	CONTAINER_BYTE
	INDEXABLE_BYTE_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end
	BOX_BYTE
	RESIZABLE_BYTE

feature -- Basic Operations

	force (v: INTEGER_8; i: INTEGER) is
		external
			"IL deferred signature (System.Byte, System.Int32): System.Void use ARRAY_BYTE"
		alias
			"force"
		end

	all_default: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_BYTE"
		alias
			"all_default"
		end

	upper: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_BYTE"
		alias
			"upper"
		end

	entry (i: INTEGER): INTEGER_8 is
		external
			"IL deferred signature (System.Int32): System.Byte use ARRAY_BYTE"
		alias
			"entry"
		end

	to_c: ANY is
		external
			"IL deferred signature (): ANY use ARRAY_BYTE"
		alias
			"to_c"
		end

	enter (v: INTEGER_8; i: INTEGER) is
		external
			"IL deferred signature (System.Byte, System.Int32): System.Void use ARRAY_BYTE"
		alias
			"enter"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use ARRAY_BYTE"
		alias
			"clear_all"
		end

	make_from_array (a: ARRAY_BYTE) is
		external
			"IL deferred signature (ARRAY_BYTE): System.Void use ARRAY_BYTE"
		alias
			"make_from_array"
		end

	empty_area: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_BYTE"
		alias
			"empty_area"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_BYTE"
		alias
			"_set_lower"
		end

	discard_items is
		external
			"IL deferred signature (): System.Void use ARRAY_BYTE"
		alias
			"discard_items"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_BYTE"
		alias
			"resize"
		end

	valid_index_set: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_BYTE"
		alias
			"valid_index_set"
		end

	all_cleared: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_BYTE"
		alias
			"all_cleared"
		end

	make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_BYTE"
		alias
			"make"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_BYTE is
		external
			"IL deferred signature (System.Int32, System.Int32): ARRAY_BYTE use ARRAY_BYTE"
		alias
			"subarray"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_BYTE"
		alias
			"auto_resize"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_BYTE"
		alias
			"_set_upper"
		end

	subcopy (other: ARRAY_BYTE; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL deferred signature (ARRAY_BYTE, System.Int32, System.Int32, System.Int32): System.Void use ARRAY_BYTE"
		alias
			"subcopy"
		end

	lower: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_BYTE"
		alias
			"lower"
		end

	same_items (other: ARRAY_BYTE): BOOLEAN is
		external
			"IL deferred signature (ARRAY_BYTE): System.Boolean use ARRAY_BYTE"
		alias
			"same_items"
		end

	to_cil: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (): System.Byte[] use ARRAY_BYTE"
		alias
			"to_cil"
		end

end -- class ARRAY_BYTE
