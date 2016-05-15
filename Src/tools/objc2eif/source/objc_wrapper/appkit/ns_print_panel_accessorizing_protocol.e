note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_PRINT_PANEL_ACCESSORIZING_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

	localized_summary_items: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localized_summary_items (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_summary_items} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_summary_items} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Required Methods Externals

	objc_localized_summary_items (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSPrintPanelAccessorizing>)$an_item localizedSummaryItems];
			 ]"
		end

feature -- Optional Methods

	key_paths_for_values_affecting_preview: detachable NS_SET
			-- Auto generated Objective-C wrapper.
		require
			has_key_paths_for_values_affecting_preview: has_key_paths_for_values_affecting_preview
		local
			result_pointer: POINTER
		do
			result_pointer := objc_key_paths_for_values_affecting_preview (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like key_paths_for_values_affecting_preview} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like key_paths_for_values_affecting_preview} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature -- Status Report

	has_key_paths_for_values_affecting_preview: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_key_paths_for_values_affecting_preview (item)
		end

feature -- Status Report Externals

	objc_has_key_paths_for_values_affecting_preview (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(keyPathsForValuesAffectingPreview)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_key_paths_for_values_affecting_preview (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSPrintPanelAccessorizing>)$an_item keyPathsForValuesAffectingPreview];
			 ]"
		end

end
