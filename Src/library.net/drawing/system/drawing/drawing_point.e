indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Point"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen expanded external class
	DRAWING_POINT

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end

feature -- Initialization

	frozen make_drawing_point_2 (dw: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Drawing.Point"
		end

	frozen make_drawing_point_1 (sz: DRAWING_SIZE) is
		external
			"IL creator signature (System.Drawing.Size) use System.Drawing.Point"
		end

	frozen make_drawing_point (x: INTEGER; y: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32) use System.Drawing.Point"
		end

feature -- Access

	frozen empty: DRAWING_POINT is
		external
			"IL static_field signature :System.Drawing.Point use System.Drawing.Point"
		alias
			"Empty"
		end

	frozen get_is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Point"
		alias
			"get_IsEmpty"
		end

	frozen get_y: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Point"
		alias
			"get_Y"
		end

	frozen get_x: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Point"
		alias
			"get_X"
		end

feature -- Element Change

	frozen set_y (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Point"
		alias
			"set_Y"
		end

	frozen set_x (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Point"
		alias
			"set_X"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Point"
		alias
			"GetHashCode"
		end

	frozen offset (dx: INTEGER; dy: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Drawing.Point"
		alias
			"Offset"
		end

	frozen truncate (value: DRAWING_POINT_F): DRAWING_POINT is
		external
			"IL static signature (System.Drawing.PointF): System.Drawing.Point use System.Drawing.Point"
		alias
			"Truncate"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Point"
		alias
			"ToString"
		end

	frozen round (value: DRAWING_POINT_F): DRAWING_POINT is
		external
			"IL static signature (System.Drawing.PointF): System.Drawing.Point use System.Drawing.Point"
		alias
			"Round"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Point"
		alias
			"Equals"
		end

	frozen ceiling (value: DRAWING_POINT_F): DRAWING_POINT is
		external
			"IL static signature (System.Drawing.PointF): System.Drawing.Point use System.Drawing.Point"
		alias
			"Ceiling"
		end

feature -- Binary Operators

	frozen infix "-" (sz: DRAWING_SIZE): DRAWING_POINT is
		external
			"IL operator signature (System.Drawing.Size): System.Drawing.Point use System.Drawing.Point"
		alias
			"op_Subtraction"
		end

	frozen infix "|=" (right: DRAWING_POINT): BOOLEAN is
		external
			"IL operator signature (System.Drawing.Point): System.Boolean use System.Drawing.Point"
		alias
			"op_Inequality"
		end

	frozen infix "+" (sz: DRAWING_SIZE): DRAWING_POINT is
		external
			"IL operator signature (System.Drawing.Size): System.Drawing.Point use System.Drawing.Point"
		alias
			"op_Addition"
		end

	frozen infix "#==" (right: DRAWING_POINT): BOOLEAN is
		external
			"IL operator signature (System.Drawing.Point): System.Boolean use System.Drawing.Point"
		alias
			"op_Equality"
		end

feature -- Specials

	frozen op_implicit (p: DRAWING_POINT): DRAWING_POINT_F is
		external
			"IL static signature (System.Drawing.Point): System.Drawing.PointF use System.Drawing.Point"
		alias
			"op_Implicit"
		end

	frozen op_explicit (p: DRAWING_POINT): DRAWING_SIZE is
		external
			"IL static signature (System.Drawing.Point): System.Drawing.Size use System.Drawing.Point"
		alias
			"op_Explicit"
		end

end -- class DRAWING_POINT
