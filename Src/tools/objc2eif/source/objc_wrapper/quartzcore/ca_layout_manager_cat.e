note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_LAYOUT_MANAGER_CAT

inherit
	NS_CATEGORY_COMMON

feature -- CALayoutManager

	preferred_size_of_layer_ (a_ns_object: NS_OBJECT; a_layer: detachable CA_LAYER): CG_SIZE
			-- Auto generated Objective-C wrapper.
		local
			a_layer__item: POINTER
		do
			if attached a_layer as a_layer_attached then
				a_layer__item := a_layer_attached.item
			end
			create Result.make
			objc_preferred_size_of_layer_ (a_ns_object.item, Result.item, a_layer__item)
		end

	invalidate_layout_of_layer_ (a_ns_object: NS_OBJECT; a_layer: detachable CA_LAYER)
			-- Auto generated Objective-C wrapper.
		local
			a_layer__item: POINTER
		do
			if attached a_layer as a_layer_attached then
				a_layer__item := a_layer_attached.item
			end
			objc_invalidate_layout_of_layer_ (a_ns_object.item, a_layer__item)
		end

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

feature {NONE} -- CALayoutManager Externals

	objc_preferred_size_of_layer_ (an_item: POINTER; result_pointer: POINTER; a_layer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CGSize *)$result_pointer = [(NSObject *)$an_item preferredSizeOfLayer:$a_layer];
			 ]"
		end

	objc_invalidate_layout_of_layer_ (an_item: POINTER; a_layer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(NSObject *)$an_item invalidateLayoutOfLayer:$a_layer];
			 ]"
		end

	objc_layout_sublayers_of_layer_ (an_item: POINTER; a_layer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(NSObject *)$an_item layoutSublayersOfLayer:$a_layer];
			 ]"
		end

end
