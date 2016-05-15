note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DRAGGING_SOURCE_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSDraggingSource

	dragging_source_operation_mask_for_local_ (a_ns_object: NS_OBJECT; a_flag: BOOLEAN): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_dragging_source_operation_mask_for_local_ (a_ns_object.item, a_flag)
		end

	names_of_promised_files_dropped_at_destination_ (a_ns_object: NS_OBJECT; a_drop_destination: detachable NS_URL): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_drop_destination__item: POINTER
		do
			if attached a_drop_destination as a_drop_destination_attached then
				a_drop_destination__item := a_drop_destination_attached.item
			end
			result_pointer := objc_names_of_promised_files_dropped_at_destination_ (a_ns_object.item, a_drop_destination__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like names_of_promised_files_dropped_at_destination_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like names_of_promised_files_dropped_at_destination_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dragged_image__began_at_ (a_ns_object: NS_OBJECT; a_image: detachable NS_IMAGE; a_screen_point: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			objc_dragged_image__began_at_ (a_ns_object.item, a_image__item, a_screen_point.item)
		end

	dragged_image__ended_at__operation_ (a_ns_object: NS_OBJECT; a_image: detachable NS_IMAGE; a_screen_point: NS_POINT; a_operation: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			objc_dragged_image__ended_at__operation_ (a_ns_object.item, a_image__item, a_screen_point.item, a_operation)
		end

	dragged_image__moved_to_ (a_ns_object: NS_OBJECT; a_image: detachable NS_IMAGE; a_screen_point: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			objc_dragged_image__moved_to_ (a_ns_object.item, a_image__item, a_screen_point.item)
		end

	ignore_modifier_keys_while_dragging (a_ns_object: NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_ignore_modifier_keys_while_dragging (a_ns_object.item)
		end

feature {NONE} -- NSDraggingSource Externals

	objc_dragging_source_operation_mask_for_local_ (an_item: POINTER; a_flag: BOOLEAN): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item draggingSourceOperationMaskForLocal:$a_flag];
			 ]"
		end

	objc_names_of_promised_files_dropped_at_destination_ (an_item: POINTER; a_drop_destination: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item namesOfPromisedFilesDroppedAtDestination:$a_drop_destination];
			 ]"
		end

	objc_dragged_image__began_at_ (an_item: POINTER; a_image: POINTER; a_screen_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item draggedImage:$a_image beganAt:*((NSPoint *)$a_screen_point)];
			 ]"
		end

	objc_dragged_image__ended_at__operation_ (an_item: POINTER; a_image: POINTER; a_screen_point: POINTER; a_operation: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item draggedImage:$a_image endedAt:*((NSPoint *)$a_screen_point) operation:$a_operation];
			 ]"
		end

	objc_dragged_image__moved_to_ (an_item: POINTER; a_image: POINTER; a_screen_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item draggedImage:$a_image movedTo:*((NSPoint *)$a_screen_point)];
			 ]"
		end

	objc_ignore_modifier_keys_while_dragging (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item ignoreModifierKeysWhileDragging];
			 ]"
		end

end
