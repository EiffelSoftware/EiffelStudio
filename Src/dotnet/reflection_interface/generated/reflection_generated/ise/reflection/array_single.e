indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAY_SINGLE"

deferred external class
	ARRAY_SINGLE

inherit
	BOX_SINGLE
	CONTAINER_SINGLE
	INDEXABLE_SINGLE_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end
	FINITE_SINGLE
	TABLE_SINGLE_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end
	BAG_SINGLE
	COLLECTION_SINGLE
	TO_SPECIAL_SINGLE
		rename
			put as put_single_int322
		end
	BOUNDED_SINGLE
	RESIZABLE_SINGLE

feature -- Basic Operations

	force (v: REAL; i: INTEGER) is
		external
			"IL deferred signature (System.Single, System.Int32): System.Void use ARRAY_SINGLE"
		alias
			"force"
		end

	all_default: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_SINGLE"
		alias
			"all_default"
		end

	upper: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_SINGLE"
		alias
			"upper"
		end

	entry (i: INTEGER): REAL is
		external
			"IL deferred signature (System.Int32): System.Single use ARRAY_SINGLE"
		alias
			"entry"
		end

	to_c: ANY is
		external
			"IL deferred signature (): ANY use ARRAY_SINGLE"
		alias
			"to_c"
		end

	enter (v: REAL; i: INTEGER) is
		external
			"IL deferred signature (System.Single, System.Int32): System.Void use ARRAY_SINGLE"
		alias
			"enter"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use ARRAY_SINGLE"
		alias
			"clear_all"
		end

	make_from_array (a: ARRAY_SINGLE) is
		external
			"IL deferred signature (ARRAY_SINGLE): System.Void use ARRAY_SINGLE"
		alias
			"make_from_array"
		end

	empty_area: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_SINGLE"
		alias
			"empty_area"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_SINGLE"
		alias
			"_set_lower"
		end

	discard_items is
		external
			"IL deferred signature (): System.Void use ARRAY_SINGLE"
		alias
			"discard_items"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_SINGLE"
		alias
			"resize"
		end

	valid_index_set: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_SINGLE"
		alias
			"valid_index_set"
		end

	all_cleared: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_SINGLE"
		alias
			"all_cleared"
		end

	make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_SINGLE"
		alias
			"make"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_SINGLE is
		external
			"IL deferred signature (System.Int32, System.Int32): ARRAY_SINGLE use ARRAY_SINGLE"
		alias
			"subarray"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_SINGLE"
		alias
			"auto_resize"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_SINGLE"
		alias
			"_set_upper"
		end

	subcopy (other: ARRAY_SINGLE; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL deferred signature (ARRAY_SINGLE, System.Int32, System.Int32, System.Int32): System.Void use ARRAY_SINGLE"
		alias
			"subcopy"
		end

	lower: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_SINGLE"
		alias
			"lower"
		end

	same_items (other: ARRAY_SINGLE): BOOLEAN is
		external
			"IL deferred signature (ARRAY_SINGLE): System.Boolean use ARRAY_SINGLE"
		alias
			"same_items"
		end

	to_cil: NATIVE_ARRAY [REAL] is
		external
			"IL deferred signature (): System.Single[] use ARRAY_SINGLE"
		alias
			"to_cil"
		end

end -- class ARRAY_SINGLE
