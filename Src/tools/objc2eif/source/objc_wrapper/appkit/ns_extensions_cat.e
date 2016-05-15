note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_EXTENSIONS_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSExtensions

	rich_text_source (a_ns_apple_script: NS_APPLE_SCRIPT): detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_rich_text_source (a_ns_apple_script.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like rich_text_source} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like rich_text_source} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSExtensions Externals

	objc_rich_text_source (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleScript *)$an_item richTextSource];
			 ]"
		end

end
