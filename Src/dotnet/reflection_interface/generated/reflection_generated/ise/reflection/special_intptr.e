indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SPECIAL_INTPTR"

deferred external class
	SPECIAL_INTPTR

feature -- Basic Operations

	a_set_native_array (native_array2: NATIVE_ARRAY [POINTER]) is
		external
			"IL deferred signature (System.IntPtr[]): System.Void use SPECIAL_INTPTR"
		alias
			"_set_native_array"
		end

	resized_area (n: INTEGER): SPECIAL_INTPTR is
		external
			"IL deferred signature (System.Int32): SPECIAL_INTPTR use SPECIAL_INTPTR"
		alias
			"resized_area"
		end

	infix "@" (i: INTEGER): POINTER is
		external
			"IL deferred signature (System.Int32): System.IntPtr use SPECIAL_INTPTR"
		alias
			"infix "@""
		end

	all_default (upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use SPECIAL_INTPTR"
		alias
			"all_default"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use SPECIAL_INTPTR"
		alias
			"clear_all"
		end

	valid_array_type (a: NATIVE_ARRAY [POINTER]): BOOLEAN is
		external
			"IL deferred signature (System.IntPtr[]): System.Boolean use SPECIAL_INTPTR"
		alias
			"valid_array_type"
		end

	index_of (v: POINTER; start_position: INTEGER): INTEGER is
		external
			"IL deferred signature (System.IntPtr, System.Int32): System.Int32 use SPECIAL_INTPTR"
		alias
			"index_of"
		end

	put (v: POINTER; i: INTEGER) is
		external
			"IL deferred signature (System.IntPtr, System.Int32): System.Void use SPECIAL_INTPTR"
		alias
			"put"
		end

	same_items (other: SPECIAL_INTPTR; upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (SPECIAL_INTPTR, System.Int32): System.Boolean use SPECIAL_INTPTR"
		alias
			"same_items"
		end

	count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use SPECIAL_INTPTR"
		alias
			"count"
		end

	item (i: INTEGER): POINTER is
		external
			"IL deferred signature (System.Int32): System.IntPtr use SPECIAL_INTPTR"
		alias
			"item"
		end

	make (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use SPECIAL_INTPTR"
		alias
			"make"
		end

	native_array: NATIVE_ARRAY [POINTER] is
		external
			"IL deferred signature (): System.IntPtr[] use SPECIAL_INTPTR"
		alias
			"native_array"
		end

	make_from_native_array (a: NATIVE_ARRAY [POINTER]) is
		external
			"IL deferred signature (System.IntPtr[]): System.Void use SPECIAL_INTPTR"
		alias
			"make_from_native_array"
		end

end -- class SPECIAL_INTPTR
