indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Image"

deferred external class
	SYSTEM_DRAWING_IMAGE

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize
		end
	SYSTEM_ICLONEABLE
	SYSTEM_IDISPOSABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

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

	frozen get_frame_dimensions_list: ARRAY [SYSTEM_GUID] is
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

	frozen get_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Drawing.Image"
		alias
			"get_Size"
		end

	frozen get_property_id_list: ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Drawing.Image"
		alias
			"get_PropertyIdList"
		end

	frozen get_raw_format: SYSTEM_DRAWING_IMAGING_IMAGEFORMAT is
		external
			"IL signature (): System.Drawing.Imaging.ImageFormat use System.Drawing.Image"
		alias
			"get_RawFormat"
		end

	frozen get_pixel_format: SYSTEM_DRAWING_IMAGING_PIXELFORMAT is
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

	frozen get_property_items: ARRAY [SYSTEM_DRAWING_IMAGING_PROPERTYITEM] is
		external
			"IL signature (): System.Drawing.Imaging.PropertyItem[] use System.Drawing.Image"
		alias
			"get_PropertyItems"
		end

	frozen get_palette: SYSTEM_DRAWING_IMAGING_COLORPALETTE is
		external
			"IL signature (): System.Drawing.Imaging.ColorPalette use System.Drawing.Image"
		alias
			"get_Palette"
		end

	frozen get_physical_dimension: SYSTEM_DRAWING_SIZEF is
		external
			"IL signature (): System.Drawing.SizeF use System.Drawing.Image"
		alias
			"get_PhysicalDimension"
		end

feature -- Element Change

	frozen set_palette (value: SYSTEM_DRAWING_IMAGING_COLORPALETTE) is
		external
			"IL signature (System.Drawing.Imaging.ColorPalette): System.Void use System.Drawing.Image"
		alias
			"set_Palette"
		end

feature -- Basic Operations

	frozen get_property_item (propid: INTEGER): SYSTEM_DRAWING_IMAGING_PROPERTYITEM is
		external
			"IL signature (System.Int32): System.Drawing.Imaging.PropertyItem use System.Drawing.Image"
		alias
			"GetPropertyItem"
		end

	frozen is_alpha_pixel_format (pixfmt: SYSTEM_DRAWING_IMAGING_PIXELFORMAT): BOOLEAN is
		external
			"IL static signature (System.Drawing.Imaging.PixelFormat): System.Boolean use System.Drawing.Image"
		alias
			"IsAlphaPixelFormat"
		end

	frozen get_encoder_parameter_list (encoder: SYSTEM_GUID): SYSTEM_DRAWING_IMAGING_ENCODERPARAMETERS is
		external
			"IL signature (System.Guid): System.Drawing.Imaging.EncoderParameters use System.Drawing.Image"
		alias
			"GetEncoderParameterList"
		end

	frozen get_pixel_format_size (pixfmt: SYSTEM_DRAWING_IMAGING_PIXELFORMAT): INTEGER is
		external
			"IL static signature (System.Drawing.Imaging.PixelFormat): System.Int32 use System.Drawing.Image"
		alias
			"GetPixelFormatSize"
		end

	frozen save_add_image (image: SYSTEM_DRAWING_IMAGE; encoder_params: SYSTEM_DRAWING_IMAGING_ENCODERPARAMETERS) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Imaging.EncoderParameters): System.Void use System.Drawing.Image"
		alias
			"SaveAdd"
		end

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.Drawing.Image"
		alias
			"Clone"
		end

	frozen set_property_item (propitem: SYSTEM_DRAWING_IMAGING_PROPERTYITEM) is
		external
			"IL signature (System.Drawing.Imaging.PropertyItem): System.Void use System.Drawing.Image"
		alias
			"SetPropertyItem"
		end

	frozen get_thumbnail_image (thumb_width: INTEGER; thumb_height: INTEGER; callback: GETTHUMBNAILIMAGEABORT_IN_SYSTEM_DRAWING_IMAGE; callback_data: POINTER): SYSTEM_DRAWING_IMAGE is
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

	frozen save_string_image_format (filename: STRING; format: SYSTEM_DRAWING_IMAGING_IMAGEFORMAT) is
		external
			"IL signature (System.String, System.Drawing.Imaging.ImageFormat): System.Void use System.Drawing.Image"
		alias
			"Save"
		end

	frozen save (filename: STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Image"
		alias
			"Save"
		end

	frozen from_stream_stream_boolean (stream: SYSTEM_IO_STREAM; use_embedded_color_management: BOOLEAN): SYSTEM_DRAWING_IMAGE is
		external
			"IL static signature (System.IO.Stream, System.Boolean): System.Drawing.Image use System.Drawing.Image"
		alias
			"FromStream"
		end

	frozen from_hbitmap (hbitmap: POINTER): SYSTEM_DRAWING_BITMAP is
		external
			"IL static signature (System.IntPtr): System.Drawing.Bitmap use System.Drawing.Image"
		alias
			"FromHbitmap"
		end

	frozen save_stream_image_format (stream: SYSTEM_IO_STREAM; format: SYSTEM_DRAWING_IMAGING_IMAGEFORMAT) is
		external
			"IL signature (System.IO.Stream, System.Drawing.Imaging.ImageFormat): System.Void use System.Drawing.Image"
		alias
			"Save"
		end

	dispose is
		external
			"IL signature (): System.Void use System.Drawing.Image"
		alias
			"Dispose"
		end

	frozen from_file_string_boolean (filename: STRING; use_embedded_color_management: BOOLEAN): SYSTEM_DRAWING_IMAGE is
		external
			"IL static signature (System.String, System.Boolean): System.Drawing.Image use System.Drawing.Image"
		alias
			"FromFile"
		end

	frozen select_active_frame (dimension: SYSTEM_DRAWING_IMAGING_FRAMEDIMENSION; frame_index: INTEGER): INTEGER is
		external
			"IL signature (System.Drawing.Imaging.FrameDimension, System.Int32): System.Int32 use System.Drawing.Image"
		alias
			"SelectActiveFrame"
		end

	frozen rotate_flip (rotate_flip_type: SYSTEM_DRAWING_ROTATEFLIPTYPE) is
		external
			"IL signature (System.Drawing.RotateFlipType): System.Void use System.Drawing.Image"
		alias
			"RotateFlip"
		end

	frozen from_hbitmap_int_ptr_int_ptr (hbitmap: POINTER; hpalette: POINTER): SYSTEM_DRAWING_BITMAP is
		external
			"IL static signature (System.IntPtr, System.IntPtr): System.Drawing.Bitmap use System.Drawing.Image"
		alias
			"FromHbitmap"
		end

	frozen from_file (filename: STRING): SYSTEM_DRAWING_IMAGE is
		external
			"IL static signature (System.String): System.Drawing.Image use System.Drawing.Image"
		alias
			"FromFile"
		end

	frozen is_extended_pixel_format (pixfmt: SYSTEM_DRAWING_IMAGING_PIXELFORMAT): BOOLEAN is
		external
			"IL static signature (System.Drawing.Imaging.PixelFormat): System.Boolean use System.Drawing.Image"
		alias
			"IsExtendedPixelFormat"
		end

	frozen save_string_image_codec_info_encoder_parameters (filename: STRING; encoder: SYSTEM_DRAWING_IMAGING_IMAGECODECINFO; encoder_params: SYSTEM_DRAWING_IMAGING_ENCODERPARAMETERS) is
		external
			"IL signature (System.String, System.Drawing.Imaging.ImageCodecInfo, System.Drawing.Imaging.EncoderParameters): System.Void use System.Drawing.Image"
		alias
			"Save"
		end

	frozen is_canonical_pixel_format (pixfmt: SYSTEM_DRAWING_IMAGING_PIXELFORMAT): BOOLEAN is
		external
			"IL static signature (System.Drawing.Imaging.PixelFormat): System.Boolean use System.Drawing.Image"
		alias
			"IsCanonicalPixelFormat"
		end

	frozen get_frame_count (dimension: SYSTEM_DRAWING_IMAGING_FRAMEDIMENSION): INTEGER is
		external
			"IL signature (System.Drawing.Imaging.FrameDimension): System.Int32 use System.Drawing.Image"
		alias
			"GetFrameCount"
		end

	frozen save_add (encoder_params: SYSTEM_DRAWING_IMAGING_ENCODERPARAMETERS) is
		external
			"IL signature (System.Drawing.Imaging.EncoderParameters): System.Void use System.Drawing.Image"
		alias
			"SaveAdd"
		end

	frozen get_bounds (page_unit: SYSTEM_DRAWING_GRAPHICSUNIT): SYSTEM_DRAWING_RECTANGLEF is
		external
			"IL signature (System.Drawing.GraphicsUnit&): System.Drawing.RectangleF use System.Drawing.Image"
		alias
			"GetBounds"
		end

	frozen save_stream_image_codec_info_encoder_parameters (stream: SYSTEM_IO_STREAM; encoder: SYSTEM_DRAWING_IMAGING_IMAGECODECINFO; encoder_params: SYSTEM_DRAWING_IMAGING_ENCODERPARAMETERS) is
		external
			"IL signature (System.IO.Stream, System.Drawing.Imaging.ImageCodecInfo, System.Drawing.Imaging.EncoderParameters): System.Void use System.Drawing.Image"
		alias
			"Save"
		end

	frozen from_stream (stream: SYSTEM_IO_STREAM): SYSTEM_DRAWING_IMAGE is
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

	frozen system_runtime_serialization_iserializable_get_object_data (si: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
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

end -- class SYSTEM_DRAWING_IMAGE
