indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SPECIAL_ANY"

deferred external class
	SPECIAL_ANY

feature -- Basic Operations

	a_set_native_array (native_array2: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL deferred signature (System.Object[]): System.Void use SPECIAL_ANY"
		alias
			"_set_native_array"
		end

	resized_area (n: INTEGER): SPECIAL_ANY is
		external
			"IL deferred signature (System.Int32): SPECIAL_ANY use SPECIAL_ANY"
		alias
			"resized_area"
		end

	infix "@" (i: INTEGER): ANY is
		external
			"IL deferred signature (System.Int32): ANY use SPECIAL_ANY"
		alias
			"infix "@""
		end

	all_default (upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use SPECIAL_ANY"
		alias
			"all_default"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use SPECIAL_ANY"
		alias
			"clear_all"
		end

	valid_array_type (a: NATIVE_ARRAY [SYSTEM_OBJECT]): BOOLEAN is
		external
			"IL deferred signature (System.Object[]): System.Boolean use SPECIAL_ANY"
		alias
			"valid_array_type"
		end

	index_of (v: ANY; start_position: INTEGER): INTEGER is
		external
			"IL deferred signature (ANY, System.Int32): System.Int32 use SPECIAL_ANY"
		alias
			"index_of"
		end

	put (v: ANY; i: INTEGER) is
		external
			"IL deferred signature (ANY, System.Int32): System.Void use SPECIAL_ANY"
		alias
			"put"
		end

	same_items (other: SPECIAL_ANY; upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (SPECIAL_ANY, System.Int32): System.Boolean use SPECIAL_ANY"
		alias
			"same_items"
		end

	count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use SPECIAL_ANY"
		alias
			"count"
		end

	item (i: INTEGER): ANY is
		external
			"IL deferred signature (System.Int32): ANY use SPECIAL_ANY"
		alias
			"item"
		end

	make (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use SPECIAL_ANY"
		alias
			"make"
		end

	native_array: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL deferred signature (): System.Object[] use SPECIAL_ANY"
		alias
			"native_array"
		end

	make_from_native_array (a: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL deferred signature (System.Object[]): System.Void use SPECIAL_ANY"
		alias
			"make_from_native_array"
		end

end -- class SPECIAL_ANY
