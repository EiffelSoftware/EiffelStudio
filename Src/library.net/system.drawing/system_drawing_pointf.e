indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.PointF"

frozen expanded external class
	SYSTEM_DRAWING_POINTF

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end



feature -- Initialization

	frozen make_pointf (x: REAL; y: REAL) is
		external
			"IL creator signature (System.Single, System.Single) use System.Drawing.PointF"
		end

feature -- Access

	frozen empty: SYSTEM_DRAWING_POINTF is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.PointF"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.PointF"
		alias
			"ToString"
		end

feature -- Binary Operators

	frozen infix "-" (sz: SYSTEM_DRAWING_SIZE): SYSTEM_DRAWING_POINTF is
		external
			"IL operator  signature (System.Drawing.Size): System.Drawing.PointF use System.Drawing.PointF"
		alias
			"op_Subtraction"
		end

	frozen infix "|=" (right: SYSTEM_DRAWING_POINTF): BOOLEAN is
		external
			"IL operator  signature (System.Drawing.PointF): System.Boolean use System.Drawing.PointF"
		alias
			"op_Inequality"
		end

	frozen infix "+" (sz: SYSTEM_DRAWING_SIZE): SYSTEM_DRAWING_POINTF is
		external
			"IL operator  signature (System.Drawing.Size): System.Drawing.PointF use System.Drawing.PointF"
		alias
			"op_Addition"
		end

	frozen infix "#==" (right: SYSTEM_DRAWING_POINTF): BOOLEAN is
		external
			"IL operator  signature (System.Drawing.PointF): System.Boolean use System.Drawing.PointF"
		alias
			"op_Equality"
		end

end -- class SYSTEM_DRAWING_POINTF
