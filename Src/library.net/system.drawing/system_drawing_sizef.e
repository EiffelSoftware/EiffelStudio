indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.SizeF"

frozen expanded external class
	SYSTEM_DRAWING_SIZEF

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end



feature -- Initialization

	frozen make_sizef (size: SYSTEM_DRAWING_SIZEF) is
		external
			"IL creator signature (System.Drawing.SizeF) use System.Drawing.SizeF"
		end

	frozen make_sizef_2 (width: REAL; height: REAL) is
		external
			"IL creator signature (System.Single, System.Single) use System.Drawing.SizeF"
		end

	frozen make_sizef_1 (pt: SYSTEM_DRAWING_POINTF) is
		external
			"IL creator signature (System.Drawing.PointF) use System.Drawing.SizeF"
		end

feature -- Access

	frozen empty: SYSTEM_DRAWING_SIZEF is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.SizeF"
		alias
			"Equals"
		end

	frozen to_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Drawing.SizeF"
		alias
			"ToSize"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.SizeF"
		alias
			"ToString"
		end

	frozen to_point_f: SYSTEM_DRAWING_POINTF is
		external
			"IL signature (): System.Drawing.PointF use System.Drawing.SizeF"
		alias
			"ToPointF"
		end

feature -- Binary Operators

	frozen infix "-" (sz2: SYSTEM_DRAWING_SIZEF): SYSTEM_DRAWING_SIZEF is
		external
			"IL operator  signature (System.Drawing.SizeF): System.Drawing.SizeF use System.Drawing.SizeF"
		alias
			"op_Subtraction"
		end

	frozen infix "|=" (sz2: SYSTEM_DRAWING_SIZEF): BOOLEAN is
		external
			"IL operator  signature (System.Drawing.SizeF): System.Boolean use System.Drawing.SizeF"
		alias
			"op_Inequality"
		end

	frozen infix "+" (sz2: SYSTEM_DRAWING_SIZEF): SYSTEM_DRAWING_SIZEF is
		external
			"IL operator  signature (System.Drawing.SizeF): System.Drawing.SizeF use System.Drawing.SizeF"
		alias
			"op_Addition"
		end

	frozen infix "#==" (sz2: SYSTEM_DRAWING_SIZEF): BOOLEAN is
		external
			"IL operator  signature (System.Drawing.SizeF): System.Boolean use System.Drawing.SizeF"
		alias
			"op_Equality"
		end

feature -- Specials

	frozen op_explicit (size: SYSTEM_DRAWING_SIZEF): SYSTEM_DRAWING_POINTF is
		external
			"IL static signature (System.Drawing.SizeF): System.Drawing.PointF use System.Drawing.SizeF"
		alias
			"op_Explicit"
		end

end -- class SYSTEM_DRAWING_SIZEF
