indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.ColorMatrixFlag"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_IMAGING_COLORMATRIXFLAG

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

	frozen default: SYSTEM_DRAWING_IMAGING_COLORMATRIXFLAG is
		external
			"IL enum signature :System.Drawing.Imaging.ColorMatrixFlag use System.Drawing.Imaging.ColorMatrixFlag"
		alias
			"0"
		end

	frozen alt_grays: SYSTEM_DRAWING_IMAGING_COLORMATRIXFLAG is
		external
			"IL enum signature :System.Drawing.Imaging.ColorMatrixFlag use System.Drawing.Imaging.ColorMatrixFlag"
		alias
			"2"
		end

	frozen skip_grays: SYSTEM_DRAWING_IMAGING_COLORMATRIXFLAG is
		external
			"IL enum signature :System.Drawing.Imaging.ColorMatrixFlag use System.Drawing.Imaging.ColorMatrixFlag"
		alias
			"1"
		end

end -- class SYSTEM_DRAWING_IMAGING_COLORMATRIXFLAG
