note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TOOL_TIP_OWNER_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSToolTipOwner

--	view__string_for_tool_tip__point__user_data_ (a_ns_object: NS_OBJECT; a_view: detachable NS_VIEW; a_tag: INTEGER_64; a_point: NS_POINT; a_data: UNSUPPORTED_TYPE): detachable NS_STRING
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_view__item: POINTER
--			a_data__item: POINTER
--		do
--			if attached a_view as a_view_attached then
--				a_view__item := a_view_attached.item
--			end
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			result_pointer := objc_view__string_for_tool_tip__point__user_data_ (a_ns_object.item, a_view__item, a_tag, a_point.item, a_data__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like view__string_for_tool_tip__point__user_data_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like view__string_for_tool_tip__point__user_data_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSToolTipOwner Externals

--	objc_view__string_for_tool_tip__point__user_data_ (an_item: POINTER; a_view: POINTER; a_tag: INTEGER_64; a_point: POINTER; a_data: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSObject *)$an_item view:$a_view stringForToolTip:$a_tag point:*((NSPoint *)$a_point) userData:];
--			 ]"
--		end

end
