note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_APP_KIT_COLOR_EXTENSIONS_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSAppKitColorExtensions

	decode_nx_color (a_ns_coder: NS_CODER): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_decode_nx_color (a_ns_coder.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decode_nx_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decode_nx_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSAppKitColorExtensions Externals

	objc_decode_nx_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCoder *)$an_item decodeNXColor];
			 ]"
		end

end
