indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAY_INT32"

deferred external class
	ARRAY_INT32

inherit
	CONTAINER_INT32
	BAG_INT32
	TABLE_INT32_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end
	BOUNDED_INT32
	BOX_INT32
	TO_SPECIAL_INT32
		rename
			put as put_int32_int322
		end
	RESIZABLE_INT32
	FINITE_INT32
	INDEXABLE_INT32_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end
	COLLECTION_INT32

feature -- Basic Operations

	force (v: INTEGER; i: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_INT32"
		alias
			"force"
		end

	all_default: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_INT32"
		alias
			"all_default"
		end

	upper: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_INT32"
		alias
			"upper"
		end

	entry (i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use ARRAY_INT32"
		alias
			"entry"
		end

	to_c: ANY is
		external
			"IL deferred signature (): ANY use ARRAY_INT32"
		alias
			"to_c"
		end

	enter (v: INTEGER; i: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_INT32"
		alias
			"enter"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use ARRAY_INT32"
		alias
			"clear_all"
		end

	make_from_array (a: ARRAY_INT32) is
		external
			"IL deferred signature (ARRAY_INT32): System.Void use ARRAY_INT32"
		alias
			"make_from_array"
		end

	empty_area: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_INT32"
		alias
			"empty_area"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_INT32"
		alias
			"_set_lower"
		end

	discard_items is
		external
			"IL deferred signature (): System.Void use ARRAY_INT32"
		alias
			"discard_items"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_INT32"
		alias
			"resize"
		end

	valid_index_set: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_INT32"
		alias
			"valid_index_set"
		end

	all_cleared: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_INT32"
		alias
			"all_cleared"
		end

	make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_INT32"
		alias
			"make"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_INT32 is
		external
			"IL deferred signature (System.Int32, System.Int32): ARRAY_INT32 use ARRAY_INT32"
		alias
			"subarray"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_INT32"
		alias
			"auto_resize"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_INT32"
		alias
			"_set_upper"
		end

	subcopy (other: ARRAY_INT32; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL deferred signature (ARRAY_INT32, System.Int32, System.Int32, System.Int32): System.Void use ARRAY_INT32"
		alias
			"subcopy"
		end

	lower: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_INT32"
		alias
			"lower"
		end

	same_items (other: ARRAY_INT32): BOOLEAN is
		external
			"IL deferred signature (ARRAY_INT32): System.Boolean use ARRAY_INT32"
		alias
			"same_items"
		end

	to_cil: NATIVE_ARRAY [INTEGER] is
		external
			"IL deferred signature (): System.Int32[] use ARRAY_INT32"
		alias
			"to_cil"
		end

end -- class ARRAY_INT32
