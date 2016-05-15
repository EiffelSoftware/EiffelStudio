note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_VALUE

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
	make

feature -- NSValue

--	get_value_ (a_value: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_value__item: POINTER
--		do
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			objc_get_value_ (item, a_value__item)
--		end

--	obj_c_type: detachable UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_obj_c_type (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like obj_c_type} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like obj_c_type} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSValue Externals

--	objc_get_value_ (an_item: POINTER; a_value: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSValue *)$an_item getValue:];
--			 ]"
--		end

--	objc_obj_c_type (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSValue *)$an_item objCType];
--			 ]"
--		end

feature {NONE} -- Initialization

--	make_with_bytes__obj_c_type_ (a_value: UNSUPPORTED_TYPE; a_type: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_value__item: POINTER
--		do
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			make_with_pointer (objc_init_with_bytes__obj_c_type_(allocate_object, a_value__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSValueCreation Externals

--	objc_init_with_bytes__obj_c_type_ (an_item: POINTER; a_value: UNSUPPORTED_TYPE; a_type: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSValue *)$an_item initWithBytes: objCType:$a_type];
--			 ]"
--		end

feature -- NSValueExtensionMethods

	nonretained_object_value: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_nonretained_object_value (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like nonretained_object_value} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like nonretained_object_value} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	pointer_value: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_pointer_value (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like pointer_value} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like pointer_value} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	is_equal_to_value_ (a_value: detachable NS_VALUE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			Result := objc_is_equal_to_value_ (item, a_value__item)
		end

feature {NONE} -- NSValueExtensionMethods Externals

	objc_nonretained_object_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSValue *)$an_item nonretainedObjectValue];
			 ]"
		end

--	objc_pointer_value (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSValue *)$an_item pointerValue];
--			 ]"
--		end

	objc_is_equal_to_value_ (an_item: POINTER; a_value: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSValue *)$an_item isEqualToValue:$a_value];
			 ]"
		end

feature -- NSValueRangeExtensions

	range_value: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_range_value (item, Result.item)
		end

feature {NONE} -- NSValueRangeExtensions Externals

	objc_range_value (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSValue *)$an_item rangeValue];
			 ]"
		end

feature -- NSValueGeometryExtensions

	point_value: NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_point_value (item, Result.item)
		end

	size_value: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_size_value (item, Result.item)
		end

	rect_value: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_rect_value (item, Result.item)
		end

feature {NONE} -- NSValueGeometryExtensions Externals

	objc_point_value (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSValue *)$an_item pointValue];
			 ]"
		end

	objc_size_value (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSValue *)$an_item sizeValue];
			 ]"
		end

	objc_rect_value (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSValue *)$an_item rectValue];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSValue"
		end

end
