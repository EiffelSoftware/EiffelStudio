note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BITMAP_IMAGE_REP

inherit
	NS_IMAGE_REP
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_focused_view_rect_,
	make_with_ci_image_,
	make_with_data_,
	make_for_incremental_load,
	make

feature {NONE} -- Initialization

	make_with_focused_view_rect_ (a_rect: NS_RECT)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_focused_view_rect_(allocate_object, a_rect.item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_bitmap_data_planes__pixels_wide__pixels_high__bits_per_sample__samples_per_pixel__has_alpha__is_planar__color_space_name__bytes_per_row__bits_per_pixel_ (a_planes: UNSUPPORTED_TYPE; a_width: INTEGER_64; a_height: INTEGER_64; a_bps: INTEGER_64; a_spp: INTEGER_64; a_alpha: BOOLEAN; a_is_planar: BOOLEAN; a_color_space_name: detachable NS_STRING; a_r_bytes: INTEGER_64; a_p_bits: INTEGER_64)
--			-- Initialize `Current'.
--		local
--			a_planes__item: POINTER
--			a_color_space_name__item: POINTER
--		do
--			if attached a_planes as a_planes_attached then
--				a_planes__item := a_planes_attached.item
--			end
--			if attached a_color_space_name as a_color_space_name_attached then
--				a_color_space_name__item := a_color_space_name_attached.item
--			end
--			make_with_pointer (objc_init_with_bitmap_data_planes__pixels_wide__pixels_high__bits_per_sample__samples_per_pixel__has_alpha__is_planar__color_space_name__bytes_per_row__bits_per_pixel_(allocate_object, a_planes__item, a_width, a_height, a_bps, a_spp, a_alpha, a_is_planar, a_color_space_name__item, a_r_bytes, a_p_bits))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_bitmap_data_planes__pixels_wide__pixels_high__bits_per_sample__samples_per_pixel__has_alpha__is_planar__color_space_name__bitmap_format__bytes_per_row__bits_per_pixel_ (a_planes: UNSUPPORTED_TYPE; a_width: INTEGER_64; a_height: INTEGER_64; a_bps: INTEGER_64; a_spp: INTEGER_64; a_alpha: BOOLEAN; a_is_planar: BOOLEAN; a_color_space_name: detachable NS_STRING; a_bitmap_format: NATURAL_64; a_r_bytes: INTEGER_64; a_p_bits: INTEGER_64)
--			-- Initialize `Current'.
--		local
--			a_planes__item: POINTER
--			a_color_space_name__item: POINTER
--		do
--			if attached a_planes as a_planes_attached then
--				a_planes__item := a_planes_attached.item
--			end
--			if attached a_color_space_name as a_color_space_name_attached then
--				a_color_space_name__item := a_color_space_name_attached.item
--			end
--			make_with_pointer (objc_init_with_bitmap_data_planes__pixels_wide__pixels_high__bits_per_sample__samples_per_pixel__has_alpha__is_planar__color_space_name__bitmap_format__bytes_per_row__bits_per_pixel_(allocate_object, a_planes__item, a_width, a_height, a_bps, a_spp, a_alpha, a_is_planar, a_color_space_name__item, a_bitmap_format, a_r_bytes, a_p_bits))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_cg_image_ (a_cg_image: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_cg_image__item: POINTER
--		do
--			if attached a_cg_image as a_cg_image_attached then
--				a_cg_image__item := a_cg_image_attached.item
--			end
--			make_with_pointer (objc_init_with_cg_image_(allocate_object, a_cg_image__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_with_ci_image_ (a_ci_image: detachable CI_IMAGE)
			-- Initialize `Current'.
		local
			a_ci_image__item: POINTER
		do
			if attached a_ci_image as a_ci_image_attached then
				a_ci_image__item := a_ci_image_attached.item
			end
			make_with_pointer (objc_init_with_ci_image_(allocate_object, a_ci_image__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_data_ (a_data: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			make_with_pointer (objc_init_with_data_(allocate_object, a_data__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_for_incremental_load
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_for_incremental_load(allocate_object))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSBitmapImageRep Externals

	objc_init_with_focused_view_rect_ (an_item: POINTER; a_rect: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item initWithFocusedViewRect:*((NSRect *)$a_rect)];
			 ]"
		end

--	objc_init_with_bitmap_data_planes__pixels_wide__pixels_high__bits_per_sample__samples_per_pixel__has_alpha__is_planar__color_space_name__bytes_per_row__bits_per_pixel_ (an_item: POINTER; a_planes: UNSUPPORTED_TYPE; a_width: INTEGER_64; a_height: INTEGER_64; a_bps: INTEGER_64; a_spp: INTEGER_64; a_alpha: BOOLEAN; a_is_planar: BOOLEAN; a_color_space_name: POINTER; a_r_bytes: INTEGER_64; a_p_bits: INTEGER_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item initWithBitmapDataPlanes: pixelsWide:$a_width pixelsHigh:$a_height bitsPerSample:$a_bps samplesPerPixel:$a_spp hasAlpha:$a_alpha isPlanar:$a_is_planar colorSpaceName:$a_color_space_name bytesPerRow:$a_r_bytes bitsPerPixel:$a_p_bits];
--			 ]"
--		end

--	objc_init_with_bitmap_data_planes__pixels_wide__pixels_high__bits_per_sample__samples_per_pixel__has_alpha__is_planar__color_space_name__bitmap_format__bytes_per_row__bits_per_pixel_ (an_item: POINTER; a_planes: UNSUPPORTED_TYPE; a_width: INTEGER_64; a_height: INTEGER_64; a_bps: INTEGER_64; a_spp: INTEGER_64; a_alpha: BOOLEAN; a_is_planar: BOOLEAN; a_color_space_name: POINTER; a_bitmap_format: NATURAL_64; a_r_bytes: INTEGER_64; a_p_bits: INTEGER_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item initWithBitmapDataPlanes: pixelsWide:$a_width pixelsHigh:$a_height bitsPerSample:$a_bps samplesPerPixel:$a_spp hasAlpha:$a_alpha isPlanar:$a_is_planar colorSpaceName:$a_color_space_name bitmapFormat:$a_bitmap_format bytesPerRow:$a_r_bytes bitsPerPixel:$a_p_bits];
--			 ]"
--		end

--	objc_init_with_cg_image_ (an_item: POINTER; a_cg_image: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item initWithCGImage:];
--			 ]"
--		end

	objc_init_with_ci_image_ (an_item: POINTER; a_ci_image: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item initWithCIImage:$a_ci_image];
			 ]"
		end

	objc_init_with_data_ (an_item: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item initWithData:$a_data];
			 ]"
		end

--	objc_bitmap_data (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item bitmapData];
--			 ]"
--		end

--	objc_get_bitmap_data_planes_ (an_item: POINTER; a_data: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSBitmapImageRep *)$an_item getBitmapDataPlanes:];
--			 ]"
--		end

	objc_is_planar (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBitmapImageRep *)$an_item isPlanar];
			 ]"
		end

	objc_samples_per_pixel (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBitmapImageRep *)$an_item samplesPerPixel];
			 ]"
		end

	objc_bits_per_pixel (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBitmapImageRep *)$an_item bitsPerPixel];
			 ]"
		end

	objc_bytes_per_row (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBitmapImageRep *)$an_item bytesPerRow];
			 ]"
		end

	objc_bytes_per_plane (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBitmapImageRep *)$an_item bytesPerPlane];
			 ]"
		end

	objc_number_of_planes (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBitmapImageRep *)$an_item numberOfPlanes];
			 ]"
		end

	objc_bitmap_format (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBitmapImageRep *)$an_item bitmapFormat];
			 ]"
		end

--	objc_get_compression__factor_ (an_item: POINTER; a_compression: UNSUPPORTED_TYPE; a_factor: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSBitmapImageRep *)$an_item getCompression: factor:];
--			 ]"
--		end

	objc_set_compression__factor_ (an_item: POINTER; a_compression: NATURAL_64; a_factor: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBitmapImageRep *)$an_item setCompression:$a_compression factor:$a_factor];
			 ]"
		end

	objc_tiff_representation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item TIFFRepresentation];
			 ]"
		end

	objc_tiff_representation_using_compression__factor_ (an_item: POINTER; a_comp: NATURAL_64; a_factor: REAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item TIFFRepresentationUsingCompression:$a_comp factor:$a_factor];
			 ]"
		end

	objc_can_be_compressed_using_ (an_item: POINTER; a_compression: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBitmapImageRep *)$an_item canBeCompressedUsing:$a_compression];
			 ]"
		end

	objc_colorize_by_mapping_gray__to_color__black_mapping__white_mapping_ (an_item: POINTER; a_mid_point: REAL_64; a_mid_point_color: POINTER; a_shadow_color: POINTER; a_light_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBitmapImageRep *)$an_item colorizeByMappingGray:$a_mid_point toColor:$a_mid_point_color blackMapping:$a_shadow_color whiteMapping:$a_light_color];
			 ]"
		end

	objc_init_for_incremental_load (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item initForIncrementalLoad];
			 ]"
		end

	objc_incremental_load_from_data__complete_ (an_item: POINTER; a_data: POINTER; a_complete: BOOLEAN): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBitmapImageRep *)$an_item incrementalLoadFromData:$a_data complete:$a_complete];
			 ]"
		end

	objc_set_color__at_x__y_ (an_item: POINTER; a_color: POINTER; a_x: INTEGER_64; a_y: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBitmapImageRep *)$an_item setColor:$a_color atX:$a_x y:$a_y];
			 ]"
		end

	objc_color_at_x__y_ (an_item: POINTER; a_x: INTEGER_64; a_y: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item colorAtX:$a_x y:$a_y];
			 ]"
		end

--	objc_get_pixel__at_x__y_ (an_item: POINTER; a_p: UNSUPPORTED_TYPE; a_x: INTEGER_64; a_y: INTEGER_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSBitmapImageRep *)$an_item getPixel: atX:$a_x y:$a_y];
--			 ]"
--		end

--	objc_set_pixel__at_x__y_ (an_item: POINTER; a_p: UNSUPPORTED_TYPE; a_x: INTEGER_64; a_y: INTEGER_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSBitmapImageRep *)$an_item setPixel: atX:$a_x y:$a_y];
--			 ]"
--		end

--	objc_cg_image (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item CGImage];
--			 ]"
--		end

	objc_color_space (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item colorSpace];
			 ]"
		end

	objc_bitmap_image_rep_by_converting_to_color_space__rendering_intent_ (an_item: POINTER; a_target_space: POINTER; a_rendering_intent: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item bitmapImageRepByConvertingToColorSpace:$a_target_space renderingIntent:$a_rendering_intent];
			 ]"
		end

	objc_bitmap_image_rep_by_retagging_with_color_space_ (an_item: POINTER; a_new_space: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item bitmapImageRepByRetaggingWithColorSpace:$a_new_space];
			 ]"
		end

feature -- NSBitmapImageRep

--	bitmap_data: detachable UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_bitmap_data (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like bitmap_data} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like bitmap_data} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	get_bitmap_data_planes_ (a_data: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_data__item: POINTER
--		do
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			objc_get_bitmap_data_planes_ (item, a_data__item)
--		end

	is_planar: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_planar (item)
		end

	samples_per_pixel: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_samples_per_pixel (item)
		end

	bits_per_pixel: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_bits_per_pixel (item)
		end

	bytes_per_row: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_bytes_per_row (item)
		end

	bytes_per_plane: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_bytes_per_plane (item)
		end

	number_of_planes: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_planes (item)
		end

	bitmap_format: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_bitmap_format (item)
		end

--	get_compression__factor_ (a_compression: UNSUPPORTED_TYPE; a_factor: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_compression__item: POINTER
--			a_factor__item: POINTER
--		do
--			if attached a_compression as a_compression_attached then
--				a_compression__item := a_compression_attached.item
--			end
--			if attached a_factor as a_factor_attached then
--				a_factor__item := a_factor_attached.item
--			end
--			objc_get_compression__factor_ (item, a_compression__item, a_factor__item)
--		end

	set_compression__factor_ (a_compression: NATURAL_64; a_factor: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_compression__factor_ (item, a_compression, a_factor)
		end

	tiff_representation: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_tiff_representation (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tiff_representation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tiff_representation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	tiff_representation_using_compression__factor_ (a_comp: NATURAL_64; a_factor: REAL_32): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_tiff_representation_using_compression__factor_ (item, a_comp, a_factor)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tiff_representation_using_compression__factor_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tiff_representation_using_compression__factor_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	can_be_compressed_using_ (a_compression: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_be_compressed_using_ (item, a_compression)
		end

	colorize_by_mapping_gray__to_color__black_mapping__white_mapping_ (a_mid_point: REAL_64; a_mid_point_color: detachable NS_COLOR; a_shadow_color: detachable NS_COLOR; a_light_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_mid_point_color__item: POINTER
			a_shadow_color__item: POINTER
			a_light_color__item: POINTER
		do
			if attached a_mid_point_color as a_mid_point_color_attached then
				a_mid_point_color__item := a_mid_point_color_attached.item
			end
			if attached a_shadow_color as a_shadow_color_attached then
				a_shadow_color__item := a_shadow_color_attached.item
			end
			if attached a_light_color as a_light_color_attached then
				a_light_color__item := a_light_color_attached.item
			end
			objc_colorize_by_mapping_gray__to_color__black_mapping__white_mapping_ (item, a_mid_point, a_mid_point_color__item, a_shadow_color__item, a_light_color__item)
		end

	incremental_load_from_data__complete_ (a_data: detachable NS_DATA; a_complete: BOOLEAN): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			Result := objc_incremental_load_from_data__complete_ (item, a_data__item, a_complete)
		end

	set_color__at_x__y_ (a_color: detachable NS_COLOR; a_x: INTEGER_64; a_y: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_color__at_x__y_ (item, a_color__item, a_x, a_y)
		end

	color_at_x__y_ (a_x: INTEGER_64; a_y: INTEGER_64): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_color_at_x__y_ (item, a_x, a_y)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_at_x__y_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_at_x__y_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	get_pixel__at_x__y_ (a_p: UNSUPPORTED_TYPE; a_x: INTEGER_64; a_y: INTEGER_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_p__item: POINTER
--		do
--			if attached a_p as a_p_attached then
--				a_p__item := a_p_attached.item
--			end
--			objc_get_pixel__at_x__y_ (item, a_p__item, a_x, a_y)
--		end

--	set_pixel__at_x__y_ (a_p: UNSUPPORTED_TYPE; a_x: INTEGER_64; a_y: INTEGER_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_p__item: POINTER
--		do
--			if attached a_p as a_p_attached then
--				a_p__item := a_p_attached.item
--			end
--			objc_set_pixel__at_x__y_ (item, a_p__item, a_x, a_y)
--		end

--	cg_image: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_cg_image (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like cg_image} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like cg_image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	color_space: detachable NS_COLOR_SPACE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_color_space (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_space} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_space} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bitmap_image_rep_by_converting_to_color_space__rendering_intent_ (a_target_space: detachable NS_COLOR_SPACE; a_rendering_intent: INTEGER_64): detachable NS_BITMAP_IMAGE_REP
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_target_space__item: POINTER
		do
			if attached a_target_space as a_target_space_attached then
				a_target_space__item := a_target_space_attached.item
			end
			result_pointer := objc_bitmap_image_rep_by_converting_to_color_space__rendering_intent_ (item, a_target_space__item, a_rendering_intent)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bitmap_image_rep_by_converting_to_color_space__rendering_intent_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bitmap_image_rep_by_converting_to_color_space__rendering_intent_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bitmap_image_rep_by_retagging_with_color_space_ (a_new_space: detachable NS_COLOR_SPACE): detachable NS_BITMAP_IMAGE_REP
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_new_space__item: POINTER
		do
			if attached a_new_space as a_new_space_attached then
				a_new_space__item := a_new_space_attached.item
			end
			result_pointer := objc_bitmap_image_rep_by_retagging_with_color_space_ (item, a_new_space__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bitmap_image_rep_by_retagging_with_color_space_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bitmap_image_rep_by_retagging_with_color_space_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature -- NSBitmapImageFileTypeExtensions

	representation_using_type__properties_ (a_storage_type: NATURAL_64; a_properties: detachable NS_DICTIONARY): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_properties__item: POINTER
		do
			if attached a_properties as a_properties_attached then
				a_properties__item := a_properties_attached.item
			end
			result_pointer := objc_representation_using_type__properties_ (item, a_storage_type, a_properties__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like representation_using_type__properties_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like representation_using_type__properties_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_property__with_value_ (a_property: detachable NS_STRING; a_value: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_property__item: POINTER
			a_value__item: POINTER
		do
			if attached a_property as a_property_attached then
				a_property__item := a_property_attached.item
			end
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			objc_set_property__with_value_ (item, a_property__item, a_value__item)
		end

	value_for_property_ (a_property: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_property__item: POINTER
		do
			if attached a_property as a_property_attached then
				a_property__item := a_property_attached.item
			end
			result_pointer := objc_value_for_property_ (item, a_property__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_for_property_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_for_property_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSBitmapImageFileTypeExtensions Externals

	objc_representation_using_type__properties_ (an_item: POINTER; a_storage_type: NATURAL_64; a_properties: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item representationUsingType:$a_storage_type properties:$a_properties];
			 ]"
		end

	objc_set_property__with_value_ (an_item: POINTER; a_property: POINTER; a_value: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBitmapImageRep *)$an_item setProperty:$a_property withValue:$a_value];
			 ]"
		end

	objc_value_for_property_ (an_item: POINTER; a_property: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBitmapImageRep *)$an_item valueForProperty:$a_property];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSBitmapImageRep"
		end

end
