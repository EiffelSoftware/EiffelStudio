indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SPECIAL_CHAR"

deferred external class
	SPECIAL_CHAR

feature -- Basic Operations

	a_set_native_array (native_array2: NATIVE_ARRAY [CHARACTER]) is
		external
			"IL deferred signature (System.Char[]): System.Void use SPECIAL_CHAR"
		alias
			"_set_native_array"
		end

	resized_area (n: INTEGER): SPECIAL_CHAR is
		external
			"IL deferred signature (System.Int32): SPECIAL_CHAR use SPECIAL_CHAR"
		alias
			"resized_area"
		end

	infix "@" (i: INTEGER): CHARACTER is
		external
			"IL deferred signature (System.Int32): System.Char use SPECIAL_CHAR"
		alias
			"infix "@""
		end

	all_default (upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use SPECIAL_CHAR"
		alias
			"all_default"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use SPECIAL_CHAR"
		alias
			"clear_all"
		end

	valid_array_type (a: NATIVE_ARRAY [CHARACTER]): BOOLEAN is
		external
			"IL deferred signature (System.Char[]): System.Boolean use SPECIAL_CHAR"
		alias
			"valid_array_type"
		end

	index_of (v: CHARACTER; start_position: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Char, System.Int32): System.Int32 use SPECIAL_CHAR"
		alias
			"index_of"
		end

	put (v: CHARACTER; i: INTEGER) is
		external
			"IL deferred signature (System.Char, System.Int32): System.Void use SPECIAL_CHAR"
		alias
			"put"
		end

	same_items (other: SPECIAL_CHAR; upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (SPECIAL_CHAR, System.Int32): System.Boolean use SPECIAL_CHAR"
		alias
			"same_items"
		end

	count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use SPECIAL_CHAR"
		alias
			"count"
		end

	item (i: INTEGER): CHARACTER is
		external
			"IL deferred signature (System.Int32): System.Char use SPECIAL_CHAR"
		alias
			"item"
		end

	make (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use SPECIAL_CHAR"
		alias
			"make"
		end

	native_array: NATIVE_ARRAY [CHARACTER] is
		external
			"IL deferred signature (): System.Char[] use SPECIAL_CHAR"
		alias
			"native_array"
		end

	make_from_native_array (a: NATIVE_ARRAY [CHARACTER]) is
		external
			"IL deferred signature (System.Char[]): System.Void use SPECIAL_CHAR"
		alias
			"make_from_native_array"
		end

end -- class SPECIAL_CHAR
