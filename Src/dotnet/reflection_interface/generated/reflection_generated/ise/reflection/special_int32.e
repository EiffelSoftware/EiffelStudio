indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SPECIAL_INT32"

deferred external class
	SPECIAL_INT32

feature -- Basic Operations

	a_set_native_array (native_array2: NATIVE_ARRAY [INTEGER]) is
		external
			"IL deferred signature (System.Int32[]): System.Void use SPECIAL_INT32"
		alias
			"_set_native_array"
		end

	resized_area (n: INTEGER): SPECIAL_INT32 is
		external
			"IL deferred signature (System.Int32): SPECIAL_INT32 use SPECIAL_INT32"
		alias
			"resized_area"
		end

	infix "@" (i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use SPECIAL_INT32"
		alias
			"infix "@""
		end

	all_default (upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use SPECIAL_INT32"
		alias
			"all_default"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use SPECIAL_INT32"
		alias
			"clear_all"
		end

	valid_array_type (a: NATIVE_ARRAY [INTEGER]): BOOLEAN is
		external
			"IL deferred signature (System.Int32[]): System.Boolean use SPECIAL_INT32"
		alias
			"valid_array_type"
		end

	index_of (v: INTEGER; start_position: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Int32 use SPECIAL_INT32"
		alias
			"index_of"
		end

	put (v: INTEGER; i: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use SPECIAL_INT32"
		alias
			"put"
		end

	same_items (other: SPECIAL_INT32; upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (SPECIAL_INT32, System.Int32): System.Boolean use SPECIAL_INT32"
		alias
			"same_items"
		end

	count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use SPECIAL_INT32"
		alias
			"count"
		end

	item (i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use SPECIAL_INT32"
		alias
			"item"
		end

	make (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use SPECIAL_INT32"
		alias
			"make"
		end

	native_array: NATIVE_ARRAY [INTEGER] is
		external
			"IL deferred signature (): System.Int32[] use SPECIAL_INT32"
		alias
			"native_array"
		end

	make_from_native_array (a: NATIVE_ARRAY [INTEGER]) is
		external
			"IL deferred signature (System.Int32[]): System.Void use SPECIAL_INT32"
		alias
			"make_from_native_array"
		end

end -- class SPECIAL_INT32
