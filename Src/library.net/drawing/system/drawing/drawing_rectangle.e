indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Rectangle"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen expanded external class
	DRAWING_RECTANGLE

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end

feature -- Initialization

	frozen make_drawing_rectangle_1 (location: DRAWING_POINT; size: DRAWING_SIZE) is
		external
			"IL creator signature (System.Drawing.Point, System.Drawing.Size) use System.Drawing.Rectangle"
		end

	frozen make_drawing_rectangle (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32) use System.Drawing.Rectangle"
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

	frozen get_size: DRAWING_SIZE is
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

	frozen empty: DRAWING_RECTANGLE is
		external
			"IL static_field signature :System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"Empty"
		end

	frozen get_location: DRAWING_POINT is
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

	frozen set_size (value: DRAWING_SIZE) is
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

	frozen set_location (value: DRAWING_POINT) is
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

	frozen union (a: DRAWING_RECTANGLE; b: DRAWING_RECTANGLE): DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.Rectangle, System.Drawing.Rectangle): System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"Union"
		end

	frozen intersects_with (rect: DRAWING_RECTANGLE): BOOLEAN is
		external
			"IL signature (System.Drawing.Rectangle): System.Boolean use System.Drawing.Rectangle"
		alias
			"IntersectsWith"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Rectangle"
		alias
			"Equals"
		end

	frozen ceiling (value: DRAWING_RECTANGLE_F): DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.RectangleF): System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"Ceiling"
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

	frozen intersect (rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Rectangle"
		alias
			"Intersect"
		end

	frozen truncate (value: DRAWING_RECTANGLE_F): DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.RectangleF): System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"Truncate"
		end

	frozen inflate_rectangle (rect: DRAWING_RECTANGLE; x: INTEGER; y: INTEGER): DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.Rectangle, System.Int32, System.Int32): System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"Inflate"
		end

	frozen round (value: DRAWING_RECTANGLE_F): DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.RectangleF): System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"Round"
		end

	frozen intersect_rectangle_rectangle (a: DRAWING_RECTANGLE; b: DRAWING_RECTANGLE): DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.Rectangle, System.Drawing.Rectangle): System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"Intersect"
		end

	frozen contains (rect: DRAWING_RECTANGLE): BOOLEAN is
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

	frozen contains_point (pt: DRAWING_POINT): BOOLEAN is
		external
			"IL signature (System.Drawing.Point): System.Boolean use System.Drawing.Rectangle"
		alias
			"Contains"
		end

	frozen offset (pos: DRAWING_POINT) is
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

	frozen from_ltrb (left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER): DRAWING_RECTANGLE is
		external
			"IL static signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Drawing.Rectangle use System.Drawing.Rectangle"
		alias
			"FromLTRB"
		end

	frozen inflate (size: DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Drawing.Rectangle"
		alias
			"Inflate"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Rectangle"
		alias
			"ToString"
		end

feature -- Binary Operators

	frozen infix "#==" (right: DRAWING_RECTANGLE): BOOLEAN is
		external
			"IL operator signature (System.Drawing.Rectangle): System.Boolean use System.Drawing.Rectangle"
		alias
			"op_Equality"
		end

	frozen infix "|=" (right: DRAWING_RECTANGLE): BOOLEAN is
		external
			"IL operator signature (System.Drawing.Rectangle): System.Boolean use System.Drawing.Rectangle"
		alias
			"op_Inequality"
		end

end -- class DRAWING_RECTANGLE
