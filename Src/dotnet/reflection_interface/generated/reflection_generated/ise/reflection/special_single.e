indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SPECIAL_SINGLE"

deferred external class
	SPECIAL_SINGLE

feature -- Basic Operations

	a_set_native_array (native_array2: NATIVE_ARRAY [REAL]) is
		external
			"IL deferred signature (System.Single[]): System.Void use SPECIAL_SINGLE"
		alias
			"_set_native_array"
		end

	resized_area (n: INTEGER): SPECIAL_SINGLE is
		external
			"IL deferred signature (System.Int32): SPECIAL_SINGLE use SPECIAL_SINGLE"
		alias
			"resized_area"
		end

	infix "@" (i: INTEGER): REAL is
		external
			"IL deferred signature (System.Int32): System.Single use SPECIAL_SINGLE"
		alias
			"infix "@""
		end

	all_default (upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use SPECIAL_SINGLE"
		alias
			"all_default"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use SPECIAL_SINGLE"
		alias
			"clear_all"
		end

	valid_array_type (a: NATIVE_ARRAY [REAL]): BOOLEAN is
		external
			"IL deferred signature (System.Single[]): System.Boolean use SPECIAL_SINGLE"
		alias
			"valid_array_type"
		end

	index_of (v: REAL; start_position: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Single, System.Int32): System.Int32 use SPECIAL_SINGLE"
		alias
			"index_of"
		end

	put (v: REAL; i: INTEGER) is
		external
			"IL deferred signature (System.Single, System.Int32): System.Void use SPECIAL_SINGLE"
		alias
			"put"
		end

	same_items (other: SPECIAL_SINGLE; upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (SPECIAL_SINGLE, System.Int32): System.Boolean use SPECIAL_SINGLE"
		alias
			"same_items"
		end

	count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use SPECIAL_SINGLE"
		alias
			"count"
		end

	item (i: INTEGER): REAL is
		external
			"IL deferred signature (System.Int32): System.Single use SPECIAL_SINGLE"
		alias
			"item"
		end

	make (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use SPECIAL_SINGLE"
		alias
			"make"
		end

	native_array: NATIVE_ARRAY [REAL] is
		external
			"IL deferred signature (): System.Single[] use SPECIAL_SINGLE"
		alias
			"native_array"
		end

	make_from_native_array (a: NATIVE_ARRAY [REAL]) is
		external
			"IL deferred signature (System.Single[]): System.Void use SPECIAL_SINGLE"
		alias
			"make_from_native_array"
		end

end -- class SPECIAL_SINGLE
