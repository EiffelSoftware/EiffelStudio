note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MUTABLE_DICTIONARY

inherit
	NS_DICTIONARY
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_capacity_,
	make_with_dictionary_,
	make_with_dictionary__copy_items_,
	make_with_objects__for_keys_,
	make_with_contents_of_file_,
	make_with_contents_of_ur_l_,
	make

feature -- NSMutableDictionary

	remove_object_for_key_ (a_key: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_remove_object_for_key_ (item, a_key__item)
		end

	set_object__for_key_ (an_object: detachable NS_OBJECT; a_key: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
			a_key__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_set_object__for_key_ (item, an_object__item, a_key__item)
		end

feature {NONE} -- NSMutableDictionary Externals

	objc_remove_object_for_key_ (an_item: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableDictionary *)$an_item removeObjectForKey:$a_key];
			 ]"
		end

	objc_set_object__for_key_ (an_item: POINTER; an_object: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableDictionary *)$an_item setObject:$an_object forKey:$a_key];
			 ]"
		end

feature -- NSExtendedMutableDictionary

	add_entries_from_dictionary_ (a_other_dictionary: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_other_dictionary__item: POINTER
		do
			if attached a_other_dictionary as a_other_dictionary_attached then
				a_other_dictionary__item := a_other_dictionary_attached.item
			end
			objc_add_entries_from_dictionary_ (item, a_other_dictionary__item)
		end

	remove_all_objects
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_all_objects (item)
		end

	remove_objects_for_keys_ (a_key_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_key_array__item: POINTER
		do
			if attached a_key_array as a_key_array_attached then
				a_key_array__item := a_key_array_attached.item
			end
			objc_remove_objects_for_keys_ (item, a_key_array__item)
		end

	set_dictionary_ (a_other_dictionary: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_other_dictionary__item: POINTER
		do
			if attached a_other_dictionary as a_other_dictionary_attached then
				a_other_dictionary__item := a_other_dictionary_attached.item
			end
			objc_set_dictionary_ (item, a_other_dictionary__item)
		end

feature {NONE} -- NSExtendedMutableDictionary Externals

	objc_add_entries_from_dictionary_ (an_item: POINTER; a_other_dictionary: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableDictionary *)$an_item addEntriesFromDictionary:$a_other_dictionary];
			 ]"
		end

	objc_remove_all_objects (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableDictionary *)$an_item removeAllObjects];
			 ]"
		end

	objc_remove_objects_for_keys_ (an_item: POINTER; a_key_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableDictionary *)$an_item removeObjectsForKeys:$a_key_array];
			 ]"
		end

	objc_set_dictionary_ (an_item: POINTER; a_other_dictionary: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableDictionary *)$an_item setDictionary:$a_other_dictionary];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_capacity_ (a_num_items: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_capacity_(allocate_object, a_num_items))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSMutableDictionaryCreation Externals

	objc_init_with_capacity_ (an_item: POINTER; a_num_items: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMutableDictionary *)$an_item initWithCapacity:$a_num_items];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMutableDictionary"
		end

end
