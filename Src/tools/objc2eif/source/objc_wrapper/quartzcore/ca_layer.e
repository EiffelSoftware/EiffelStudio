note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_LAYER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	CA_MEDIA_TIMING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make,
	make_with_layer_

feature {NONE} -- Initialization

	make_with_layer_ (a_layer: detachable NS_OBJECT)
			-- Initialize `Current'.
		local
			a_layer__item: POINTER
		do
			if attached a_layer as a_layer_attached then
				a_layer__item := a_layer_attached.item
			end
			make_with_pointer (objc_init_with_layer_(allocate_object, a_layer__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- CALayer Externals

	objc_init_with_layer_ (an_item: POINTER; a_layer: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item initWithLayer:$a_layer];
			 ]"
		end

	objc_presentation_layer (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item presentationLayer];
			 ]"
		end

	objc_model_layer (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item modelLayer];
			 ]"
		end

	objc_should_archive_value_for_key_ (an_item: POINTER; a_key: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item shouldArchiveValueForKey:$a_key];
			 ]"
		end

	objc_affine_transform (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CGAffineTransform *)$result_pointer = [(CALayer *)$an_item affineTransform];
			 ]"
		end

	objc_set_affine_transform_ (an_item: POINTER; a_m: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setAffineTransform:*((CGAffineTransform *)$a_m)];
			 ]"
		end

	objc_contents_are_flipped (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item contentsAreFlipped];
			 ]"
		end

	objc_remove_from_superlayer (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item removeFromSuperlayer];
			 ]"
		end

	objc_add_sublayer_ (an_item: POINTER; a_layer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item addSublayer:$a_layer];
			 ]"
		end

	objc_insert_sublayer__at_index_ (an_item: POINTER; a_layer: POINTER; a_idx: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item insertSublayer:$a_layer atIndex:$a_idx];
			 ]"
		end

	objc_insert_sublayer__below_ (an_item: POINTER; a_layer: POINTER; a_sibling: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item insertSublayer:$a_layer below:$a_sibling];
			 ]"
		end

	objc_insert_sublayer__above_ (an_item: POINTER; a_layer: POINTER; a_sibling: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item insertSublayer:$a_layer above:$a_sibling];
			 ]"
		end

	objc_replace_sublayer__with_ (an_item: POINTER; a_layer: POINTER; a_layer2: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item replaceSublayer:$a_layer with:$a_layer2];
			 ]"
		end

	objc_convert_point__from_layer_ (an_item: POINTER; result_pointer: POINTER; a_p: POINTER; a_l: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CGPoint *)$result_pointer = [(CALayer *)$an_item convertPoint:*((CGPoint *)$a_p) fromLayer:$a_l];
			 ]"
		end

	objc_convert_point__to_layer_ (an_item: POINTER; result_pointer: POINTER; a_p: POINTER; a_l: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CGPoint *)$result_pointer = [(CALayer *)$an_item convertPoint:*((CGPoint *)$a_p) toLayer:$a_l];
			 ]"
		end

	objc_convert_rect__from_layer_ (an_item: POINTER; result_pointer: POINTER; a_r: POINTER; a_l: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CGRect *)$result_pointer = [(CALayer *)$an_item convertRect:*((CGRect *)$a_r) fromLayer:$a_l];
			 ]"
		end

	objc_convert_rect__to_layer_ (an_item: POINTER; result_pointer: POINTER; a_r: POINTER; a_l: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CGRect *)$result_pointer = [(CALayer *)$an_item convertRect:*((CGRect *)$a_r) toLayer:$a_l];
			 ]"
		end

	objc_convert_time__from_layer_ (an_item: POINTER; a_t: REAL_64; a_l: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item convertTime:$a_t fromLayer:$a_l];
			 ]"
		end

	objc_convert_time__to_layer_ (an_item: POINTER; a_t: REAL_64; a_l: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item convertTime:$a_t toLayer:$a_l];
			 ]"
		end

	objc_hit_test_ (an_item: POINTER; a_p: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item hitTest:*((CGPoint *)$a_p)];
			 ]"
		end

	objc_contains_point_ (an_item: POINTER; a_p: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item containsPoint:*((CGPoint *)$a_p)];
			 ]"
		end

	objc_display (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item display];
			 ]"
		end

	objc_set_needs_display (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setNeedsDisplay];
			 ]"
		end

	objc_set_needs_display_in_rect_ (an_item: POINTER; a_r: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setNeedsDisplayInRect:*((CGRect *)$a_r)];
			 ]"
		end

	objc_needs_display (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item needsDisplay];
			 ]"
		end

	objc_display_if_needed (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item displayIfNeeded];
			 ]"
		end

--	objc_draw_in_context_ (an_item: POINTER; a_ctx: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				[(CALayer *)$an_item drawInContext:];
--			 ]"
--		end

--	objc_render_in_context_ (an_item: POINTER; a_ctx: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				[(CALayer *)$an_item renderInContext:];
--			 ]"
--		end

	objc_preferred_frame_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CGSize *)$result_pointer = [(CALayer *)$an_item preferredFrameSize];
			 ]"
		end

	objc_set_needs_layout (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setNeedsLayout];
			 ]"
		end

	objc_needs_layout (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item needsLayout];
			 ]"
		end

	objc_layout_if_needed (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item layoutIfNeeded];
			 ]"
		end

	objc_layout_sublayers (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item layoutSublayers];
			 ]"
		end

	objc_resize_sublayers_with_old_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item resizeSublayersWithOldSize:*((CGSize *)$a_size)];
			 ]"
		end

	objc_resize_with_old_superlayer_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item resizeWithOldSuperlayerSize:*((CGSize *)$a_size)];
			 ]"
		end

	objc_action_for_key_ (an_item: POINTER; a_event: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item actionForKey:$a_event];
			 ]"
		end

--	objc_add_animation__for_key_ (an_item: POINTER; a_anim: POINTER; a_key: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				[(CALayer *)$an_item addAnimation:$a_anim forKey:$a_key];
--			 ]"
--		end

	objc_remove_all_animations (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item removeAllAnimations];
			 ]"
		end

	objc_remove_animation_for_key_ (an_item: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item removeAnimationForKey:$a_key];
			 ]"
		end

	objc_animation_keys (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item animationKeys];
			 ]"
		end

--	objc_animation_for_key_ (an_item: POINTER; a_key: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CALayer *)$an_item animationForKey:$a_key];
--			 ]"
--		end

feature -- CALayer

	presentation_layer: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_presentation_layer (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like presentation_layer} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like presentation_layer} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	model_layer: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_model_layer (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like model_layer} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like model_layer} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	should_archive_value_for_key_ (a_key: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_should_archive_value_for_key_ (item, a_key__item)
		end

	affine_transform: CG_AFFINE_TRANSFORM
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_affine_transform (item, Result.item)
		end

	set_affine_transform_ (a_m: CG_AFFINE_TRANSFORM)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_affine_transform_ (item, a_m.item)
		end

	contents_are_flipped: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_contents_are_flipped (item)
		end

	remove_from_superlayer
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_from_superlayer (item)
		end

	add_sublayer_ (a_layer: detachable CA_LAYER)
			-- Auto generated Objective-C wrapper.
		local
			a_layer__item: POINTER
		do
			if attached a_layer as a_layer_attached then
				a_layer__item := a_layer_attached.item
			end
			objc_add_sublayer_ (item, a_layer__item)
		end

	insert_sublayer__at_index_ (a_layer: detachable CA_LAYER; a_idx: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		local
			a_layer__item: POINTER
		do
			if attached a_layer as a_layer_attached then
				a_layer__item := a_layer_attached.item
			end
			objc_insert_sublayer__at_index_ (item, a_layer__item, a_idx)
		end

	insert_sublayer__below_ (a_layer: detachable CA_LAYER; a_sibling: detachable CA_LAYER)
			-- Auto generated Objective-C wrapper.
		local
			a_layer__item: POINTER
			a_sibling__item: POINTER
		do
			if attached a_layer as a_layer_attached then
				a_layer__item := a_layer_attached.item
			end
			if attached a_sibling as a_sibling_attached then
				a_sibling__item := a_sibling_attached.item
			end
			objc_insert_sublayer__below_ (item, a_layer__item, a_sibling__item)
		end

	insert_sublayer__above_ (a_layer: detachable CA_LAYER; a_sibling: detachable CA_LAYER)
			-- Auto generated Objective-C wrapper.
		local
			a_layer__item: POINTER
			a_sibling__item: POINTER
		do
			if attached a_layer as a_layer_attached then
				a_layer__item := a_layer_attached.item
			end
			if attached a_sibling as a_sibling_attached then
				a_sibling__item := a_sibling_attached.item
			end
			objc_insert_sublayer__above_ (item, a_layer__item, a_sibling__item)
		end

	replace_sublayer__with_ (a_layer: detachable CA_LAYER; a_layer2: detachable CA_LAYER)
			-- Auto generated Objective-C wrapper.
		local
			a_layer__item: POINTER
			a_layer2__item: POINTER
		do
			if attached a_layer as a_layer_attached then
				a_layer__item := a_layer_attached.item
			end
			if attached a_layer2 as a_layer2_attached then
				a_layer2__item := a_layer2_attached.item
			end
			objc_replace_sublayer__with_ (item, a_layer__item, a_layer2__item)
		end

	convert_point__from_layer_ (a_p: CG_POINT; a_l: detachable CA_LAYER): CG_POINT
			-- Auto generated Objective-C wrapper.
		local
			a_l__item: POINTER
		do
			if attached a_l as a_l_attached then
				a_l__item := a_l_attached.item
			end
			create Result.make
			objc_convert_point__from_layer_ (item, Result.item, a_p.item, a_l__item)
		end

	convert_point__to_layer_ (a_p: CG_POINT; a_l: detachable CA_LAYER): CG_POINT
			-- Auto generated Objective-C wrapper.
		local
			a_l__item: POINTER
		do
			if attached a_l as a_l_attached then
				a_l__item := a_l_attached.item
			end
			create Result.make
			objc_convert_point__to_layer_ (item, Result.item, a_p.item, a_l__item)
		end

	convert_rect__from_layer_ (a_r: CG_RECT; a_l: detachable CA_LAYER): CG_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_l__item: POINTER
		do
			if attached a_l as a_l_attached then
				a_l__item := a_l_attached.item
			end
			create Result.make
			objc_convert_rect__from_layer_ (item, Result.item, a_r.item, a_l__item)
		end

	convert_rect__to_layer_ (a_r: CG_RECT; a_l: detachable CA_LAYER): CG_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_l__item: POINTER
		do
			if attached a_l as a_l_attached then
				a_l__item := a_l_attached.item
			end
			create Result.make
			objc_convert_rect__to_layer_ (item, Result.item, a_r.item, a_l__item)
		end

	convert_time__from_layer_ (a_t: REAL_64; a_l: detachable CA_LAYER): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_l__item: POINTER
		do
			if attached a_l as a_l_attached then
				a_l__item := a_l_attached.item
			end
			Result := objc_convert_time__from_layer_ (item, a_t, a_l__item)
		end

	convert_time__to_layer_ (a_t: REAL_64; a_l: detachable CA_LAYER): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_l__item: POINTER
		do
			if attached a_l as a_l_attached then
				a_l__item := a_l_attached.item
			end
			Result := objc_convert_time__to_layer_ (item, a_t, a_l__item)
		end

	hit_test_ (a_p: CG_POINT): detachable CA_LAYER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_hit_test_ (item, a_p.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like hit_test_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like hit_test_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	contains_point_ (a_p: CG_POINT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_contains_point_ (item, a_p.item)
		end

	display
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_display (item)
		end

	set_needs_display
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_needs_display (item)
		end

	set_needs_display_in_rect_ (a_r: CG_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_needs_display_in_rect_ (item, a_r.item)
		end

	needs_display: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_needs_display (item)
		end

	display_if_needed
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_display_if_needed (item)
		end

--	draw_in_context_ (a_ctx: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_ctx__item: POINTER
--		do
--			if attached a_ctx as a_ctx_attached then
--				a_ctx__item := a_ctx_attached.item
--			end
--			objc_draw_in_context_ (item, a_ctx__item)
--		end

--	render_in_context_ (a_ctx: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_ctx__item: POINTER
--		do
--			if attached a_ctx as a_ctx_attached then
--				a_ctx__item := a_ctx_attached.item
--			end
--			objc_render_in_context_ (item, a_ctx__item)
--		end

	preferred_frame_size: CG_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_preferred_frame_size (item, Result.item)
		end

	set_needs_layout
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_needs_layout (item)
		end

	needs_layout: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_needs_layout (item)
		end

	layout_if_needed
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_layout_if_needed (item)
		end

	layout_sublayers
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_layout_sublayers (item)
		end

	resize_sublayers_with_old_size_ (a_size: CG_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_resize_sublayers_with_old_size_ (item, a_size.item)
		end

	resize_with_old_superlayer_size_ (a_size: CG_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_resize_with_old_superlayer_size_ (item, a_size.item)
		end

	action_for_key_ (a_event: detachable NS_STRING): detachable CA_ACTION_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			result_pointer := objc_action_for_key_ (item, a_event__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like action_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like action_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	add_animation__for_key_ (a_anim: UNSUPPORTED_TYPE; a_key: detachable NS_STRING)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_key__item: POINTER
--		do
--			if attached a_key as a_key_attached then
--				a_key__item := a_key_attached.item
--			end
--			objc_add_animation__for_key_ (item, , a_key__item)
--		end

	remove_all_animations
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_all_animations (item)
		end

	remove_animation_for_key_ (a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_remove_animation_for_key_ (item, a_key__item)
		end

	animation_keys: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_animation_keys (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like animation_keys} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like animation_keys} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	animation_for_key_ (a_key: detachable NS_STRING): detachable UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_key__item: POINTER
--		do
--			if attached a_key as a_key_attached then
--				a_key__item := a_key_attached.item
--			end
--			result_pointer := objc_animation_for_key_ (item, a_key__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like animation_for_key_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like animation_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature -- Properties

	bounds: CG_RECT assign set_bounds
			-- Auto generated Objective-C wrapper.
		do
			create Result.make
			objc_bounds (item, Result.item)
		end

	set_bounds (an_arg: CG_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bounds (item, an_arg.item)
		end

	position: CG_POINT assign set_position
			-- Auto generated Objective-C wrapper.
		do
			create Result.make
			objc_position (item, Result.item)
		end

	set_position (an_arg: CG_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_position (item, an_arg.item)
		end

	z_position: REAL_64 assign set_z_position
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_z_position (item)
		end

	set_z_position (an_arg: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_z_position (item, an_arg)
		end

	anchor_point: CG_POINT assign set_anchor_point
			-- Auto generated Objective-C wrapper.
		do
			create Result.make
			objc_anchor_point (item, Result.item)
		end

	set_anchor_point (an_arg: CG_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_anchor_point (item, an_arg.item)
		end

	anchor_point_z: REAL_64 assign set_anchor_point_z
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_anchor_point_z (item)
		end

	set_anchor_point_z (an_arg: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_anchor_point_z (item, an_arg)
		end

	transform: CA_TRANSFORM3D assign set_transform
			-- Auto generated Objective-C wrapper.
		do
			create Result.make
			objc_transform (item, Result.item)
		end

	set_transform (an_arg: CA_TRANSFORM3D)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_transform (item, an_arg.item)
		end

	frame: CG_RECT assign set_frame
			-- Auto generated Objective-C wrapper.
		do
			create Result.make
			objc_frame (item, Result.item)
		end

	set_frame (an_arg: CG_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_frame (item, an_arg.item)
		end

	is_hidden: BOOLEAN assign set_hidden
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_is_hidden (item)
		end

	set_hidden (an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_hidden (item, an_arg)
		end

	is_double_sided: BOOLEAN assign set_double_sided
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_is_double_sided (item)
		end

	set_double_sided (an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_double_sided (item, an_arg)
		end

	is_geometry_flipped: BOOLEAN assign set_geometry_flipped
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_is_geometry_flipped (item)
		end

	set_geometry_flipped (an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_geometry_flipped (item, an_arg)
		end

	superlayer: detachable CA_LAYER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_superlayer (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like superlayer} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like superlayer} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	sublayers: detachable NS_ARRAY assign set_sublayers
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_sublayers (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like sublayers} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like sublayers} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_sublayers (an_arg: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_sublayers (item, an_arg__item)
		end

	sublayer_transform: CA_TRANSFORM3D assign set_sublayer_transform
			-- Auto generated Objective-C wrapper.
		do
			create Result.make
			objc_sublayer_transform (item, Result.item)
		end

	set_sublayer_transform (an_arg: CA_TRANSFORM3D)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_sublayer_transform (item, an_arg.item)
		end

	mask: detachable CA_LAYER assign set_mask
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_mask (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mask} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mask} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_mask (an_arg: detachable CA_LAYER)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_mask (item, an_arg__item)
		end

	masks_to_bounds: BOOLEAN assign set_masks_to_bounds
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_masks_to_bounds (item)
		end

	set_masks_to_bounds (an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_masks_to_bounds (item, an_arg)
		end

	contents: detachable NS_OBJECT assign set_contents
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_contents (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like contents} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like contents} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_contents (an_arg: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_contents (item, an_arg__item)
		end

	contents_rect: CG_RECT assign set_contents_rect
			-- Auto generated Objective-C wrapper.
		do
			create Result.make
			objc_contents_rect (item, Result.item)
		end

	set_contents_rect (an_arg: CG_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_contents_rect (item, an_arg.item)
		end

	contents_gravity: detachable NS_STRING assign set_contents_gravity
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_contents_gravity (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like contents_gravity} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like contents_gravity} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_contents_gravity (an_arg: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_contents_gravity (item, an_arg__item)
		end

	contents_center: CG_RECT assign set_contents_center
			-- Auto generated Objective-C wrapper.
		do
			create Result.make
			objc_contents_center (item, Result.item)
		end

	set_contents_center (an_arg: CG_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_contents_center (item, an_arg.item)
		end

	minification_filter: detachable NS_STRING assign set_minification_filter
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_minification_filter (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like minification_filter} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like minification_filter} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_minification_filter (an_arg: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_minification_filter (item, an_arg__item)
		end

	magnification_filter: detachable NS_STRING assign set_magnification_filter
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_magnification_filter (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like magnification_filter} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like magnification_filter} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_magnification_filter (an_arg: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_magnification_filter (item, an_arg__item)
		end

	minification_filter_bias: REAL_32 assign set_minification_filter_bias
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_minification_filter_bias (item)
		end

	set_minification_filter_bias (an_arg: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_minification_filter_bias (item, an_arg)
		end

	is_opaque: BOOLEAN assign set_opaque
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_is_opaque (item)
		end

	set_opaque (an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_opaque (item, an_arg)
		end

	needs_display_on_bounds_change: BOOLEAN assign set_needs_display_on_bounds_change
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_needs_display_on_bounds_change (item)
		end

	set_needs_display_on_bounds_change (an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_needs_display_on_bounds_change (item, an_arg)
		end

	edge_antialiasing_mask: NATURAL_32 assign set_edge_antialiasing_mask
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_edge_antialiasing_mask (item)
		end

	set_edge_antialiasing_mask (an_arg: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_edge_antialiasing_mask (item, an_arg)
		end

--	background_color: UNSUPPORTED_TYPE assign set_background_color
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_background_color (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like background_color} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	set_background_color (an_arg: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			an_arg__item: POINTER
--		do
--			if attached an_arg as an_arg_attached then
--				an_arg__item := an_arg_attached.item
--			end
--			objc_set_background_color (item, an_arg__item)
--		end

	corner_radius: REAL_64 assign set_corner_radius
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_corner_radius (item)
		end

	set_corner_radius (an_arg: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_corner_radius (item, an_arg)
		end

	border_width: REAL_64 assign set_border_width
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_border_width (item)
		end

	set_border_width (an_arg: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_border_width (item, an_arg)
		end

--	border_color: UNSUPPORTED_TYPE assign set_border_color
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_border_color (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like border_color} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like border_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	set_border_color (an_arg: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			an_arg__item: POINTER
--		do
--			if attached an_arg as an_arg_attached then
--				an_arg__item := an_arg_attached.item
--			end
--			objc_set_border_color (item, an_arg__item)
--		end

	opacity: REAL_32 assign set_opacity
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_opacity (item)
		end

	set_opacity (an_arg: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_opacity (item, an_arg)
		end

	compositing_filter: detachable NS_OBJECT assign set_compositing_filter
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_compositing_filter (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like compositing_filter} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like compositing_filter} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_compositing_filter (an_arg: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_compositing_filter (item, an_arg__item)
		end

	filters: detachable NS_ARRAY assign set_filters
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_filters (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like filters} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like filters} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_filters (an_arg: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_filters (item, an_arg__item)
		end

	background_filters: detachable NS_ARRAY assign set_background_filters
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_background_filters (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like background_filters} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like background_filters} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_background_filters (an_arg: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_background_filters (item, an_arg__item)
		end

--	shadow_color: UNSUPPORTED_TYPE assign set_shadow_color
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_shadow_color (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like shadow_color} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like shadow_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	set_shadow_color (an_arg: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			an_arg__item: POINTER
--		do
--			if attached an_arg as an_arg_attached then
--				an_arg__item := an_arg_attached.item
--			end
--			objc_set_shadow_color (item, an_arg__item)
--		end

	shadow_opacity: REAL_32 assign set_shadow_opacity
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_shadow_opacity (item)
		end

	set_shadow_opacity (an_arg: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shadow_opacity (item, an_arg)
		end

	shadow_offset: CG_SIZE assign set_shadow_offset
			-- Auto generated Objective-C wrapper.
		do
			create Result.make
			objc_shadow_offset (item, Result.item)
		end

	set_shadow_offset (an_arg: CG_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shadow_offset (item, an_arg.item)
		end

	shadow_radius: REAL_64 assign set_shadow_radius
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_shadow_radius (item)
		end

	set_shadow_radius (an_arg: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shadow_radius (item, an_arg)
		end

	autoresizing_mask: NATURAL_32 assign set_autoresizing_mask
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_autoresizing_mask (item)
		end

	set_autoresizing_mask (an_arg: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autoresizing_mask (item, an_arg)
		end

	layout_manager: detachable NS_OBJECT assign set_layout_manager
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_layout_manager (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like layout_manager} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like layout_manager} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_layout_manager (an_arg: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_layout_manager (item, an_arg__item)
		end

	actions: detachable NS_DICTIONARY assign set_actions
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_actions (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like actions} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like actions} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_actions (an_arg: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_actions (item, an_arg__item)
		end

	name: detachable NS_STRING assign set_name
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

	set_name (an_arg: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_name (item, an_arg__item)
		end

	delegate: detachable NS_OBJECT assign set_delegate
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

	set_delegate (an_arg: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_delegate (item, an_arg__item)
		end

	style: detachable NS_DICTIONARY assign set_style
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_style (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like style} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like style} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_style (an_arg: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_style (item, an_arg__item)
		end

feature {NONE} -- Properties Externals

	objc_bounds (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CGRect *)$result_pointer = [(CALayer *)$an_item bounds];
			 ]"
		end

	objc_set_bounds (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setBounds:*((CGRect *)$an_arg)]
			 ]"
		end

	objc_position (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CGPoint *)$result_pointer = [(CALayer *)$an_item position];
			 ]"
		end

	objc_set_position (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setPosition:*((CGPoint *)$an_arg)]
			 ]"
		end

	objc_z_position (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item zPosition];
			 ]"
		end

	objc_set_z_position (an_item: POINTER; an_arg: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setZPosition:$an_arg]
			 ]"
		end

	objc_anchor_point (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CGPoint *)$result_pointer = [(CALayer *)$an_item anchorPoint];
			 ]"
		end

	objc_set_anchor_point (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setAnchorPoint:*((CGPoint *)$an_arg)]
			 ]"
		end

	objc_anchor_point_z (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item anchorPointZ];
			 ]"
		end

	objc_set_anchor_point_z (an_item: POINTER; an_arg: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setAnchorPointZ:$an_arg]
			 ]"
		end

	objc_transform (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CATransform3D *)$result_pointer = [(CALayer *)$an_item transform];
			 ]"
		end

	objc_set_transform (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setTransform:*((CATransform3D *)$an_arg)]
			 ]"
		end

	objc_frame (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CGRect *)$result_pointer = [(CALayer *)$an_item frame];
			 ]"
		end

	objc_set_frame (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setFrame:*((CGRect *)$an_arg)]
			 ]"
		end

	objc_is_hidden (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item isHidden];
			 ]"
		end

	objc_set_hidden (an_item: POINTER; an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setHidden:$an_arg]
			 ]"
		end

	objc_is_double_sided (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item isDoubleSided];
			 ]"
		end

	objc_set_double_sided (an_item: POINTER; an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setDoubleSided:$an_arg]
			 ]"
		end

	objc_is_geometry_flipped (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item isGeometryFlipped];
			 ]"
		end

	objc_set_geometry_flipped (an_item: POINTER; an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setGeometryFlipped:$an_arg]
			 ]"
		end

	objc_superlayer (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item superlayer];
			 ]"
		end

	objc_sublayers (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item sublayers];
			 ]"
		end

	objc_set_sublayers (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setSublayers:$an_arg]
			 ]"
		end

	objc_sublayer_transform (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CATransform3D *)$result_pointer = [(CALayer *)$an_item sublayerTransform];
			 ]"
		end

	objc_set_sublayer_transform (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setSublayerTransform:*((CATransform3D *)$an_arg)]
			 ]"
		end

	objc_mask (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item mask];
			 ]"
		end

	objc_set_mask (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setMask:$an_arg]
			 ]"
		end

	objc_masks_to_bounds (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item masksToBounds];
			 ]"
		end

	objc_set_masks_to_bounds (an_item: POINTER; an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setMasksToBounds:$an_arg]
			 ]"
		end

	objc_contents (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item contents];
			 ]"
		end

	objc_set_contents (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setContents:$an_arg]
			 ]"
		end

	objc_contents_rect (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CGRect *)$result_pointer = [(CALayer *)$an_item contentsRect];
			 ]"
		end

	objc_set_contents_rect (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setContentsRect:*((CGRect *)$an_arg)]
			 ]"
		end

	objc_contents_gravity (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item contentsGravity];
			 ]"
		end

	objc_set_contents_gravity (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setContentsGravity:$an_arg]
			 ]"
		end

	objc_contents_center (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CGRect *)$result_pointer = [(CALayer *)$an_item contentsCenter];
			 ]"
		end

	objc_set_contents_center (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setContentsCenter:*((CGRect *)$an_arg)]
			 ]"
		end

	objc_minification_filter (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item minificationFilter];
			 ]"
		end

	objc_set_minification_filter (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setMinificationFilter:$an_arg]
			 ]"
		end

	objc_magnification_filter (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item magnificationFilter];
			 ]"
		end

	objc_set_magnification_filter (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setMagnificationFilter:$an_arg]
			 ]"
		end

	objc_minification_filter_bias (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item minificationFilterBias];
			 ]"
		end

	objc_set_minification_filter_bias (an_item: POINTER; an_arg: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setMinificationFilterBias:$an_arg]
			 ]"
		end

	objc_is_opaque (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item isOpaque];
			 ]"
		end

	objc_set_opaque (an_item: POINTER; an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setOpaque:$an_arg]
			 ]"
		end

	objc_needs_display_on_bounds_change (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item needsDisplayOnBoundsChange];
			 ]"
		end

	objc_set_needs_display_on_bounds_change (an_item: POINTER; an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setNeedsDisplayOnBoundsChange:$an_arg]
			 ]"
		end

	objc_edge_antialiasing_mask (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item edgeAntialiasingMask];
			 ]"
		end

	objc_set_edge_antialiasing_mask (an_item: POINTER; an_arg: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setEdgeAntialiasingMask:$an_arg]
			 ]"
		end

--	objc_background_color (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CALayer *)$an_item backgroundColor];
--			 ]"
--		end

--	objc_set_background_color (an_item: POINTER; an_arg: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				[(CALayer *)$an_item setBackgroundColor:$ARG]
--			 ]"
--		end

	objc_corner_radius (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item cornerRadius];
			 ]"
		end

	objc_set_corner_radius (an_item: POINTER; an_arg: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setCornerRadius:$an_arg]
			 ]"
		end

	objc_border_width (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item borderWidth];
			 ]"
		end

	objc_set_border_width (an_item: POINTER; an_arg: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setBorderWidth:$an_arg]
			 ]"
		end

--	objc_border_color (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CALayer *)$an_item borderColor];
--			 ]"
--		end

--	objc_set_border_color (an_item: POINTER; an_arg: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				[(CALayer *)$an_item setBorderColor:$ARG]
--			 ]"
--		end

	objc_opacity (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item opacity];
			 ]"
		end

	objc_set_opacity (an_item: POINTER; an_arg: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setOpacity:$an_arg]
			 ]"
		end

	objc_compositing_filter (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item compositingFilter];
			 ]"
		end

	objc_set_compositing_filter (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setCompositingFilter:$an_arg]
			 ]"
		end

	objc_filters (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item filters];
			 ]"
		end

	objc_set_filters (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setFilters:$an_arg]
			 ]"
		end

	objc_background_filters (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item backgroundFilters];
			 ]"
		end

	objc_set_background_filters (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setBackgroundFilters:$an_arg]
			 ]"
		end

--	objc_shadow_color (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CALayer *)$an_item shadowColor];
--			 ]"
--		end

--	objc_set_shadow_color (an_item: POINTER; an_arg: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				[(CALayer *)$an_item setShadowColor:$ARG]
--			 ]"
--		end

	objc_shadow_opacity (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item shadowOpacity];
			 ]"
		end

	objc_set_shadow_opacity (an_item: POINTER; an_arg: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setShadowOpacity:$an_arg]
			 ]"
		end

	objc_shadow_offset (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CGSize *)$result_pointer = [(CALayer *)$an_item shadowOffset];
			 ]"
		end

	objc_set_shadow_offset (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setShadowOffset:*((CGSize *)$an_arg)]
			 ]"
		end

	objc_shadow_radius (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item shadowRadius];
			 ]"
		end

	objc_set_shadow_radius (an_item: POINTER; an_arg: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setShadowRadius:$an_arg]
			 ]"
		end

	objc_autoresizing_mask (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CALayer *)$an_item autoresizingMask];
			 ]"
		end

	objc_set_autoresizing_mask (an_item: POINTER; an_arg: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setAutoresizingMask:$an_arg]
			 ]"
		end

	objc_layout_manager (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item layoutManager];
			 ]"
		end

	objc_set_layout_manager (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setLayoutManager:$an_arg]
			 ]"
		end

	objc_actions (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item actions];
			 ]"
		end

	objc_set_actions (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setActions:$an_arg]
			 ]"
		end

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item name];
			 ]"
		end

	objc_set_name (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setName:$an_arg]
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item delegate];
			 ]"
		end

	objc_set_delegate (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setDelegate:$an_arg]
			 ]"
		end

	objc_style (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CALayer *)$an_item style];
			 ]"
		end

	objc_set_style (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CALayer *)$an_item setStyle:$an_arg]
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "CALayer"
		end

end
