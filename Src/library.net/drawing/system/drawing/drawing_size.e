indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Size"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen expanded external class
	DRAWING_SIZE

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end

feature -- Initialization

	frozen make_drawing_size (pt: DRAWING_POINT) is
		external
			"IL creator signature (System.Drawing.Point) use System.Drawing.Size"
		end

	frozen make_drawing_size_1 (width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32) use System.Drawing.Size"
		end

feature -- Access

	frozen empty: DRAWING_SIZE is
		external
			"IL static_field signature :System.Drawing.Size use System.Drawing.Size"
		alias
			"Empty"
		end

	frozen get_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Size"
		alias
			"get_Height"
		end

	frozen get_is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Size"
		alias
			"get_IsEmpty"
		end

	frozen get_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Size"
		alias
			"get_Width"
		end

feature -- Element Change

	frozen set_height (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Size"
		alias
			"set_Height"
		end

	frozen set_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Size"
		alias
			"set_Width"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Size"
		alias
			"GetHashCode"
		end

	frozen truncate (value: DRAWING_SIZE_F): DRAWING_SIZE is
		external
			"IL static signature (System.Drawing.SizeF): System.Drawing.Size use System.Drawing.Size"
		alias
			"Truncate"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Size"
		alias
			"ToString"
		end

	frozen round (value: DRAWING_SIZE_F): DRAWING_SIZE is
		external
			"IL static signature (System.Drawing.SizeF): System.Drawing.Size use System.Drawing.Size"
		alias
			"Round"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Size"
		alias
			"Equals"
		end

	frozen ceiling (value: DRAWING_SIZE_F): DRAWING_SIZE is
		external
			"IL static signature (System.Drawing.SizeF): System.Drawing.Size use System.Drawing.Size"
		alias
			"Ceiling"
		end

feature -- Binary Operators

	frozen infix "-" (sz2: DRAWING_SIZE): DRAWING_SIZE is
		external
			"IL operator signature (System.Drawing.Size): System.Drawing.Size use System.Drawing.Size"
		alias
			"op_Subtraction"
		end

	frozen infix "|=" (sz2: DRAWING_SIZE): BOOLEAN is
		external
			"IL operator signature (System.Drawing.Size): System.Boolean use System.Drawing.Size"
		alias
			"op_Inequality"
		end

	frozen infix "+" (sz2: DRAWING_SIZE): DRAWING_SIZE is
		external
			"IL operator signature (System.Drawing.Size): System.Drawing.Size use System.Drawing.Size"
		alias
			"op_Addition"
		end

	frozen infix "#==" (sz2: DRAWING_SIZE): BOOLEAN is
		external
			"IL operator signature (System.Drawing.Size): System.Boolean use System.Drawing.Size"
		alias
			"op_Equality"
		end

feature -- Specials

	frozen op_implicit (p: DRAWING_SIZE): DRAWING_SIZE_F is
		external
			"IL static signature (System.Drawing.Size): System.Drawing.SizeF use System.Drawing.Size"
		alias
			"op_Implicit"
		end

	frozen op_explicit (size: DRAWING_SIZE): DRAWING_POINT is
		external
			"IL static signature (System.Drawing.Size): System.Drawing.Point use System.Drawing.Size"
		alias
			"op_Explicit"
		end

end -- class DRAWING_SIZE
