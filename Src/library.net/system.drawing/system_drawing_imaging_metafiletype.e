indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.MetafileType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_IMAGING_METAFILETYPE

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

	frozen emf: SYSTEM_DRAWING_IMAGING_METAFILETYPE is
		external
			"IL enum signature :System.Drawing.Imaging.MetafileType use System.Drawing.Imaging.MetafileType"
		alias
			"3"
		end

	frozen emf_plus_only: SYSTEM_DRAWING_IMAGING_METAFILETYPE is
		external
			"IL enum signature :System.Drawing.Imaging.MetafileType use System.Drawing.Imaging.MetafileType"
		alias
			"4"
		end

	frozen wmf: SYSTEM_DRAWING_IMAGING_METAFILETYPE is
		external
			"IL enum signature :System.Drawing.Imaging.MetafileType use System.Drawing.Imaging.MetafileType"
		alias
			"1"
		end

	frozen invalid: SYSTEM_DRAWING_IMAGING_METAFILETYPE is
		external
			"IL enum signature :System.Drawing.Imaging.MetafileType use System.Drawing.Imaging.MetafileType"
		alias
			"0"
		end

	frozen wmf_placeable: SYSTEM_DRAWING_IMAGING_METAFILETYPE is
		external
			"IL enum signature :System.Drawing.Imaging.MetafileType use System.Drawing.Imaging.MetafileType"
		alias
			"2"
		end

	frozen emf_plus_dual: SYSTEM_DRAWING_IMAGING_METAFILETYPE is
		external
			"IL enum signature :System.Drawing.Imaging.MetafileType use System.Drawing.Imaging.MetafileType"
		alias
			"5"
		end

end -- class SYSTEM_DRAWING_IMAGING_METAFILETYPE
