indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Font"

frozen external class
	SYSTEM_DRAWING_FONT

inherit
	SYSTEM_MARSHALBYREFOBJECT
		rename
			is_equal as equals_object
		redefine
			finalize,
			get_hash_code,
			equals_object,
			to_string
		end
	SYSTEM_ICLONEABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_IDISPOSABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data,
			is_equal as equals_object
		end

create
	make_font_1,
	make_font,
	make_font_7,
	make_font_6,
	make_font_5,
	make_font_4,
	make_font_12,
	make_font_10,
	make_font_11,
	make_font_9,
	make_font_8,
	make_font_3,
	make_font_2

feature {NONE} -- Initialization

	frozen make_font_1 (family: SYSTEM_DRAWING_FONTFAMILY; em_size: REAL; style: SYSTEM_DRAWING_FONTSTYLE; unit: SYSTEM_DRAWING_GRAPHICSUNIT) is
		external
			"IL creator signature (System.Drawing.FontFamily, System.Single, System.Drawing.FontStyle, System.Drawing.GraphicsUnit) use System.Drawing.Font"
		end

	frozen make_font (prototype: SYSTEM_DRAWING_FONT; new_style: SYSTEM_DRAWING_FONTSTYLE) is
		external
			"IL creator signature (System.Drawing.Font, System.Drawing.FontStyle) use System.Drawing.Font"
		end

	frozen make_font_7 (family: SYSTEM_DRAWING_FONTFAMILY; em_size: REAL; unit: SYSTEM_DRAWING_GRAPHICSUNIT) is
		external
			"IL creator signature (System.Drawing.FontFamily, System.Single, System.Drawing.GraphicsUnit) use System.Drawing.Font"
		end

	frozen make_font_6 (family: SYSTEM_DRAWING_FONTFAMILY; em_size: REAL; style: SYSTEM_DRAWING_FONTSTYLE) is
		external
			"IL creator signature (System.Drawing.FontFamily, System.Single, System.Drawing.FontStyle) use System.Drawing.Font"
		end

	frozen make_font_5 (family_name: STRING; em_size: REAL; style: SYSTEM_DRAWING_FONTSTYLE; unit: SYSTEM_DRAWING_GRAPHICSUNIT; gdi_char_set: INTEGER_8; gdi_vertical_font: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Single, System.Drawing.FontStyle, System.Drawing.GraphicsUnit, System.Byte, System.Boolean) use System.Drawing.Font"
		end

	frozen make_font_4 (family_name: STRING; em_size: REAL; style: SYSTEM_DRAWING_FONTSTYLE; unit: SYSTEM_DRAWING_GRAPHICSUNIT; gdi_char_set: INTEGER_8) is
		external
			"IL creator signature (System.String, System.Single, System.Drawing.FontStyle, System.Drawing.GraphicsUnit, System.Byte) use System.Drawing.Font"
		end

	frozen make_font_12 (family_name: STRING; em_size: REAL) is
		external
			"IL creator signature (System.String, System.Single) use System.Drawing.Font"
		end

	frozen make_font_10 (family_name: STRING; em_size: REAL; style: SYSTEM_DRAWING_FONTSTYLE) is
		external
			"IL creator signature (System.String, System.Single, System.Drawing.FontStyle) use System.Drawing.Font"
		end

	frozen make_font_11 (family_name: STRING; em_size: REAL; unit: SYSTEM_DRAWING_GRAPHICSUNIT) is
		external
			"IL creator signature (System.String, System.Single, System.Drawing.GraphicsUnit) use System.Drawing.Font"
		end

	frozen make_font_9 (family_name: STRING; em_size: REAL; style: SYSTEM_DRAWING_FONTSTYLE; unit: SYSTEM_DRAWING_GRAPHICSUNIT) is
		external
			"IL creator signature (System.String, System.Single, System.Drawing.FontStyle, System.Drawing.GraphicsUnit) use System.Drawing.Font"
		end

	frozen make_font_8 (family: SYSTEM_DRAWING_FONTFAMILY; em_size: REAL) is
		external
			"IL creator signature (System.Drawing.FontFamily, System.Single) use System.Drawing.Font"
		end

	frozen make_font_3 (family: SYSTEM_DRAWING_FONTFAMILY; em_size: REAL; style: SYSTEM_DRAWING_FONTSTYLE; unit: SYSTEM_DRAWING_GRAPHICSUNIT; gdi_char_set: INTEGER_8; gdi_vertical_font: BOOLEAN) is
		external
			"IL creator signature (System.Drawing.FontFamily, System.Single, System.Drawing.FontStyle, System.Drawing.GraphicsUnit, System.Byte, System.Boolean) use System.Drawing.Font"
		end

	frozen make_font_2 (family: SYSTEM_DRAWING_FONTFAMILY; em_size: REAL; style: SYSTEM_DRAWING_FONTSTYLE; unit: SYSTEM_DRAWING_GRAPHICSUNIT; gdi_char_set: INTEGER_8) is
		external
			"IL creator signature (System.Drawing.FontFamily, System.Single, System.Drawing.FontStyle, System.Drawing.GraphicsUnit, System.Byte) use System.Drawing.Font"
		end

feature -- Access

	frozen get_size: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Font"
		alias
			"get_Size"
		end

	frozen get_name: STRING is
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

	frozen get_style: SYSTEM_DRAWING_FONTSTYLE is
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

	frozen get_font_family: SYSTEM_DRAWING_FONTFAMILY is
		external
			"IL signature (): System.Drawing.FontFamily use System.Drawing.Font"
		alias
			"get_FontFamily"
		end

	frozen get_unit: SYSTEM_DRAWING_GRAPHICSUNIT is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Font"
		alias
			"ToString"
		end

	frozen from_hdc (hdc: POINTER): SYSTEM_DRAWING_FONT is
		external
			"IL static signature (System.IntPtr): System.Drawing.Font use System.Drawing.Font"
		alias
			"FromHdc"
		end

	frozen from_log_font_object_int_ptr (lf: ANY; hdc: POINTER): SYSTEM_DRAWING_FONT is
		external
			"IL static signature (System.Object, System.IntPtr): System.Drawing.Font use System.Drawing.Font"
		alias
			"FromLogFont"
		end

	frozen get_height_single: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Font"
		alias
			"GetHeight"
		end

	frozen to_log_font_object_graphics (log_font: ANY; graphics: SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Object, System.Drawing.Graphics): System.Void use System.Drawing.Font"
		alias
			"ToLogFont"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Font"
		alias
			"Dispose"
		end

	frozen from_log_font (lf: ANY): SYSTEM_DRAWING_FONT is
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

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.Drawing.Font"
		alias
			"Clone"
		end

	frozen get_height_graphics (graphics: SYSTEM_DRAWING_GRAPHICS): REAL is
		external
			"IL signature (System.Drawing.Graphics): System.Single use System.Drawing.Font"
		alias
			"GetHeight"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Font"
		alias
			"Equals"
		end

	frozen to_log_font (log_font: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Drawing.Font"
		alias
			"ToLogFont"
		end

	frozen from_hfont (hfont: POINTER): SYSTEM_DRAWING_FONT is
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

	frozen system_runtime_serialization_iserializable_get_object_data (si: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
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

end -- class SYSTEM_DRAWING_FONT
