indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "TO_SPECIAL_INTPTR"

deferred external class
	TO_SPECIAL_INTPTR

feature -- Basic Operations

	set_area (other: SPECIAL_INTPTR) is
		external
			"IL deferred signature (SPECIAL_INTPTR): System.Void use TO_SPECIAL_INTPTR"
		alias
			"set_area"
		end

	a_set_area (area2: SPECIAL_INTPTR) is
		external
			"IL deferred signature (SPECIAL_INTPTR): System.Void use TO_SPECIAL_INTPTR"
		alias
			"_set_area"
		end

	infix "@" (i: INTEGER): POINTER is
		external
			"IL deferred signature (System.Int32): System.IntPtr use TO_SPECIAL_INTPTR"
		alias
			"infix "@""
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use TO_SPECIAL_INTPTR"
		alias
			"valid_index"
		end

	put (v: POINTER; i: INTEGER) is
		external
			"IL deferred signature (System.IntPtr, System.Int32): System.Void use TO_SPECIAL_INTPTR"
		alias
			"put"
		end

	area: SPECIAL_INTPTR is
		external
			"IL deferred signature (): SPECIAL_INTPTR use TO_SPECIAL_INTPTR"
		alias
			"area"
		end

	item (i: INTEGER): POINTER is
		external
			"IL deferred signature (System.Int32): System.IntPtr use TO_SPECIAL_INTPTR"
		alias
			"item"
		end

	make_area (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use TO_SPECIAL_INTPTR"
		alias
			"make_area"
		end

end -- class TO_SPECIAL_INTPTR
