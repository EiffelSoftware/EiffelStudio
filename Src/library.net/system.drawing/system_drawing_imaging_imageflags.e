indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.ImageFlags"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_IMAGING_IMAGEFLAGS

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

	frozen has_translucent: SYSTEM_DRAWING_IMAGING_IMAGEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"4"
		end

	frozen caching: SYSTEM_DRAWING_IMAGING_IMAGEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"131072"
		end

	frozen partially_scalable: SYSTEM_DRAWING_IMAGING_IMAGEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"8"
		end

	frozen has_alpha: SYSTEM_DRAWING_IMAGING_IMAGEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"2"
		end

	frozen has_real_dpi: SYSTEM_DRAWING_IMAGING_IMAGEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"4096"
		end

	frozen color_space_gray: SYSTEM_DRAWING_IMAGING_IMAGEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"64"
		end

	frozen none: SYSTEM_DRAWING_IMAGING_IMAGEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"0"
		end

	frozen read_only: SYSTEM_DRAWING_IMAGING_IMAGEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"65536"
		end

	frozen color_space_ycck: SYSTEM_DRAWING_IMAGING_IMAGEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"256"
		end

	frozen color_space_cmyk: SYSTEM_DRAWING_IMAGING_IMAGEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"32"
		end

	frozen color_space_rgb: SYSTEM_DRAWING_IMAGING_IMAGEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"16"
		end

	frozen has_real_pixel_size: SYSTEM_DRAWING_IMAGING_IMAGEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"8192"
		end

	frozen scalable: SYSTEM_DRAWING_IMAGING_IMAGEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"1"
		end

	frozen color_space_ycbcr: SYSTEM_DRAWING_IMAGING_IMAGEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"128"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_DRAWING_IMAGING_IMAGEFLAGS
