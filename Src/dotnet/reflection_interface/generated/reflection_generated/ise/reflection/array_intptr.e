indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAY_INTPTR"

deferred external class
	ARRAY_INTPTR

inherit
	INDEXABLE_INTPTR_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end
	TO_SPECIAL_INTPTR
		rename
			put as put_int_ptr_int322
		end
	RESIZABLE_INTPTR
	BOUNDED_INTPTR
	COLLECTION_INTPTR
	BAG_INTPTR
	TABLE_INTPTR_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end
	CONTAINER_INTPTR
	BOX_INTPTR
	FINITE_INTPTR

feature -- Basic Operations

	force (v: POINTER; i: INTEGER) is
		external
			"IL deferred signature (System.IntPtr, System.Int32): System.Void use ARRAY_INTPTR"
		alias
			"force"
		end

	all_default: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_INTPTR"
		alias
			"all_default"
		end

	upper: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_INTPTR"
		alias
			"upper"
		end

	entry (i: INTEGER): POINTER is
		external
			"IL deferred signature (System.Int32): System.IntPtr use ARRAY_INTPTR"
		alias
			"entry"
		end

	to_c: ANY is
		external
			"IL deferred signature (): ANY use ARRAY_INTPTR"
		alias
			"to_c"
		end

	enter (v: POINTER; i: INTEGER) is
		external
			"IL deferred signature (System.IntPtr, System.Int32): System.Void use ARRAY_INTPTR"
		alias
			"enter"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use ARRAY_INTPTR"
		alias
			"clear_all"
		end

	make_from_array (a: ARRAY_INTPTR) is
		external
			"IL deferred signature (ARRAY_INTPTR): System.Void use ARRAY_INTPTR"
		alias
			"make_from_array"
		end

	empty_area: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_INTPTR"
		alias
			"empty_area"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_INTPTR"
		alias
			"_set_lower"
		end

	discard_items is
		external
			"IL deferred signature (): System.Void use ARRAY_INTPTR"
		alias
			"discard_items"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_INTPTR"
		alias
			"resize"
		end

	valid_index_set: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_INTPTR"
		alias
			"valid_index_set"
		end

	all_cleared: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_INTPTR"
		alias
			"all_cleared"
		end

	make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_INTPTR"
		alias
			"make"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_INTPTR is
		external
			"IL deferred signature (System.Int32, System.Int32): ARRAY_INTPTR use ARRAY_INTPTR"
		alias
			"subarray"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_INTPTR"
		alias
			"auto_resize"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_INTPTR"
		alias
			"_set_upper"
		end

	subcopy (other: ARRAY_INTPTR; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL deferred signature (ARRAY_INTPTR, System.Int32, System.Int32, System.Int32): System.Void use ARRAY_INTPTR"
		alias
			"subcopy"
		end

	lower: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_INTPTR"
		alias
			"lower"
		end

	same_items (other: ARRAY_INTPTR): BOOLEAN is
		external
			"IL deferred signature (ARRAY_INTPTR): System.Boolean use ARRAY_INTPTR"
		alias
			"same_items"
		end

	to_cil: NATIVE_ARRAY [POINTER] is
		external
			"IL deferred signature (): System.IntPtr[] use ARRAY_INTPTR"
		alias
			"to_cil"
		end

end -- class ARRAY_INTPTR
