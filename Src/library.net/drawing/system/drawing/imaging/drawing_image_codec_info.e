indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.ImageCodecInfo"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_IMAGE_CODEC_INFO

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_signature_masks: NATIVE_ARRAY [NATIVE_ARRAY [INTEGER_8]] is
		external
			"IL signature (): System.Byte[][] use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_SignatureMasks"
		end

	frozen get_clsid: GUID is
		external
			"IL signature (): System.Guid use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_Clsid"
		end

	frozen get_codec_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_CodecName"
		end

	frozen get_dll_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_DllName"
		end

	frozen get_format_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_FormatDescription"
		end

	frozen get_format_id: GUID is
		external
			"IL signature (): System.Guid use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_FormatID"
		end

	frozen get_flags: DRAWING_IMAGE_CODEC_FLAGS is
		external
			"IL signature (): System.Drawing.Imaging.ImageCodecFlags use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_Flags"
		end

	frozen get_filename_extension: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_FilenameExtension"
		end

	frozen get_mime_type: SYSTEM_STRING is
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

	frozen get_signature_patterns: NATIVE_ARRAY [NATIVE_ARRAY [INTEGER_8]] is
		external
			"IL signature (): System.Byte[][] use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"get_SignaturePatterns"
		end

feature -- Element Change

	frozen set_codec_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_CodecName"
		end

	frozen set_filename_extension (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_FilenameExtension"
		end

	frozen set_dll_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_DllName"
		end

	frozen set_clsid (value: GUID) is
		external
			"IL signature (System.Guid): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_Clsid"
		end

	frozen set_mime_type (value: SYSTEM_STRING) is
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

	frozen set_signature_masks (value: NATIVE_ARRAY [NATIVE_ARRAY [INTEGER_8]]) is
		external
			"IL signature (System.Byte[][]): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_SignatureMasks"
		end

	frozen set_format_description (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_FormatDescription"
		end

	frozen set_signature_patterns (value: NATIVE_ARRAY [NATIVE_ARRAY [INTEGER_8]]) is
		external
			"IL signature (System.Byte[][]): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_SignaturePatterns"
		end

	frozen set_flags (value: DRAWING_IMAGE_CODEC_FLAGS) is
		external
			"IL signature (System.Drawing.Imaging.ImageCodecFlags): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_Flags"
		end

	frozen set_format_id (value: GUID) is
		external
			"IL signature (System.Guid): System.Void use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"set_FormatID"
		end

feature -- Basic Operations

	frozen get_image_encoders: NATIVE_ARRAY [DRAWING_IMAGE_CODEC_INFO] is
		external
			"IL static signature (): System.Drawing.Imaging.ImageCodecInfo[] use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"GetImageEncoders"
		end

	frozen get_image_decoders: NATIVE_ARRAY [DRAWING_IMAGE_CODEC_INFO] is
		external
			"IL static signature (): System.Drawing.Imaging.ImageCodecInfo[] use System.Drawing.Imaging.ImageCodecInfo"
		alias
			"GetImageDecoders"
		end

end -- class DRAWING_IMAGE_CODEC_INFO
