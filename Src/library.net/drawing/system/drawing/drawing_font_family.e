indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.FontFamily"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_FONT_FAMILY

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDISPOSABLE

create
	make_drawing_font_family_2,
	make_drawing_font_family,
	make_drawing_font_family_1

feature {NONE} -- Initialization

	frozen make_drawing_font_family_2 (generic_family: DRAWING_GENERIC_FONT_FAMILIES) is
		external
			"IL creator signature (System.Drawing.Text.GenericFontFamilies) use System.Drawing.FontFamily"
		end

	frozen make_drawing_font_family (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Drawing.FontFamily"
		end

	frozen make_drawing_font_family_1 (name: SYSTEM_STRING; font_collection: DRAWING_FONT_COLLECTION) is
		external
			"IL creator signature (System.String, System.Drawing.Text.FontCollection) use System.Drawing.FontFamily"
		end

feature -- Access

	frozen get_generic_serif: DRAWING_FONT_FAMILY is
		external
			"IL static signature (): System.Drawing.FontFamily use System.Drawing.FontFamily"
		alias
			"get_GenericSerif"
		end

	frozen get_generic_sans_serif: DRAWING_FONT_FAMILY is
		external
			"IL static signature (): System.Drawing.FontFamily use System.Drawing.FontFamily"
		alias
			"get_GenericSansSerif"
		end

	frozen get_families: NATIVE_ARRAY [DRAWING_FONT_FAMILY] is
		external
			"IL static signature (): System.Drawing.FontFamily[] use System.Drawing.FontFamily"
		alias
			"get_Families"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.FontFamily"
		alias
			"get_Name"
		end

	frozen get_generic_monospace: DRAWING_FONT_FAMILY is
		external
			"IL static signature (): System.Drawing.FontFamily use System.Drawing.FontFamily"
		alias
			"get_GenericMonospace"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.FontFamily"
		alias
			"ToString"
		end

	frozen get_families_graphics (graphics: DRAWING_GRAPHICS): NATIVE_ARRAY [DRAWING_FONT_FAMILY] is
		external
			"IL static signature (System.Drawing.Graphics): System.Drawing.FontFamily[] use System.Drawing.FontFamily"
		alias
			"GetFamilies"
		end

	frozen is_style_available (style: DRAWING_FONT_STYLE): BOOLEAN is
		external
			"IL signature (System.Drawing.FontStyle): System.Boolean use System.Drawing.FontFamily"
		alias
			"IsStyleAvailable"
		end

	frozen get_cell_ascent (style: DRAWING_FONT_STYLE): INTEGER is
		external
			"IL signature (System.Drawing.FontStyle): System.Int32 use System.Drawing.FontFamily"
		alias
			"GetCellAscent"
		end

	frozen get_em_height (style: DRAWING_FONT_STYLE): INTEGER is
		external
			"IL signature (System.Drawing.FontStyle): System.Int32 use System.Drawing.FontFamily"
		alias
			"GetEmHeight"
		end

	frozen get_name_int32 (language: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Drawing.FontFamily"
		alias
			"GetName"
		end

	frozen get_line_spacing (style: DRAWING_FONT_STYLE): INTEGER is
		external
			"IL signature (System.Drawing.FontStyle): System.Int32 use System.Drawing.FontFamily"
		alias
			"GetLineSpacing"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.FontFamily"
		alias
			"Equals"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.FontFamily"
		alias
			"Dispose"
		end

	frozen get_cell_descent (style: DRAWING_FONT_STYLE): INTEGER is
		external
			"IL signature (System.Drawing.FontStyle): System.Int32 use System.Drawing.FontFamily"
		alias
			"GetCellDescent"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.FontFamily"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.FontFamily"
		alias
			"Finalize"
		end

end -- class DRAWING_FONT_FAMILY
