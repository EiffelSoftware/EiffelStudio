note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_APPLE_EVENT_DESCRIPTOR_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSAppleEventDescriptor

	null_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_null_descriptor (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like null_descriptor} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like null_descriptor} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	descriptor_with_descriptor_type__bytes__length_ (a_descriptor_type: NATURAL_32; a_bytes: UNSUPPORTED_TYPE; a_byte_count: NATURAL_64): detachable NS_APPLE_EVENT_DESCRIPTOR
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_bytes__item: POINTER
--		do
--			if attached a_bytes as a_bytes_attached then
--				a_bytes__item := a_bytes_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_descriptor_with_descriptor_type__bytes__length_ (l_objc_class.item, a_descriptor_type, a_bytes__item, a_byte_count)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like descriptor_with_descriptor_type__bytes__length_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like descriptor_with_descriptor_type__bytes__length_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	descriptor_with_descriptor_type__data_ (a_descriptor_type: NATURAL_32; a_data: detachable NS_DATA): detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_descriptor_with_descriptor_type__data_ (l_objc_class.item, a_descriptor_type, a_data__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like descriptor_with_descriptor_type__data_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like descriptor_with_descriptor_type__data_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	descriptor_with_boolean_ (a_boolean: CHARACTER): detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_descriptor_with_boolean_ (l_objc_class.item, a_boolean)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like descriptor_with_boolean_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like descriptor_with_boolean_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	descriptor_with_enum_code_ (a_enumerator: NATURAL_32): detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_descriptor_with_enum_code_ (l_objc_class.item, a_enumerator)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like descriptor_with_enum_code_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like descriptor_with_enum_code_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	descriptor_with_int32_ (a_signed_int: INTEGER_32): detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_descriptor_with_int32_ (l_objc_class.item, a_signed_int)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like descriptor_with_int32_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like descriptor_with_int32_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	descriptor_with_type_code_ (a_type_code: NATURAL_32): detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_descriptor_with_type_code_ (l_objc_class.item, a_type_code)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like descriptor_with_type_code_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like descriptor_with_type_code_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	descriptor_with_string_ (a_string: detachable NS_STRING): detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_descriptor_with_string_ (l_objc_class.item, a_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like descriptor_with_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like descriptor_with_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	apple_event_with_event_class__event_i_d__target_descriptor__return_i_d__transaction_i_d_ (a_event_class: NATURAL_32; a_event_id: NATURAL_32; a_target_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR; a_return_id: INTEGER_16; a_transaction_id: INTEGER_32): detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_target_descriptor__item: POINTER
		do
			if attached a_target_descriptor as a_target_descriptor_attached then
				a_target_descriptor__item := a_target_descriptor_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_apple_event_with_event_class__event_i_d__target_descriptor__return_i_d__transaction_i_d_ (l_objc_class.item, a_event_class, a_event_id, a_target_descriptor__item, a_return_id, a_transaction_id)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like apple_event_with_event_class__event_i_d__target_descriptor__return_i_d__transaction_i_d_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like apple_event_with_event_class__event_i_d__target_descriptor__return_i_d__transaction_i_d_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	list_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_list_descriptor (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like list_descriptor} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like list_descriptor} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	record_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_record_descriptor (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like record_descriptor} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like record_descriptor} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSAppleEventDescriptor Externals

	objc_null_descriptor (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object nullDescriptor];
			 ]"
		end

--	objc_descriptor_with_descriptor_type__bytes__length_ (a_class_object: POINTER; a_descriptor_type: NATURAL_32; a_bytes: UNSUPPORTED_TYPE; a_byte_count: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object descriptorWithDescriptorType:$a_descriptor_type bytes: length:$a_byte_count];
--			 ]"
--		end

	objc_descriptor_with_descriptor_type__data_ (a_class_object: POINTER; a_descriptor_type: NATURAL_32; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object descriptorWithDescriptorType:$a_descriptor_type data:$a_data];
			 ]"
		end

	objc_descriptor_with_boolean_ (a_class_object: POINTER; a_boolean: CHARACTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object descriptorWithBoolean:$a_boolean];
			 ]"
		end

	objc_descriptor_with_enum_code_ (a_class_object: POINTER; a_enumerator: NATURAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object descriptorWithEnumCode:$a_enumerator];
			 ]"
		end

	objc_descriptor_with_int32_ (a_class_object: POINTER; a_signed_int: INTEGER_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object descriptorWithInt32:$a_signed_int];
			 ]"
		end

	objc_descriptor_with_type_code_ (a_class_object: POINTER; a_type_code: NATURAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object descriptorWithTypeCode:$a_type_code];
			 ]"
		end

	objc_descriptor_with_string_ (a_class_object: POINTER; a_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object descriptorWithString:$a_string];
			 ]"
		end

	objc_apple_event_with_event_class__event_i_d__target_descriptor__return_i_d__transaction_i_d_ (a_class_object: POINTER; a_event_class: NATURAL_32; a_event_id: NATURAL_32; a_target_descriptor: POINTER; a_return_id: INTEGER_16; a_transaction_id: INTEGER_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object appleEventWithEventClass:$a_event_class eventID:$a_event_id targetDescriptor:$a_target_descriptor returnID:$a_return_id transactionID:$a_transaction_id];
			 ]"
		end

	objc_list_descriptor (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object listDescriptor];
			 ]"
		end

	objc_record_descriptor (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object recordDescriptor];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSAppleEventDescriptor"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
