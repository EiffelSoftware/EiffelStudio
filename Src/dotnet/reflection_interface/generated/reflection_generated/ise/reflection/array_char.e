indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ARRAY_CHAR"

deferred external class
	ARRAY_CHAR

inherit
	RESIZABLE_CHAR
	BOX_CHAR
	CONTAINER_CHAR
	TABLE_CHAR_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end
	TO_SPECIAL_CHAR
		rename
			put as put_char_int322
		end
	BOUNDED_CHAR
	BAG_CHAR
	INDEXABLE_CHAR_INT32
		rename
			infix "@" as infix "@_int32",
			item as item_int32
		end
	FINITE_CHAR
	COLLECTION_CHAR

feature -- Basic Operations

	force (v: CHARACTER; i: INTEGER) is
		external
			"IL deferred signature (System.Char, System.Int32): System.Void use ARRAY_CHAR"
		alias
			"force"
		end

	all_default: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_CHAR"
		alias
			"all_default"
		end

	upper: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_CHAR"
		alias
			"upper"
		end

	entry (i: INTEGER): CHARACTER is
		external
			"IL deferred signature (System.Int32): System.Char use ARRAY_CHAR"
		alias
			"entry"
		end

	to_c: ANY is
		external
			"IL deferred signature (): ANY use ARRAY_CHAR"
		alias
			"to_c"
		end

	enter (v: CHARACTER; i: INTEGER) is
		external
			"IL deferred signature (System.Char, System.Int32): System.Void use ARRAY_CHAR"
		alias
			"enter"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use ARRAY_CHAR"
		alias
			"clear_all"
		end

	make_from_array (a: ARRAY_CHAR) is
		external
			"IL deferred signature (ARRAY_CHAR): System.Void use ARRAY_CHAR"
		alias
			"make_from_array"
		end

	empty_area: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_CHAR"
		alias
			"empty_area"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_CHAR"
		alias
			"_set_lower"
		end

	discard_items is
		external
			"IL deferred signature (): System.Void use ARRAY_CHAR"
		alias
			"discard_items"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_CHAR"
		alias
			"resize"
		end

	valid_index_set: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_CHAR"
		alias
			"valid_index_set"
		end

	all_cleared: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ARRAY_CHAR"
		alias
			"all_cleared"
		end

	make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_CHAR"
		alias
			"make"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_CHAR is
		external
			"IL deferred signature (System.Int32, System.Int32): ARRAY_CHAR use ARRAY_CHAR"
		alias
			"subarray"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use ARRAY_CHAR"
		alias
			"auto_resize"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ARRAY_CHAR"
		alias
			"_set_upper"
		end

	subcopy (other: ARRAY_CHAR; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL deferred signature (ARRAY_CHAR, System.Int32, System.Int32, System.Int32): System.Void use ARRAY_CHAR"
		alias
			"subcopy"
		end

	lower: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ARRAY_CHAR"
		alias
			"lower"
		end

	same_items (other: ARRAY_CHAR): BOOLEAN is
		external
			"IL deferred signature (ARRAY_CHAR): System.Boolean use ARRAY_CHAR"
		alias
			"same_items"
		end

	to_cil: NATIVE_ARRAY [CHARACTER] is
		external
			"IL deferred signature (): System.Char[] use ARRAY_CHAR"
		alias
			"to_cil"
		end

end -- class ARRAY_CHAR
