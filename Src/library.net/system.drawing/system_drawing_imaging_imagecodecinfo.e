indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.ImageCodecInfo"

frozen external class
	SYSTEM_DRAWING_IMAGING_IMAGECODECINFO

create {NONE}

feature -- Access

	frozen get_signature_masks: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[][] use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_SignatureMasks"
		end

	frozen get_clsid: SYSTEM_GUID is
		external
			"IL signature (): System.Guid use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_Clsid"
		end

	frozen get_codec_name: STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_CodecName"
		end

	frozen get_dll_name: STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_DllName"
		end

	frozen get_format_description: STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_FormatDescription"
		end

	frozen get_format_id: SYSTEM_GUID is
		external
			"IL signature (): System.Guid use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_FormatID"
		end

	frozen get_flags: SYSTEM_DRAWING_IMAGING_IMAGECODECFLAGS is
		external
			"IL signature (): System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_Flags"
		end

	frozen get_filename_extension: STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_FilenameExtension"
		end

	frozen get_mime_type: STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_MimeType"
		end

	frozen get_version: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_Version"
		end

	frozen get_signature_patterns: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[][] use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_SignaturePatterns"
		end

feature -- Element Change

	frozen set_codec_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_CodecName"
		end

	frozen set_filename_extension (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_FilenameExtension"
		end

	frozen set_dll_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_DllName"
		end

	frozen set_clsid (value: SYSTEM_GUID) is
		external
			"IL signature (System.Guid): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_Clsid"
		end

	frozen set_mime_type (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_MimeType"
		end

	frozen set_version (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_Version"
		end

	frozen set_signature_masks (value: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[][]): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_SignatureMasks"
		end

	frozen set_format_description (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_FormatDescription"
		end

	frozen set_signature_patterns (value: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[][]): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_SignaturePatterns"
		end

	frozen set_flags (value: SYSTEM_DRAWING_IMAGING_IMAGECODECFLAGS) is
		external
			"IL signature (System.Drawing.Imaging.ImageCodecFlags): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_Flags"
		end

	frozen set_format_id (value: SYSTEM_GUID) is
		external
			"IL signature (System.Guid): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_FormatID"
		end

feature -- Basic Operations

	frozen get_image_encoders: ARRAY [SYSTEM_DRAWING_IMAGING_IMAGECODECINFO] is
		external
			"IL static signature (): System.Drawing.Imaging.ImageCodecInfo[] use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"GetImageEncoders"
		end

	frozen add_image_codec (imagecs: SYSTEM_DRAWING_IMAGING_IMAGECODECINFO) is
		external
			"IL static signature (System.Drawing.Imaging.ImageCodecInfo): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"AddImageCodec"
		end

	frozen get_image_decoders: ARRAY [SYSTEM_DRAWING_IMAGING_IMAGECODECINFO] is
		external
			"IL static signature (): System.Drawing.Imaging.ImageCodecInfo[] use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"GetImageDecoders"
		end

	frozen remove_image_codec (imagecs: SYSTEM_DRAWING_IMAGING_IMAGECODECINFO) is
		external
			"IL static signature (System.Drawing.Imaging.ImageCodecInfo): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"RemoveImageCodec"
		end

end -- class SYSTEM_DRAWING_IMAGING_IMAGECODECINFO
