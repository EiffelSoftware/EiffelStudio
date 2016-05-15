note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUNDLE_SOUND_EXTENSIONS_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSBundleSoundExtensions

	path_for_sound_resource_ (a_ns_bundle: NS_BUNDLE; a_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			result_pointer := objc_path_for_sound_resource_ (a_ns_bundle.item, a_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path_for_sound_resource_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path_for_sound_resource_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSBundleSoundExtensions Externals

	objc_path_for_sound_resource_ (an_item: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item pathForSoundResource:$a_name];
			 ]"
		end

end
