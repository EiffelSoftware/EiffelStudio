indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.ImageFormat"

frozen external class
	SYSTEM_DRAWING_IMAGING_IMAGEFORMAT

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (guid: SYSTEM_GUID) is
		external
			"IL creator signature (System.Guid) use System.Drawing.Imaging.ImageFormat"
		end

feature -- Access

	frozen get_memory_bmp: SYSTEM_DRAWING_IMAGING_IMAGEFORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_MemoryBmp"
		end

	frozen get_icon: SYSTEM_DRAWING_IMAGING_IMAGEFORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Icon"
		end

	frozen get_emf: SYSTEM_DRAWING_IMAGING_IMAGEFORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Emf"
		end

	frozen get_guid: SYSTEM_GUID is
		external
			"IL signature (): System.Guid use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Guid"
		end

	frozen get_gif: SYSTEM_DRAWING_IMAGING_IMAGEFORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Gif"
		end

	frozen get_wmf: SYSTEM_DRAWING_IMAGING_IMAGEFORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Wmf"
		end

	frozen get_jpeg: SYSTEM_DRAWING_IMAGING_IMAGEFORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Jpeg"
		end

	frozen get_bmp: SYSTEM_DRAWING_IMAGING_IMAGEFORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Bmp"
		end

	frozen get_exif: SYSTEM_DRAWING_IMAGING_IMAGEFORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Exif"
		end

	frozen get_png: SYSTEM_DRAWING_IMAGING_IMAGEFORMAT is
		external
			"IL static signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Imaging.ImageFormat"
		alias
			"get_Png"
		end

	frozen get_tiff: SYSTEM_DRAWING_IMAGING_IMAGEFORMAT is
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

	equals_object (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Imaging.ImageFormat"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.ImageFormat"
		alias
			"ToString"
		end

end -- class SYSTEM_DRAWING_IMAGING_IMAGEFORMAT
