indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAY_ANY"

deferred external class
	ARRAY_ANY

inherit
	CONTAINER_ANY
	RESIZABLE_ANY
	FINITE_ANY
	INDEXABLE_ANY_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end
	BOX_ANY
	BAG_ANY
	TABLE_ANY_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end
	COLLECTION_ANY
	TO_SPECIAL_ANY
		rename
			put as put_any_int322
		end
	BOUNDED_ANY

feature -- Basic Operations

	force (v: ANY; i: INTEGER) is
		external
			"IL deferred signature (ANY, System.Int32): System.Void use ARRAY_ANY"
		alias
			"force"
		end

	all_default: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_ANY"
		alias
			"all_default"
		end

	upper: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_ANY"
		alias
			"upper"
		end

	entry (i: INTEGER): ANY is
		external
			"IL deferred signature (System.Int32): ANY use ARRAY_ANY"
		alias
			"entry"
		end

	to_c: ANY is
		external
			"IL deferred signature (): ANY use ARRAY_ANY"
		alias
			"to_c"
		end

	enter (v: ANY; i: INTEGER) is
		external
			"IL deferred signature (ANY, System.Int32): System.Void use ARRAY_ANY"
		alias
			"enter"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use ARRAY_ANY"
		alias
			"clear_all"
		end

	make_from_array (a: ARRAY_ANY) is
		external
			"IL deferred signature (ARRAY_ANY): System.Void use ARRAY_ANY"
		alias
			"make_from_array"
		end

	empty_area: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_ANY"
		alias
			"empty_area"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_ANY"
		alias
			"_set_lower"
		end

	discard_items is
		external
			"IL deferred signature (): System.Void use ARRAY_ANY"
		alias
			"discard_items"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_ANY"
		alias
			"resize"
		end

	valid_index_set: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_ANY"
		alias
			"valid_index_set"
		end

	all_cleared: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_ANY"
		alias
			"all_cleared"
		end

	make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_ANY"
		alias
			"make"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_ANY is
		external
			"IL deferred signature (System.Int32, System.Int32): ARRAY_ANY use ARRAY_ANY"
		alias
			"subarray"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_ANY"
		alias
			"auto_resize"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_ANY"
		alias
			"_set_upper"
		end

	subcopy (other: ARRAY_ANY; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL deferred signature (ARRAY_ANY, System.Int32, System.Int32, System.Int32): System.Void use ARRAY_ANY"
		alias
			"subcopy"
		end

	lower: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_ANY"
		alias
			"lower"
		end

	same_items (other: ARRAY_ANY): BOOLEAN is
		external
			"IL deferred signature (ARRAY_ANY): System.Boolean use ARRAY_ANY"
		alias
			"same_items"
		end

	to_cil: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL deferred signature (): System.Object[] use ARRAY_ANY"
		alias
			"to_cil"
		end

end -- class ARRAY_ANY
