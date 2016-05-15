note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_IMAGE_REP

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSImageRep

	draw: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_draw (item)
		end

	draw_at_point_ (a_point: NS_POINT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_draw_at_point_ (item, a_point.item)
		end

	draw_in_rect_ (a_rect: NS_RECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_draw_in_rect_ (item, a_rect.item)
		end

	draw_in_rect__from_rect__operation__fraction__respect_flipped__hints_ (a_dst_space_portion_rect: NS_RECT; a_src_space_portion_rect: NS_RECT; a_op: NATURAL_64; a_requested_alpha: REAL_64; a_respect_context_is_flipped: BOOLEAN; a_hints: detachable NS_DICTIONARY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_hints__item: POINTER
		do
			if attached a_hints as a_hints_attached then
				a_hints__item := a_hints_attached.item
			end
			Result := objc_draw_in_rect__from_rect__operation__fraction__respect_flipped__hints_ (item, a_dst_space_portion_rect.item, a_src_space_portion_rect.item, a_op, a_requested_alpha, a_respect_context_is_flipped, a_hints__item)
		end

	set_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_size_ (item, a_size.item)
		end

	size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_size (item, Result.item)
		end

	set_alpha_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_alpha_ (item, a_flag)
		end

	has_alpha: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_alpha (item)
		end

	set_opaque_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_opaque_ (item, a_flag)
		end

	is_opaque: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_opaque (item)
		end

	set_color_space_name_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_color_space_name_ (item, a_string__item)
		end

	color_space_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_color_space_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_space_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_space_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_bits_per_sample_ (an_int: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bits_per_sample_ (item, an_int)
		end

	bits_per_sample: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_bits_per_sample (item)
		end

	set_pixels_wide_ (an_int: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_pixels_wide_ (item, an_int)
		end

	pixels_wide: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_pixels_wide (item)
		end

	set_pixels_high_ (an_int: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_pixels_high_ (item, an_int)
		end

	pixels_high: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_pixels_high (item)
		end

--	cg_image_for_proposed_rect__context__hints_ (a_proposed_dest_rect: UNSUPPORTED_TYPE; a_context: detachable NS_GRAPHICS_CONTEXT; a_hints: detachable NS_DICTIONARY): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_proposed_dest_rect__item: POINTER
--			a_context__item: POINTER
--			a_hints__item: POINTER
--		do
--			if attached a_proposed_dest_rect as a_proposed_dest_rect_attached then
--				a_proposed_dest_rect__item := a_proposed_dest_rect_attached.item
--			end
--			if attached a_context as a_context_attached then
--				a_context__item := a_context_attached.item
--			end
--			if attached a_hints as a_hints_attached then
--				a_hints__item := a_hints_attached.item
--			end
--			result_pointer := objc_cg_image_for_proposed_rect__context__hints_ (item, a_proposed_dest_rect__item, a_context__item, a_hints__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like cg_image_for_proposed_rect__context__hints_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like cg_image_for_proposed_rect__context__hints_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSImageRep Externals

	objc_draw (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageRep *)$an_item draw];
			 ]"
		end

	objc_draw_at_point_ (an_item: POINTER; a_point: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageRep *)$an_item drawAtPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_draw_in_rect_ (an_item: POINTER; a_rect: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageRep *)$an_item drawInRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_draw_in_rect__from_rect__operation__fraction__respect_flipped__hints_ (an_item: POINTER; a_dst_space_portion_rect: POINTER; a_src_space_portion_rect: POINTER; a_op: NATURAL_64; a_requested_alpha: REAL_64; a_respect_context_is_flipped: BOOLEAN; a_hints: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageRep *)$an_item drawInRect:*((NSRect *)$a_dst_space_portion_rect) fromRect:*((NSRect *)$a_src_space_portion_rect) operation:$a_op fraction:$a_requested_alpha respectFlipped:$a_respect_context_is_flipped hints:$a_hints];
			 ]"
		end

	objc_set_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageRep *)$an_item setSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSImageRep *)$an_item size];
			 ]"
		end

	objc_set_alpha_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageRep *)$an_item setAlpha:$a_flag];
			 ]"
		end

	objc_has_alpha (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageRep *)$an_item hasAlpha];
			 ]"
		end

	objc_set_opaque_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageRep *)$an_item setOpaque:$a_flag];
			 ]"
		end

	objc_is_opaque (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageRep *)$an_item isOpaque];
			 ]"
		end

	objc_set_color_space_name_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageRep *)$an_item setColorSpaceName:$a_string];
			 ]"
		end

	objc_color_space_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImageRep *)$an_item colorSpaceName];
			 ]"
		end

	objc_set_bits_per_sample_ (an_item: POINTER; an_int: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageRep *)$an_item setBitsPerSample:$an_int];
			 ]"
		end

	objc_bits_per_sample (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageRep *)$an_item bitsPerSample];
			 ]"
		end

	objc_set_pixels_wide_ (an_item: POINTER; an_int: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageRep *)$an_item setPixelsWide:$an_int];
			 ]"
		end

	objc_pixels_wide (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageRep *)$an_item pixelsWide];
			 ]"
		end

	objc_set_pixels_high_ (an_item: POINTER; an_int: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageRep *)$an_item setPixelsHigh:$an_int];
			 ]"
		end

	objc_pixels_high (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageRep *)$an_item pixelsHigh];
			 ]"
		end

--	objc_cg_image_for_proposed_rect__context__hints_ (an_item: POINTER; a_proposed_dest_rect: UNSUPPORTED_TYPE; a_context: POINTER; a_hints: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSImageRep *)$an_item CGImageForProposedRect: context:$a_context hints:$a_hints];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSImageRep"
		end

end
