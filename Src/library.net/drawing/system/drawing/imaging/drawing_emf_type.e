indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.EmfType"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DRAWING_EMF_TYPE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen emf_plus_only: DRAWING_EMF_TYPE is
		external
			"IL enum signature :System.Drawing.Imaging.EmfType use System.Drawing.Imaging.EmfType"
		alias
			"4"
		end

	frozen emf_only: DRAWING_EMF_TYPE is
		external
			"IL enum signature :System.Drawing.Imaging.EmfType use System.Drawing.Imaging.EmfType"
		alias
			"3"
		end

	frozen emf_plus_dual: DRAWING_EMF_TYPE is
		external
			"IL enum signature :System.Drawing.Imaging.EmfType use System.Drawing.Imaging.EmfType"
		alias
			"5"
		end

end -- class DRAWING_EMF_TYPE
