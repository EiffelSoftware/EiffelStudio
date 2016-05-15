note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_APP_KIT_ADDITIONS_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSAppKitAdditions

	init_with_color_ (a_ci_color: CI_COLOR; a_color: detachable NS_COLOR): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			result_pointer := objc_init_with_color_ (a_ci_color.item, a_color__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like init_with_color_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like init_with_color_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSAppKitAdditions Externals

	objc_init_with_color_ (an_item: POINTER; a_color: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(CIColor *)$an_item initWithColor:$a_color];
			 ]"
		end

end
