note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_VALUE_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSValueCreation

--	value_with_bytes__obj_c_type_ (a_value: UNSUPPORTED_TYPE; a_type: UNSUPPORTED_TYPE): detachable NS_VALUE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_value__item: POINTER
--		do
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_value_with_bytes__obj_c_type_ (l_objc_class.item, a_value__item, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like value_with_bytes__obj_c_type_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like value_with_bytes__obj_c_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	value__with_obj_c_type_ (a_value: UNSUPPORTED_TYPE; a_type: UNSUPPORTED_TYPE): detachable NS_VALUE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_value__item: POINTER
--		do
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_value__with_obj_c_type_ (l_objc_class.item, a_value__item, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like value__with_obj_c_type_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like value__with_obj_c_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSValueCreation Externals

--	objc_value_with_bytes__obj_c_type_ (a_class_object: POINTER; a_value: UNSUPPORTED_TYPE; a_type: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object valueWithBytes: objCType:$a_type];
--			 ]"
--		end

--	objc_value__with_obj_c_type_ (a_class_object: POINTER; a_value: UNSUPPORTED_TYPE; a_type: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object value: withObjCType:$a_type];
--			 ]"
--		end

feature -- NSValueExtensionMethods

	value_with_nonretained_object_ (an_object: detachable NS_OBJECT): detachable NS_VALUE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_value_with_nonretained_object_ (l_objc_class.item, an_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_with_nonretained_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_with_nonretained_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	value_with_pointer_ (a_pointer: UNSUPPORTED_TYPE): detachable NS_VALUE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_pointer__item: POINTER
--		do
--			if attached a_pointer as a_pointer_attached then
--				a_pointer__item := a_pointer_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_value_with_pointer_ (l_objc_class.item, a_pointer__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like value_with_pointer_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like value_with_pointer_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSValueExtensionMethods Externals

	objc_value_with_nonretained_object_ (a_class_object: POINTER; a_an_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object valueWithNonretainedObject:$a_an_object];
			 ]"
		end

--	objc_value_with_pointer_ (a_class_object: POINTER; a_pointer: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object valueWithPointer:];
--			 ]"
--		end

feature -- NSValueRangeExtensions

	value_with_range_ (a_range: NS_RANGE): detachable NS_VALUE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_value_with_range_ (l_objc_class.item, a_range.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_with_range_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_with_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSValueRangeExtensions Externals

	objc_value_with_range_ (a_class_object: POINTER; a_range: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object valueWithRange:*((NSRange *)$a_range)];
			 ]"
		end

feature -- NSValueGeometryExtensions

	value_with_point_ (a_point: NS_POINT): detachable NS_VALUE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_value_with_point_ (l_objc_class.item, a_point.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_with_point_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_with_point_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	value_with_size_ (a_size: NS_SIZE): detachable NS_VALUE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_value_with_size_ (l_objc_class.item, a_size.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_with_size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_with_size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	value_with_rect_ (a_rect: NS_RECT): detachable NS_VALUE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_value_with_rect_ (l_objc_class.item, a_rect.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_with_rect_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_with_rect_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSValueGeometryExtensions Externals

	objc_value_with_point_ (a_class_object: POINTER; a_point: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object valueWithPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_value_with_size_ (a_class_object: POINTER; a_size: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object valueWithSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_value_with_rect_ (a_class_object: POINTER; a_rect: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object valueWithRect:*((NSRect *)$a_rect)];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSValue"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
