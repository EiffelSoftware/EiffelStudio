indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.ImageCodecFlags"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_IMAGING_IMAGECODECFLAGS

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

	frozen encoder: SYSTEM_DRAWING_IMAGING_IMAGECODECFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"1"
		end

	frozen system: SYSTEM_DRAWING_IMAGING_IMAGECODECFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"131072"
		end

	frozen user: SYSTEM_DRAWING_IMAGING_IMAGECODECFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"262144"
		end

	frozen support_vector: SYSTEM_DRAWING_IMAGING_IMAGECODECFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"8"
		end

	frozen support_bitmap: SYSTEM_DRAWING_IMAGING_IMAGECODECFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"4"
		end

	frozen blocking_decode: SYSTEM_DRAWING_IMAGING_IMAGECODECFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"32"
		end

	frozen seekable_encode: SYSTEM_DRAWING_IMAGING_IMAGECODECFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"16"
		end

	frozen decoder: SYSTEM_DRAWING_IMAGING_IMAGECODECFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"2"
		end

	frozen builtin: SYSTEM_DRAWING_IMAGING_IMAGECODECFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"65536"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_DRAWING_IMAGING_IMAGECODECFLAGS
