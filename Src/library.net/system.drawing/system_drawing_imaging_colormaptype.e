indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.ColorMapType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_IMAGING_COLORMAPTYPE

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen default: SYSTEM_DRAWING_IMAGING_COLORMAPTYPE is
		external
			"IL enum signature :System.Drawing.Imaging.ColorMapType use System.Drawing.Imaging.ColorMapType"
		alias
			"0"
		end

	frozen brush: SYSTEM_DRAWING_IMAGING_COLORMAPTYPE is
		external
			"IL enum signature :System.Drawing.Imaging.ColorMapType use System.Drawing.Imaging.ColorMapType"
		alias
			"1"
		end

end -- class SYSTEM_DRAWING_IMAGING_COLORMAPTYPE
