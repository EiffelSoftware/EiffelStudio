indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.MetafileHeader"

frozen external class
	SYSTEM_DRAWING_IMAGING_METAFILEHEADER

create {NONE}

feature -- Access

	frozen get_emf_plus_header_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.MetafileHeader"
		alias
			"get_EmfPlusHeaderSize"
		end

	frozen get_wmf_header: SYSTEM_DRAWING_IMAGING_METAHEADER is
		external
			"IL signature (): System.Drawing.Imaging.MetaHeader use System.Drawing.Imaging.MetafileHeader"
		alias
			"get_WmfHeader"
		end

	frozen get_type_metafile_type: SYSTEM_DRAWING_IMAGING_METAFILETYPE is
		external
			"IL signature (): System.Drawing.Imaging.MetafileType use System.Drawing.Imaging.MetafileHeader"
		alias
			"get_Type"
		end

	frozen get_dpi_y: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Imaging.MetafileHeader"
		alias
			"get_DpiY"
		end

	frozen get_bounds: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Drawing.Imaging.MetafileHeader"
		alias
			"get_Bounds"
		end

	frozen get_dpi_x: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Imaging.MetafileHeader"
		alias
			"get_DpiX"
		end

	frozen get_logical_dpi_x: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.MetafileHeader"
		alias
			"get_LogicalDpiX"
		end

	frozen get_metafile_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.MetafileHeader"
		alias
			"get_MetafileSize"
		end

	frozen get_version: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.MetafileHeader"
		alias
			"get_Version"
		end

	frozen get_logical_dpi_y: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.MetafileHeader"
		alias
			"get_LogicalDpiY"
		end

feature -- Basic Operations

	frozen is_emf_plus: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Imaging.MetafileHeader"
		alias
			"IsEmfPlus"
		end

	frozen is_wmf: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Imaging.MetafileHeader"
		alias
			"IsWmf"
		end

	frozen is_emf_plus_dual: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Imaging.MetafileHeader"
		alias
			"IsEmfPlusDual"
		end

	frozen is_emf_or_emf_plus: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Imaging.MetafileHeader"
		alias
			"IsEmfOrEmfPlus"
		end

	frozen is_display: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Imaging.MetafileHeader"
		alias
			"IsDisplay"
		end

	frozen is_emf_plus_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Imaging.MetafileHeader"
		alias
			"IsEmfPlusOnly"
		end

	frozen is_emf: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Imaging.MetafileHeader"
		alias
			"IsEmf"
		end

	frozen is_wmf_placeable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Imaging.MetafileHeader"
		alias
			"IsWmfPlaceable"
		end

end -- class SYSTEM_DRAWING_IMAGING_METAFILEHEADER
