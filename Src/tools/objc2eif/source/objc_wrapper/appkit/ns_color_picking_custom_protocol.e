note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_COLOR_PICKING_CUSTOM_PROTOCOL

inherit
	NS_COLOR_PICKING_DEFAULT_PROTOCOL

feature -- Required Methods

	supports_mode_ (a_mode: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_supports_mode_ (item, a_mode)
		end

	current_mode: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_current_mode (item)
		end

	provide_new_view_ (a_initial_request: BOOLEAN): detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_provide_new_view_ (item, a_initial_request)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like provide_new_view_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like provide_new_view_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_color_ (a_new_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_new_color__item: POINTER
		do
			if attached a_new_color as a_new_color_attached then
				a_new_color__item := a_new_color_attached.item
			end
			objc_set_color_ (item, a_new_color__item)
		end

feature {NONE} -- Required Methods Externals

	objc_supports_mode_ (an_item: POINTER; a_mode: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSColorPickingCustom>)$an_item supportsMode:$a_mode];
			 ]"
		end

	objc_current_mode (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSColorPickingCustom>)$an_item currentMode];
			 ]"
		end

	objc_provide_new_view_ (an_item: POINTER; a_initial_request: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSColorPickingCustom>)$an_item provideNewView:$a_initial_request];
			 ]"
		end

	objc_set_color_ (an_item: POINTER; a_new_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSColorPickingCustom>)$an_item setColor:$a_new_color];
			 ]"
		end

end
