note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STATUS_BAR

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSStatusBar

	status_item_with_length_ (a_length: REAL_64): detachable NS_STATUS_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_status_item_with_length_ (item, a_length)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like status_item_with_length_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like status_item_with_length_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	remove_status_item_ (a_item: detachable NS_STATUS_ITEM)
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_remove_status_item_ (item, a_item__item)
		end

	is_vertical: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_vertical (item)
		end

	thickness: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_thickness (item)
		end

feature {NONE} -- NSStatusBar Externals

	objc_status_item_with_length_ (an_item: POINTER; a_length: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSStatusBar *)$an_item statusItemWithLength:$a_length];
			 ]"
		end

	objc_remove_status_item_ (an_item: POINTER; a_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusBar *)$an_item removeStatusItem:$a_item];
			 ]"
		end

	objc_is_vertical (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSStatusBar *)$an_item isVertical];
			 ]"
		end

	objc_thickness (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSStatusBar *)$an_item thickness];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSStatusBar"
		end

end
