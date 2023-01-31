note
	description: "[
			Image functions in GDI+.
			For more information, please see:
			MSDN Image Functions:
			http://msdn.microsoft.com/en-us/library/ms534041(VS.85).aspx
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_IMAGE

inherit
	WEL_GDIP_ANY
		redefine
			destroy_item
		end

create
	default_create

create {WEL_GDIP_IMAGE}
	make_with_item

feature {NONE} -- Initialization

	make_with_item (a_item: POINTER)
			-- Creation method
		require
			not_void: a_item /= default_pointer
		do
			default_create
			item := a_item
		ensure
			set: item = a_item
		end

feature -- Command

	frozen load_image_from_file (a_file_name: READABLE_STRING_GENERAL)
			-- Redefine
		obsolete
			"Use `load_image_from_path' instead [2017-05-31]."
		do
			load_image_from_path (create {PATH}.make_from_string (a_file_name))
		end

	load_image_from_path (a_file_name: PATH)
			-- Redefine
		do
			load_image_from_file_original (a_file_name)
		end

	load_image_from_stream (a_stream: WEL_COM_ISTREAM)
			-- Load image from `a_stream'
		require
			not_void: a_stream /= Void
		local
			l_result: INTEGER_32
		do
			destroy_item
			item := c_gdip_load_image_from_stream (gdi_plus_handle, a_stream.item, $l_result)
		end

	load_image_from_raw_file (a_file: RAW_FILE)
			-- Load image from `a_file'
		require
			not_void: a_file /= Void
			ready_for_read: a_file.is_open_read
		local
			l_pointer: MANAGED_POINTER
		do
			create l_pointer.make (a_file.count)
			a_file.read_to_managed_pointer (l_pointer, 0, a_file.count)
			load_image_from_memory (l_pointer.item, l_pointer.count.as_natural_32)
		end

	load_image_from_memory (a_pointer: POINTER; a_byte_counts: NATURAL_32)
			-- Load image from `a_pointer'
		require
			valid: a_pointer /= default_pointer
		local
			l_stream: WEL_COM_ISTREAM
		do
			create l_stream.create_istream_from_memory (a_pointer, a_byte_counts)
			load_image_from_stream (l_stream)
				-- Do not wait for the GC to release memory.
			l_stream.destroy
		end

	frozen save_image_to_file (a_file_name: READABLE_STRING_GENERAL)
			-- Save data to a file.
		obsolete
			"Use `save_image_to_path' instead [2017-05-31]."
		require
			not_void: a_file_name /= Void
			exists: exists
		do
			save_image_to_path (create {PATH}.make_from_string (a_file_name))
		end

	frozen save_image_to_file_with_parameters (a_file_name: READABLE_STRING_GENERAL; a_parameters: detachable WEL_GDIP_IMAGE_ENCODER_PARAMETERS)
			-- Save data to a file with `a_parameters' options
		obsolete
			"Use `save_image_to_path_with_parameters' instead [2017-05-31]."
		require
			not_void: a_file_name /= Void
			exists: exists
		do
			save_image_to_path_with_parameters (create {PATH}.make_from_string (a_file_name), a_parameters)
		end

	frozen save_image_to_file_with_encoder (a_file_name: READABLE_STRING_GENERAL; a_format: WEL_GDIP_IMAGE_ENCODER)
			-- Save data to a file with image encoder parameter
		obsolete
			"Use `save_image_to_path_with_encoder' instead [2017-05-31]."
		require
			not_void: a_file_name /= Void
			not_void: a_format /= Void
			exists: exists
		do
			save_image_to_path_with_encoder (create {PATH}.make_from_string (a_file_name), a_format)
		end

	frozen save_image_to_file_with_encoder_and_parameters (a_file_name: READABLE_STRING_GENERAL; a_format: WEL_GDIP_IMAGE_ENCODER; a_parameters: detachable WEL_GDIP_IMAGE_ENCODER_PARAMETERS)
			-- Save data to a file with image encoder and parameters
		obsolete
			"Use `save_image_to_path_with_encoder_and_parameters' instead [2017-05-31]."
		require
			not_void: a_file_name /= Void
			not_void: a_format /= Void
			exists: exists
		do
			save_image_to_path_with_encoder_and_parameters (create {PATH}.make_from_string (a_file_name), a_format, a_parameters)
		end

	save_image_to_path (a_file_name: PATH)
			-- Save data to a file `a_file_name'.
		require
			not_void: a_file_name /= Void
			exists: exists
		local
			l_format: WEL_GDIP_IMAGE_ENCODER
		do
			l_format := format_for_save_file
			save_image_to_path_with_encoder_and_parameters (a_file_name, l_format, Void)
		end

	save_image_to_path_with_parameters (a_file_name: PATH; a_parameters: detachable WEL_GDIP_IMAGE_ENCODER_PARAMETERS)
			-- Save data to a file `a_file_name' with `a_parameters' options
		require
			not_void: a_file_name /= Void
			exists: exists
		local
			l_format: WEL_GDIP_IMAGE_ENCODER
		do
			l_format := format_for_save_file

			save_image_to_path_with_encoder_and_parameters (a_file_name, l_format, a_parameters)
		end

	save_image_to_path_with_encoder (a_file_name: PATH; a_format: WEL_GDIP_IMAGE_ENCODER)
			-- Save data to a file `a_file_name' with image encoder parameter
		require
			not_void: a_file_name /= Void
			not_void: a_format /= Void
			exists: exists
		do
			save_image_to_path_with_encoder_and_parameters (a_file_name, a_format, Void)
		end

	save_image_to_path_with_encoder_and_parameters (a_file_name: PATH; a_format: WEL_GDIP_IMAGE_ENCODER; a_parameters: detachable WEL_GDIP_IMAGE_ENCODER_PARAMETERS)
			-- Save data to a file `a_file_name' with image encoder and parameters
		require
			not_void: a_file_name /= Void
			not_void: a_format /= Void
			exists: exists
		local
			l_result: INTEGER
			l_wel_string: WEL_STRING
			l_parameters: POINTER
			l_encoder_info: detachable WEL_GDIP_IMAGE_CODEC_INFO
		do
			create l_wel_string.make_from_path (a_file_name)
			if a_parameters /= Void then
				l_parameters := a_parameters.item.item
			end
			l_encoder_info := a_format.find_encoder
			check not_void: l_encoder_info /= Void then end
			c_gdip_save_image_to_file (gdi_plus_handle, item, l_wel_string.item, l_encoder_info.cls_id.item, l_parameters, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	save_image_to_stream (a_stream: WEL_COM_ISTREAM)
			-- Save data to a file.
		require
			not_void: a_stream /= Void
			exists: exists
		local
			l_format: WEL_GDIP_IMAGE_ENCODER
		do
			l_format := format_for_save_file

			save_image_to_stream_with_encoder (a_stream, l_format)
		end

	save_image_to_stream_with_parameters (a_stream: WEL_COM_ISTREAM; a_parameters: detachable WEL_GDIP_IMAGE_ENCODER_PARAMETERS)
			-- Save data to a stream with `a_parameters' options
		require
			not_void: a_stream /= Void
			exists: exists
		local
			l_format: WEL_GDIP_IMAGE_ENCODER
		do
			l_format := format_for_save_file

			save_image_to_stream_with_encoder_and_parameters (a_stream, l_format, a_parameters)
		end

	save_image_to_stream_with_encoder (a_stream: WEL_COM_ISTREAM; a_format: WEL_GDIP_IMAGE_ENCODER)
			-- Save data to a stream with image encoder parameter
		require
			not_void: a_stream /= Void
			not_void: a_format /= Void
			exists: exists
		do
			save_image_to_stream_with_encoder_and_parameters (a_stream, a_format, Void)
		end

	save_image_to_stream_with_encoder_and_parameters (a_stream: WEL_COM_ISTREAM; a_format: WEL_GDIP_IMAGE_ENCODER; a_parameters: detachable WEL_GDIP_IMAGE_ENCODER_PARAMETERS)
			-- Save image to `a_stream'
		require
			not_void: a_stream /= Void
			not_void: a_format /= Void
			exists: exists
		local
			l_result: INTEGER
			l_parameters: POINTER
			l_encoder_info: detachable WEL_GDIP_IMAGE_CODEC_INFO
		do
			if a_parameters /= Void then
				l_parameters := a_parameters.item.item
			end
			l_encoder_info := a_format.find_encoder
			check not_void: l_encoder_info /= Void then end
			c_gdip_save_image_to_stream (gdi_plus_handle, item, a_stream.item, l_encoder_info.cls_id.item, l_parameters, $l_result)
			check l_result = {WEL_GDIP_STATUS}.ok end
		end

	save_image_to_memory: MANAGED_POINTER
			-- Save image data to result pointer
		local
			l_stream: WEL_COM_ISTREAM
			l_pointer: POINTER
			l_size: NATURAL_64
		do
			-- IStream will alloc memory itself when passing default_pointer
			create l_stream.create_istream_from_memory (l_pointer, 0)
			save_image_to_stream (l_stream)

			l_size := l_stream.stat.cb_size

			if l_size > 0 then
				Result := l_stream.read_all
			else
				check nothing_in_stream: False end
				create Result.make (0)
			end
		end

	save_image_to_raw_file (a_file: RAW_FILE)
			-- Write image data to `a_file'
		require
			not_void: a_file /= Void
			valid: a_file.is_open_write
			exists: exists
		local
			l_memory: MANAGED_POINTER
		do
			l_memory := save_image_to_memory
			a_file.start
			a_file.put_managed_pointer (l_memory, 0, l_memory.count)
		end

	clone_rectangle_pixel_format (a_rectangle: WEL_GDIP_RECT; a_format: INTEGER): WEL_GDIP_BITMAP
			-- Close Current with option `a_rectangle' and `a_format'
		require
			valid: a_rectangle /= Void and then (a_rectangle.width > 0 and a_rectangle.height > 0)
			valid: (create {WEL_GDIP_PIXEL_FORMAT}).is_valid_format (a_format)
			exists: exists
		local
			l_graphics: WEL_GDIP_GRAPHICS
			l_src_rect, l_dest_rect: WEL_RECT
		do
			create Result.make_formatted (a_rectangle.width, a_rectangle.height, a_format)
			create l_graphics.make_from_image (Result)
			create l_src_rect.make (a_rectangle.x, a_rectangle.y, a_rectangle.width, a_rectangle.height)
			create l_dest_rect.make (0, 0, a_rectangle.width, a_rectangle.height)
			l_graphics.draw_image_with_dest_rect_src_rect (Current, l_dest_rect ,l_src_rect)
		ensure
			not_void: Result /= Void
			size_correct: Result.width = a_rectangle.width and Result.height = a_rectangle.height
		end

feature -- Query

	width: INTEGER
			-- Width
		require
			exists: exists
		local
			l_result_status: INTEGER
		do
			Result := c_gdip_get_image_width (gdi_plus_handle, item, $l_result_status).to_integer_32
			check ok: l_result_status = {WEL_GDIP_STATUS}.ok end
		end

	height: INTEGER
			-- Height
		require
			exists: exists
		local
			l_result_status: INTEGER
		do
			Result := c_gdip_get_image_height (gdi_plus_handle, item, $l_result_status).to_integer_32
			check ok: l_result_status = {WEL_GDIP_STATUS}.ok end
		end

	raw_format: detachable WEL_GUID
			-- Image format guid.
		require
			exists: exists
		do
			Result := raw_format_orignal
		end

	pixel_format: INTEGER
			-- Pixel format in memory
		require
			exists: exists
		local
			l_result_status: INTEGER
		do
			Result := c_gdip_get_image_pixel_format (gdi_plus_handle, item, $l_result_status)
			check ok: l_result_status = {WEL_GDIP_STATUS}.ok end
		ensure
			valid: (create {WEL_GDIP_PIXEL_FORMAT}).is_valid_format (Result)
		end

	get_thumbnail_image (a_width, a_height: INTEGER): WEL_GDIP_IMAGE
			-- Gets a thumbnail image from this Image object
		require
			exists: exists
		local
			l_result_pointer: POINTER
			l_result_status: INTEGER
		do
			l_result_pointer := c_gdip_get_thumbnail_image (gdi_plus_handle, item, a_width, a_height, default_pointer, default_pointer, $l_result_status)
			check ok: l_result_status = {WEL_GDIP_STATUS}.ok end

			create Result.make_with_item (l_result_pointer)
		end

	all_image_encoders: ARRAYED_LIST [WEL_GDIP_IMAGE_CODEC_INFO]
			-- All image encoders.
		local
			l_size, l_num_encoders: NATURAL_32
			l_result: INTEGER
			l_all_encoders: POINTER
			l_counter: INTEGER
			l_item: WEL_GDIP_IMAGE_CODEC_INFO
		do
			c_gdip_get_image_encoders_size (gdi_plus_handle, $l_num_encoders, $l_size, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end

			from
				create l_all_encoders
				l_all_encoders := l_all_encoders.memory_alloc (l_size.to_integer_16)
				c_gdip_get_image_encoders (gdi_plus_handle, l_num_encoders, l_size, l_all_encoders, $l_result)
				check ok: l_result = {WEL_GDIP_STATUS}.ok end
				create Result.make (l_num_encoders.to_integer_16)
			until
				l_counter >= l_num_encoders.to_integer_16
			loop
				-- We don't need to free `l_all_encoders''s content, because they will be freed by WEL_GDIP_IMAGE_CODEC_INFOs.
				create l_item.share_from_pointer (l_all_encoders + {WEL_GDIP_IMAGE_CODEC_INFO}.c_size_of_image_codec_info * l_counter)
				Result.extend (l_item)
				l_counter := l_counter + 1
			end
		ensure
			not_void: Result /= Void
		end

feature -- Destory

	destroy_item
			-- Redefine
		local
			l_result: INTEGER
		do
			if item /= default_pointer then
				c_gdip_dispose_image (gdi_plus_handle, item, $l_result)
				check ok: l_result = {WEL_GDIP_STATUS}.ok end
				item := default_pointer
			end
		end

feature {WEL_GDIP_IMAGE} -- Implementation

	raw_format_orignal: WEL_GUID
			-- Image raw format. Orignal Gdi+ implmentation
		local
			l_result: INTEGER
		do
			create Result.make_empty
			c_gdip_get_image_raw_format (gdi_plus_handle, item, Result.item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	load_image_from_file_original (a_file_name: PATH)
			-- Load datas from a file. Orignal Gdi+ implementation.
		require
			not_void: a_file_name /= Void
		local
			l_wel_string: WEL_STRING
			l_result: INTEGER
		do
			destroy_item
			create l_wel_string.make_from_path (a_file_name)
			item := c_gdip_load_image_from_file (gdi_plus_handle, l_wel_string.item, $l_result)
		end

	find_format: WEL_GDIP_IMAGE_ENCODER
			-- Find image encoder.
		require
			format_recorded: raw_format /= Void
		local
			l_all_format: ARRAYED_LIST [WEL_GDIP_IMAGE_ENCODER]
			l_constants: WEL_GDIP_IMAGE_ENCODER_CONSTANTS
			l_result: detachable like find_format
		do
			from
				create l_constants
				l_all_format := l_constants.all_formats
				l_all_format.start
			until
				l_result /= Void or l_all_format.after
			loop
				if l_all_format.item.guid ~ raw_format then
					l_result := l_all_format.item
				end
				l_all_format.forth
			end
			check l_result /= Void then end
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	format_for_save_file: WEL_GDIP_IMAGE_ENCODER
			-- Find proper image encoder for saving the image to file
		local
			l_constants: WEL_GDIP_IMAGE_ENCODER_CONSTANTS
		do
			if raw_format /= Void then
				Result := find_format
			else
				-- Is memoryBMP, we use PNG for saving as defualt.
				create l_constants
				Result := l_constants.png
			end
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- C externals

	c_gdip_load_image_from_file (a_gdiplus_handle: POINTER; a_wchar_file_name: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
			-- Create a Gdi+ bitmap object name from file `a_wchar_file_name'.
			-- Pixmap format include BMP, GIF, JPEG, PNG, TIFF, and EMF.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_wchar_file_name_not_null: a_wchar_file_name /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipLoadImageFromFile = NULL;
				GpImage *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipLoadImageFromFile) {
					GdipLoadImageFromFile = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipLoadImageFromFile");
				}	
				
				if (GdipLoadImageFromFile) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GDIPCONST  WCHAR*, GpImage **)) GdipLoadImageFromFile)
								((GDIPCONST  WCHAR *) $a_wchar_file_name,
								(GpBitmap **) &l_result);
				}				
				
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_load_image_from_stream (a_gdiplus_handle: POINTER; a_stream: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
			-- Create a Gdi+ bitmap object name from `a_stream'.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_stream_not_null: a_stream /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipLoadImageFromStream = NULL;
				GpImage *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipLoadImageFromStream) {
					GdipLoadImageFromStream = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipLoadImageFromStream");
				}	
				
				if (GdipLoadImageFromStream) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (IStream *, GpImage **)) GdipLoadImageFromStream)
								((IStream *) $a_stream,
								(GpBitmap **) &l_result);
				}				
				
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_save_image_to_file (a_gdiplus_handle: POINTER; a_gdip_image: POINTER; a_wchar_file_name, a_clsid_encoder, a_encoder_params: POINTER; a_result_status: TYPED_POINTER [INTEGER])
			-- Save `a_gdip_image' to `a_wchar_file_name'
			-- Pixmap format include BMP, GIF, JPEG, PNG, TIFF, and EMF.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_wchar_file_name_not_null: a_wchar_file_name /= default_pointer
			a_clsid_encoder_not_null: a_clsid_encoder /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipSaveImageToFile = NULL;
				GpImage *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 100;
				
				if (!GdipSaveImageToFile) {
					GdipSaveImageToFile = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipSaveImageToFile");
				}	
				
				if (GdipSaveImageToFile) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *, GDIPCONST  WCHAR *, GDIPCONST CLSID *, GDIPCONST EncoderParameters *)) GdipSaveImageToFile)
								((GpImage *) $a_gdip_image,
								(GDIPCONST  WCHAR *) $a_wchar_file_name,
								(GDIPCONST CLSID*) $a_clsid_encoder,
								(GDIPCONST EncoderParameters *) $a_encoder_params);
				}				
			}
			]"
		end

	c_gdip_save_image_to_stream (a_gdiplus_handle: POINTER; a_gdip_image: POINTER; a_stream, a_clsid_encoder, a_encoder_params: POINTER; a_result_status: TYPED_POINTER [INTEGER])
			-- Save `a_gdip_image' to `a_wchar_file_name'
			-- Pixmap format include BMP, GIF, JPEG, PNG, TIFF, and EMF.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_stream_not_null: a_stream /= default_pointer
			a_clsid_encoder_not_null: a_clsid_encoder /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipSaveImageToStream = NULL;
				GpImage *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 100;
				
				if (!GdipSaveImageToStream) {
					GdipSaveImageToStream = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipSaveImageToStream");
				}	
				
				if (GdipSaveImageToStream) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *, IStream *, GDIPCONST CLSID *, GDIPCONST EncoderParameters *)) GdipSaveImageToStream)
								((GpImage *) $a_gdip_image,
								(IStream *) $a_stream,
								(GDIPCONST CLSID*) $a_clsid_encoder,
								(GDIPCONST EncoderParameters *) $a_encoder_params);
				}				
			}
			]"
		end

	c_gdip_get_image_width (a_gdiplus_handle: POINTER; a_item: POINTER; a_result_status: TYPED_POINTER [INTEGER]): NATURAL_32
			-- Width
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_item_not_null: a_item /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				static FARPROC GdipGetImageWidth = NULL;
				EIF_NATURAL_32 l_result;
				
				*(EIF_NATURAL_32 *) $a_result_status = 1;
				
				if (!GdipGetImageWidth) {
					GdipGetImageWidth = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipGetImageWidth");
				}
				if (GdipGetImageWidth) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *, UINT *)) GdipGetImageWidth)
								((GpImage *) $a_item,
								(UINT *) &l_result);
				}
				
				return l_result;
			]"
		end

	c_gdip_get_image_height (a_gdiplus_handle: POINTER; a_item: POINTER; a_result_status: TYPED_POINTER [INTEGER]): NATURAL_32
			-- Height
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_item_not_null: a_item /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipGetImageHeight = NULL;
				EIF_NATURAL_32 l_result;
				
				*(EIF_NATURAL_32 *) $a_result_status = 1;
				
				if (!GdipGetImageHeight) {
					GdipGetImageHeight = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipGetImageHeight");
				}			
				
				if (GdipGetImageHeight) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *, UINT *)) GdipGetImageHeight)
								((GpImage *) $a_item,
								(UINT *) &l_result);
				}
				return l_result;
			}
			]"
		end

	c_gdip_get_image_pixel_format (a_gdiplus_handle: POINTER; a_item: POINTER; a_result_status: TYPED_POINTER [INTEGER]): INTEGER
			-- Get pixel format information
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_item_not_null: a_item /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipGetImagePixelFormat = NULL;
				EIF_NATURAL_32 l_result;
				
				*(EIF_NATURAL_32 *) $a_result_status = 1;
				
				if (!GdipGetImagePixelFormat) {
					GdipGetImagePixelFormat = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipGetImagePixelFormat");
				}			
				
				if (GdipGetImagePixelFormat) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *, UINT *)) GdipGetImagePixelFormat)
								((GpImage *) $a_item,
								(UINT *) &l_result);
				}
				return l_result;
			}
			]"
		end

	c_gdip_dispose_image (a_gdiplus_handle: POINTER; a_image: POINTER; a_result_status: TYPED_POINTER [INTEGER])
			-- Dispose `a_image'
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_iamge_not_null: a_image /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipDisposeImage = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipDisposeImage) {
					GdipDisposeImage = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipDisposeImage");
				}			
				if (GdipDisposeImage) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *)) GdipDisposeImage)
								((GpImage *) $a_image);
				}
			}
			]"
		end

	c_gdip_get_image_encoders_size (a_gdiplus_handle: POINTER; a_num_encoders, a_size: TYPED_POINTER [NATURAL_32]; a_result_status: TYPED_POINTER [INTEGER])
			-- Get image encoders size.
			-- `a_num_encoders' and `a_size' is out paramter.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipGetImageEncodersSize = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipGetImageEncodersSize) {
					GdipGetImageEncodersSize = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipGetImageEncodersSize");
				}
				if (GdipGetImageEncodersSize) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (UINT *, UINT *)) GdipGetImageEncodersSize)
								((UINT *) $a_num_encoders,
								(UINT *) $a_size);
				}			
			}
			]"
		end

	c_gdip_get_image_encoders (a_gdiplus_handle: POINTER; a_num_encoders, a_size: NATURAL_32; a_result_pointer: POINTER; a_result_status: TYPED_POINTER [INTEGER])
			-- Get image encoders.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipGetImageEncoders = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipGetImageEncoders) {
					GdipGetImageEncoders = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipGetImageEncoders");
				}
				if (GdipGetImageEncoders) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (UINT, UINT, ImageCodecInfo *)) GdipGetImageEncoders)
								((UINT) $a_num_encoders,
								(UINT) $a_size,
								(ImageCodecInfo *) $a_result_pointer);
				}
			}
			]"
		end

	c_gdip_get_image_raw_format (a_gdiplus_handle: POINTER; a_image: POINTER; a_result_guid: POINTER; a_result_status: TYPED_POINTER [INTEGER])
			-- Get image encoders.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipGetImageRawFormat = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipGetImageRawFormat) {
					GdipGetImageRawFormat = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipGetImageRawFormat");
				}
				if (GdipGetImageRawFormat) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *, GUID *)) GdipGetImageRawFormat)
								((GpImage *) $a_image,
								(GUID *) $a_result_guid);
				}
			}
			]"
		end

	c_gdip_get_thumbnail_image (a_gdiplus_handle: POINTER; a_image: POINTER; a_width, a_height: INTEGER; a_get_thumbnail_image_abort: POINTER; a_callback_data: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
			-- Get thumbnail_image
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipGetImageThumbnail = NULL;
				GpImage *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipGetImageThumbnail) {
					GdipGetImageThumbnail = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipGetImageThumbnail");
				}
				if (GdipGetImageThumbnail) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *, UINT, UINT, GpImage **, GetThumbnailImageAbort, VOID *)) GdipGetImageThumbnail)
								((GpImage *) $a_image,
								(UINT) $a_width,
								(UINT) $a_height,			
								(GpBitmap **) &l_result,
								(GetThumbnailImageAbort) $a_get_thumbnail_image_abort,
								(VOID *) $a_callback_data);
				}
				return (EIF_POINTER) l_result;
			}
			]"
		end

feature -- Obsolete

	save_image_to_file_with_format (a_file_name: STRING; a_format: WEL_GDIP_IMAGE_FORMAT)
			-- Save data to a file with image format parameter
		obsolete
			"Use save_image_to_file_with_encoder instead [2017-05-31]."
		require
			not_void: a_file_name /= Void
			not_void: a_format /= Void
		local
			l_encoder: WEL_GDIP_IMAGE_ENCODER
		do
			create l_encoder.make (a_format.guid)
			save_image_to_file_with_encoder_and_parameters (a_file_name, l_encoder, Void)
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
