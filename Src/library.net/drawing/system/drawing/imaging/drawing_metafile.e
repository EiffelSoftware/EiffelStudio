indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.Metafile"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_METAFILE

inherit
	DRAWING_IMAGE
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end
	ICLONEABLE
	IDISPOSABLE

create
	make_drawing_metafile,
	make_drawing_metafile_38,
	make_drawing_metafile_37,
	make_drawing_metafile_36,
	make_drawing_metafile_35,
	make_drawing_metafile_34,
	make_drawing_metafile_33,
	make_drawing_metafile_32,
	make_drawing_metafile_31,
	make_drawing_metafile_30,
	make_drawing_metafile_28,
	make_drawing_metafile_29,
	make_drawing_metafile_26,
	make_drawing_metafile_27,
	make_drawing_metafile_24,
	make_drawing_metafile_25,
	make_drawing_metafile_22,
	make_drawing_metafile_23,
	make_drawing_metafile_20,
	make_drawing_metafile_19,
	make_drawing_metafile_18,
	make_drawing_metafile_15,
	make_drawing_metafile_14,
	make_drawing_metafile_17,
	make_drawing_metafile_16,
	make_drawing_metafile_11,
	make_drawing_metafile_10,
	make_drawing_metafile_13,
	make_drawing_metafile_12,
	make_drawing_metafile_21,
	make_drawing_metafile_8,
	make_drawing_metafile_9,
	make_drawing_metafile_4,
	make_drawing_metafile_5,
	make_drawing_metafile_6,
	make_drawing_metafile_7,
	make_drawing_metafile_1,
	make_drawing_metafile_2,
	make_drawing_metafile_3

feature {NONE} -- Initialization

	frozen make_drawing_metafile (hmetafile: POINTER; wmf_header: DRAWING_WMF_PLACEABLE_FILE_HEADER) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Imaging.WmfPlaceableFileHeader) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_38 (stream: SYSTEM_STREAM; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE; frame_unit: DRAWING_METAFILE_FRAME_UNIT; type: DRAWING_EMF_TYPE; description: SYSTEM_STRING) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_37 (stream: SYSTEM_STREAM; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE; frame_unit: DRAWING_METAFILE_FRAME_UNIT; type: DRAWING_EMF_TYPE) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_36 (stream: SYSTEM_STREAM; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE; frame_unit: DRAWING_METAFILE_FRAME_UNIT) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_35 (stream: SYSTEM_STREAM; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.Rectangle) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_34 (stream: SYSTEM_STREAM; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE_F; frame_unit: DRAWING_METAFILE_FRAME_UNIT; type: DRAWING_EMF_TYPE; description: SYSTEM_STRING) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_33 (stream: SYSTEM_STREAM; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE_F; frame_unit: DRAWING_METAFILE_FRAME_UNIT; type: DRAWING_EMF_TYPE) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_32 (stream: SYSTEM_STREAM; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE_F; frame_unit: DRAWING_METAFILE_FRAME_UNIT) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_31 (stream: SYSTEM_STREAM; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE_F) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.RectangleF) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_30 (stream: SYSTEM_STREAM; reference_hdc: POINTER; type: DRAWING_EMF_TYPE; description: SYSTEM_STRING) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_28 (stream: SYSTEM_STREAM; reference_hdc: POINTER) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_29 (stream: SYSTEM_STREAM; reference_hdc: POINTER; type: DRAWING_EMF_TYPE) is
		external
			"IL creator signature (System.IO.Stream, System.IntPtr, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_26 (file_name: SYSTEM_STRING; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE; frame_unit: DRAWING_METAFILE_FRAME_UNIT; description: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_27 (file_name: SYSTEM_STRING; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE; frame_unit: DRAWING_METAFILE_FRAME_UNIT; type: DRAWING_EMF_TYPE; description: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_24 (file_name: SYSTEM_STRING; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE; frame_unit: DRAWING_METAFILE_FRAME_UNIT) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_25 (file_name: SYSTEM_STRING; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE; frame_unit: DRAWING_METAFILE_FRAME_UNIT; type: DRAWING_EMF_TYPE) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_22 (file_name: SYSTEM_STRING; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE_F; frame_unit: DRAWING_METAFILE_FRAME_UNIT; type: DRAWING_EMF_TYPE; description: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_23 (file_name: SYSTEM_STRING; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.Rectangle) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_20 (file_name: SYSTEM_STRING; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE_F; frame_unit: DRAWING_METAFILE_FRAME_UNIT; type: DRAWING_EMF_TYPE) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_19 (file_name: SYSTEM_STRING; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE_F; frame_unit: DRAWING_METAFILE_FRAME_UNIT) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_18 (file_name: SYSTEM_STRING; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE_F) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.RectangleF) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_15 (file_name: SYSTEM_STRING; reference_hdc: POINTER) is
		external
			"IL creator signature (System.String, System.IntPtr) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_14 (reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE; frame_unit: DRAWING_METAFILE_FRAME_UNIT; type: DRAWING_EMF_TYPE; desc: SYSTEM_STRING) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_17 (file_name: SYSTEM_STRING; reference_hdc: POINTER; type: DRAWING_EMF_TYPE; description: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_16 (file_name: SYSTEM_STRING; reference_hdc: POINTER; type: DRAWING_EMF_TYPE) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_11 (reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Rectangle) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_10 (reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE_F; frame_unit: DRAWING_METAFILE_FRAME_UNIT; type: DRAWING_EMF_TYPE; description: SYSTEM_STRING) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_13 (reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE; frame_unit: DRAWING_METAFILE_FRAME_UNIT; type: DRAWING_EMF_TYPE) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_12 (reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE; frame_unit: DRAWING_METAFILE_FRAME_UNIT) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Rectangle, System.Drawing.Imaging.MetafileFrameUnit) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_21 (file_name: SYSTEM_STRING; reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE_F; frame_unit: DRAWING_METAFILE_FRAME_UNIT; desc: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_8 (reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE_F; frame_unit: DRAWING_METAFILE_FRAME_UNIT) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_9 (reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE_F; frame_unit: DRAWING_METAFILE_FRAME_UNIT; type: DRAWING_EMF_TYPE) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.RectangleF, System.Drawing.Imaging.MetafileFrameUnit, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_4 (stream: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_5 (reference_hdc: POINTER; emf_type: DRAWING_EMF_TYPE) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Imaging.EmfType) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_6 (reference_hdc: POINTER; emf_type: DRAWING_EMF_TYPE; description: SYSTEM_STRING) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Imaging.EmfType, System.String) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_7 (reference_hdc: POINTER; frame_rect: DRAWING_RECTANGLE_F) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.RectangleF) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_1 (hmetafile: POINTER; wmf_header: DRAWING_WMF_PLACEABLE_FILE_HEADER; delete_wmf: BOOLEAN) is
		external
			"IL creator signature (System.IntPtr, System.Drawing.Imaging.WmfPlaceableFileHeader, System.Boolean) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_2 (henhmetafile: POINTER; delete_emf: BOOLEAN) is
		external
			"IL creator signature (System.IntPtr, System.Boolean) use System.Drawing.Imaging.Metafile"
		end

	frozen make_drawing_metafile_3 (filename: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Drawing.Imaging.Metafile"
		end

feature -- Basic Operations

	frozen play_record (record_type: DRAWING_EMF_PLUS_RECORD_TYPE; flags: INTEGER; data_size: INTEGER; data: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Drawing.Imaging.EmfPlusRecordType, System.Int32, System.Int32, System.Byte[]): System.Void use System.Drawing.Imaging.Metafile"
		alias
			"PlayRecord"
		end

	frozen get_metafile_header_int_ptr_wmf_placeable_file_header (hmetafile: POINTER; wmf_header: DRAWING_WMF_PLACEABLE_FILE_HEADER): DRAWING_METAFILE_HEADER is
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

	frozen get_metafile_header_int_ptr (henhmetafile: POINTER): DRAWING_METAFILE_HEADER is
		external
			"IL static signature (System.IntPtr): System.Drawing.Imaging.MetafileHeader use System.Drawing.Imaging.Metafile"
		alias
			"GetMetafileHeader"
		end

	frozen get_metafile_header_stream (stream: SYSTEM_STREAM): DRAWING_METAFILE_HEADER is
		external
			"IL static signature (System.IO.Stream): System.Drawing.Imaging.MetafileHeader use System.Drawing.Imaging.Metafile"
		alias
			"GetMetafileHeader"
		end

	frozen get_metafile_header_string (file_name: SYSTEM_STRING): DRAWING_METAFILE_HEADER is
		external
			"IL static signature (System.String): System.Drawing.Imaging.MetafileHeader use System.Drawing.Imaging.Metafile"
		alias
			"GetMetafileHeader"
		end

	frozen get_metafile_header: DRAWING_METAFILE_HEADER is
		external
			"IL signature (): System.Drawing.Imaging.MetafileHeader use System.Drawing.Imaging.Metafile"
		alias
			"GetMetafileHeader"
		end

end -- class DRAWING_METAFILE
