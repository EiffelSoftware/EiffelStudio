indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.ImageFlags"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DRAWING_IMAGE_FLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen has_translucent: DRAWING_IMAGE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"4"
		end

	frozen caching: DRAWING_IMAGE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"131072"
		end

	frozen partially_scalable: DRAWING_IMAGE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"8"
		end

	frozen has_alpha: DRAWING_IMAGE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"2"
		end

	frozen has_real_dpi: DRAWING_IMAGE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"4096"
		end

	frozen color_space_gray: DRAWING_IMAGE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"64"
		end

	frozen none: DRAWING_IMAGE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"0"
		end

	frozen read_only: DRAWING_IMAGE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"65536"
		end

	frozen color_space_ycck: DRAWING_IMAGE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"256"
		end

	frozen color_space_cmyk: DRAWING_IMAGE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"32"
		end

	frozen color_space_rgb: DRAWING_IMAGE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"16"
		end

	frozen has_real_pixel_size: DRAWING_IMAGE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"8192"
		end

	frozen scalable: DRAWING_IMAGE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageFlags use System.Drawing.Imaging.ImageFlags"
		alias
			"1"
		end

	frozen color_space_ycbcr: DRAWING_IMAGE_FLAGS is
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

end -- class DRAWING_IMAGE_FLAGS
