indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SPECIAL_BOOLEAN"

deferred external class
	SPECIAL_BOOLEAN

feature -- Basic Operations

	a_set_native_array (native_array2: NATIVE_ARRAY [BOOLEAN]) is
		external
			"IL deferred signature (System.Boolean[]): System.Void use SPECIAL_BOOLEAN"
		alias
			"_set_native_array"
		end

	resized_area (n: INTEGER): SPECIAL_BOOLEAN is
		external
			"IL deferred signature (System.Int32): SPECIAL_BOOLEAN use SPECIAL_BOOLEAN"
		alias
			"resized_area"
		end

	infix "@" (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use SPECIAL_BOOLEAN"
		alias
			"infix "@""
		end

	all_default (upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use SPECIAL_BOOLEAN"
		alias
			"all_default"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use SPECIAL_BOOLEAN"
		alias
			"clear_all"
		end

	valid_array_type (a: NATIVE_ARRAY [BOOLEAN]): BOOLEAN is
		external
			"IL deferred signature (System.Boolean[]): System.Boolean use SPECIAL_BOOLEAN"
		alias
			"valid_array_type"
		end

	index_of (v: BOOLEAN; start_position: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Boolean, System.Int32): System.Int32 use SPECIAL_BOOLEAN"
		alias
			"index_of"
		end

	put (v: BOOLEAN; i: INTEGER) is
		external
			"IL deferred signature (System.Boolean, System.Int32): System.Void use SPECIAL_BOOLEAN"
		alias
			"put"
		end

	same_items (other: SPECIAL_BOOLEAN; upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (SPECIAL_BOOLEAN, System.Int32): System.Boolean use SPECIAL_BOOLEAN"
		alias
			"same_items"
		end

	count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use SPECIAL_BOOLEAN"
		alias
			"count"
		end

	item (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use SPECIAL_BOOLEAN"
		alias
			"item"
		end

	make (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use SPECIAL_BOOLEAN"
		alias
			"make"
		end

	native_array: NATIVE_ARRAY [BOOLEAN] is
		external
			"IL deferred signature (): System.Boolean[] use SPECIAL_BOOLEAN"
		alias
			"native_array"
		end

	make_from_native_array (a: NATIVE_ARRAY [BOOLEAN]) is
		external
			"IL deferred signature (System.Boolean[]): System.Void use SPECIAL_BOOLEAN"
		alias
			"make_from_native_array"
		end

end -- class SPECIAL_BOOLEAN
