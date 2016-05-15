note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_INDEX_PATH

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_index_,
	make

feature {NONE} -- Initialization

	make_with_index_ (a_index: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_index_(allocate_object, a_index))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_indexes__length_ (a_indexes: UNSUPPORTED_TYPE; a_length: NATURAL_64)
--			-- Initialize `Current'.
--		local
--			a_indexes__item: POINTER
--		do
--			if attached a_indexes as a_indexes_attached then
--				a_indexes__item := a_indexes_attached.item
--			end
--			make_with_pointer (objc_init_with_indexes__length_(allocate_object, a_indexes__item, a_length))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSIndexPath Externals

	objc_init_with_index_ (an_item: POINTER; a_index: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSIndexPath *)$an_item initWithIndex:$a_index];
			 ]"
		end

--	objc_init_with_indexes__length_ (an_item: POINTER; a_indexes: UNSUPPORTED_TYPE; a_length: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSIndexPath *)$an_item initWithIndexes: length:$a_length];
--			 ]"
--		end

	objc_index_path_by_adding_index_ (an_item: POINTER; a_index: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSIndexPath *)$an_item indexPathByAddingIndex:$a_index];
			 ]"
		end

	objc_index_path_by_removing_last_index (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSIndexPath *)$an_item indexPathByRemovingLastIndex];
			 ]"
		end

	objc_index_at_position_ (an_item: POINTER; a_position: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexPath *)$an_item indexAtPosition:$a_position];
			 ]"
		end

	objc_length (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexPath *)$an_item length];
			 ]"
		end

--	objc_get_indexes_ (an_item: POINTER; a_indexes: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSIndexPath *)$an_item getIndexes:];
--			 ]"
--		end

	objc_compare_ (an_item: POINTER; a_other_object: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexPath *)$an_item compare:$a_other_object];
			 ]"
		end

feature -- NSIndexPath

	index_path_by_adding_index_ (a_index: NATURAL_64): detachable NS_INDEX_PATH
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_index_path_by_adding_index_ (item, a_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like index_path_by_adding_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like index_path_by_adding_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	index_path_by_removing_last_index: detachable NS_INDEX_PATH
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_index_path_by_removing_last_index (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like index_path_by_removing_last_index} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like index_path_by_removing_last_index} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	index_at_position_ (a_position: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_index_at_position_ (item, a_position)
		end

	length: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_length (item)
		end

--	get_indexes_ (a_indexes: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_indexes__item: POINTER
--		do
--			if attached a_indexes as a_indexes_attached then
--				a_indexes__item := a_indexes_attached.item
--			end
--			objc_get_indexes_ (item, a_indexes__item)
--		end

	compare_ (a_other_object: detachable NS_INDEX_PATH): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_other_object__item: POINTER
		do
			if attached a_other_object as a_other_object_attached then
				a_other_object__item := a_other_object_attached.item
			end
			Result := objc_compare_ (item, a_other_object__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSIndexPath"
		end

end
