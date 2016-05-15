note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_COLOR_PICKING_DEFAULT_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

	provide_new_button_image: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_provide_new_button_image (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like provide_new_button_image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like provide_new_button_image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	insert_new_button_image__in_ (a_new_button_image: detachable NS_IMAGE; a_button_cell: detachable NS_BUTTON_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_new_button_image__item: POINTER
			a_button_cell__item: POINTER
		do
			if attached a_new_button_image as a_new_button_image_attached then
				a_new_button_image__item := a_new_button_image_attached.item
			end
			if attached a_button_cell as a_button_cell_attached then
				a_button_cell__item := a_button_cell_attached.item
			end
			objc_insert_new_button_image__in_ (item, a_new_button_image__item, a_button_cell__item)
		end

	view_size_changed_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_view_size_changed_ (item, a_sender__item)
		end

	alpha_control_added_or_removed_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_alpha_control_added_or_removed_ (item, a_sender__item)
		end

	attach_color_list_ (a_color_list: detachable NS_COLOR_LIST)
			-- Auto generated Objective-C wrapper.
		local
			a_color_list__item: POINTER
		do
			if attached a_color_list as a_color_list_attached then
				a_color_list__item := a_color_list_attached.item
			end
			objc_attach_color_list_ (item, a_color_list__item)
		end

	detach_color_list_ (a_color_list: detachable NS_COLOR_LIST)
			-- Auto generated Objective-C wrapper.
		local
			a_color_list__item: POINTER
		do
			if attached a_color_list as a_color_list_attached then
				a_color_list__item := a_color_list_attached.item
			end
			objc_detach_color_list_ (item, a_color_list__item)
		end

	set_mode_ (a_mode: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_mode_ (item, a_mode)
		end

	button_tool_tip: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_button_tool_tip (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like button_tool_tip} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like button_tool_tip} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	min_content_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_min_content_size (item, Result.item)
		end

feature {NONE} -- Required Methods Externals

	objc_provide_new_button_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSColorPickingDefault>)$an_item provideNewButtonImage];
			 ]"
		end

	objc_insert_new_button_image__in_ (an_item: POINTER; a_new_button_image: POINTER; a_button_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSColorPickingDefault>)$an_item insertNewButtonImage:$a_new_button_image in:$a_button_cell];
			 ]"
		end

	objc_view_size_changed_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSColorPickingDefault>)$an_item viewSizeChanged:$a_sender];
			 ]"
		end

	objc_alpha_control_added_or_removed_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSColorPickingDefault>)$an_item alphaControlAddedOrRemoved:$a_sender];
			 ]"
		end

	objc_attach_color_list_ (an_item: POINTER; a_color_list: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSColorPickingDefault>)$an_item attachColorList:$a_color_list];
			 ]"
		end

	objc_detach_color_list_ (an_item: POINTER; a_color_list: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSColorPickingDefault>)$an_item detachColorList:$a_color_list];
			 ]"
		end

	objc_set_mode_ (an_item: POINTER; a_mode: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSColorPickingDefault>)$an_item setMode:$a_mode];
			 ]"
		end

	objc_button_tool_tip (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSColorPickingDefault>)$an_item buttonToolTip];
			 ]"
		end

	objc_min_content_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(id <NSColorPickingDefault>)$an_item minContentSize];
			 ]"
		end

end
