indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAY_BOOLEAN"

deferred external class
	ARRAY_BOOLEAN

inherit
	BOUNDED_BOOLEAN
	BAG_BOOLEAN
	COLLECTION_BOOLEAN
	TO_SPECIAL_BOOLEAN
		rename
			put as put_boolean_int322
		end
	TABLE_BOOLEAN_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end
	CONTAINER_BOOLEAN
	FINITE_BOOLEAN
	BOX_BOOLEAN
	INDEXABLE_BOOLEAN_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end
	RESIZABLE_BOOLEAN

feature -- Basic Operations

	force (v: BOOLEAN; i: INTEGER) is
		external
			"IL deferred signature (System.Boolean, System.Int32): System.Void use ARRAY_BOOLEAN"
		alias
			"force"
		end

	all_default: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_BOOLEAN"
		alias
			"all_default"
		end

	upper: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_BOOLEAN"
		alias
			"upper"
		end

	entry (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use ARRAY_BOOLEAN"
		alias
			"entry"
		end

	to_c: ANY is
		external
			"IL deferred signature (): ANY use ARRAY_BOOLEAN"
		alias
			"to_c"
		end

	enter (v: BOOLEAN; i: INTEGER) is
		external
			"IL deferred signature (System.Boolean, System.Int32): System.Void use ARRAY_BOOLEAN"
		alias
			"enter"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use ARRAY_BOOLEAN"
		alias
			"clear_all"
		end

	make_from_array (a: ARRAY_BOOLEAN) is
		external
			"IL deferred signature (ARRAY_BOOLEAN): System.Void use ARRAY_BOOLEAN"
		alias
			"make_from_array"
		end

	empty_area: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_BOOLEAN"
		alias
			"empty_area"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_BOOLEAN"
		alias
			"_set_lower"
		end

	discard_items is
		external
			"IL deferred signature (): System.Void use ARRAY_BOOLEAN"
		alias
			"discard_items"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_BOOLEAN"
		alias
			"resize"
		end

	valid_index_set: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_BOOLEAN"
		alias
			"valid_index_set"
		end

	all_cleared: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_BOOLEAN"
		alias
			"all_cleared"
		end

	make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_BOOLEAN"
		alias
			"make"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_BOOLEAN is
		external
			"IL deferred signature (System.Int32, System.Int32): ARRAY_BOOLEAN use ARRAY_BOOLEAN"
		alias
			"subarray"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_BOOLEAN"
		alias
			"auto_resize"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_BOOLEAN"
		alias
			"_set_upper"
		end

	subcopy (other: ARRAY_BOOLEAN; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL deferred signature (ARRAY_BOOLEAN, System.Int32, System.Int32, System.Int32): System.Void use ARRAY_BOOLEAN"
		alias
			"subcopy"
		end

	lower: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_BOOLEAN"
		alias
			"lower"
		end

	same_items (other: ARRAY_BOOLEAN): BOOLEAN is
		external
			"IL deferred signature (ARRAY_BOOLEAN): System.Boolean use ARRAY_BOOLEAN"
		alias
			"same_items"
		end

	to_cil: NATIVE_ARRAY [BOOLEAN] is
		external
			"IL deferred signature (): System.Boolean[] use ARRAY_BOOLEAN"
		alias
			"to_cil"
		end

end -- class ARRAY_BOOLEAN
