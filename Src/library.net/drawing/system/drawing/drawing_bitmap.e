indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Bitmap"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_BITMAP

inherit
	DRAWING_IMAGE
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end
	ICLONEABLE
	IDISPOSABLE

create
	make_drawing_bitmap_10,
	make_drawing_bitmap_11,
	make_drawing_bitmap_4,
	make_drawing_bitmap_5,
	make_drawing_bitmap_6,
	make_drawing_bitmap_7,
	make_drawing_bitmap_1,
	make_drawing_bitmap_2,
	make_drawing_bitmap_3,
	make_drawing_bitmap,
	make_drawing_bitmap_8,
	make_drawing_bitmap_9

feature {NONE} -- Initialization

	frozen make_drawing_bitmap_10 (original: DRAWING_IMAGE; width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.Drawing.Image, System.Int32, System.Int32) use System.Drawing.Bitmap"
		end

	frozen make_drawing_bitmap_11 (original: DRAWING_IMAGE; new_size: DRAWING_SIZE) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Size) use System.Drawing.Bitmap"
		end

	frozen make_drawing_bitmap_4 (stream: SYSTEM_STREAM; use_icm: BOOLEAN) is
		external
			"IL creator signature (System.IO.Stream, System.Boolean) use System.Drawing.Bitmap"
		end

	frozen make_drawing_bitmap_5 (width: INTEGER; height: INTEGER; stride: INTEGER; format: DRAWING_PIXEL_FORMAT; scan0: POINTER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Drawing.Imaging.PixelFormat, System.IntPtr) use System.Drawing.Bitmap"
		end

	frozen make_drawing_bitmap_6 (width: INTEGER; height: INTEGER; format: DRAWING_PIXEL_FORMAT) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Drawing.Imaging.PixelFormat) use System.Drawing.Bitmap"
		end

	frozen make_drawing_bitmap_7 (width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32) use System.Drawing.Bitmap"
		end

	frozen make_drawing_bitmap_1 (filename: SYSTEM_STRING; use_icm: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.Drawing.Bitmap"
		end

	frozen make_drawing_bitmap_2 (type: TYPE; resource: SYSTEM_STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.Drawing.Bitmap"
		end

	frozen make_drawing_bitmap_3 (stream: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Drawing.Bitmap"
		end

	frozen make_drawing_bitmap (filename: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Drawing.Bitmap"
		end

	frozen make_drawing_bitmap_8 (width: INTEGER; height: INTEGER; g: DRAWING_GRAPHICS) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Drawing.Graphics) use System.Drawing.Bitmap"
		end

	frozen make_drawing_bitmap_9 (original: DRAWING_IMAGE) is
		external
			"IL creator signature (System.Drawing.Image) use System.Drawing.Bitmap"
		end

feature -- Basic Operations

	frozen from_hicon (hicon: POINTER): DRAWING_BITMAP is
		external
			"IL static signature (System.IntPtr): System.Drawing.Bitmap use System.Drawing.Bitmap"
		alias
			"FromHicon"
		end

	frozen make_transparent_color (transparent_color: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Drawing.Bitmap"
		alias
			"MakeTransparent"
		end

	frozen lock_bits (rect: DRAWING_RECTANGLE; flags: DRAWING_IMAGE_LOCK_MODE; format: DRAWING_PIXEL_FORMAT): DRAWING_BITMAP_DATA is
		external
			"IL signature (System.Drawing.Rectangle, System.Drawing.Imaging.ImageLockMode, System.Drawing.Imaging.PixelFormat): System.Drawing.Imaging.BitmapData use System.Drawing.Bitmap"
		alias
			"LockBits"
		end

	frozen get_hbitmap: POINTER is
		external
			"IL signature (): System.IntPtr use System.Drawing.Bitmap"
		alias
			"GetHbitmap"
		end

	frozen get_hbitmap_color (background: DRAWING_COLOR): POINTER is
		external
			"IL signature (System.Drawing.Color): System.IntPtr use System.Drawing.Bitmap"
		alias
			"GetHbitmap"
		end

	frozen get_pixel (x: INTEGER; y: INTEGER): DRAWING_COLOR is
		external
			"IL signature (System.Int32, System.Int32): System.Drawing.Color use System.Drawing.Bitmap"
		alias
			"GetPixel"
		end

	frozen unlock_bits (bitmapdata: DRAWING_BITMAP_DATA) is
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

	frozen clone__rectangle_f (rect: DRAWING_RECTANGLE_F; format: DRAWING_PIXEL_FORMAT): DRAWING_BITMAP is
		external
			"IL signature (System.Drawing.RectangleF, System.Drawing.Imaging.PixelFormat): System.Drawing.Bitmap use System.Drawing.Bitmap"
		alias
			"Clone"
		end

	frozen set_pixel (x: INTEGER; y: INTEGER; color: DRAWING_COLOR) is
		external
			"IL signature (System.Int32, System.Int32, System.Drawing.Color): System.Void use System.Drawing.Bitmap"
		alias
			"SetPixel"
		end

	frozen from_resource (hinstance: POINTER; bitmap_name: SYSTEM_STRING): DRAWING_BITMAP is
		external
			"IL static signature (System.IntPtr, System.String): System.Drawing.Bitmap use System.Drawing.Bitmap"
		alias
			"FromResource"
		end

	frozen clone__rectangle (rect: DRAWING_RECTANGLE; format: DRAWING_PIXEL_FORMAT): DRAWING_BITMAP is
		external
			"IL signature (System.Drawing.Rectangle, System.Drawing.Imaging.PixelFormat): System.Drawing.Bitmap use System.Drawing.Bitmap"
		alias
			"Clone"
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

end -- class DRAWING_BITMAP
