note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MAP_TABLE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL
	NS_FAST_ENUMERATION_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_key_options__value_options__capacity_,
	make_with_key_pointer_functions__value_pointer_functions__capacity_,
	make

feature {NONE} -- Initialization

	make_with_key_options__value_options__capacity_ (a_key_options: NATURAL_64; a_value_options: NATURAL_64; a_initial_capacity: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_key_options__value_options__capacity_(allocate_object, a_key_options, a_value_options, a_initial_capacity))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_key_pointer_functions__value_pointer_functions__capacity_ (a_key_functions: detachable NS_POINTER_FUNCTIONS; a_value_functions: detachable NS_POINTER_FUNCTIONS; a_initial_capacity: NATURAL_64)
			-- Initialize `Current'.
		local
			a_key_functions__item: POINTER
			a_value_functions__item: POINTER
		do
			if attached a_key_functions as a_key_functions_attached then
				a_key_functions__item := a_key_functions_attached.item
			end
			if attached a_value_functions as a_value_functions_attached then
				a_value_functions__item := a_value_functions_attached.item
			end
			make_with_pointer (objc_init_with_key_pointer_functions__value_pointer_functions__capacity_(allocate_object, a_key_functions__item, a_value_functions__item, a_initial_capacity))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSMapTable Externals

	objc_init_with_key_options__value_options__capacity_ (an_item: POINTER; a_key_options: NATURAL_64; a_value_options: NATURAL_64; a_initial_capacity: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMapTable *)$an_item initWithKeyOptions:$a_key_options valueOptions:$a_value_options capacity:$a_initial_capacity];
			 ]"
		end

	objc_init_with_key_pointer_functions__value_pointer_functions__capacity_ (an_item: POINTER; a_key_functions: POINTER; a_value_functions: POINTER; a_initial_capacity: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMapTable *)$an_item initWithKeyPointerFunctions:$a_key_functions valuePointerFunctions:$a_value_functions capacity:$a_initial_capacity];
			 ]"
		end

	objc_key_pointer_functions (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMapTable *)$an_item keyPointerFunctions];
			 ]"
		end

	objc_value_pointer_functions (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMapTable *)$an_item valuePointerFunctions];
			 ]"
		end

	objc_object_for_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMapTable *)$an_item objectForKey:$a_key];
			 ]"
		end

	objc_remove_object_for_key_ (an_item: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMapTable *)$an_item removeObjectForKey:$a_key];
			 ]"
		end

	objc_set_object__for_key_ (an_item: POINTER; an_object: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMapTable *)$an_item setObject:$an_object forKey:$a_key];
			 ]"
		end

	objc_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSMapTable *)$an_item count];
			 ]"
		end

	objc_key_enumerator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMapTable *)$an_item keyEnumerator];
			 ]"
		end

	objc_object_enumerator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMapTable *)$an_item objectEnumerator];
			 ]"
		end

	objc_remove_all_objects (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMapTable *)$an_item removeAllObjects];
			 ]"
		end

	objc_dictionary_representation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMapTable *)$an_item dictionaryRepresentation];
			 ]"
		end

feature -- NSMapTable

	key_pointer_functions: detachable NS_POINTER_FUNCTIONS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_key_pointer_functions (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like key_pointer_functions} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like key_pointer_functions} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	value_pointer_functions: detachable NS_POINTER_FUNCTIONS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_value_pointer_functions (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_pointer_functions} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_pointer_functions} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	object_for_key_ (a_key: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_object_for_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

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

	count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_count (item)
		end

	key_enumerator: detachable NS_ENUMERATOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_key_enumerator (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like key_enumerator} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like key_enumerator} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	object_enumerator: detachable NS_ENUMERATOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_object_enumerator (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_enumerator} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_enumerator} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	remove_all_objects
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_all_objects (item)
		end

	dictionary_representation: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_dictionary_representation (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dictionary_representation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dictionary_representation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMapTable"
		end

end
