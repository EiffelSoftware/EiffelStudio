indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Rectangle"

frozen expanded external class
	SYSTEM_DRAWING_RECTANGLE

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end



feature -- Initialization

	frozen make_rectangle (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32) use System.Drawing.Rectangle"
		end

	frozen make_rectangle_1 (location: SYSTEM_DRAWING_POINT; size: SYSTEM_DRAWING_SIZE) is
		external
			"IL creator signature (System.Drawing.Point, System.Drawing.Size) use System.Drawing.Rectangle"
		end

feature -- Access

	frozen get_bottom: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Rectangle"
		alias
			"get_Bottom"
		end

	frozen get_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Rectangle"
		alias
			"get_Width"
		end

	frozen get_is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Rectangle"
		alias
			"get_IsEmpty"
		end

	frozen get_right: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Rectangle"
		alias
			"get_Right"
		end

	frozen get_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Rectangle"
		alias
			"get_Height"
		end

	frozen get_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Drawing.Rectangle"
		alias
			"get_Size"
		end

	frozen get_y: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Rectangle"
		alias
			"get_Y"
		end

	frozen get_x: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Rectangle"
		alias
			"get_X"
		end

	frozen get_left: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Rectangle"
		alias
			"get_Left"
		end

	frozen empty: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static_field signature :System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"Empty"
		end

	frozen get_location: SYSTEM_DRAWING_POINT is
		external
			"IL signature (): System.Drawing.Point use System.Drawing.Rectangle"
		alias
			"get_Location"
		end

	frozen get_top: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Rectangle"
		alias
			"get_Top"
		end

feature -- Element Change

	frozen set_height (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Rectangle"
		alias
			"set_Height"
		end

	frozen set_y (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Rectangle"
		alias
			"set_Y"
		end

	frozen set_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Drawing.Rectangle"
		alias
			"set_Size"
		end

	frozen set_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Rectangle"
		alias
			"set_Width"
		end

	frozen set_location (value: SYSTEM_DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Point): System.Void use System.Drawing.Rectangle"
		alias
			"set_Location"
		end

	frozen set_x (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Rectangle"
		alias
			"set_X"
		end

feature -- Basic Operations

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Rectangle"
		alias
			"Equals"
		end

	frozen intersects_with (rect: SYSTEM_DRAWING_RECTANGLE): BOOLEAN is
		external
			"IL signature (System.Drawing.Rectangle): System.Boolean use System.Drawing.Rectangle"
		alias
			"IntersectsWith"
		end

	frozen ceiling (value: SYSTEM_DRAWING_RECTANGLEF): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.RectangleF): System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"Ceiling"
		end

	frozen union (a: SYSTEM_DRAWING_RECTANGLE; b: SYSTEM_DRAWING_RECTANGLE): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.Rectangle, System.Drawing.Rectangle): System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"Union"
		end

	frozen offset_int32 (x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Drawing.Rectangle"
		alias
			"Offset"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Rectangle"
		alias
			"GetHashCode"
		end

	frozen intersect (rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Rectangle"
		alias
			"Intersect"
		end

	frozen truncate (value: SYSTEM_DRAWING_RECTANGLEF): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.RectangleF): System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"Truncate"
		end

	frozen inflate_rectangle (rect: SYSTEM_DRAWING_RECTANGLE; x: INTEGER; y: INTEGER): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.Rectangle, System.Int32, System.Int32): System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"Inflate"
		end

	frozen round (value: SYSTEM_DRAWING_RECTANGLEF): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.RectangleF): System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"Round"
		end

	frozen intersect_rectangle_rectangle (a: SYSTEM_DRAWING_RECTANGLE; b: SYSTEM_DRAWING_RECTANGLE): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.Rectangle, System.Drawing.Rectangle): System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"Intersect"
		end

	frozen contains (rect: SYSTEM_DRAWING_RECTANGLE): BOOLEAN is
		external
			"IL signature (System.Drawing.Rectangle): System.Boolean use System.Drawing.Rectangle"
		alias
			"Contains"
		end

	frozen contains_int32 (x: INTEGER; y: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32): System.Boolean use System.Drawing.Rectangle"
		alias
			"Contains"
		end

	frozen contains_point (pt: SYSTEM_DRAWING_POINT): BOOLEAN is
		external
			"IL signature (System.Drawing.Point): System.Boolean use System.Drawing.Rectangle"
		alias
			"Contains"
		end

	frozen offset (pos: SYSTEM_DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Point): System.Void use System.Drawing.Rectangle"
		alias
			"Offset"
		end

	frozen inflate_int32 (width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Drawing.Rectangle"
		alias
			"Inflate"
		end

	frozen from_ltrb (left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"FromLTRB"
		end

	frozen inflate (size: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Drawing.Rectangle"
		alias
			"Inflate"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Rectangle"
		alias
			"ToString"
		end

feature -- Binary Operators

	frozen infix "#==" (right: SYSTEM_DRAWING_RECTANGLE): BOOLEAN is
		external
			"IL operator  signature (System.Drawing.Rectangle): System.Boolean use System.Drawing.Rectangle"
		alias
			"op_Equality"
		end

	frozen infix "|=" (right: SYSTEM_DRAWING_RECTANGLE): BOOLEAN is
		external
			"IL operator  signature (System.Drawing.Rectangle): System.Boolean use System.Drawing.Rectangle"
		alias
			"op_Inequality"
		end

end -- class SYSTEM_DRAWING_RECTANGLE
