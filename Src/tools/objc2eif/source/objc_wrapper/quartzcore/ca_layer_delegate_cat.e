note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_LAYER_DELEGATE_CAT

inherit
	NS_CATEGORY_COMMON

feature -- CALayerDelegate

	display_layer_ (a_ns_object: NS_OBJECT; a_layer: detachable CA_LAYER)
			-- Auto generated Objective-C wrapper.
		local
			a_layer__item: POINTER
		do
			if attached a_layer as a_layer_attached then
				a_layer__item := a_layer_attached.item
			end
			objc_display_layer_ (a_ns_object.item, a_layer__item)
		end

--	draw_layer__in_context_ (a_ns_object: NS_OBJECT; a_layer: detachable CA_LAYER; a_ctx: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_layer__item: POINTER
--			a_ctx__item: POINTER
--		do
--			if attached a_layer as a_layer_attached then
--				a_layer__item := a_layer_attached.item
--			end
--			if attached a_ctx as a_ctx_attached then
--				a_ctx__item := a_ctx_attached.item
--			end
--			objc_draw_layer__in_context_ (a_ns_object.item, a_layer__item, a_ctx__item)
--		end

	layout_sublayers_of_layer_ (a_ns_object: NS_OBJECT; a_layer: detachable CA_LAYER)
			-- Auto generated Objective-C wrapper.
		local
			a_layer__item: POINTER
		do
			if attached a_layer as a_layer_attached then
				a_layer__item := a_layer_attached.item
			end
			objc_layout_sublayers_of_layer_ (a_ns_object.item, a_layer__item)
		end

	action_for_layer__for_key_ (a_ns_object: NS_OBJECT; a_layer: detachable CA_LAYER; a_event: detachable NS_STRING): detachable CA_ACTION_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_layer__item: POINTER
			a_event__item: POINTER
		do
			if attached a_layer as a_layer_attached then
				a_layer__item := a_layer_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			result_pointer := objc_action_for_layer__for_key_ (a_ns_object.item, a_layer__item, a_event__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like action_for_layer__for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like action_for_layer__for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- CALayerDelegate Externals

	objc_display_layer_ (an_item: POINTER; a_layer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(NSObject *)$an_item displayLayer:$a_layer];
			 ]"
		end

--	objc_draw_layer__in_context_ (an_item: POINTER; a_layer: POINTER; a_ctx: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				[(NSObject *)$an_item drawLayer:$a_layer inContext:];
--			 ]"
--		end

	objc_layout_sublayers_of_layer_ (an_item: POINTER; a_layer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(NSObject *)$an_item layoutSublayersOfLayer:$a_layer];
			 ]"
		end

	objc_action_for_layer__for_key_ (an_item: POINTER; a_layer: POINTER; a_event: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item actionForLayer:$a_layer forKey:$a_event];
			 ]"
		end

end
