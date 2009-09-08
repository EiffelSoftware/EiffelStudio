note
	description: "Summary description for {NS_BITMAP_IMAGE_REP}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BITMAP_IMAGE_REP

inherit
	NS_IMAGE_REP

create
	make_with_data

feature -- Creating an NSBitmapImageRep Object

	make_with_data (a_data: NS_DATA)
			-- Creates and returns an `NSBitmapImageRep' object initialized with the first image in the supplied data.
		do
			make_from_pointer ({NS_BITMAP_IMAGE_REP_API}.image_rep_with_data (a_data.item))
		end

--	image_reps_with_data (a_data: NS_DATA): NS_ARRAY [NS_IMAGE_REP]
--			-- Creates and returns an array of initialized `NSBitmapImageRep' objects corresponding to the images in the supplied data.
--		do
--			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.image_reps_with_data (a_data.item))
--		end

--	colorize_by_mapping_gray_to_color_black_mapping_white_mapping (a_mid_point: REAL; a_mid_point_color: NS_COLOR; a_shadow_color: NS_COLOR; a_light_color: NS_COLOR)
--			-- Colorizes a grayscale image.
--		do
--			{NS_BITMAP_IMAGE_REP_API}.colorize_by_mapping_gray_to_color_black_mapping_white_mapping (item, a_mid_point, a_mid_point_color.item, a_shadow_color.item, a_light_color.item)
--		end

--	init_with_bitmap_data_planes_pixels_wide_pixels_high_bits_per_sample_samples_per_pixel_has_alpha_is_planar_color_space_name_bitmap_format_bytes_per_row_bits_per_pixel (a_planes: POINTER[NATURAL_8]; a_width: INTEGER; a_height: INTEGER; a_bps: INTEGER; a_spp: INTEGER; a_alpha: BOOLEAN; a_is_planar: BOOLEAN; a_color_space_name: NS_STRING; a_bitmap_format: INTEGER; a_r_bytes: INTEGER; a_p_bits: INTEGER): NS_OBJECT
--			-- Initializes the receiver, a newly allocated `NSBitmapImageRep' object, so it can render the specified image.
--		do
--			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.init_with_bitmap_data_planes_pixels_wide_pixels_high_bits_per_sample_samples_per_pixel_has_alpha_is_planar_color_space_name_bitmap_format_bytes_per_row_bits_per_pixel (item, a_planes.item, a_width, a_height, a_bps, a_spp, a_alpha, a_is_planar, a_color_space_name.item, a_bitmap_format, a_r_bytes, a_p_bits))
--		end

--	init_with_bitmap_data_planes_pixels_wide_pixels_high_bits_per_sample_samples_per_pixel_has_alpha_is_planar_color_space_name_bytes_per_row_bits_per_pixel (a_planes: POINTER[NATURAL_8]; a_width: INTEGER; a_height: INTEGER; a_bps: INTEGER; a_spp: INTEGER; a_alpha: BOOLEAN; a_is_planar: BOOLEAN; a_color_space_name: NS_STRING; a_r_bytes: INTEGER; a_p_bits: INTEGER): NS_OBJECT
--			-- Initializes the receiver, a newly allocated `NSBitmapImageRep' object, so it can render the specified image.
--		do
--			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.init_with_bitmap_data_planes_pixels_wide_pixels_high_bits_per_sample_samples_per_pixel_has_alpha_is_planar_color_space_name_bytes_per_row_bits_per_pixel (item, a_planes.item, a_width, a_height, a_bps, a_spp, a_alpha, a_is_planar, a_color_space_name.item, a_r_bytes, a_p_bits))
--		end

--	init_with_cg_image (a_cg_image: CG_IMAGE_REF): NS_OBJECT
--			-- Returns an `NSBitmapImageRep' object created from a Core Graphics image object.
--		do
--			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.init_with_cg_image (item, a_cg_image.item))
--		end

--	init_with_ci_image (a_ci_image: CI_IMAGE): NS_OBJECT
--			-- Returns an `NSBitmapImageRep' object created from a Core Image object.
--		do
--			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.init_with_ci_image (item, a_ci_image.item))
--		end

	init_with_data (a_data: NS_DATA): NS_OBJECT
			-- Initializes a newly allocated `NSBitmapImageRep' from the provided data.
		do
			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.init_with_data (item, a_data.item))
		end

	init_with_focused_view_rect (a_rect: NS_RECT): NS_OBJECT
			-- Initializes the receiver, a newly allocated `NSBitmapImageRep' object, with bitmap data read from a rendered image.
		do
			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.init_with_focused_view_rect (item, a_rect.item))
		end

	init_for_incremental_load: NS_OBJECT
			-- Initializes and returns the receiver, a newly allocated `NSBitmapImageRep' object, for incremental loading.
		do
			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.init_for_incremental_load (item))
		end

feature -- Getting Information About the Image

	bitmap_format: INTEGER
			-- Returns the bitmap format of the receiver.
		do
			Result := {NS_BITMAP_IMAGE_REP_API}.bitmap_format (item)
		end

	bits_per_pixel: INTEGER
			-- Returns the number of bits allocated for each pixel in each plane of data.
		do
			Result := {NS_BITMAP_IMAGE_REP_API}.bits_per_pixel (item)
		end

	bytes_per_plane: INTEGER
			-- Returns the number of bytes in each plane or channel of data.
		do
			Result := {NS_BITMAP_IMAGE_REP_API}.bytes_per_plane (item)
		end

	bytes_per_row: INTEGER
			-- Returns the minimum number of bytes required to specify a scan line (a single row of pixels spanning the width of the image) in each data plane.
		do
			Result := {NS_BITMAP_IMAGE_REP_API}.bytes_per_row (item)
		end

	is_planar: BOOLEAN
			-- Returns `YES' if image data is a planar configuration and `NO' if its in a meshed configuration.
		do
			Result := {NS_BITMAP_IMAGE_REP_API}.is_planar (item)
		end

	number_of_planes: INTEGER
			-- Returns the number of separate planes image data is organized into.
		do
			Result := {NS_BITMAP_IMAGE_REP_API}.number_of_planes (item)
		end

	samples_per_pixel: INTEGER
			-- Returns the number of components in the data.
		do
			Result := {NS_BITMAP_IMAGE_REP_API}.samples_per_pixel (item)
		end

feature -- Getting Image Data

	bitmap_data: TYPED_POINTER[NATURAL_8]
			-- Returns a pointer to the bitmap data.
		do
			create Result
			Result.set_item ({NS_BITMAP_IMAGE_REP_API}.bitmap_data (item))
		end

	get_bitmap_data_planes (a_data: TYPED_POINTER[NATURAL_8])
			-- Returns by indirection bitmap data of the receiver separated into planes.
		do
			{NS_BITMAP_IMAGE_REP_API}.get_bitmap_data_planes (item, a_data)
		end

feature -- Producing Representations of the Image

--	tiff_representation_of_image_reps_in_array (a_array: NS_ARRAY [NS_BITMAP_IMAGE_REP]): NS_ARRAY[NS_DATA]
--			-- Returns a TIFF representation of the given images
--		do
--			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.tiff_representation_of_image_reps_in_array (a_array.item))
--		end

--	tiff_representation_of_image_reps_in_array_using_compression_factor (a_array: NS_ARRAY; a_comp: INTEGER; a_factor: REAL): NS_DATA
--			-- Returns a TIFF representation of the given images using a specified compression scheme and factor.
--		do
--			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.tiff_representation_of_image_reps_in_array_using_compression_factor (a_array.item, a_comp, a_factor))
--		end

	tiff_representation: NS_DATA
			-- Returns a TIFF representation of the receiver.
		do
			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.tiff_representation (item))
		end

	tiff_representation_using_compression_factor (a_comp: INTEGER; a_factor: REAL): NS_DATA
			-- Returns a TIFF representation of the image using the specified compression.
		do
			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.tiff_representation_using_compression_factor (item, a_comp, a_factor))
		end

--	representation_of_image_reps_in_array_using_type_properties (a_image_reps: NS_ARRAY; a_storage_type: INTEGER; a_properties: NS_DICTIONARY): NS_DATA
--			-- Formats the specified bitmap images using the specified storage type and properties and returns them in a data object.
--		require
--			valid_storage_type: -- (a_storage_type)
--		do
--			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.representation_of_image_reps_in_array_using_type_properties (a_image_reps.item, a_storage_type.item, a_properties.item))
--		end

	representation_using_type (a_storage_type: INTEGER; a_properties: detachable NS_DICTIONARY): NS_DATA
			-- Formats the receiver`s image data using the specified storage type and properties and returns it in a data object.
		require
			valid_storage_type: -- (a_storage_type)
		local
			l_properties: POINTER
		do
			if attached a_properties then
				l_properties := a_properties.item
			end
			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.representation_using_type_properties (item, a_storage_type, l_properties))
		end

feature -- Mananging Compression Types

	get_tiff_compression_types_count (a_list: TYPED_POINTER[TYPED_POINTER[INTEGER]]; a_num_types: TYPED_POINTER[INTEGER])
			-- Returns by indirection an array of all available compression types that can be used when writing a TIFF image.
		do
			{NS_BITMAP_IMAGE_REP_API}.get_tiff_compression_types_count (a_list, a_num_types)
		end

	localized_name_for_tiff_compression_type (a_compression: INTEGER): NS_STRING
			-- Returns an autoreleased string containing the localized name for the specified compression type.
		do
			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.localized_name_for_tiff_compression_type (a_compression))
		end

	can_be_compressed_using (a_compression: INTEGER): BOOLEAN
			-- Tests whether the receiver can be compressed by the specified compression scheme.
		do
			Result := {NS_BITMAP_IMAGE_REP_API}.can_be_compressed_using (item, a_compression)
		end

	set_compression_factor (a_compression: INTEGER; a_factor: REAL)
			-- Sets the receiver`s compression type and compression factor.
		do
			{NS_BITMAP_IMAGE_REP_API}.set_compression_factor (item, a_compression, a_factor)
		end

	get_compression_factor (a_compression: TYPED_POINTER[NATURAL_64]; a_factor: TYPED_POINTER[REAL])
			-- Returns by indirection the receiver`s compression type and compression factor.
		do
			{NS_BITMAP_IMAGE_REP_API}.get_compression_factor (item, a_compression, a_factor)
		end

	set_property_with_value (a_property: NS_STRING; a_value: NS_OBJECT)
			-- Sets the image`s <em>property</em> to <em>value</em>.
		do
			{NS_BITMAP_IMAGE_REP_API}.set_property_with_value (item, a_property.item, a_value.item)
		end

	value_for_property (a_property: NS_STRING): NS_OBJECT
			-- Returns the value for the specified property.
		do
			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.value_for_property (item, a_property.item))
		end

feature -- Loading Image Incrementally

	incremental_load_from_data_complete (a_data: NS_DATA; a_complete: BOOLEAN): INTEGER
			-- Loads the current image data into an incrementally-loaded image representation and returns the current status of the image.
		do
			Result := {NS_BITMAP_IMAGE_REP_API}.incremental_load_from_data_complete (item, a_data.item, a_complete)
		end

feature -- Managing Pixel Values

	set_color_at_x_y (a_color: NS_COLOR; a_x: INTEGER; a_y: INTEGER)
			-- Changes the color of the pixel at the specified coordinates.
		do
			{NS_BITMAP_IMAGE_REP_API}.set_color_at_x_y (item, a_color.item, a_x, a_y)
		end

	color_at_x_y (a_x: INTEGER; a_y: INTEGER): NS_COLOR
			-- Returns the color of the pixel at the specified coordinates.
		do
			create Result.share_from_pointer ({NS_BITMAP_IMAGE_REP_API}.color_at_x_y (item, a_x, a_y))
		end

--	set_pixel_at_x_y (a_color: NS_COLOR; a_x: INTEGER; a_y: INTEGER)
--			-- Error generating setPixel:atX:y:: Message signature for feature not set
--		do
--		end

--	get_pixel_at_x_y (a_color: NS_COLOR; a_x: INTEGER; a_y: INTEGER)
--			-- Error generating getPixel:atX:y:: Message signature for feature not set
--		do
--		end

feature -- Getting a Core Graphics Image

	cg_image: POINTER
			-- Returns a Core Graphics image object from the receiver`s current bitmap data.
		do
			Result := {NS_BITMAP_IMAGE_REP_API}.cg_image (item)
		end

feature -- Contract support

	is_valid_bitmap_image_file_type (a_integer: INTEGER): BOOLEAN
			-- Is a_integer a valid file-type constant?
		do
			Result := (<<tiff_file_type, bmp_file_type, gif_file_type, jpeg_file_type, png_file_type, jpeg2000_file_type>>).has (a_integer)
		end

feature -- BitmapImageFileType constants

	frozen TIFF_file_type: INTEGER
			-- NSTIFFFileType
			-- Tagged Image File Format (TIFF)
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSTIFFFileType"
		end

	frozen BMP_file_type: INTEGER
			-- NSBMPFileType
			-- Windows bitmap image (BMP) format
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSBMPFileType"
		end

	frozen GIF_file_type: INTEGER
			-- NSGIFFileType
			-- Graphics Image Format (GIF), originally created by CompuServe for online downloads
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSGIFFileType"
		end

	frozen JPEG_file_type: INTEGER
			-- NSJPEGFileType
			-- JPEG format
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSGIFFileType"
		end

	frozen PNG_file_type: INTEGER
			-- NSPNGFileType
			-- Portable Network Graphics (PNG) format
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSPNGFileType"
		end

	frozen JPEG2000_file_type: INTEGER
			-- NSJPEG2000FileType
			-- JPEG 2000 file format.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSJPEG2000FileType"
		end

end
