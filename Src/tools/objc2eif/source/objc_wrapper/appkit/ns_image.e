note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_IMAGE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_size_,
	make_with_data_,
	make_with_contents_of_file_,
	make_with_contents_of_ur_l_,
	make_by_referencing_file_,
	make_by_referencing_ur_l_,
	make_with_pasteboard_,
	make_with_data_ignoring_orientation_,
	make

feature {NONE} -- Initialization

	make_with_size_ (a_size: NS_SIZE)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_size_(allocate_object, a_size.item))
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

	make_with_contents_of_file_ (a_file_name: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_file_name__item: POINTER
		do
			if attached a_file_name as a_file_name_attached then
				a_file_name__item := a_file_name_attached.item
			end
			make_with_pointer (objc_init_with_contents_of_file_(allocate_object, a_file_name__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_contents_of_ur_l_ (a_url: detachable NS_URL)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			make_with_pointer (objc_init_with_contents_of_ur_l_(allocate_object, a_url__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_by_referencing_file_ (a_file_name: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_file_name__item: POINTER
		do
			if attached a_file_name as a_file_name_attached then
				a_file_name__item := a_file_name_attached.item
			end
			make_with_pointer (objc_init_by_referencing_file_(allocate_object, a_file_name__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_by_referencing_ur_l_ (a_url: detachable NS_URL)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			make_with_pointer (objc_init_by_referencing_ur_l_(allocate_object, a_url__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_icon_ref_ (a_icon_ref: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_icon_ref__item: POINTER
--		do
--			if attached a_icon_ref as a_icon_ref_attached then
--				a_icon_ref__item := a_icon_ref_attached.item
--			end
--			make_with_pointer (objc_init_with_icon_ref_(allocate_object, a_icon_ref__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_with_pasteboard_ (a_pasteboard: detachable NS_PASTEBOARD)
			-- Initialize `Current'.
		local
			a_pasteboard__item: POINTER
		do
			if attached a_pasteboard as a_pasteboard_attached then
				a_pasteboard__item := a_pasteboard_attached.item
			end
			make_with_pointer (objc_init_with_pasteboard_(allocate_object, a_pasteboard__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_data_ignoring_orientation_ (a_data: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			make_with_pointer (objc_init_with_data_ignoring_orientation_(allocate_object, a_data__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_cg_image__size_ (a_cg_image: UNSUPPORTED_TYPE; a_size: NS_SIZE)
--			-- Initialize `Current'.
--		local
--			a_cg_image__item: POINTER
--		do
--			if attached a_cg_image as a_cg_image_attached then
--				a_cg_image__item := a_cg_image_attached.item
--			end
--			make_with_pointer (objc_init_with_cg_image__size_(allocate_object, a_cg_image__item, a_size.item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSImage Externals

	objc_init_with_size_ (an_item: POINTER; a_size: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item initWithSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_init_with_data_ (an_item: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item initWithData:$a_data];
			 ]"
		end

	objc_init_with_contents_of_file_ (an_item: POINTER; a_file_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item initWithContentsOfFile:$a_file_name];
			 ]"
		end

	objc_init_with_contents_of_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item initWithContentsOfURL:$a_url];
			 ]"
		end

	objc_init_by_referencing_file_ (an_item: POINTER; a_file_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item initByReferencingFile:$a_file_name];
			 ]"
		end

	objc_init_by_referencing_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item initByReferencingURL:$a_url];
			 ]"
		end

--	objc_init_with_icon_ref_ (an_item: POINTER; a_icon_ref: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSImage *)$an_item initWithIconRef:];
--			 ]"
--		end

	objc_init_with_pasteboard_ (an_item: POINTER; a_pasteboard: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item initWithPasteboard:$a_pasteboard];
			 ]"
		end

	objc_init_with_data_ignoring_orientation_ (an_item: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item initWithDataIgnoringOrientation:$a_data];
			 ]"
		end

	objc_set_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item setSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSImage *)$an_item size];
			 ]"
		end

	objc_set_name_ (an_item: POINTER; a_string: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImage *)$an_item setName:$a_string];
			 ]"
		end

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item name];
			 ]"
		end

	objc_set_background_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item setBackgroundColor:$a_color];
			 ]"
		end

	objc_background_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item backgroundColor];
			 ]"
		end

	objc_set_uses_eps_on_resolution_mismatch_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item setUsesEPSOnResolutionMismatch:$a_flag];
			 ]"
		end

	objc_uses_eps_on_resolution_mismatch (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImage *)$an_item usesEPSOnResolutionMismatch];
			 ]"
		end

	objc_set_prefers_color_match_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item setPrefersColorMatch:$a_flag];
			 ]"
		end

	objc_prefers_color_match (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImage *)$an_item prefersColorMatch];
			 ]"
		end

	objc_set_matches_on_multiple_resolution_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item setMatchesOnMultipleResolution:$a_flag];
			 ]"
		end

	objc_matches_on_multiple_resolution (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImage *)$an_item matchesOnMultipleResolution];
			 ]"
		end

	objc_draw_at_point__from_rect__operation__fraction_ (an_item: POINTER; a_point: POINTER; a_from_rect: POINTER; a_op: NATURAL_64; a_delta: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item drawAtPoint:*((NSPoint *)$a_point) fromRect:*((NSRect *)$a_from_rect) operation:$a_op fraction:$a_delta];
			 ]"
		end

	objc_draw_in_rect__from_rect__operation__fraction_ (an_item: POINTER; a_rect: POINTER; a_from_rect: POINTER; a_op: NATURAL_64; a_delta: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item drawInRect:*((NSRect *)$a_rect) fromRect:*((NSRect *)$a_from_rect) operation:$a_op fraction:$a_delta];
			 ]"
		end

	objc_draw_in_rect__from_rect__operation__fraction__respect_flipped__hints_ (an_item: POINTER; a_dst_space_portion_rect: POINTER; a_src_space_portion_rect: POINTER; a_op: NATURAL_64; a_requested_alpha: REAL_64; a_respect_context_is_flipped: BOOLEAN; a_hints: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item drawInRect:*((NSRect *)$a_dst_space_portion_rect) fromRect:*((NSRect *)$a_src_space_portion_rect) operation:$a_op fraction:$a_requested_alpha respectFlipped:$a_respect_context_is_flipped hints:$a_hints];
			 ]"
		end

	objc_draw_representation__in_rect_ (an_item: POINTER; a_image_rep: POINTER; a_rect: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImage *)$an_item drawRepresentation:$a_image_rep inRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_recache (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item recache];
			 ]"
		end

	objc_tiff_representation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item TIFFRepresentation];
			 ]"
		end

	objc_tiff_representation_using_compression__factor_ (an_item: POINTER; a_comp: NATURAL_64; a_float: REAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item TIFFRepresentationUsingCompression:$a_comp factor:$a_float];
			 ]"
		end

	objc_representations (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item representations];
			 ]"
		end

	objc_add_representations_ (an_item: POINTER; a_image_reps: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item addRepresentations:$a_image_reps];
			 ]"
		end

	objc_add_representation_ (an_item: POINTER; a_image_rep: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item addRepresentation:$a_image_rep];
			 ]"
		end

	objc_remove_representation_ (an_item: POINTER; a_image_rep: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item removeRepresentation:$a_image_rep];
			 ]"
		end

	objc_is_valid (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImage *)$an_item isValid];
			 ]"
		end

	objc_lock_focus (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item lockFocus];
			 ]"
		end

	objc_lock_focus_flipped_ (an_item: POINTER; a_flipped: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item lockFocusFlipped:$a_flipped];
			 ]"
		end

	objc_unlock_focus (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item unlockFocus];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item setDelegate:$an_object];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item delegate];
			 ]"
		end

	objc_cancel_incremental_load (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item cancelIncrementalLoad];
			 ]"
		end

	objc_set_cache_mode_ (an_item: POINTER; a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item setCacheMode:$a_mode];
			 ]"
		end

	objc_cache_mode (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImage *)$an_item cacheMode];
			 ]"
		end

	objc_alignment_rect (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSImage *)$an_item alignmentRect];
			 ]"
		end

	objc_set_alignment_rect_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item setAlignmentRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_is_template (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImage *)$an_item isTemplate];
			 ]"
		end

	objc_set_template_ (an_item: POINTER; a_is_template: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item setTemplate:$a_is_template];
			 ]"
		end

	objc_accessibility_description (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item accessibilityDescription];
			 ]"
		end

	objc_set_accessibility_description_ (an_item: POINTER; a_description: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item setAccessibilityDescription:$a_description];
			 ]"
		end

--	objc_init_with_cg_image__size_ (an_item: POINTER; a_cg_image: UNSUPPORTED_TYPE; a_size: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSImage *)$an_item initWithCGImage: size:*((NSSize *)$a_size)];
--			 ]"
--		end

--	objc_cg_image_for_proposed_rect__context__hints_ (an_item: POINTER; a_proposed_dest_rect: UNSUPPORTED_TYPE; a_reference_context: POINTER; a_hints: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSImage *)$an_item CGImageForProposedRect: context:$a_reference_context hints:$a_hints];
--			 ]"
--		end

	objc_best_representation_for_rect__context__hints_ (an_item: POINTER; a_rect: POINTER; a_reference_context: POINTER; a_hints: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImage *)$an_item bestRepresentationForRect:*((NSRect *)$a_rect) context:$a_reference_context hints:$a_hints];
			 ]"
		end

	objc_hit_test_rect__with_image_destination_rect__context__hints__flipped_ (an_item: POINTER; a_test_rect_dest_space: POINTER; a_image_rect_dest_space: POINTER; a_context: POINTER; a_hints: POINTER; a_flipped: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImage *)$an_item hitTestRect:*((NSRect *)$a_test_rect_dest_space) withImageDestinationRect:*((NSRect *)$a_image_rect_dest_space) context:$a_context hints:$a_hints flipped:$a_flipped];
			 ]"
		end

feature -- NSImage

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

	set_name_ (a_string: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			Result := objc_set_name_ (item, a_string__item)
		end

	name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_background_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_background_color_ (item, a_color__item)
		end

	background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_background_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_uses_eps_on_resolution_mismatch_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_eps_on_resolution_mismatch_ (item, a_flag)
		end

	uses_eps_on_resolution_mismatch: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_eps_on_resolution_mismatch (item)
		end

	set_prefers_color_match_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_prefers_color_match_ (item, a_flag)
		end

	prefers_color_match: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_prefers_color_match (item)
		end

	set_matches_on_multiple_resolution_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_matches_on_multiple_resolution_ (item, a_flag)
		end

	matches_on_multiple_resolution: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_matches_on_multiple_resolution (item)
		end

	draw_at_point__from_rect__operation__fraction_ (a_point: NS_POINT; a_from_rect: NS_RECT; a_op: NATURAL_64; a_delta: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_at_point__from_rect__operation__fraction_ (item, a_point.item, a_from_rect.item, a_op, a_delta)
		end

	draw_in_rect__from_rect__operation__fraction_ (a_rect: NS_RECT; a_from_rect: NS_RECT; a_op: NATURAL_64; a_delta: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_in_rect__from_rect__operation__fraction_ (item, a_rect.item, a_from_rect.item, a_op, a_delta)
		end

	draw_in_rect__from_rect__operation__fraction__respect_flipped__hints_ (a_dst_space_portion_rect: NS_RECT; a_src_space_portion_rect: NS_RECT; a_op: NATURAL_64; a_requested_alpha: REAL_64; a_respect_context_is_flipped: BOOLEAN; a_hints: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_hints__item: POINTER
		do
			if attached a_hints as a_hints_attached then
				a_hints__item := a_hints_attached.item
			end
			objc_draw_in_rect__from_rect__operation__fraction__respect_flipped__hints_ (item, a_dst_space_portion_rect.item, a_src_space_portion_rect.item, a_op, a_requested_alpha, a_respect_context_is_flipped, a_hints__item)
		end

	draw_representation__in_rect_ (a_image_rep: detachable NS_IMAGE_REP; a_rect: NS_RECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_image_rep__item: POINTER
		do
			if attached a_image_rep as a_image_rep_attached then
				a_image_rep__item := a_image_rep_attached.item
			end
			Result := objc_draw_representation__in_rect_ (item, a_image_rep__item, a_rect.item)
		end

	recache
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_recache (item)
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

	tiff_representation_using_compression__factor_ (a_comp: NATURAL_64; a_float: REAL_32): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_tiff_representation_using_compression__factor_ (item, a_comp, a_float)
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

	representations: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_representations (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like representations} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like representations} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_representations_ (a_image_reps: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_image_reps__item: POINTER
		do
			if attached a_image_reps as a_image_reps_attached then
				a_image_reps__item := a_image_reps_attached.item
			end
			objc_add_representations_ (item, a_image_reps__item)
		end

	add_representation_ (a_image_rep: detachable NS_IMAGE_REP)
			-- Auto generated Objective-C wrapper.
		local
			a_image_rep__item: POINTER
		do
			if attached a_image_rep as a_image_rep_attached then
				a_image_rep__item := a_image_rep_attached.item
			end
			objc_add_representation_ (item, a_image_rep__item)
		end

	remove_representation_ (a_image_rep: detachable NS_IMAGE_REP)
			-- Auto generated Objective-C wrapper.
		local
			a_image_rep__item: POINTER
		do
			if attached a_image_rep as a_image_rep_attached then
				a_image_rep__item := a_image_rep_attached.item
			end
			objc_remove_representation_ (item, a_image_rep__item)
		end

	is_valid: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_valid (item)
		end

	lock_focus
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_lock_focus (item)
		end

	lock_focus_flipped_ (a_flipped: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_lock_focus_flipped_ (item, a_flipped)
		end

	unlock_focus
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_unlock_focus (item)
		end

	set_delegate_ (an_object: detachable NS_IMAGE_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

	delegate: detachable NS_IMAGE_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	cancel_incremental_load
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_cancel_incremental_load (item)
		end

	set_cache_mode_ (a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_cache_mode_ (item, a_mode)
		end

	cache_mode: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_cache_mode (item)
		end

	alignment_rect: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_alignment_rect (item, Result.item)
		end

	set_alignment_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_alignment_rect_ (item, a_rect.item)
		end

	is_template: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_template (item)
		end

	set_template_ (a_is_template: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_template_ (item, a_is_template)
		end

	accessibility_description: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_accessibility_description (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like accessibility_description} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like accessibility_description} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_accessibility_description_ (a_description: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_description__item: POINTER
		do
			if attached a_description as a_description_attached then
				a_description__item := a_description_attached.item
			end
			objc_set_accessibility_description_ (item, a_description__item)
		end

--	cg_image_for_proposed_rect__context__hints_ (a_proposed_dest_rect: UNSUPPORTED_TYPE; a_reference_context: detachable NS_GRAPHICS_CONTEXT; a_hints: detachable NS_DICTIONARY): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_proposed_dest_rect__item: POINTER
--			a_reference_context__item: POINTER
--			a_hints__item: POINTER
--		do
--			if attached a_proposed_dest_rect as a_proposed_dest_rect_attached then
--				a_proposed_dest_rect__item := a_proposed_dest_rect_attached.item
--			end
--			if attached a_reference_context as a_reference_context_attached then
--				a_reference_context__item := a_reference_context_attached.item
--			end
--			if attached a_hints as a_hints_attached then
--				a_hints__item := a_hints_attached.item
--			end
--			result_pointer := objc_cg_image_for_proposed_rect__context__hints_ (item, a_proposed_dest_rect__item, a_reference_context__item, a_hints__item)
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

	best_representation_for_rect__context__hints_ (a_rect: NS_RECT; a_reference_context: detachable NS_GRAPHICS_CONTEXT; a_hints: detachable NS_DICTIONARY): detachable NS_IMAGE_REP
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_reference_context__item: POINTER
			a_hints__item: POINTER
		do
			if attached a_reference_context as a_reference_context_attached then
				a_reference_context__item := a_reference_context_attached.item
			end
			if attached a_hints as a_hints_attached then
				a_hints__item := a_hints_attached.item
			end
			result_pointer := objc_best_representation_for_rect__context__hints_ (item, a_rect.item, a_reference_context__item, a_hints__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like best_representation_for_rect__context__hints_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like best_representation_for_rect__context__hints_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	hit_test_rect__with_image_destination_rect__context__hints__flipped_ (a_test_rect_dest_space: NS_RECT; a_image_rect_dest_space: NS_RECT; a_context: detachable NS_GRAPHICS_CONTEXT; a_hints: detachable NS_DICTIONARY; a_flipped: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_context__item: POINTER
			a_hints__item: POINTER
		do
			if attached a_context as a_context_attached then
				a_context__item := a_context_attached.item
			end
			if attached a_hints as a_hints_attached then
				a_hints__item := a_hints_attached.item
			end
			Result := objc_hit_test_rect__with_image_destination_rect__context__hints__flipped_ (item, a_test_rect_dest_space.item, a_image_rect_dest_space.item, a_context__item, a_hints__item, a_flipped)
		end

feature -- NSDeprecated

	set_flipped_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_flipped_ (item, a_flag)
		end

	is_flipped: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_flipped (item)
		end

	dissolve_to_point__fraction_ (a_point: NS_POINT; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_dissolve_to_point__fraction_ (item, a_point.item, a_float)
		end

	dissolve_to_point__from_rect__fraction_ (a_point: NS_POINT; a_rect: NS_RECT; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_dissolve_to_point__from_rect__fraction_ (item, a_point.item, a_rect.item, a_float)
		end

	composite_to_point__operation_ (a_point: NS_POINT; a_op: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_composite_to_point__operation_ (item, a_point.item, a_op)
		end

	composite_to_point__from_rect__operation_ (a_point: NS_POINT; a_rect: NS_RECT; a_op: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_composite_to_point__from_rect__operation_ (item, a_point.item, a_rect.item, a_op)
		end

	composite_to_point__operation__fraction_ (a_point: NS_POINT; a_op: NATURAL_64; a_delta: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_composite_to_point__operation__fraction_ (item, a_point.item, a_op, a_delta)
		end

	composite_to_point__from_rect__operation__fraction_ (a_point: NS_POINT; a_rect: NS_RECT; a_op: NATURAL_64; a_delta: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_composite_to_point__from_rect__operation__fraction_ (item, a_point.item, a_rect.item, a_op, a_delta)
		end

	lock_focus_on_representation_ (a_image_representation: detachable NS_IMAGE_REP)
			-- Auto generated Objective-C wrapper.
		local
			a_image_representation__item: POINTER
		do
			if attached a_image_representation as a_image_representation_attached then
				a_image_representation__item := a_image_representation_attached.item
			end
			objc_lock_focus_on_representation_ (item, a_image_representation__item)
		end

	set_scales_when_resized_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_scales_when_resized_ (item, a_flag)
		end

	scales_when_resized: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_scales_when_resized (item)
		end

	set_data_retained_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_data_retained_ (item, a_flag)
		end

	is_data_retained: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_data_retained (item)
		end

	set_cached_separately_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_cached_separately_ (item, a_flag)
		end

	is_cached_separately: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_cached_separately (item)
		end

	set_cache_depth_matches_image_depth_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_cache_depth_matches_image_depth_ (item, a_flag)
		end

	cache_depth_matches_image_depth: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_cache_depth_matches_image_depth (item)
		end

feature {NONE} -- NSDeprecated Externals

	objc_set_flipped_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item setFlipped:$a_flag];
			 ]"
		end

	objc_is_flipped (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImage *)$an_item isFlipped];
			 ]"
		end

	objc_dissolve_to_point__fraction_ (an_item: POINTER; a_point: POINTER; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item dissolveToPoint:*((NSPoint *)$a_point) fraction:$a_float];
			 ]"
		end

	objc_dissolve_to_point__from_rect__fraction_ (an_item: POINTER; a_point: POINTER; a_rect: POINTER; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item dissolveToPoint:*((NSPoint *)$a_point) fromRect:*((NSRect *)$a_rect) fraction:$a_float];
			 ]"
		end

	objc_composite_to_point__operation_ (an_item: POINTER; a_point: POINTER; a_op: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item compositeToPoint:*((NSPoint *)$a_point) operation:$a_op];
			 ]"
		end

	objc_composite_to_point__from_rect__operation_ (an_item: POINTER; a_point: POINTER; a_rect: POINTER; a_op: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item compositeToPoint:*((NSPoint *)$a_point) fromRect:*((NSRect *)$a_rect) operation:$a_op];
			 ]"
		end

	objc_composite_to_point__operation__fraction_ (an_item: POINTER; a_point: POINTER; a_op: NATURAL_64; a_delta: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item compositeToPoint:*((NSPoint *)$a_point) operation:$a_op fraction:$a_delta];
			 ]"
		end

	objc_composite_to_point__from_rect__operation__fraction_ (an_item: POINTER; a_point: POINTER; a_rect: POINTER; a_op: NATURAL_64; a_delta: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item compositeToPoint:*((NSPoint *)$a_point) fromRect:*((NSRect *)$a_rect) operation:$a_op fraction:$a_delta];
			 ]"
		end

	objc_lock_focus_on_representation_ (an_item: POINTER; a_image_representation: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item lockFocusOnRepresentation:$a_image_representation];
			 ]"
		end

	objc_set_scales_when_resized_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item setScalesWhenResized:$a_flag];
			 ]"
		end

	objc_scales_when_resized (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImage *)$an_item scalesWhenResized];
			 ]"
		end

	objc_set_data_retained_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item setDataRetained:$a_flag];
			 ]"
		end

	objc_is_data_retained (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImage *)$an_item isDataRetained];
			 ]"
		end

	objc_set_cached_separately_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item setCachedSeparately:$a_flag];
			 ]"
		end

	objc_is_cached_separately (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImage *)$an_item isCachedSeparately];
			 ]"
		end

	objc_set_cache_depth_matches_image_depth_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImage *)$an_item setCacheDepthMatchesImageDepth:$a_flag];
			 ]"
		end

	objc_cache_depth_matches_image_depth (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImage *)$an_item cacheDepthMatchesImageDepth];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSImage"
		end

end
