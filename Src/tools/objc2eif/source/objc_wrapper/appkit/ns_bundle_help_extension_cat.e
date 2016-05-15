note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUNDLE_HELP_EXTENSION_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSBundleHelpExtension

	context_help_for_key_ (a_ns_bundle: NS_BUNDLE; a_key: detachable NS_STRING): detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_context_help_for_key_ (a_ns_bundle.item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like context_help_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like context_help_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSBundleHelpExtension Externals

	objc_context_help_for_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item contextHelpForKey:$a_key];
			 ]"
		end

end
