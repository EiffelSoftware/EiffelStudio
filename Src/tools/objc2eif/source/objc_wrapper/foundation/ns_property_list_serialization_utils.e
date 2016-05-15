note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PROPERTY_LIST_SERIALIZATION_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSPropertyListSerialization

	property_list__is_valid_for_format_ (a_plist: detachable NS_OBJECT; a_format: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_plist__item: POINTER
		do
			if attached a_plist as a_plist_attached then
				a_plist__item := a_plist_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_property_list__is_valid_for_format_ (l_objc_class.item, a_plist__item, a_format)
		end

--	data_with_property_list__format__options__error_ (a_plist: detachable NS_OBJECT; a_format: NATURAL_64; a_opt: NATURAL_64; a_error: UNSUPPORTED_TYPE): detachable NS_DATA
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_plist__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_plist as a_plist_attached then
--				a_plist__item := a_plist_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_data_with_property_list__format__options__error_ (l_objc_class.item, a_plist__item, a_format, a_opt, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like data_with_property_list__format__options__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like data_with_property_list__format__options__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	write_property_list__to_stream__format__options__error_ (a_plist: detachable NS_OBJECT; a_stream: detachable NS_OUTPUT_STREAM; a_format: NATURAL_64; a_opt: NATURAL_64; a_error: UNSUPPORTED_TYPE): INTEGER_64
--			-- Auto generated Objective-C wrapper.
--		local
--			l_objc_class: OBJC_CLASS
--			a_plist__item: POINTER
--			a_stream__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_plist as a_plist_attached then
--				a_plist__item := a_plist_attached.item
--			end
--			if attached a_stream as a_stream_attached then
--				a_stream__item := a_stream_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			Result := objc_write_property_list__to_stream__format__options__error_ (l_objc_class.item, a_plist__item, a_stream__item, a_format, a_opt, a_error__item)
--		end

--	property_list_with_data__options__format__error_ (a_data: detachable NS_DATA; a_opt: NATURAL_64; a_format: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_data__item: POINTER
--			a_format__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			if attached a_format as a_format_attached then
--				a_format__item := a_format_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_property_list_with_data__options__format__error_ (l_objc_class.item, a_data__item, a_opt, a_format__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like property_list_with_data__options__format__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like property_list_with_data__options__format__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	property_list_with_stream__options__format__error_ (a_stream: detachable NS_INPUT_STREAM; a_opt: NATURAL_64; a_format: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_stream__item: POINTER
--			a_format__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_stream as a_stream_attached then
--				a_stream__item := a_stream_attached.item
--			end
--			if attached a_format as a_format_attached then
--				a_format__item := a_format_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_property_list_with_stream__options__format__error_ (l_objc_class.item, a_stream__item, a_opt, a_format__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like property_list_with_stream__options__format__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like property_list_with_stream__options__format__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	data_from_property_list__format__error_description_ (a_plist: detachable NS_OBJECT; a_format: NATURAL_64; a_error_string: UNSUPPORTED_TYPE): detachable NS_DATA
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_plist__item: POINTER
--			a_error_string__item: POINTER
--		do
--			if attached a_plist as a_plist_attached then
--				a_plist__item := a_plist_attached.item
--			end
--			if attached a_error_string as a_error_string_attached then
--				a_error_string__item := a_error_string_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_data_from_property_list__format__error_description_ (l_objc_class.item, a_plist__item, a_format, a_error_string__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like data_from_property_list__format__error_description_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like data_from_property_list__format__error_description_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	property_list_from_data__mutability_option__format__error_description_ (a_data: detachable NS_DATA; a_opt: NATURAL_64; a_format: UNSUPPORTED_TYPE; a_error_string: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_data__item: POINTER
--			a_format__item: POINTER
--			a_error_string__item: POINTER
--		do
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			if attached a_format as a_format_attached then
--				a_format__item := a_format_attached.item
--			end
--			if attached a_error_string as a_error_string_attached then
--				a_error_string__item := a_error_string_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_property_list_from_data__mutability_option__format__error_description_ (l_objc_class.item, a_data__item, a_opt, a_format__item, a_error_string__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like property_list_from_data__mutability_option__format__error_description_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like property_list_from_data__mutability_option__format__error_description_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSPropertyListSerialization Externals

	objc_property_list__is_valid_for_format_ (a_class_object: POINTER; a_plist: POINTER; a_format: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object propertyList:$a_plist isValidForFormat:$a_format];
			 ]"
		end

--	objc_data_with_property_list__format__options__error_ (a_class_object: POINTER; a_plist: POINTER; a_format: NATURAL_64; a_opt: NATURAL_64; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object dataWithPropertyList:$a_plist format:$a_format options:$a_opt error:];
--			 ]"
--		end

--	objc_write_property_list__to_stream__format__options__error_ (a_class_object: POINTER; a_plist: POINTER; a_stream: POINTER; a_format: NATURAL_64; a_opt: NATURAL_64; a_error: UNSUPPORTED_TYPE): INTEGER_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(Class)$a_class_object writePropertyList:$a_plist toStream:$a_stream format:$a_format options:$a_opt error:];
--			 ]"
--		end

--	objc_property_list_with_data__options__format__error_ (a_class_object: POINTER; a_data: POINTER; a_opt: NATURAL_64; a_format: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object propertyListWithData:$a_data options:$a_opt format: error:];
--			 ]"
--		end

--	objc_property_list_with_stream__options__format__error_ (a_class_object: POINTER; a_stream: POINTER; a_opt: NATURAL_64; a_format: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object propertyListWithStream:$a_stream options:$a_opt format: error:];
--			 ]"
--		end

--	objc_data_from_property_list__format__error_description_ (a_class_object: POINTER; a_plist: POINTER; a_format: NATURAL_64; a_error_string: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object dataFromPropertyList:$a_plist format:$a_format errorDescription:];
--			 ]"
--		end

--	objc_property_list_from_data__mutability_option__format__error_description_ (a_class_object: POINTER; a_data: POINTER; a_opt: NATURAL_64; a_format: UNSUPPORTED_TYPE; a_error_string: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object propertyListFromData:$a_data mutabilityOption:$a_opt format: errorDescription:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPropertyListSerialization"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
