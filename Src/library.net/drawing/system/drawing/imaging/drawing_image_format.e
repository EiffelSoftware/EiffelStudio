indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.ImageFormat"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_IMAGE_FORMAT

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (guid: GUID) is
		external
			"IL creator signature (System.Guid) use System.Drawing.Imaging.ImageFormat"
		end

feature -- Access

	frozen get_memory_bmp: DRAWING_IMAGE_FORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_MemoryBmp"
		end

	frozen get_icon: DRAWING_IMAGE_FORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Icon"
		end

	frozen get_emf: DRAWING_IMAGE_FORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Emf"
		end

	frozen get_guid: GUID is
		external
			"IL signature (): System.Guid use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Guid"
		end

	frozen get_gif: DRAWING_IMAGE_FORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Gif"
		end

	frozen get_wmf: DRAWING_IMAGE_FORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Wmf"
		end

	frozen get_jpeg: DRAWING_IMAGE_FORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Jpeg"
		end

	frozen get_bmp: DRAWING_IMAGE_FORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Bmp"
		end

	frozen get_exif: DRAWING_IMAGE_FORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Exif"
		end

	frozen get_png: DRAWING_IMAGE_FORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Png"
		end

	frozen get_tiff: DRAWING_IMAGE_FORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Tiff"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.ImageFormat"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.ImageFormat"
		alias
			"ToString"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Imaging.ImageFormat"
		alias
			"Equals"
		end

end -- class DRAWING_IMAGE_FORMAT
