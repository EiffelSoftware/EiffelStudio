indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.PixelFormat"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_IMAGING_PIXELFORMAT

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

	frozen format32bpp_argb: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"2498570"
		end

	frozen palpha: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"524288"
		end

	frozen max: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"15"
		end

	frozen format24bpp_rgb: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"137224"
		end

	frozen format48bpp_rgb: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"1060876"
		end

	frozen dont_care: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"0"
		end

	frozen format32bpp_rgb: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"139273"
		end

	frozen format16bpp_gray_scale: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"1052676"
		end

	frozen format16bpp_rgb555: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"135173"
		end

	frozen format32bpp_pargb: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"925707"
		end

	frozen alpha: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"262144"
		end

	frozen canonical: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"2097152"
		end

	frozen undefined: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"0"
		end

	frozen format64bpp_argb: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"3424269"
		end

	frozen gdi: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"131072"
		end

	frozen format16bpp_argb1555: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"397319"
		end

	frozen extended: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"1048576"
		end

	frozen format16bpp_rgb565: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"135174"
		end

	frozen format64bpp_pargb: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
		external
			"IL enum signature :System.Drawing.Imaging.PixelFormat use System.Drawing.Imaging.PixelFormat"
		alias
			"1851406"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_DRAWING_IMAGING_PIXELFORMAT
