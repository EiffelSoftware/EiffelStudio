indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.RectangleF"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen expanded external class
	DRAWING_RECTANGLE_F

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end

feature -- Initialization

	frozen make_drawing_rectangle_f (x: REAL; y: REAL; width: REAL; height: REAL) is
		external
			"IL creator signature (System.Single, System.Single, System.Single, System.Single) use System.Drawing.RectangleF"
		end

	frozen make_drawing_rectangle_f_1 (location: DRAWING_POINT_F; size: DRAWING_SIZE_F) is
		external
			"IL creator signature (System.Drawing.PointF, System.Drawing.SizeF) use System.Drawing.RectangleF"
		end

feature -- Access

	frozen get_bottom: REAL is
		external
			"IL signature (): System.Single use System.Drawing.RectangleF"
		alias
			"get_Bottom"
		end

	frozen get_width: REAL is
		external
			"IL signature (): System.Single use System.Drawing.RectangleF"
		alias
			"get_Width"
		end

	frozen get_is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.RectangleF"
		alias
			"get_IsEmpty"
		end

	frozen get_right: REAL is
		external
			"IL signature (): System.Single use System.Drawing.RectangleF"
		alias
			"get_Right"
		end

	frozen get_height: REAL is
		external
			"IL signature (): System.Single use System.Drawing.RectangleF"
		alias
			"get_Height"
		end

	frozen get_size: DRAWING_SIZE_F is
		external
			"IL signature (): System.Drawing.SizeF use System.Drawing.RectangleF"
		alias
			"get_Size"
		end

	frozen get_y: REAL is
		external
			"IL signature (): System.Single use System.Drawing.RectangleF"
		alias
			"get_Y"
		end

	frozen get_x: REAL is
		external
			"IL signature (): System.Single use System.Drawing.RectangleF"
		alias
			"get_X"
		end

	frozen get_left: REAL is
		external
			"IL signature (): System.Single use System.Drawing.RectangleF"
		alias
			"get_Left"
		end

	frozen empty: DRAWING_RECTANGLE_F is
		external
			"IL static_field signature :System.Drawing.RectangleF use System.Drawing.RectangleF"
		alias
			"Empty"
		end

	frozen get_location: DRAWING_POINT_F is
		external
			"IL signature (): System.Drawing.PointF use System.Drawing.RectangleF"
		alias
			"get_Location"
		end

	frozen get_top: REAL is
		external
			"IL signature (): System.Single use System.Drawing.RectangleF"
		alias
			"get_Top"
		end

feature -- Element Change

	frozen set_height (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.RectangleF"
		alias
			"set_Height"
		end

	frozen set_y (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.RectangleF"
		alias
			"set_Y"
		end

	frozen set_size (value: DRAWING_SIZE_F) is
		external
			"IL signature (System.Drawing.SizeF): System.Void use System.Drawing.RectangleF"
		alias
			"set_Size"
		end

	frozen set_width (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.RectangleF"
		alias
			"set_Width"
		end

	frozen set_location (value: DRAWING_POINT_F) is
		external
			"IL signature (System.Drawing.PointF): System.Void use System.Drawing.RectangleF"
		alias
			"set_Location"
		end

	frozen set_x (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.RectangleF"
		alias
			"set_X"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.RectangleF"
		alias
			"ToString"
		end

	frozen union (a: DRAWING_RECTANGLE_F; b: DRAWING_RECTANGLE_F): DRAWING_RECTANGLE_F is
		external
			"IL static signature (System.Drawing.RectangleF, System.Drawing.RectangleF): System.Drawing.RectangleF use System.Drawing.RectangleF"
		alias
			"Union"
		end

	frozen intersect (rect: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.RectangleF"
		alias
			"Intersect"
		end

	frozen inflate (size: DRAWING_SIZE_F) is
		external
			"IL signature (System.Drawing.SizeF): System.Void use System.Drawing.RectangleF"
		alias
			"Inflate"
		end

	frozen contains_point_f (pt: DRAWING_POINT_F): BOOLEAN is
		external
			"IL signature (System.Drawing.PointF): System.Boolean use System.Drawing.RectangleF"
		alias
			"Contains"
		end

	frozen intersects_with (rect: DRAWING_RECTANGLE_F): BOOLEAN is
		external
			"IL signature (System.Drawing.RectangleF): System.Boolean use System.Drawing.RectangleF"
		alias
			"IntersectsWith"
		end

	frozen from_ltrb (left: REAL; top: REAL; right: REAL; bottom: REAL): DRAWING_RECTANGLE_F is
		external
			"IL static signature (System.Single, System.Single, System.Single, System.Single): System.Drawing.RectangleF use System.Drawing.RectangleF"
		alias
			"FromLTRB"
		end

	frozen contains (rect: DRAWING_RECTANGLE_F): BOOLEAN is
		external
			"IL signature (System.Drawing.RectangleF): System.Boolean use System.Drawing.RectangleF"
		alias
			"Contains"
		end

	frozen contains_single (x: REAL; y: REAL): BOOLEAN is
		external
			"IL signature (System.Single, System.Single): System.Boolean use System.Drawing.RectangleF"
		alias
			"Contains"
		end

	frozen inflate_single (x: REAL; y: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.RectangleF"
		alias
			"Inflate"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.RectangleF"
		alias
			"Equals"
		end

	frozen inflate_rectangle_f (rect: DRAWING_RECTANGLE_F; x: REAL; y: REAL): DRAWING_RECTANGLE_F is
		external
			"IL static signature (System.Drawing.RectangleF, System.Single, System.Single): System.Drawing.RectangleF use System.Drawing.RectangleF"
		alias
			"Inflate"
		end

	frozen offset (pos: DRAWING_POINT_F) is
		external
			"IL signature (System.Drawing.PointF): System.Void use System.Drawing.RectangleF"
		alias
			"Offset"
		end

	frozen offset_single (x: REAL; y: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.RectangleF"
		alias
			"Offset"
		end

	frozen intersect_rectangle_f_rectangle_f (a: DRAWING_RECTANGLE_F; b: DRAWING_RECTANGLE_F): DRAWING_RECTANGLE_F is
		external
			"IL static signature (System.Drawing.RectangleF, System.Drawing.RectangleF): System.Drawing.RectangleF use System.Drawing.RectangleF"
		alias
			"Intersect"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.RectangleF"
		alias
			"GetHashCode"
		end

feature -- Binary Operators

	frozen infix "#==" (right: DRAWING_RECTANGLE_F): BOOLEAN is
		external
			"IL operator signature (System.Drawing.RectangleF): System.Boolean use System.Drawing.RectangleF"
		alias
			"op_Equality"
		end

	frozen infix "|=" (right: DRAWING_RECTANGLE_F): BOOLEAN is
		external
			"IL operator signature (System.Drawing.RectangleF): System.Boolean use System.Drawing.RectangleF"
		alias
			"op_Inequality"
		end

feature -- Specials

	frozen op_implicit (r: DRAWING_RECTANGLE): DRAWING_RECTANGLE_F is
		external
			"IL static signature (System.Drawing.Rectangle): System.Drawing.RectangleF use System.Drawing.RectangleF"
		alias
			"op_Implicit"
		end

end -- class DRAWING_RECTANGLE_F
