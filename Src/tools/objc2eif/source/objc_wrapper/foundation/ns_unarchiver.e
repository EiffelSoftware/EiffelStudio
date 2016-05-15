note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_UNARCHIVER

inherit
	NS_CODER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_for_reading_with_data_,
	make

feature {NONE} -- Initialization

	make_for_reading_with_data_ (a_data: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			make_with_pointer (objc_init_for_reading_with_data_(allocate_object, a_data__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSUnarchiver Externals

	objc_init_for_reading_with_data_ (an_item: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUnarchiver *)$an_item initForReadingWithData:$a_data];
			 ]"
		end

	objc_is_at_end (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUnarchiver *)$an_item isAtEnd];
			 ]"
		end

	objc_replace_object__with_object_ (an_item: POINTER; a_object: POINTER; a_new_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUnarchiver *)$an_item replaceObject:$a_object withObject:$a_new_object];
			 ]"
		end

feature -- NSUnarchiver

	is_at_end: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_at_end (item)
		end

	replace_object__with_object_ (a_object: detachable NS_OBJECT; a_new_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
			a_new_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			if attached a_new_object as a_new_object_attached then
				a_new_object__item := a_new_object_attached.item
			end
			objc_replace_object__with_object_ (item, a_object__item, a_new_object__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSUnarchiver"
		end

end
