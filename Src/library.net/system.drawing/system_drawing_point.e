indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Point"

frozen expanded external class
	SYSTEM_DRAWING_POINT

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end



feature -- Initialization

	frozen make_point_2 (dw: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Drawing.Point"
		end

	frozen make_point (x: INTEGER; y: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32) use System.Drawing.Point"
		end

	frozen make_point_1 (sz: SYSTEM_DRAWING_SIZE) is
		external
			"IL creator signature (System.Drawing.Size) use System.Drawing.Point"
		end

feature -- Access

	frozen empty: SYSTEM_DRAWING_POINT is
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

	frozen offset (dx: INTEGER; dy: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Drawing.Point"
		alias
			"Offset"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Point"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Point"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Point"
		alias
			"ToString"
		end

	frozen round (value: SYSTEM_DRAWING_POINTF): SYSTEM_DRAWING_POINT is
		external
			"IL static signature (System.Drawing.PointF): System.Drawing.Point use System.Drawing.Point"
		alias
			"Round"
		end

	frozen truncate (value: SYSTEM_DRAWING_POINTF): SYSTEM_DRAWING_POINT is
		external
			"IL static signature (System.Drawing.PointF): System.Drawing.Point use System.Drawing.Point"
		alias
			"Truncate"
		end

	frozen ceiling (value: SYSTEM_DRAWING_POINTF): SYSTEM_DRAWING_POINT is
		external
			"IL static signature (System.Drawing.PointF): System.Drawing.Point use System.Drawing.Point"
		alias
			"Ceiling"
		end

feature -- Binary Operators

	frozen infix "-" (sz: SYSTEM_DRAWING_SIZE): SYSTEM_DRAWING_POINT is
		external
			"IL operator  signature (System.Drawing.Size): System.Drawing.Point use System.Drawing.Point"
		alias
			"op_Subtraction"
		end

	frozen infix "|=" (right: SYSTEM_DRAWING_POINT): BOOLEAN is
		external
			"IL operator  signature (System.Drawing.Point): System.Boolean use System.Drawing.Point"
		alias
			"op_Inequality"
		end

	frozen infix "+" (sz: SYSTEM_DRAWING_SIZE): SYSTEM_DRAWING_POINT is
		external
			"IL operator  signature (System.Drawing.Size): System.Drawing.Point use System.Drawing.Point"
		alias
			"op_Addition"
		end

	frozen infix "#==" (right: SYSTEM_DRAWING_POINT): BOOLEAN is
		external
			"IL operator  signature (System.Drawing.Point): System.Boolean use System.Drawing.Point"
		alias
			"op_Equality"
		end

feature -- Specials

	frozen op_implicit (p: SYSTEM_DRAWING_POINT): SYSTEM_DRAWING_POINTF is
		external
			"IL static signature (System.Drawing.Point): System.Drawing.PointF use System.Drawing.Point"
		alias
			"op_Implicit"
		end

	frozen op_explicit (p: SYSTEM_DRAWING_POINT): SYSTEM_DRAWING_SIZE is
		external
			"IL static signature (System.Drawing.Point): System.Drawing.Size use System.Drawing.Point"
		alias
			"op_Explicit"
		end

end -- class SYSTEM_DRAWING_POINT
