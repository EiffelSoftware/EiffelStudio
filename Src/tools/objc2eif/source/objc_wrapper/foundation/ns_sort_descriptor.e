note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SORT_DESCRIPTOR

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_key__ascending_,
	make_with_key__ascending__selector_,
	make

feature {NONE} -- Initialization

	make_with_key__ascending_ (a_key: detachable NS_STRING; a_ascending: BOOLEAN)
			-- Initialize `Current'.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			make_with_pointer (objc_init_with_key__ascending_(allocate_object, a_key__item, a_ascending))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_key__ascending__selector_ (a_key: detachable NS_STRING; a_ascending: BOOLEAN; a_selector: detachable OBJC_SELECTOR)
			-- Initialize `Current'.
		local
			a_key__item: POINTER
			a_selector__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			make_with_pointer (objc_init_with_key__ascending__selector_(allocate_object, a_key__item, a_ascending, a_selector__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_key__ascending__comparator_ (a_key: detachable NS_STRING; a_ascending: BOOLEAN; a_cmptr: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_key__item: POINTER
--		do
--			if attached a_key as a_key_attached then
--				a_key__item := a_key_attached.item
--			end
--			make_with_pointer (objc_init_with_key__ascending__comparator_(allocate_object, a_key__item, a_ascending))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSSortDescriptor Externals

	objc_init_with_key__ascending_ (an_item: POINTER; a_key: POINTER; a_ascending: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSortDescriptor *)$an_item initWithKey:$a_key ascending:$a_ascending];
			 ]"
		end

	objc_init_with_key__ascending__selector_ (an_item: POINTER; a_key: POINTER; a_ascending: BOOLEAN; a_selector: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSortDescriptor *)$an_item initWithKey:$a_key ascending:$a_ascending selector:$a_selector];
			 ]"
		end

	objc_ascending (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSSortDescriptor *)$an_item ascending];
			 ]"
		end

	objc_selector (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSortDescriptor *)$an_item selector];
			 ]"
		end

--	objc_init_with_key__ascending__comparator_ (an_item: POINTER; a_key: POINTER; a_ascending: BOOLEAN; a_cmptr: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSSortDescriptor *)$an_item initWithKey:$a_key ascending:$a_ascending comparator:];
--			 ]"
--		end

--	objc_comparator (an_item: POINTER): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSSortDescriptor *)$an_item comparator];
--			 ]"
--		end

	objc_compare_object__to_object_ (an_item: POINTER; a_object1: POINTER; a_object2: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSSortDescriptor *)$an_item compareObject:$a_object1 toObject:$a_object2];
			 ]"
		end

	objc_reversed_sort_descriptor (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSortDescriptor *)$an_item reversedSortDescriptor];
			 ]"
		end

feature -- NSSortDescriptor

	ascending: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_ascending (item)
		end

	selector: detachable OBJC_SELECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selector (item)
			if result_pointer /= default_pointer then
				create {OBJC_SELECTOR} Result.make_with_pointer (result_pointer)
			end
			
		end

--	comparator: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			Result := objc_comparator (item)
--		end

	compare_object__to_object_ (a_object1: detachable NS_OBJECT; a_object2: detachable NS_OBJECT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_object1__item: POINTER
			a_object2__item: POINTER
		do
			if attached a_object1 as a_object1_attached then
				a_object1__item := a_object1_attached.item
			end
			if attached a_object2 as a_object2_attached then
				a_object2__item := a_object2_attached.item
			end
			Result := objc_compare_object__to_object_ (item, a_object1__item, a_object2__item)
		end

	reversed_sort_descriptor: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_reversed_sort_descriptor (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like reversed_sort_descriptor} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like reversed_sort_descriptor} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSortDescriptor"
		end

end
