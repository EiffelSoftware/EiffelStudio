indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAY_DOUBLE"

deferred external class
	ARRAY_DOUBLE

inherit
	BOX_DOUBLE
	TO_SPECIAL_DOUBLE
		rename
			put as put_double_int322
		end
	COLLECTION_DOUBLE
	BAG_DOUBLE
	INDEXABLE_DOUBLE_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end
	RESIZABLE_DOUBLE
	BOUNDED_DOUBLE
	FINITE_DOUBLE
	CONTAINER_DOUBLE
	TABLE_DOUBLE_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end

feature -- Basic Operations

	force (v: DOUBLE; i: INTEGER) is
		external
			"IL deferred signature (System.Double, System.Int32): System.Void use ARRAY_DOUBLE"
		alias
			"force"
		end

	all_default: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_DOUBLE"
		alias
			"all_default"
		end

	upper: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_DOUBLE"
		alias
			"upper"
		end

	entry (i: INTEGER): DOUBLE is
		external
			"IL deferred signature (System.Int32): System.Double use ARRAY_DOUBLE"
		alias
			"entry"
		end

	to_c: ANY is
		external
			"IL deferred signature (): ANY use ARRAY_DOUBLE"
		alias
			"to_c"
		end

	enter (v: DOUBLE; i: INTEGER) is
		external
			"IL deferred signature (System.Double, System.Int32): System.Void use ARRAY_DOUBLE"
		alias
			"enter"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use ARRAY_DOUBLE"
		alias
			"clear_all"
		end

	make_from_array (a: ARRAY_DOUBLE) is
		external
			"IL deferred signature (ARRAY_DOUBLE): System.Void use ARRAY_DOUBLE"
		alias
			"make_from_array"
		end

	empty_area: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_DOUBLE"
		alias
			"empty_area"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_DOUBLE"
		alias
			"_set_lower"
		end

	discard_items is
		external
			"IL deferred signature (): System.Void use ARRAY_DOUBLE"
		alias
			"discard_items"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_DOUBLE"
		alias
			"resize"
		end

	valid_index_set: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_DOUBLE"
		alias
			"valid_index_set"
		end

	all_cleared: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_DOUBLE"
		alias
			"all_cleared"
		end

	make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_DOUBLE"
		alias
			"make"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_DOUBLE is
		external
			"IL deferred signature (System.Int32, System.Int32): ARRAY_DOUBLE use ARRAY_DOUBLE"
		alias
			"subarray"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_DOUBLE"
		alias
			"auto_resize"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_DOUBLE"
		alias
			"_set_upper"
		end

	subcopy (other: ARRAY_DOUBLE; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL deferred signature (ARRAY_DOUBLE, System.Int32, System.Int32, System.Int32): System.Void use ARRAY_DOUBLE"
		alias
			"subcopy"
		end

	lower: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_DOUBLE"
		alias
			"lower"
		end

	same_items (other: ARRAY_DOUBLE): BOOLEAN is
		external
			"IL deferred signature (ARRAY_DOUBLE): System.Boolean use ARRAY_DOUBLE"
		alias
			"same_items"
		end

	to_cil: NATIVE_ARRAY [DOUBLE] is
		external
			"IL deferred signature (): System.Double[] use ARRAY_DOUBLE"
		alias
			"to_cil"
		end

end -- class ARRAY_DOUBLE
