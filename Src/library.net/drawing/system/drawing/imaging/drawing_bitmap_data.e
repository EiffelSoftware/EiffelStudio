indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.BitmapData"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_BITMAP_DATA

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Imaging.BitmapData"
		end

feature -- Access

	frozen get_reserved: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.BitmapData"
		alias
			"get_Reserved"
		end

	frozen get_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.BitmapData"
		alias
			"get_Height"
		end

	frozen get_stride: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.BitmapData"
		alias
			"get_Stride"
		end

	frozen get_scan0: POINTER is
		external
			"IL signature (): System.IntPtr use System.Drawing.Imaging.BitmapData"
		alias
			"get_Scan0"
		end

	frozen get_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.BitmapData"
		alias
			"get_Width"
		end

	frozen get_pixel_format: DRAWING_PIXEL_FORMAT is
		external
			"IL signature (): System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.BitmapData"
		alias
			"get_PixelFormat"
		end

feature -- Element Change

	frozen set_height (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Imaging.BitmapData"
		alias
			"set_Height"
		end

	frozen set_stride (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Imaging.BitmapData"
		alias
			"set_Stride"
		end

	frozen set_pixel_format (value: DRAWING_PIXEL_FORMAT) is
		external
			"IL signature (System.Drawing.Imaging.PixelFormat): System.Void use System.Drawing.Imaging.BitmapData"
		alias
			"set_PixelFormat"
		end

	frozen set_reserved (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Imaging.BitmapData"
		alias
			"set_Reserved"
		end

	frozen set_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Imaging.BitmapData"
		alias
			"set_Width"
		end

	frozen set_scan0 (value: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Drawing.Imaging.BitmapData"
		alias
			"set_Scan0"
		end

end -- class DRAWING_BITMAP_DATA
