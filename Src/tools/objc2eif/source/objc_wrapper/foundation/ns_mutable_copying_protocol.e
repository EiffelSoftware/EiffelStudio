note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_MUTABLE_COPYING_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

--	mutable_copy_with_zone_ (a_zone: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_zone__item: POINTER
--		do
--			if attached a_zone as a_zone_attached then
--				a_zone__item := a_zone_attached.item
--			end
--			result_pointer := objc_mutable_copy_with_zone_ (item, a_zone__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like mutable_copy_with_zone_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like mutable_copy_with_zone_} new_eiffel_object (result_pointer, False) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- Required Methods Externals

--	objc_mutable_copy_with_zone_ (an_item: POINTER; a_zone: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(id <NSMutableCopying>)$an_item mutableCopyWithZone:];
--			 ]"
--		end

end
