indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.WmfPlaceableFileHeader"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_WMF_PLACEABLE_FILE_HEADER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Imaging.WmfPlaceableFileHeader"
		end

feature -- Access

	frozen get_key: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"get_Key"
		end

	frozen get_bbox_top: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"get_BboxTop"
		end

	frozen get_reserved: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"get_Reserved"
		end

	frozen get_bbox_left: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"get_BboxLeft"
		end

	frozen get_inch: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"get_Inch"
		end

	frozen get_bbox_bottom: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"get_BboxBottom"
		end

	frozen get_checksum: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"get_Checksum"
		end

	frozen get_bbox_right: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"get_BboxRight"
		end

	frozen get_hmf: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"get_Hmf"
		end

feature -- Element Change

	frozen set_bbox_left (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"set_BboxLeft"
		end

	frozen set_bbox_top (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"set_BboxTop"
		end

	frozen set_checksum (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"set_Checksum"
		end

	frozen set_bbox_bottom (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"set_BboxBottom"
		end

	frozen set_bbox_right (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"set_BboxRight"
		end

	frozen set_hmf (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"set_Hmf"
		end

	frozen set_inch (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"set_Inch"
		end

	frozen set_key (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"set_Key"
		end

	frozen set_reserved (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Imaging.WmfPlaceableFileHeader"
		alias
			"set_Reserved"
		end

end -- class DRAWING_WMF_PLACEABLE_FILE_HEADER
