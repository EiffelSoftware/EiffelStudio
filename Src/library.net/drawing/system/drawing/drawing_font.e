indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Font"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_FONT

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLONEABLE
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end
	IDISPOSABLE

create
	make_drawing_font_12,
	make_drawing_font,
	make_drawing_font_4,
	make_drawing_font_5,
	make_drawing_font_6,
	make_drawing_font_7,
	make_drawing_font_1,
	make_drawing_font_2,
	make_drawing_font_3,
	make_drawing_font_8,
	make_drawing_font_9,
	make_drawing_font_11,
	make_drawing_font_10

feature {NONE} -- Initialization

	frozen make_drawing_font_12 (family_name: SYSTEM_STRING; em_size: REAL) is
		external
			"IL creator signature (System.String, System.Single) use System.Drawing.Font"
		end

	frozen make_drawing_font (prototype: DRAWING_FONT; new_style: DRAWING_FONT_STYLE) is
		external
			"IL creator signature (System.Drawing.Font, System.Drawing.FontStyle) use System.Drawing.Font"
		end

	frozen make_drawing_font_4 (family_name: SYSTEM_STRING; em_size: REAL; style: DRAWING_FONT_STYLE; unit: DRAWING_GRAPHICS_UNIT; gdi_char_set: INTEGER_8) is
		external
			"IL creator signature (System.String, System.Single, System.Drawing.FontStyle, System.Drawing.GraphicsUnit, System.Byte) use System.Drawing.Font"
		end

	frozen make_drawing_font_5 (family_name: SYSTEM_STRING; em_size: REAL; style: DRAWING_FONT_STYLE; unit: DRAWING_GRAPHICS_UNIT; gdi_char_set: INTEGER_8; gdi_vertical_font: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Single, System.Drawing.FontStyle, System.Drawing.GraphicsUnit, System.Byte, System.Boolean) use System.Drawing.Font"
		end

	frozen make_drawing_font_6 (family: DRAWING_FONT_FAMILY; em_size: REAL; style: DRAWING_FONT_STYLE) is
		external
			"IL creator signature (System.Drawing.FontFamily, System.Single, System.Drawing.FontStyle) use System.Drawing.Font"
		end

	frozen make_drawing_font_7 (family: DRAWING_FONT_FAMILY; em_size: REAL; unit: DRAWING_GRAPHICS_UNIT) is
		external
			"IL creator signature (System.Drawing.FontFamily, System.Single, System.Drawing.GraphicsUnit) use System.Drawing.Font"
		end

	frozen make_drawing_font_1 (family: DRAWING_FONT_FAMILY; em_size: REAL; style: DRAWING_FONT_STYLE; unit: DRAWING_GRAPHICS_UNIT) is
		external
			"IL creator signature (System.Drawing.FontFamily, System.Single, System.Drawing.FontStyle, System.Drawing.GraphicsUnit) use System.Drawing.Font"
		end

	frozen make_drawing_font_2 (family: DRAWING_FONT_FAMILY; em_size: REAL; style: DRAWING_FONT_STYLE; unit: DRAWING_GRAPHICS_UNIT; gdi_char_set: INTEGER_8) is
		external
			"IL creator signature (System.Drawing.FontFamily, System.Single, System.Drawing.FontStyle, System.Drawing.GraphicsUnit, System.Byte) use System.Drawing.Font"
		end

	frozen make_drawing_font_3 (family: DRAWING_FONT_FAMILY; em_size: REAL; style: DRAWING_FONT_STYLE; unit: DRAWING_GRAPHICS_UNIT; gdi_char_set: INTEGER_8; gdi_vertical_font: BOOLEAN) is
		external
			"IL creator signature (System.Drawing.FontFamily, System.Single, System.Drawing.FontStyle, System.Drawing.GraphicsUnit, System.Byte, System.Boolean) use System.Drawing.Font"
		end

	frozen make_drawing_font_8 (family: DRAWING_FONT_FAMILY; em_size: REAL) is
		external
			"IL creator signature (System.Drawing.FontFamily, System.Single) use System.Drawing.Font"
		end

	frozen make_drawing_font_9 (family_name: SYSTEM_STRING; em_size: REAL; style: DRAWING_FONT_STYLE; unit: DRAWING_GRAPHICS_UNIT) is
		external
			"IL creator signature (System.String, System.Single, System.Drawing.FontStyle, System.Drawing.GraphicsUnit) use System.Drawing.Font"
		end

	frozen make_drawing_font_11 (family_name: SYSTEM_STRING; em_size: REAL; unit: DRAWING_GRAPHICS_UNIT) is
		external
			"IL creator signature (System.String, System.Single, System.Drawing.GraphicsUnit) use System.Drawing.Font"
		end

	frozen make_drawing_font_10 (family_name: SYSTEM_STRING; em_size: REAL; style: DRAWING_FONT_STYLE) is
		external
			"IL creator signature (System.String, System.Single, System.Drawing.FontStyle) use System.Drawing.Font"
		end

feature -- Access

	frozen get_size: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Font"
		alias
			"get_Size"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Font"
		alias
			"get_Name"
		end

	frozen get_italic: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Font"
		alias
			"get_Italic"
		end

	frozen get_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Font"
		alias
			"get_Height"
		end

	frozen get_style: DRAWING_FONT_STYLE is
		external
			"IL signature (): System.Drawing.FontStyle use System.Drawing.Font"
		alias
			"get_Style"
		end

	frozen get_underline: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Font"
		alias
			"get_Underline"
		end

	frozen get_gdi_vertical_font: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Font"
		alias
			"get_GdiVerticalFont"
		end

	frozen get_gdi_char_set: INTEGER_8 is
		external
			"IL signature (): System.Byte use System.Drawing.Font"
		alias
			"get_GdiCharSet"
		end

	frozen get_bold: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Font"
		alias
			"get_Bold"
		end

	frozen get_size_in_points: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Font"
		alias
			"get_SizeInPoints"
		end

	frozen get_font_family: DRAWING_FONT_FAMILY is
		external
			"IL signature (): System.Drawing.FontFamily use System.Drawing.Font"
		alias
			"get_FontFamily"
		end

	frozen get_unit: DRAWING_GRAPHICS_UNIT is
		external
			"IL signature (): System.Drawing.GraphicsUnit use System.Drawing.Font"
		alias
			"get_Unit"
		end

	frozen get_strikeout: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Font"
		alias
			"get_Strikeout"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Font"
		alias
			"ToString"
		end

	frozen to_log_font_object_graphics (log_font: SYSTEM_OBJECT; graphics: DRAWING_GRAPHICS) is
		external
			"IL signature (System.Object, System.Drawing.Graphics): System.Void use System.Drawing.Font"
		alias
			"ToLogFont"
		end

	frozen get_height_single: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Font"
		alias
			"GetHeight"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Font"
		alias
			"Dispose"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Drawing.Font"
		alias
			"Clone"
		end

	frozen from_log_font (lf: SYSTEM_OBJECT): DRAWING_FONT is
		external
			"IL static signature (System.Object): System.Drawing.Font use System.Drawing.Font"
		alias
			"FromLogFont"
		end

	frozen to_hfont: POINTER is
		external
			"IL signature (): System.IntPtr use System.Drawing.Font"
		alias
			"ToHfont"
		end

	frozen from_log_font_object_int_ptr (lf: SYSTEM_OBJECT; hdc: POINTER): DRAWING_FONT is
		external
			"IL static signature (System.Object, System.IntPtr): System.Drawing.Font use System.Drawing.Font"
		alias
			"FromLogFont"
		end

	frozen get_height_graphics (graphics: DRAWING_GRAPHICS): REAL is
		external
			"IL signature (System.Drawing.Graphics): System.Single use System.Drawing.Font"
		alias
			"GetHeight"
		end

	frozen from_hdc (hdc: POINTER): DRAWING_FONT is
		external
			"IL static signature (System.IntPtr): System.Drawing.Font use System.Drawing.Font"
		alias
			"FromHdc"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Font"
		alias
			"Equals"
		end

	frozen to_log_font (log_font: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Drawing.Font"
		alias
			"ToLogFont"
		end

	frozen from_hfont (hfont: POINTER): DRAWING_FONT is
		external
			"IL static signature (System.IntPtr): System.Drawing.Font use System.Drawing.Font"
		alias
			"FromHfont"
		end

	frozen get_height_single2 (dpi: REAL): REAL is
		external
			"IL signature (System.Single): System.Single use System.Drawing.Font"
		alias
			"GetHeight"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Font"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (si: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Drawing.Font"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Font"
		alias
			"Finalize"
		end

end -- class DRAWING_FONT
