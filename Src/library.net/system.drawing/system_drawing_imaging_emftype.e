indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.EmfType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_IMAGING_EMFTYPE

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

	frozen emf_plus_only: SYSTEM_DRAWING_IMAGING_EMFTYPE is
		external
			"IL enum signature :System.Drawing.Imaging.EmfType use System.Drawing.Imaging.EmfType"
		alias
			"4"
		end

	frozen emf_only: SYSTEM_DRAWING_IMAGING_EMFTYPE is
		external
			"IL enum signature :System.Drawing.Imaging.EmfType use System.Drawing.Imaging.EmfType"
		alias
			"3"
		end

	frozen emf_plus_dual: SYSTEM_DRAWING_IMAGING_EMFTYPE is
		external
			"IL enum signature :System.Drawing.Imaging.EmfType use System.Drawing.Imaging.EmfType"
		alias
			"5"
		end

end -- class SYSTEM_DRAWING_IMAGING_EMFTYPE
