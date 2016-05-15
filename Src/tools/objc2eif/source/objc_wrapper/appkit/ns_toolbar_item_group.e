note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TOOLBAR_ITEM_GROUP

inherit
	NS_TOOLBAR_ITEM
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_item_identifier_,
	make

feature -- NSToolbarItemGroup

	set_subitems_ (a_subitems: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_subitems__item: POINTER
		do
			if attached a_subitems as a_subitems_attached then
				a_subitems__item := a_subitems_attached.item
			end
			objc_set_subitems_ (item, a_subitems__item)
		end

	subitems: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_subitems (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like subitems} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like subitems} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSToolbarItemGroup Externals

	objc_set_subitems_ (an_item: POINTER; a_subitems: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItemGroup *)$an_item setSubitems:$a_subitems];
			 ]"
		end

	objc_subitems (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbarItemGroup *)$an_item subitems];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSToolbarItemGroup"
		end

end
