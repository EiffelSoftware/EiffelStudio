note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_DRAGGING_INFO_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

	dragging_destination_window: detachable NS_WINDOW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_dragging_destination_window (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dragging_destination_window} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dragging_destination_window} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dragging_source_operation_mask: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_dragging_source_operation_mask (item)
		end

	dragging_location: NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_dragging_location (item, Result.item)
		end

	dragged_image_location: NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_dragged_image_location (item, Result.item)
		end

	dragged_image: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_dragged_image (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dragged_image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dragged_image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dragging_pasteboard: detachable NS_PASTEBOARD
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_dragging_pasteboard (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dragging_pasteboard} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dragging_pasteboard} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dragging_source: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_dragging_source (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dragging_source} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dragging_source} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dragging_sequence_number: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_dragging_sequence_number (item)
		end

	slide_dragged_image_to_ (a_screen_point: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_slide_dragged_image_to_ (item, a_screen_point.item)
		end

	names_of_promised_files_dropped_at_destination_ (a_drop_destination: detachable NS_URL): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_drop_destination__item: POINTER
		do
			if attached a_drop_destination as a_drop_destination_attached then
				a_drop_destination__item := a_drop_destination_attached.item
			end
			result_pointer := objc_names_of_promised_files_dropped_at_destination_ (item, a_drop_destination__item)
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

feature {NONE} -- Required Methods Externals

	objc_dragging_destination_window (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSDraggingInfo>)$an_item draggingDestinationWindow];
			 ]"
		end

	objc_dragging_source_operation_mask (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSDraggingInfo>)$an_item draggingSourceOperationMask];
			 ]"
		end

	objc_dragging_location (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(id <NSDraggingInfo>)$an_item draggingLocation];
			 ]"
		end

	objc_dragged_image_location (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(id <NSDraggingInfo>)$an_item draggedImageLocation];
			 ]"
		end

	objc_dragged_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSDraggingInfo>)$an_item draggedImage];
			 ]"
		end

	objc_dragging_pasteboard (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSDraggingInfo>)$an_item draggingPasteboard];
			 ]"
		end

	objc_dragging_source (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSDraggingInfo>)$an_item draggingSource];
			 ]"
		end

	objc_dragging_sequence_number (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSDraggingInfo>)$an_item draggingSequenceNumber];
			 ]"
		end

	objc_slide_dragged_image_to_ (an_item: POINTER; a_screen_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSDraggingInfo>)$an_item slideDraggedImageTo:*((NSPoint *)$a_screen_point)];
			 ]"
		end

	objc_names_of_promised_files_dropped_at_destination_ (an_item: POINTER; a_drop_destination: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSDraggingInfo>)$an_item namesOfPromisedFilesDroppedAtDestination:$a_drop_destination];
			 ]"
		end

end
