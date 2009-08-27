note
	description: "Summary description for {NS_BITMAP_IMAGE_REP_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BITMAP_IMAGE_REP_API

feature -- Creating an NSBitmapImageRep Object

	frozen image_rep_with_data (a_data: POINTER): POINTER
			-- + (id)imageRepWithData: (NSData *) data
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBitmapImageRep imageRepWithData: $a_data];"
		end

	frozen image_reps_with_data (a_data: POINTER): POINTER
			-- + (NSArray *)imageRepsWithData: (NSData *) data
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBitmapImageRep imageRepsWithData: $a_data];"
		end

	frozen colorize_by_mapping_gray_to_color_black_mapping_white_mapping (a_ns_bitmap_image_rep: POINTER; a_mid_point: REAL; a_mid_point_color: POINTER; a_shadow_color: POINTER; a_light_color: POINTER)
			-- - (void)colorizeByMappingGray: (CGFloat) midPoint toColor: (NSColor *) midPointColor blackMapping: (NSColor *) shadowColor whiteMapping: (NSColor *) lightColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBitmapImageRep*)$a_ns_bitmap_image_rep colorizeByMappingGray: $a_mid_point toColor: $a_mid_point_color blackMapping: $a_shadow_color whiteMapping: $a_light_color];"
		end

	frozen init_with_bitmap_data_planes_pixels_wide_pixels_high_bits_per_sample_samples_per_pixel_has_alpha_is_planar_color_space_name_bitmap_format_bytes_per_row_bits_per_pixel (a_ns_bitmap_image_rep: POINTER; a_planes: POINTER; a_width: INTEGER; a_height: INTEGER; a_bps: INTEGER; a_spp: INTEGER; a_alpha: BOOLEAN; a_is_planar: BOOLEAN; a_color_space_name: POINTER; a_bitmap_format: INTEGER; a_r_bytes: INTEGER; a_p_bits: INTEGER): POINTER
			-- - (id)initWithBitmapDataPlanes: (unsigned char **) planes pixelsWide: (NSInteger) width pixelsHigh: (NSInteger) height bitsPerSample: (NSInteger) bps samplesPerPixel: (NSInteger) spp hasAlpha: (BOOL) alpha isPlanar: (BOOL) isPlanar colorSpaceName: (NSString *) colorSpaceName bitmapFormat: (NSBitmapFormat) bitmapFormat bytesPerRow: (NSInteger) rBytes bitsPerPixel: (NSInteger) pBits
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep initWithBitmapDataPlanes: $a_planes pixelsWide: $a_width pixelsHigh: $a_height bitsPerSample: $a_bps samplesPerPixel: $a_spp hasAlpha: $a_alpha isPlanar: $a_is_planar colorSpaceName: $a_color_space_name bitmapFormat: $a_bitmap_format bytesPerRow: $a_r_bytes bitsPerPixel: $a_p_bits];"
		end

	frozen init_with_bitmap_data_planes_pixels_wide_pixels_high_bits_per_sample_samples_per_pixel_has_alpha_is_planar_color_space_name_bytes_per_row_bits_per_pixel (a_ns_bitmap_image_rep: POINTER; a_planes: POINTER; a_width: INTEGER; a_height: INTEGER; a_bps: INTEGER; a_spp: INTEGER; a_alpha: BOOLEAN; a_is_planar: BOOLEAN; a_color_space_name: POINTER; a_r_bytes: INTEGER; a_p_bits: INTEGER): POINTER
			-- - (id)initWithBitmapDataPlanes: (unsigned char **) planes pixelsWide: (NSInteger) width pixelsHigh: (NSInteger) height bitsPerSample: (NSInteger) bps samplesPerPixel: (NSInteger) spp hasAlpha: (BOOL) alpha isPlanar: (BOOL) isPlanar colorSpaceName: (NSString *) colorSpaceName bytesPerRow: (NSInteger) rBytes bitsPerPixel: (NSInteger) pBits
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep initWithBitmapDataPlanes: $a_planes pixelsWide: $a_width pixelsHigh: $a_height bitsPerSample: $a_bps samplesPerPixel: $a_spp hasAlpha: $a_alpha isPlanar: $a_is_planar colorSpaceName: $a_color_space_name bytesPerRow: $a_r_bytes bitsPerPixel: $a_p_bits];"
		end

	frozen init_with_cg_image (a_ns_bitmap_image_rep: POINTER; a_cg_image: POINTER): POINTER
			-- - (id)initWithCGImage: (CGImageRef) cgImage
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep initWithCGImage: *(CGImageRef*)$a_cg_image];"
		end

	frozen init_with_ci_image (a_ns_bitmap_image_rep: POINTER; a_ci_image: POINTER): POINTER
			-- - (id)initWithCIImage: (CIImage *) ciImage
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep initWithCIImage: $a_ci_image];"
		end

	frozen init_with_data (a_ns_bitmap_image_rep: POINTER; a_data: POINTER): POINTER
			-- - (id)initWithData: (NSData *) data
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep initWithData: $a_data];"
		end

	frozen init_with_focused_view_rect (a_ns_bitmap_image_rep: POINTER; a_rect: POINTER): POINTER
			-- - (id)initWithFocusedViewRect: (NSRect) rect
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep initWithFocusedViewRect: *(NSRect*)$a_rect];"
		end

	frozen init_for_incremental_load (a_ns_bitmap_image_rep: POINTER): POINTER
			-- - (id)initForIncrementalLoad
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep initForIncrementalLoad];"
		end

feature -- Getting Information About the Image

	frozen bitmap_format (a_ns_bitmap_image_rep: POINTER): INTEGER
			-- - (NSBitmapFormat)bitmapFormat
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep bitmapFormat];"
		end

	frozen bits_per_pixel (a_ns_bitmap_image_rep: POINTER): INTEGER
			-- - (NSInteger)bitsPerPixel
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep bitsPerPixel];"
		end

	frozen bytes_per_plane (a_ns_bitmap_image_rep: POINTER): INTEGER
			-- - (NSInteger)bytesPerPlane
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep bytesPerPlane];"
		end

	frozen bytes_per_row (a_ns_bitmap_image_rep: POINTER): INTEGER
			-- - (NSInteger)bytesPerRow
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep bytesPerRow];"
		end

	frozen is_planar (a_ns_bitmap_image_rep: POINTER): BOOLEAN
			-- - (BOOL)isPlanar
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep isPlanar];"
		end

	frozen number_of_planes (a_ns_bitmap_image_rep: POINTER): INTEGER
			-- - (NSInteger)numberOfPlanes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep numberOfPlanes];"
		end

	frozen samples_per_pixel (a_ns_bitmap_image_rep: POINTER): INTEGER
			-- - (NSInteger)samplesPerPixel
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep samplesPerPixel];"
		end

feature -- Getting Image Data

	frozen bitmap_data (a_ns_bitmap_image_rep: POINTER): POINTER
			-- - (unsigned char *)bitmapData
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep bitmapData];"
		end

	frozen get_bitmap_data_planes (a_ns_bitmap_image_rep: POINTER; a_data: POINTER)
			-- - (void)getBitmapDataPlanes: (unsigned char **) data
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBitmapImageRep*)$a_ns_bitmap_image_rep getBitmapDataPlanes: $a_data];"
		end

feature -- Producing Representations of the Image

	frozen tiff_representation_of_image_reps_in_array (a_array: POINTER): POINTER
			-- + (NSData *)TIFFRepresentationOfImageRepsInArray: (NSArray *) array
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBitmapImageRep TIFFRepresentationOfImageRepsInArray: $a_array];"
		end

	frozen tiff_representation_of_image_reps_in_array_using_compression_factor (a_array: POINTER; a_comp: POINTER; a_factor: REAL): POINTER
			-- + (NSData *)TIFFRepresentationOfImageRepsInArray: (NSArray *) array usingCompression: (NSTIFFCompression) comp factor: (float) factor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBitmapImageRep TIFFRepresentationOfImageRepsInArray: $a_array usingCompression: *(NSTIFFCompression*)$a_comp factor: $a_factor];"
		end

	frozen tiff_representation (a_ns_bitmap_image_rep: POINTER): POINTER
			-- - (NSData *)TIFFRepresentation
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep TIFFRepresentation];"
		end

	frozen tiff_representation_using_compression_factor (a_ns_bitmap_image_rep: POINTER; a_comp: INTEGER; a_factor: REAL): POINTER
			-- - (NSData *)TIFFRepresentationUsingCompression: (NSTIFFCompression) comp factor: (float) factor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep TIFFRepresentationUsingCompression: $a_comp factor: $a_factor];"
		end

	frozen representation_of_image_reps_in_array_using_type_properties (a_image_reps: POINTER; a_storage_type: POINTER; a_properties: POINTER): POINTER
			-- + (NSData *)representationOfImageRepsInArray: (NSArray *) imageReps usingType: (NSBitmapImageFileType) storageType properties: (NSDictionary *) properties
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBitmapImageRep representationOfImageRepsInArray: $a_image_reps usingType: *(NSBitmapImageFileType*)$a_storage_type properties: $a_properties];"
		end

	frozen representation_using_type_properties (a_ns_bitmap_image_rep: POINTER; a_storage_type: INTEGER; a_properties: POINTER): POINTER
			-- - (NSData *)representationUsingType: (NSBitmapImageFileType) storageType properties: (NSDictionary *) properties
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep representationUsingType: $a_storage_type properties: $a_properties];"
		end

feature -- Mananging Compression Types

	frozen get_tiff_compression_types_count (a_list: POINTER; a_num_types: POINTER)
			-- + (void)getTIFFCompressionTypes: (const NSTIFFCompression **) list count: (NSInteger *) numTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSBitmapImageRep getTIFFCompressionTypes: $a_list count: $a_num_types];"
		end

	frozen localized_name_for_tiff_compression_type (a_compression: INTEGER): POINTER
			-- + (NSString *)localizedNameForTIFFCompressionType: (NSTIFFCompression) compression
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBitmapImageRep localizedNameForTIFFCompressionType: $a_compression];"
		end

	frozen can_be_compressed_using (a_ns_bitmap_image_rep: POINTER; a_compression: INTEGER): BOOLEAN
			-- - (BOOL)canBeCompressedUsing: (NSTIFFCompression) compression
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep canBeCompressedUsing: $a_compression];"
		end

	frozen set_compression_factor (a_ns_bitmap_image_rep: POINTER; a_compression: INTEGER; a_factor: REAL)
			-- - (void)setCompression: (NSTIFFCompression) compression factor: (float) factor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBitmapImageRep*)$a_ns_bitmap_image_rep setCompression: $a_compression factor: $a_factor];"
		end

	frozen get_compression_factor (a_ns_bitmap_image_rep: POINTER; a_compression: TYPED_POINTER[NATURAL]; a_factor: TYPED_POINTER[REAL])
			-- - (void)getCompression: (NSTIFFCompression *) compression factor: (float *) factor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBitmapImageRep*)$a_ns_bitmap_image_rep getCompression: $a_compression factor: $a_factor];"
		end

	frozen set_property_with_value (a_ns_bitmap_image_rep: POINTER; a_property: POINTER; a_value: POINTER)
			-- - (void)setProperty: (NSString *) property withValue: (id) value
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBitmapImageRep*)$a_ns_bitmap_image_rep setProperty: $a_property withValue: $a_value];"
		end

	frozen value_for_property (a_ns_bitmap_image_rep: POINTER; a_property: POINTER): POINTER
			-- - (id)valueForProperty: (NSString *) property
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep valueForProperty: $a_property];"
		end

feature -- Loading Image Incrementally

	frozen incremental_load_from_data_complete (a_ns_bitmap_image_rep: POINTER; a_data: POINTER; a_complete: BOOLEAN): INTEGER
			-- - (NSInteger)incrementalLoadFromData: (NSData*) data complete: (BOOL) complete
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep incrementalLoadFromData: $a_data complete: $a_complete];"
		end

feature -- Managing Pixel Values

	frozen set_color_at_x_y (a_ns_bitmap_image_rep: POINTER; a_color: POINTER; a_x: INTEGER; a_y: INTEGER)
			-- - (void)setColor: (NSColor*) color atX: (NSInteger) x y: (NSInteger) y
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBitmapImageRep*)$a_ns_bitmap_image_rep setColor: $a_color atX: $a_x y: $a_y];"
		end

	frozen color_at_x_y (a_ns_bitmap_image_rep: POINTER; a_x: INTEGER; a_y: INTEGER): POINTER
			-- - (NSColor*)colorAtX: (NSInteger) x y: (NSInteger) y
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep colorAtX: $a_x y: $a_y];"
		end

-- Error generating setPixel:atX:y:: Message signature for feature not set
-- Error generating getPixel:atX:y:: Message signature for feature not set

feature -- Getting a Core Graphics Image

	frozen cg_image (a_ns_bitmap_image_rep: POINTER): POINTER
			-- - (CGImageRef)CGImage
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBitmapImageRep*)$a_ns_bitmap_image_rep CGImage];"
		end


end
