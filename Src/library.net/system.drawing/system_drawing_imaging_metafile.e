indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.Metafile"

frozen external class
	SYSTEM_DRAWING_IMAGING_METAFILE

inherit
	SYSTEM_DRAWING_IMAGE
	SYSTEM_ICLONEABLE
	SYSTEM_IDISPOSABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_metafile,
	make_metafile_21,
	make_metafile_31,
	make_metafile_32,
	make_metafile_12,
	make_metafile_13,
	make_metafile_10,
	make_metafile_11,
	make_metafile_16,
	make_metafile_17,
	make_metafile_14,
	make_metafile_15,
	make_metafile_18,
	make_metafile_19,
	make_metafile_20,
	make_metafile_23,
	make_metafile_22,
	make_metafile_25,
	make_metafile_24,
	make_metafile_27,
	make_metafile_26,
	make_metafile_29,
	make_metafile_28,
	make_metafile_3,
	make_metafile_2,
	make_metafile_1,
	make_metafile_7,
	make_metafile_6,
	make_metafile_5,
	make_metafile_4,
	make_metafile_30,
	make_metafile_9,
	make_metafile_8,
	make_metafile_33,
	make_metafile_34,
	make_metafile_35,
	make_metafile_36,
	make_metafile_37,
	make_metafile_38

feature {NONE} -- Initialization

	frozen make_metafile (hmetafile: POINTER; wmf_header: SYSTEM_DRAWING_IMAGING_WMFPLACEABLEFILEHEADER) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Imaging.WmfPlaceableFileHeader) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_21 (file_name: STRING; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLEF; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT; desc: STRING) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_31 (stream: SYSTEM_IO_STREAM; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.RectangleF) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_32 (stream: SYSTEM_IO_STREAM; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLEF; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_12 (reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLE; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_13 (reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLE; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT; type: SYSTEM_DRAWING_IMAGING_EMFTYPE) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_10 (reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLEF; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT; type: SYSTEM_DRAWING_IMAGING_EMFTYPE; description: STRING) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_11 (reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Rectangle) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_16 (file_name: STRING; reference_hdc: POINTER; type: SYSTEM_DRAWING_IMAGING_EMFTYPE) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_17 (file_name: STRING; reference_hdc: POINTER; type: SYSTEM_DRAWING_IMAGING_EMFTYPE; description: STRING) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_14 (reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLE; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT; type: SYSTEM_DRAWING_IMAGING_EMFTYPE; desc: STRING) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_15 (file_name: STRING; reference_hdc: POINTER) is
		external
			"IL creator signature (System.String, System.IntPtr) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_18 (file_name: STRING; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.RectangleF) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_19 (file_name: STRING; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLEF; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_20 (file_name: STRING; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLEF; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT; type: SYSTEM_DRAWING_IMAGING_EMFTYPE) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_23 (file_name: STRING; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.Rectangle) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_22 (file_name: STRING; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLEF; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT; type: SYSTEM_DRAWING_IMAGING_EMFTYPE; description: STRING) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_25 (file_name: STRING; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLE; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT; type: SYSTEM_DRAWING_IMAGING_EMFTYPE) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_24 (file_name: STRING; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLE; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_27 (file_name: STRING; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLE; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT; type: SYSTEM_DRAWING_IMAGING_EMFTYPE; description: STRING) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_26 (file_name: STRING; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLE; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT; description: STRING) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_29 (stream: SYSTEM_IO_STREAM; reference_hdc: POINTER; type: SYSTEM_DRAWING_IMAGING_EMFTYPE) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_28 (stream: SYSTEM_IO_STREAM; reference_hdc: POINTER) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_3 (filename: STRING) is
		external
			"IL creator signature (System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_2 (henhmetafile: POINTER; delete_emf: BOOLEAN) is
		external
			"IL creator signature (System.IntPtr, System.Boolean) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_1 (hmetafile: POINTER; wmf_header: SYSTEM_DRAWING_IMAGING_WMFPLACEABLEFILEHEADER; delete_wmf: BOOLEAN) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Imaging.WmfPlaceableFileHeader, System.Boolean) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_7 (reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.RectangleF) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_6 (reference_hdc: POINTER; emf_type: SYSTEM_DRAWING_IMAGING_EMFTYPE; description: STRING) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_5 (reference_hdc: POINTER; emf_type: SYSTEM_DRAWING_IMAGING_EMFTYPE) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_4 (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_30 (stream: SYSTEM_IO_STREAM; reference_hdc: POINTER; type: SYSTEM_DRAWING_IMAGING_EMFTYPE; description: STRING) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_9 (reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLEF; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT; type: SYSTEM_DRAWING_IMAGING_EMFTYPE) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_8 (reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLEF; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_33 (stream: SYSTEM_IO_STREAM; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLEF; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT; type: SYSTEM_DRAWING_IMAGING_EMFTYPE) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_34 (stream: SYSTEM_IO_STREAM; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLEF; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT; type: SYSTEM_DRAWING_IMAGING_EMFTYPE; description: STRING) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_35 (stream: SYSTEM_IO_STREAM; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.Rectangle) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_36 (stream: SYSTEM_IO_STREAM; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLE; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_37 (stream: SYSTEM_IO_STREAM; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLE; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT; type: SYSTEM_DRAWING_IMAGING_EMFTYPE) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_metafile_38 (stream: SYSTEM_IO_STREAM; reference_hdc: POINTER; frame_rect: SYSTEM_DRAWING_RECTANGLE; frame_unit: SYSTEM_DRAWING_IMAGING_METAFILEFRAMEUNIT; type: SYSTEM_DRAWING_IMAGING_EMFTYPE; description: STRING) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

feature -- Basic Operations

	frozen play_record (record_type: SYSTEM_DRAWING_IMAGING_EMFPLUSRECORDTYPE; flags: INTEGER; data_size: INTEGER; data: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Drawing.Imaging.EmfPlusRecordType, System.Int32, System.Int32, System.Byte[]): System.Void use System.Drawing.Imaging.Metafile"
		alias
			"PlayRecord"
		end

	frozen get_metafile_header_int_ptr_wmf_placeable_file_header (hmetafile: POINTER; wmf_header: SYSTEM_DRAWING_IMAGING_WMFPLACEABLEFILEHEADER): SYSTEM_DRAWING_IMAGING_METAFILEHEADER is
		external
			"IL static signature (System.IntPtr, System.Drawing.Imaging.WmfPlaceableFileHeader): System.Drawing.Imaging.MetafileHeader use System.Drawing.Imaging.Metafile"
		alias
			"GetMetafileHeader"
		end

	frozen get_henhmetafile: POINTER is
		external
			"IL signature (): System.IntPtr use System.Drawing.Imaging.Metafile"
		alias
			"GetHenhmetafile"
		end

	frozen get_metafile_header_int_ptr (henhmetafile: POINTER): SYSTEM_DRAWING_IMAGING_METAFILEHEADER is
		external
			"IL static signature (System.IntPtr): System.Drawing.Imaging.MetafileHeader use System.Drawing.Imaging.Metafile"
		alias
			"GetMetafileHeader"
		end

	frozen get_metafile_header_stream (stream: SYSTEM_IO_STREAM): SYSTEM_DRAWING_IMAGING_METAFILEHEADER is
		external
			"IL static signature (System.IO.Stream): System.Drawing.Imaging.MetafileHeader use System.Drawing.Imaging.Metafile"
		alias
			"GetMetafileHeader"
		end

	frozen get_metafile_header_string (file_name: STRING): SYSTEM_DRAWING_IMAGING_METAFILEHEADER is
		external
			"IL static signature (System.String): System.Drawing.Imaging.MetafileHeader use System.Drawing.Imaging.Metafile"
		alias
			"GetMetafileHeader"
		end

	frozen get_metafile_header: SYSTEM_DRAWING_IMAGING_METAFILEHEADER is
		external
			"IL signature (): System.Drawing.Imaging.MetafileHeader use System.Drawing.Imaging.Metafile"
		alias
			"GetMetafileHeader"
		end

end -- class SYSTEM_DRAWING_IMAGING_METAFILE
