indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.FontFamily"

frozen external class
	SYSTEM_DRAWING_FONTFAMILY

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
	SYSTEM_IDISPOSABLE
		rename
			is_equal as equals_object
		end

create
	make_fontfamily,
	make_fontfamily_2,
	make_fontfamily_1

feature {NONE} -- Initialization

	frozen make_fontfamily (name: STRING) is
		external
			"IL creator signature (System.String) use System.Drawing.FontFamily"
		end

	frozen make_fontfamily_2 (generic_family: SYSTEM_DRAWING_TEXT_GENERICFONTFAMILIES) is
		external
			"IL creator signature (System.Drawing.Text.GenericFontFamilies) use System.Drawing.FontFamily"
		end

	frozen make_fontfamily_1 (name: STRING; font_collection: SYSTEM_DRAWING_TEXT_FONTCOLLECTION) is
		external
			"IL creator signature (System.String, System.Drawing.Text.FontCollection) use System.Drawing.FontFamily"
		end

feature -- Access

	frozen get_generic_serif: SYSTEM_DRAWING_FONTFAMILY is
		external
			"IL static signature (): System.Drawing.FontFamily use System.Drawing.FontFamily"
		alias
			"get_GenericSerif"
		end

	frozen get_generic_sans_serif: SYSTEM_DRAWING_FONTFAMILY is
		external
			"IL static signature (): System.Drawing.FontFamily use System.Drawing.FontFamily"
		alias
			"get_GenericSansSerif"
		end

	frozen get_families: ARRAY [SYSTEM_DRAWING_FONTFAMILY] is
		external
			"IL static signature (): System.Drawing.FontFamily[] use System.Drawing.FontFamily"
		alias
			"get_Families"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Drawing.FontFamily"
		alias
			"get_Name"
		end

	frozen get_generic_monospace: SYSTEM_DRAWING_FONTFAMILY is
		external
			"IL static signature (): System.Drawing.FontFamily use System.Drawing.FontFamily"
		alias
			"get_GenericMonospace"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.FontFamily"
		alias
			"ToString"
		end

	frozen get_families_graphics (graphics: SYSTEM_DRAWING_GRAPHICS): ARRAY [SYSTEM_DRAWING_FONTFAMILY] is
		external
			"IL static signature (System.Drawing.Graphics): System.Drawing.FontFamily[] use System.Drawing.FontFamily"
		alias
			"GetFamilies"
		end

	frozen is_style_available (style: SYSTEM_DRAWING_FONTSTYLE): BOOLEAN is
		external
			"IL signature (System.Drawing.FontStyle): System.Boolean use System.Drawing.FontFamily"
		alias
			"IsStyleAvailable"
		end

	frozen get_cell_ascent (style: SYSTEM_DRAWING_FONTSTYLE): INTEGER is
		external
			"IL signature (System.Drawing.FontStyle): System.Int32 use System.Drawing.FontFamily"
		alias
			"GetCellAscent"
		end

	frozen get_em_height (style: SYSTEM_DRAWING_FONTSTYLE): INTEGER is
		external
			"IL signature (System.Drawing.FontStyle): System.Int32 use System.Drawing.FontFamily"
		alias
			"GetEmHeight"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.FontFamily"
		alias
			"Equals"
		end

	frozen get_name_int32 (language: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Drawing.FontFamily"
		alias
			"GetName"
		end

	frozen get_line_spacing (style: SYSTEM_DRAWING_FONTSTYLE): INTEGER is
		external
			"IL signature (System.Drawing.FontStyle): System.Int32 use System.Drawing.FontFamily"
		alias
			"GetLineSpacing"
		end

	frozen get_cell_descent (style: SYSTEM_DRAWING_FONTSTYLE): INTEGER is
		external
			"IL signature (System.Drawing.FontStyle): System.Int32 use System.Drawing.FontFamily"
		alias
			"GetCellDescent"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.FontFamily"
		alias
			"Dispose"
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

end -- class SYSTEM_DRAWING_FONTFAMILY
