indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SPECIAL_BYTE"

deferred external class
	SPECIAL_BYTE

feature -- Basic Operations

	a_set_native_array (native_array2: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL deferred signature (System.Byte[]): System.Void use SPECIAL_BYTE"
		alias
			"_set_native_array"
		end

	resized_area (n: INTEGER): SPECIAL_BYTE is
		external
			"IL deferred signature (System.Int32): SPECIAL_BYTE use SPECIAL_BYTE"
		alias
			"resized_area"
		end

	infix "@" (i: INTEGER): INTEGER_8 is
		external
			"IL deferred signature (System.Int32): System.Byte use SPECIAL_BYTE"
		alias
			"infix "@""
		end

	all_default (upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use SPECIAL_BYTE"
		alias
			"all_default"
		end

	clear_all is
		external
			"IL deferred signature (): System.Void use SPECIAL_BYTE"
		alias
			"clear_all"
		end

	valid_array_type (a: NATIVE_ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL deferred signature (System.Byte[]): System.Boolean use SPECIAL_BYTE"
		alias
			"valid_array_type"
		end

	index_of (v: INTEGER_8; start_position: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Byte, System.Int32): System.Int32 use SPECIAL_BYTE"
		alias
			"index_of"
		end

	put (v: INTEGER_8; i: INTEGER) is
		external
			"IL deferred signature (System.Byte, System.Int32): System.Void use SPECIAL_BYTE"
		alias
			"put"
		end

	same_items (other: SPECIAL_BYTE; upper: INTEGER): BOOLEAN is
		external
			"IL deferred signature (SPECIAL_BYTE, System.Int32): System.Boolean use SPECIAL_BYTE"
		alias
			"same_items"
		end

	count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use SPECIAL_BYTE"
		alias
			"count"
		end

	item (i: INTEGER): INTEGER_8 is
		external
			"IL deferred signature (System.Int32): System.Byte use SPECIAL_BYTE"
		alias
			"item"
		end

	make (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use SPECIAL_BYTE"
		alias
			"make"
		end

	native_array: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (): System.Byte[] use SPECIAL_BYTE"
		alias
			"native_array"
		end

	make_from_native_array (a: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL deferred signature (System.Byte[]): System.Void use SPECIAL_BYTE"
		alias
			"make_from_native_array"
		end

end -- class SPECIAL_BYTE
