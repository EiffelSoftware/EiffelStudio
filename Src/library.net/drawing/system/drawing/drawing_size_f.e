indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.SizeF"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen expanded external class
	DRAWING_SIZE_F

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end

feature -- Initialization

	frozen make_drawing_size_f_2 (width: REAL; height: REAL) is
		external
			"IL creator signature (System.Single, System.Single) use System.Drawing.SizeF"
		end

	frozen make_drawing_size_f_1 (pt: DRAWING_POINT_F) is
		external
			"IL creator signature (System.Drawing.PointF) use System.Drawing.SizeF"
		end

	frozen make_drawing_size_f (size: DRAWING_SIZE_F) is
		external
			"IL creator signature (System.Drawing.SizeF) use System.Drawing.SizeF"
		end

feature -- Access

	frozen empty: DRAWING_SIZE_F is
		external
			"IL static_field signature :System.Drawing.SizeF use System.Drawing.SizeF"
		alias
			"Empty"
		end

	frozen get_height: REAL is
		external
			"IL signature (): System.Single use System.Drawing.SizeF"
		alias
			"get_Height"
		end

	frozen get_is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.SizeF"
		alias
			"get_IsEmpty"
		end

	frozen get_width: REAL is
		external
			"IL signature (): System.Single use System.Drawing.SizeF"
		alias
			"get_Width"
		end

feature -- Element Change

	frozen set_height (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.SizeF"
		alias
			"set_Height"
		end

	frozen set_width (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.SizeF"
		alias
			"set_Width"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.SizeF"
		alias
			"GetHashCode"
		end

	frozen to_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Drawing.SizeF"
		alias
			"ToSize"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.SizeF"
		alias
			"ToString"
		end

	frozen to_point_f: DRAWING_POINT_F is
		external
			"IL signature (): System.Drawing.PointF use System.Drawing.SizeF"
		alias
			"ToPointF"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.SizeF"
		alias
			"Equals"
		end

feature -- Binary Operators

	frozen infix "-" (sz2: DRAWING_SIZE_F): DRAWING_SIZE_F is
		external
			"IL operator signature (System.Drawing.SizeF): System.Drawing.SizeF use System.Drawing.SizeF"
		alias
			"op_Subtraction"
		end

	frozen infix "|=" (sz2: DRAWING_SIZE_F): BOOLEAN is
		external
			"IL operator signature (System.Drawing.SizeF): System.Boolean use System.Drawing.SizeF"
		alias
			"op_Inequality"
		end

	frozen infix "+" (sz2: DRAWING_SIZE_F): DRAWING_SIZE_F is
		external
			"IL operator signature (System.Drawing.SizeF): System.Drawing.SizeF use System.Drawing.SizeF"
		alias
			"op_Addition"
		end

	frozen infix "#==" (sz2: DRAWING_SIZE_F): BOOLEAN is
		external
			"IL operator signature (System.Drawing.SizeF): System.Boolean use System.Drawing.SizeF"
		alias
			"op_Equality"
		end

feature -- Specials

	frozen op_explicit (size: DRAWING_SIZE_F): DRAWING_POINT_F is
		external
			"IL static signature (System.Drawing.SizeF): System.Drawing.PointF use System.Drawing.SizeF"
		alias
			"op_Explicit"
		end

end -- class DRAWING_SIZE_F
