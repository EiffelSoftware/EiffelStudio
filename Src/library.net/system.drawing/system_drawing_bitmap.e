indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Bitmap"

frozen external class
	SYSTEM_DRAWING_BITMAP

inherit
	SYSTEM_DRAWING_IMAGE
	SYSTEM_ICLONEABLE
	SYSTEM_IDISPOSABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_bitmap_6,
	make_bitmap_5,
	make_bitmap_4,
	make_bitmap_10,
	make_bitmap_11,
	make_bitmap_9,
	make_bitmap_8,
	make_bitmap_3,
	make_bitmap_2,
	make_bitmap_1,
	make_bitmap,
	make_bitmap_7

feature {NONE} -- Initialization

	frozen make_bitmap_6 (width: INTEGER; height: INTEGER; format: SYSTEM_DRAWING_IMAGING_PIXELFORMAT) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Drawing.Imaging.PixelFormat) use System.Drawing.Bitmap"
		end

	frozen make_bitmap_5 (width: INTEGER; height: INTEGER; stride: INTEGER; format: SYSTEM_DRAWING_IMAGING_PIXELFORMAT; scan0: POINTER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Drawing.Imaging.PixelFormat, System.IntPtr) use System.Drawing.Bitmap"
		end

	frozen make_bitmap_4 (stream: SYSTEM_IO_STREAM; use_icm: BOOLEAN) is
		external
			"IL creator signature (System.IO.Stream, System.Boolean) use System.Drawing.Bitmap"
		end

	frozen make_bitmap_10 (original: SYSTEM_DRAWING_IMAGE; width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.Drawing.Image, System.Int32, System.Int32) use System.Drawing.Bitmap"
		end

	frozen make_bitmap_11 (original: SYSTEM_DRAWING_IMAGE; new_size: SYSTEM_DRAWING_SIZE) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Size) use System.Drawing.Bitmap"
		end

	frozen make_bitmap_9 (original: SYSTEM_DRAWING_IMAGE) is
		external
			"IL creator signature (System.Drawing.Image) use System.Drawing.Bitmap"
		end

	frozen make_bitmap_8 (width: INTEGER; height: INTEGER; g: SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Drawing.Graphics) use System.Drawing.Bitmap"
		end

	frozen make_bitmap_3 (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Drawing.Bitmap"
		end

	frozen make_bitmap_2 (type: SYSTEM_TYPE; resource: STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.Drawing.Bitmap"
		end

	frozen make_bitmap_1 (filename: STRING; use_icm: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.Drawing.Bitmap"
		end

	frozen make_bitmap (filename: STRING) is
		external
			"IL creator signature (System.String) use System.Drawing.Bitmap"
		end

	frozen make_bitmap_7 (width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32) use System.Drawing.Bitmap"
		end

feature -- Basic Operations

	frozen from_hicon (hicon: POINTER): SYSTEM_DRAWING_BITMAP is
		external
			"IL static signature (System.IntPtr): System.Drawing.Bitmap use System.Drawing.Bitmap"
		alias
			"FromHicon"
		end

	frozen make_transparent_color (transparent_color: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Drawing.Bitmap"
		alias
			"MakeTransparent"
		end

	frozen clone_rectangle (rect: SYSTEM_DRAWING_RECTANGLE; format: SYSTEM_DRAWING_IMAGING_PIXELFORMAT): SYSTEM_DRAWING_BITMAP is
		external
			"IL signature (System.Drawing.Rectangle, System.Drawing.Imaging.PixelFormat): System.Drawing.Bitmap use System.Drawing.Bitmap"
		alias
			"Clone"
		end

	frozen clone_rectangle_f (rect: SYSTEM_DRAWING_RECTANGLEF; format: SYSTEM_DRAWING_IMAGING_PIXELFORMAT): SYSTEM_DRAWING_BITMAP is
		external
			"IL signature (System.Drawing.RectangleF, System.Drawing.Imaging.PixelFormat): System.Drawing.Bitmap use System.Drawing.Bitmap"
		alias
			"Clone"
		end

	frozen get_hbitmap: POINTER is
		external
			"IL signature (): System.IntPtr use System.Drawing.Bitmap"
		alias
			"GetHbitmap"
		end

	frozen get_hbitmap_color (background: SYSTEM_DRAWING_COLOR): POINTER is
		external
			"IL signature (System.Drawing.Color): System.IntPtr use System.Drawing.Bitmap"
		alias
			"GetHbitmap"
		end

	frozen get_pixel (x: INTEGER; y: INTEGER): SYSTEM_DRAWING_COLOR is
		external
			"IL signature (System.Int32, System.Int32): System.Drawing.Color use System.Drawing.Bitmap"
		alias
			"GetPixel"
		end

	frozen unlock_bits (bitmapdata: SYSTEM_DRAWING_IMAGING_BITMAPDATA) is
		external
			"IL signature (System.Drawing.Imaging.BitmapData): System.Void use System.Drawing.Bitmap"
		alias
			"UnlockBits"
		end

	frozen make_transparent is
		external
			"IL signature (): System.Void use System.Drawing.Bitmap"
		alias
			"MakeTransparent"
		end

	frozen set_pixel (x: INTEGER; y: INTEGER; color: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Int32, System.Int32, System.Drawing.Color): System.Void use System.Drawing.Bitmap"
		alias
			"SetPixel"
		end

	frozen lock_bits (rect: SYSTEM_DRAWING_RECTANGLE; flags: SYSTEM_DRAWING_IMAGING_IMAGELOCKMODE; format: SYSTEM_DRAWING_IMAGING_PIXELFORMAT): SYSTEM_DRAWING_IMAGING_BITMAPDATA is
		external
			"IL signature (System.Drawing.Rectangle, System.Drawing.Imaging.ImageLockMode, System.Drawing.Imaging.PixelFormat): System.Drawing.Imaging.BitmapData use System.Drawing.Bitmap"
		alias
			"LockBits"
		end

	frozen from_resource (hinstance: POINTER; bitmap_name: STRING): SYSTEM_DRAWING_BITMAP is
		external
			"IL static signature (System.IntPtr, System.String): System.Drawing.Bitmap use System.Drawing.Bitmap"
		alias
			"FromResource"
		end

	frozen get_hicon: POINTER is
		external
			"IL signature (): System.IntPtr use System.Drawing.Bitmap"
		alias
			"GetHicon"
		end

	frozen set_resolution (x_dpi: REAL; y_dpi: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Bitmap"
		alias
			"SetResolution"
		end

end -- class SYSTEM_DRAWING_BITMAP
