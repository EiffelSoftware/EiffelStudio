indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Image"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	DRAWING_IMAGE

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize
		end
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end
	ICLONEABLE
	IDISPOSABLE

feature -- Access

	frozen get_vertical_resolution: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Image"
		alias
			"get_VerticalResolution"
		end

	frozen get_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Image"
		alias
			"get_Width"
		end

	frozen get_frame_dimensions_list: NATIVE_ARRAY [GUID] is
		external
			"IL signature (): System.Guid[] use System.Drawing.Image"
		alias
			"get_FrameDimensionsList"
		end

	frozen get_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Image"
		alias
			"get_Height"
		end

	frozen get_horizontal_resolution: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Image"
		alias
			"get_HorizontalResolution"
		end

	frozen get_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Drawing.Image"
		alias
			"get_Size"
		end

	frozen get_property_id_list: NATIVE_ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Drawing.Image"
		alias
			"get_PropertyIdList"
		end

	frozen get_raw_format: DRAWING_IMAGE_FORMAT is
		external
			"IL signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Image"
		alias
			"get_RawFormat"
		end

	frozen get_pixel_format: DRAWING_PIXEL_FORMAT is
		external
			"IL signature (): System.Drawing.Imaging.PixelFormat use System.Drawing.Image"
		alias
			"get_PixelFormat"
		end

	frozen get_flags: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Image"
		alias
			"get_Flags"
		end

	frozen get_property_items: NATIVE_ARRAY [DRAWING_PROPERTY_ITEM] is
		external
			"IL signature (): System.Drawing.Imaging.PropertyItem[] use System.Drawing.Image"
		alias
			"get_PropertyItems"
		end

	frozen get_palette: DRAWING_COLOR_PALETTE is
		external
			"IL signature (): System.Drawing.Imaging.ColorPalette use System.Drawing.Image"
		alias
			"get_Palette"
		end

	frozen get_physical_dimension: DRAWING_SIZE_F is
		external
			"IL signature (): System.Drawing.SizeF use System.Drawing.Image"
		alias
			"get_PhysicalDimension"
		end

feature -- Element Change

	frozen set_palette (value: DRAWING_COLOR_PALETTE) is
		external
			"IL signature (System.Drawing.Imaging.ColorPalette): System.Void use System.Drawing.Image"
		alias
			"set_Palette"
		end

feature -- Basic Operations

	frozen get_property_item (propid: INTEGER): DRAWING_PROPERTY_ITEM is
		external
			"IL signature (System.Int32): System.Drawing.Imaging.PropertyItem use System.Drawing.Image"
		alias
			"GetPropertyItem"
		end

	frozen is_alpha_pixel_format (pixfmt: DRAWING_PIXEL_FORMAT): BOOLEAN is
		external
			"IL static signature (System.Drawing.Imaging.PixelFormat): System.Boolean use System.Drawing.Image"
		alias
			"IsAlphaPixelFormat"
		end

	frozen get_encoder_parameter_list (encoder: GUID): DRAWING_ENCODER_PARAMETERS is
		external
			"IL signature (System.Guid): System.Drawing.Imaging.EncoderParameters use System.Drawing.Image"
		alias
			"GetEncoderParameterList"
		end

	frozen get_pixel_format_size (pixfmt: DRAWING_PIXEL_FORMAT): INTEGER is
		external
			"IL static signature (System.Drawing.Imaging.PixelFormat): System.Int32 use System.Drawing.Image"
		alias
			"GetPixelFormatSize"
		end

	frozen save_add_image (image: DRAWING_IMAGE; encoder_params: DRAWING_ENCODER_PARAMETERS) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Imaging.EncoderParameters): System.Void use System.Drawing.Image"
		alias
			"SaveAdd"
		end

	frozen select_active_frame (dimension: DRAWING_FRAME_DIMENSION; frame_index: INTEGER): INTEGER is
		external
			"IL signature (System.Drawing.Imaging.FrameDimension, System.Int32): System.Int32 use System.Drawing.Image"
		alias
			"SelectActiveFrame"
		end

	frozen set_property_item (propitem: DRAWING_PROPERTY_ITEM) is
		external
			"IL signature (System.Drawing.Imaging.PropertyItem): System.Void use System.Drawing.Image"
		alias
			"SetPropertyItem"
		end

	frozen get_thumbnail_image (thumb_width: INTEGER; thumb_height: INTEGER; callback: DRAWING_GET_THUMBNAIL_IMAGE_ABORT_IN_DRAWING_IMAGE; callback_data: POINTER): DRAWING_IMAGE is
		external
			"IL signature (System.Int32, System.Int32, System.Drawing.Image+GetThumbnailImageAbort, System.IntPtr): System.Drawing.Image use System.Drawing.Image"
		alias
			"GetThumbnailImage"
		end

	frozen remove_property_item (propid: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Image"
		alias
			"RemovePropertyItem"
		end

	frozen save_string_image_format (filename: SYSTEM_STRING; format: DRAWING_IMAGE_FORMAT) is
		external
			"IL signature (System.String, System.Drawing.Imaging.ImageFormat): System.Void use System.Drawing.Image"
		alias
			"Save"
		end

	frozen save (filename: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Image"
		alias
			"Save"
		end

	frozen from_stream_stream_boolean (stream: SYSTEM_STREAM; use_embedded_color_management: BOOLEAN): DRAWING_IMAGE is
		external
			"IL static signature (System.IO.Stream, System.Boolean): System.Drawing.Image use System.Drawing.Image"
		alias
			"FromStream"
		end

	frozen is_canonical_pixel_format (pixfmt: DRAWING_PIXEL_FORMAT): BOOLEAN is
		external
			"IL static signature (System.Drawing.Imaging.PixelFormat): System.Boolean use System.Drawing.Image"
		alias
			"IsCanonicalPixelFormat"
		end

	frozen save_stream_image_format (stream: SYSTEM_STREAM; format: DRAWING_IMAGE_FORMAT) is
		external
			"IL signature (System.IO.Stream, System.Drawing.Imaging.ImageFormat): System.Void use System.Drawing.Image"
		alias
			"Save"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Image"
		alias
			"Dispose"
		end

	frozen from_file_string_boolean (filename: SYSTEM_STRING; use_embedded_color_management: BOOLEAN): DRAWING_IMAGE is
		external
			"IL static signature (System.String, System.Boolean): System.Drawing.Image use System.Drawing.Image"
		alias
			"FromFile"
		end

	frozen from_hbitmap (hbitmap: POINTER): DRAWING_BITMAP is
		external
			"IL static signature (System.IntPtr): System.Drawing.Bitmap use System.Drawing.Image"
		alias
			"FromHbitmap"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Drawing.Image"
		alias
			"Clone"
		end

	frozen rotate_flip (rotate_flip_type: DRAWING_ROTATE_FLIP_TYPE) is
		external
			"IL signature (System.Drawing.RotateFlipType): System.Void use System.Drawing.Image"
		alias
			"RotateFlip"
		end

	frozen from_hbitmap_int_ptr_int_ptr (hbitmap: POINTER; hpalette: POINTER): DRAWING_BITMAP is
		external
			"IL static signature (System.IntPtr, System.IntPtr): System.Drawing.Bitmap use System.Drawing.Image"
		alias
			"FromHbitmap"
		end

	frozen from_file (filename: SYSTEM_STRING): DRAWING_IMAGE is
		external
			"IL static signature (System.String): System.Drawing.Image use System.Drawing.Image"
		alias
			"FromFile"
		end

	frozen is_extended_pixel_format (pixfmt: DRAWING_PIXEL_FORMAT): BOOLEAN is
		external
			"IL static signature (System.Drawing.Imaging.PixelFormat): System.Boolean use System.Drawing.Image"
		alias
			"IsExtendedPixelFormat"
		end

	frozen save_string_image_codec_info_encoder_parameters (filename: SYSTEM_STRING; encoder: DRAWING_IMAGE_CODEC_INFO; encoder_params: DRAWING_ENCODER_PARAMETERS) is
		external
			"IL signature (System.String, System.Drawing.Imaging.ImageCodecInfo, System.Drawing.Imaging.EncoderParameters): System.Void use System.Drawing.Image"
		alias
			"Save"
		end

	frozen get_frame_count (dimension: DRAWING_FRAME_DIMENSION): INTEGER is
		external
			"IL signature (System.Drawing.Imaging.FrameDimension): System.Int32 use System.Drawing.Image"
		alias
			"GetFrameCount"
		end

	frozen save_add (encoder_params: DRAWING_ENCODER_PARAMETERS) is
		external
			"IL signature (System.Drawing.Imaging.EncoderParameters): System.Void use System.Drawing.Image"
		alias
			"SaveAdd"
		end

	frozen get_bounds (page_unit: DRAWING_GRAPHICS_UNIT): DRAWING_RECTANGLE_F is
		external
			"IL signature (System.Drawing.GraphicsUnit&): System.Drawing.RectangleF use System.Drawing.Image"
		alias
			"GetBounds"
		end

	frozen save_stream_image_codec_info_encoder_parameters (stream: SYSTEM_STREAM; encoder: DRAWING_IMAGE_CODEC_INFO; encoder_params: DRAWING_ENCODER_PARAMETERS) is
		external
			"IL signature (System.IO.Stream, System.Drawing.Imaging.ImageCodecInfo, System.Drawing.Imaging.EncoderParameters): System.Void use System.Drawing.Image"
		alias
			"Save"
		end

	frozen from_stream (stream: SYSTEM_STREAM): DRAWING_IMAGE is
		external
			"IL static signature (System.IO.Stream): System.Drawing.Image use System.Drawing.Image"
		alias
			"FromStream"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Drawing.Image"
		alias
			"Dispose"
		end

	frozen system_runtime_serialization_iserializable_get_object_data (si: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Drawing.Image"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Image"
		alias
			"Finalize"
		end

end -- class DRAWING_IMAGE
