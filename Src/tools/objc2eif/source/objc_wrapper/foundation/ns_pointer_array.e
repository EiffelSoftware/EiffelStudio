note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_POINTER_ARRAY

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_FAST_ENUMERATION_PROTOCOL
	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_options_,
	make_with_pointer_functions_,
	make

feature {NONE} -- Initialization

	make_with_options_ (a_options: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_options_(allocate_object, a_options))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_pointer_functions_ (a_functions: detachable NS_POINTER_FUNCTIONS)
			-- Initialize `Current'.
		local
			a_functions__item: POINTER
		do
			if attached a_functions as a_functions_attached then
				a_functions__item := a_functions_attached.item
			end
			make_with_pointer (objc_init_with_pointer_functions_(allocate_object, a_functions__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSPointerArray Externals

	objc_init_with_options_ (an_item: POINTER; a_options: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPointerArray *)$an_item initWithOptions:$a_options];
			 ]"
		end

	objc_init_with_pointer_functions_ (an_item: POINTER; a_functions: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPointerArray *)$an_item initWithPointerFunctions:$a_functions];
			 ]"
		end

	objc_pointer_functions (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPointerArray *)$an_item pointerFunctions];
			 ]"
		end

--	objc_pointer_at_index_ (an_item: POINTER; a_index: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSPointerArray *)$an_item pointerAtIndex:$a_index];
--			 ]"
--		end

--	objc_add_pointer_ (an_item: POINTER; a_pointer: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSPointerArray *)$an_item addPointer:];
--			 ]"
--		end

	objc_remove_pointer_at_index_ (an_item: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSPointerArray *)$an_item removePointerAtIndex:$a_index];
			 ]"
		end

--	objc_insert_pointer__at_index_ (an_item: POINTER; a_item: UNSUPPORTED_TYPE; a_index: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSPointerArray *)$an_item insertPointer: atIndex:$a_index];
--			 ]"
--		end

--	objc_replace_pointer_at_index__with_pointer_ (an_item: POINTER; a_index: NATURAL_64; a_item: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSPointerArray *)$an_item replacePointerAtIndex:$a_index withPointer:];
--			 ]"
--		end

	objc_compact (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSPointerArray *)$an_item compact];
			 ]"
		end

	objc_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSPointerArray *)$an_item count];
			 ]"
		end

	objc_set_count_ (an_item: POINTER; a_count: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSPointerArray *)$an_item setCount:$a_count];
			 ]"
		end

feature -- NSPointerArray

	pointer_functions: detachable NS_POINTER_FUNCTIONS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_pointer_functions (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pointer_functions} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pointer_functions} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	pointer_at_index_ (a_index: NATURAL_64): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_pointer_at_index_ (item, a_index)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like pointer_at_index_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like pointer_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	add_pointer_ (a_pointer: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_pointer__item: POINTER
--		do
--			if attached a_pointer as a_pointer_attached then
--				a_pointer__item := a_pointer_attached.item
--			end
--			objc_add_pointer_ (item, a_pointer__item)
--		end

	remove_pointer_at_index_ (a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_pointer_at_index_ (item, a_index)
		end

--	insert_pointer__at_index_ (a_item: UNSUPPORTED_TYPE; a_index: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_item__item: POINTER
--		do
--			if attached a_item as a_item_attached then
--				a_item__item := a_item_attached.item
--			end
--			objc_insert_pointer__at_index_ (item, a_item__item, a_index)
--		end

--	replace_pointer_at_index__with_pointer_ (a_index: NATURAL_64; a_item: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_item__item: POINTER
--		do
--			if attached a_item as a_item_attached then
--				a_item__item := a_item_attached.item
--			end
--			objc_replace_pointer_at_index__with_pointer_ (item, a_index, a_item__item)
--		end

	compact
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_compact (item)
		end

	count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_count (item)
		end

	set_count_ (a_count: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_count_ (item, a_count)
		end

feature -- NSArrayConveniences

	all_objects: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_all_objects (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like all_objects} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like all_objects} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSArrayConveniences Externals

	objc_all_objects (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPointerArray *)$an_item allObjects];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPointerArray"
		end

end
