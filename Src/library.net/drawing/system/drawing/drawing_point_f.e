indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.PointF"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen expanded external class
	DRAWING_POINT_F

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end

feature -- Initialization

	frozen make_drawing_point_f (x: REAL; y: REAL) is
		external
			"IL creator signature (System.Single, System.Single) use System.Drawing.PointF"
		end

feature -- Access

	frozen empty: DRAWING_POINT_F is
		external
			"IL static_field signature :System.Drawing.PointF use System.Drawing.PointF"
		alias
			"Empty"
		end

	frozen get_is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.PointF"
		alias
			"get_IsEmpty"
		end

	frozen get_y: REAL is
		external
			"IL signature (): System.Single use System.Drawing.PointF"
		alias
			"get_Y"
		end

	frozen get_x: REAL is
		external
			"IL signature (): System.Single use System.Drawing.PointF"
		alias
			"get_X"
		end

feature -- Element Change

	frozen set_y (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.PointF"
		alias
			"set_Y"
		end

	frozen set_x (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.PointF"
		alias
			"set_X"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.PointF"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.PointF"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.PointF"
		alias
			"Equals"
		end

feature -- Binary Operators

	frozen infix "-" (sz: DRAWING_SIZE): DRAWING_POINT_F is
		external
			"IL operator signature (System.Drawing.Size): System.Drawing.PointF use System.Drawing.PointF"
		alias
			"op_Subtraction"
		end

	frozen infix "|=" (right: DRAWING_POINT_F): BOOLEAN is
		external
			"IL operator signature (System.Drawing.PointF): System.Boolean use System.Drawing.PointF"
		alias
			"op_Inequality"
		end

	frozen infix "+" (sz: DRAWING_SIZE): DRAWING_POINT_F is
		external
			"IL operator signature (System.Drawing.Size): System.Drawing.PointF use System.Drawing.PointF"
		alias
			"op_Addition"
		end

	frozen infix "#==" (right: DRAWING_POINT_F): BOOLEAN is
		external
			"IL operator signature (System.Drawing.PointF): System.Boolean use System.Drawing.PointF"
		alias
			"op_Equality"
		end

end -- class DRAWING_POINT_F
