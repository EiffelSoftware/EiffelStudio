indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.RectangleF"

frozen expanded external class
	SYSTEM_DRAWING_RECTANGLEF

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end



feature -- Initialization

	frozen make_rectanglef (x: REAL; y: REAL; width: REAL; height: REAL) is
		external
			"IL creator signature (System.Single, System.Single, System.Single, System.Single) use System.Drawing.RectangleF"
		end

	frozen make_rectanglef_1 (location: SYSTEM_DRAWING_POINTF; size: SYSTEM_DRAWING_SIZEF) is
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

	frozen get_size: SYSTEM_DRAWING_SIZEF is
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

	frozen empty: SYSTEM_DRAWING_RECTANGLEF is
		external
			"IL static_field signature :System.Drawing.RectangleF use System.Drawing.RectangleF"
		alias
			"Empty"
		end

	frozen get_location: SYSTEM_DRAWING_POINTF is
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

	frozen set_size (value: SYSTEM_DRAWING_SIZEF) is
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

	frozen set_location (value: SYSTEM_DRAWING_POINTF) is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.RectangleF"
		alias
			"ToString"
		end

	frozen union (a: SYSTEM_DRAWING_RECTANGLEF; b: SYSTEM_DRAWING_RECTANGLEF): SYSTEM_DRAWING_RECTANGLEF is
		external
			"IL static signature (System.Drawing.RectangleF, System.Drawing.RectangleF): System.Drawing.RectangleF use System.Drawing.RectangleF"
		alias
			"Union"
		end

	frozen intersect (rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.RectangleF"
		alias
			"Intersect"
		end

	frozen inflate (size: SYSTEM_DRAWING_SIZEF) is
		external
			"IL signature (System.Drawing.SizeF): System.Void use System.Drawing.RectangleF"
		alias
			"Inflate"
		end

	frozen contains_point_f (pt: SYSTEM_DRAWING_POINTF): BOOLEAN is
		external
			"IL signature (System.Drawing.PointF): System.Boolean use System.Drawing.RectangleF"
		alias
			"Contains"
		end

	frozen intersects_with (rect: SYSTEM_DRAWING_RECTANGLEF): BOOLEAN is
		external
			"IL signature (System.Drawing.RectangleF): System.Boolean use System.Drawing.RectangleF"
		alias
			"IntersectsWith"
		end

	frozen from_ltrb (left: REAL; top: REAL; right: REAL; bottom: REAL): SYSTEM_DRAWING_RECTANGLEF is
		external
			"IL static signature (System.Single, System.Single, System.Single, System.Single): System.Drawing.RectangleF use System.Drawing.RectangleF"
		alias
			"FromLTRB"
		end

	frozen offset_single (x: REAL; y: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.RectangleF"
		alias
			"Offset"
		end

	frozen contains (rect: SYSTEM_DRAWING_RECTANGLEF): BOOLEAN is
		external
			"IL signature (System.Drawing.RectangleF): System.Boolean use System.Drawing.RectangleF"
		alias
			"Contains"
		end

	frozen inflate_single (x: REAL; y: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.RectangleF"
		alias
			"Inflate"
		end

	frozen contains_single (x: REAL; y: REAL): BOOLEAN is
		external
			"IL signature (System.Single, System.Single): System.Boolean use System.Drawing.RectangleF"
		alias
			"Contains"
		end

	frozen inflate_rectangle_f (rect: SYSTEM_DRAWING_RECTANGLEF; x: REAL; y: REAL): SYSTEM_DRAWING_RECTANGLEF is
		external
			"IL static signature (System.Drawing.RectangleF, System.Single, System.Single): System.Drawing.RectangleF use System.Drawing.RectangleF"
		alias
			"Inflate"
		end

	frozen offset (pos: SYSTEM_DRAWING_POINTF) is
		external
			"IL signature (System.Drawing.PointF): System.Void use System.Drawing.RectangleF"
		alias
			"Offset"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.RectangleF"
		alias
			"Equals"
		end

	frozen intersect_rectangle_f_rectangle_f (a: SYSTEM_DRAWING_RECTANGLEF; b: SYSTEM_DRAWING_RECTANGLEF): SYSTEM_DRAWING_RECTANGLEF is
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

	frozen infix "#==" (right: SYSTEM_DRAWING_RECTANGLEF): BOOLEAN is
		external
			"IL operator  signature (System.Drawing.RectangleF): System.Boolean use System.Drawing.RectangleF"
		alias
			"op_Equality"
		end

	frozen infix "|=" (right: SYSTEM_DRAWING_RECTANGLEF): BOOLEAN is
		external
			"IL operator  signature (System.Drawing.RectangleF): System.Boolean use System.Drawing.RectangleF"
		alias
			"op_Inequality"
		end

feature -- Specials

	frozen op_implicit (r: SYSTEM_DRAWING_RECTANGLE): SYSTEM_DRAWING_RECTANGLEF is
		external
			"IL static signature (System.Drawing.Rectangle): System.Drawing.RectangleF use System.Drawing.RectangleF"
		alias
			"op_Implicit"
		end

end -- class SYSTEM_DRAWING_RECTANGLEF
