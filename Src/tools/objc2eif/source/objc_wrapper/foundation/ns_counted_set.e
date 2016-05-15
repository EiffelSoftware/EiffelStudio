note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COUNTED_SET

inherit
	NS_MUTABLE_SET
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_capacity_,
	make_with_array_,
	make_with_set_,
	make_with_set__copy_items_,
	make

feature -- NSCountedSet

	count_for_object_ (a_object: detachable NS_OBJECT): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_count_for_object_ (item, a_object__item)
		end

feature {NONE} -- NSCountedSet Externals

	objc_count_for_object_ (an_item: POINTER; a_object: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCountedSet *)$an_item countForObject:$a_object];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCountedSet"
		end

end
