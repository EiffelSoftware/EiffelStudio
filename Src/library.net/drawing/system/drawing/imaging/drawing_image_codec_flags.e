indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.ImageCodecFlags"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DRAWING_IMAGE_CODEC_FLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen encoder: DRAWING_IMAGE_CODEC_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"1"
		end

	frozen system: DRAWING_IMAGE_CODEC_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"131072"
		end

	frozen user: DRAWING_IMAGE_CODEC_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"262144"
		end

	frozen support_vector: DRAWING_IMAGE_CODEC_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"8"
		end

	frozen support_bitmap: DRAWING_IMAGE_CODEC_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"4"
		end

	frozen blocking_decode: DRAWING_IMAGE_CODEC_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"32"
		end

	frozen seekable_encode: DRAWING_IMAGE_CODEC_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"16"
		end

	frozen decoder: DRAWING_IMAGE_CODEC_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecFlags"
		alias
			"2"
		end

	frozen builtin: DRAWING_IMAGE_CODEC_FLAGS is
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

end -- class DRAWING_IMAGE_CODEC_FLAGS
