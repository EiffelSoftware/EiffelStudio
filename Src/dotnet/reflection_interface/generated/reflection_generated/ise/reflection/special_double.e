indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SPECIAL_DOUBLE"

deferred external class
	SPECIAL_DOUBLE

feature -- Basic Operations

	a_set_native_array (native_array2: NATIVE_ARRAY [DOUBLE]) is
		external
			"IL deferred signature (System.Double[]): System.Void use SPECIAL_DOUBLE"
		alias
			"_set_native_array"
		end

	resized_area (n: INTEGER): SPECIAL_DOUBLE is
		external
			"IL deferred signature (System.Int32): SPECIAL_DOUBLE use SPECIAL_DOUBLE"
		alias
			"resized_area"
		end

	infix "@" (i: INTEGER): DOUBLE is
		external
			"IL deferred signature (System.Int32): System.Double use SPECIAL_DOUBLE"
		alias
			"infix "@""
		end

	all_default (upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use SPECIAL_DOUBLE"
		alias
			"all_default"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use SPECIAL_DOUBLE"
		alias
			"clear_all"
		end

	valid_array_type (a: NATIVE_ARRAY [DOUBLE]): BOOLEAN is
		external
			"IL deferred signature (System.Double[]): System.Boolean use SPECIAL_DOUBLE"
		alias
			"valid_array_type"
		end

	index_of (v: DOUBLE; start_position: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Double, System.Int32): System.Int32 use SPECIAL_DOUBLE"
		alias
			"index_of"
		end

	put (v: DOUBLE; i: INTEGER) is
		external
			"IL deferred signature (System.Double, System.Int32): System.Void use SPECIAL_DOUBLE"
		alias
			"put"
		end

	same_items (other: SPECIAL_DOUBLE; upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (SPECIAL_DOUBLE, System.Int32): System.Boolean use SPECIAL_DOUBLE"
		alias
			"same_items"
		end

	count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use SPECIAL_DOUBLE"
		alias
			"count"
		end

	item (i: INTEGER): DOUBLE is
		external
			"IL deferred signature (System.Int32): System.Double use SPECIAL_DOUBLE"
		alias
			"item"
		end

	make (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use SPECIAL_DOUBLE"
		alias
			"make"
		end

	native_array: NATIVE_ARRAY [DOUBLE] is
		external
			"IL deferred signature (): System.Double[] use SPECIAL_DOUBLE"
		alias
			"native_array"
		end

	make_from_native_array (a: NATIVE_ARRAY [DOUBLE]) is
		external
			"IL deferred signature (System.Double[]): System.Void use SPECIAL_DOUBLE"
		alias
			"make_from_native_array"
		end

end -- class SPECIAL_DOUBLE
