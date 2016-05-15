note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_APPLE_EVENT_DESCRIPTOR

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_descriptor_type__data_,
	make_with_event_class__event_i_d__target_descriptor__return_i_d__transaction_i_d_,
	make_list_descriptor,
	make_record_descriptor,
	make

feature {NONE} -- Initialization

--	make_with_ae_desc_no_copy_ (a_ae_desc: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_ae_desc__item: POINTER
--		do
--			if attached a_ae_desc as a_ae_desc_attached then
--				a_ae_desc__item := a_ae_desc_attached.item
--			end
--			make_with_pointer (objc_init_with_ae_desc_no_copy_(allocate_object, a_ae_desc__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_descriptor_type__bytes__length_ (a_descriptor_type: NATURAL_32; a_bytes: UNSUPPORTED_TYPE; a_byte_count: NATURAL_64)
--			-- Initialize `Current'.
--		local
--			a_bytes__item: POINTER
--		do
--			if attached a_bytes as a_bytes_attached then
--				a_bytes__item := a_bytes_attached.item
--			end
--			make_with_pointer (objc_init_with_descriptor_type__bytes__length_(allocate_object, a_descriptor_type, a_bytes__item, a_byte_count))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_with_descriptor_type__data_ (a_descriptor_type: NATURAL_32; a_data: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			make_with_pointer (objc_init_with_descriptor_type__data_(allocate_object, a_descriptor_type, a_data__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_event_class__event_i_d__target_descriptor__return_i_d__transaction_i_d_ (a_event_class: NATURAL_32; a_event_id: NATURAL_32; a_target_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR; a_return_id: INTEGER_16; a_transaction_id: INTEGER_32)
			-- Initialize `Current'.
		local
			a_target_descriptor__item: POINTER
		do
			if attached a_target_descriptor as a_target_descriptor_attached then
				a_target_descriptor__item := a_target_descriptor_attached.item
			end
			make_with_pointer (objc_init_with_event_class__event_i_d__target_descriptor__return_i_d__transaction_i_d_(allocate_object, a_event_class, a_event_id, a_target_descriptor__item, a_return_id, a_transaction_id))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_list_descriptor
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_list_descriptor(allocate_object))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_record_descriptor
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_record_descriptor(allocate_object))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSAppleEventDescriptor Externals

--	objc_init_with_ae_desc_no_copy_ (an_item: POINTER; a_ae_desc: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAppleEventDescriptor *)$an_item initWithAEDescNoCopy:];
--			 ]"
--		end

--	objc_init_with_descriptor_type__bytes__length_ (an_item: POINTER; a_descriptor_type: NATURAL_32; a_bytes: UNSUPPORTED_TYPE; a_byte_count: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAppleEventDescriptor *)$an_item initWithDescriptorType:$a_descriptor_type bytes: length:$a_byte_count];
--			 ]"
--		end

	objc_init_with_descriptor_type__data_ (an_item: POINTER; a_descriptor_type: NATURAL_32; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleEventDescriptor *)$an_item initWithDescriptorType:$a_descriptor_type data:$a_data];
			 ]"
		end

	objc_init_with_event_class__event_i_d__target_descriptor__return_i_d__transaction_i_d_ (an_item: POINTER; a_event_class: NATURAL_32; a_event_id: NATURAL_32; a_target_descriptor: POINTER; a_return_id: INTEGER_16; a_transaction_id: INTEGER_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleEventDescriptor *)$an_item initWithEventClass:$a_event_class eventID:$a_event_id targetDescriptor:$a_target_descriptor returnID:$a_return_id transactionID:$a_transaction_id];
			 ]"
		end

	objc_init_list_descriptor (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleEventDescriptor *)$an_item initListDescriptor];
			 ]"
		end

	objc_init_record_descriptor (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleEventDescriptor *)$an_item initRecordDescriptor];
			 ]"
		end

--	objc_ae_desc (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAppleEventDescriptor *)$an_item aeDesc];
--			 ]"
--		end

	objc_descriptor_type (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSAppleEventDescriptor *)$an_item descriptorType];
			 ]"
		end

	objc_data (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleEventDescriptor *)$an_item data];
			 ]"
		end

	objc_boolean_value (an_item: POINTER): CHARACTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSAppleEventDescriptor *)$an_item booleanValue];
			 ]"
		end

	objc_enum_code_value (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSAppleEventDescriptor *)$an_item enumCodeValue];
			 ]"
		end

	objc_int32_value (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSAppleEventDescriptor *)$an_item int32Value];
			 ]"
		end

	objc_type_code_value (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSAppleEventDescriptor *)$an_item typeCodeValue];
			 ]"
		end

	objc_string_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleEventDescriptor *)$an_item stringValue];
			 ]"
		end

	objc_event_class (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSAppleEventDescriptor *)$an_item eventClass];
			 ]"
		end

	objc_event_id (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSAppleEventDescriptor *)$an_item eventID];
			 ]"
		end

	objc_return_id (an_item: POINTER): INTEGER_16
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSAppleEventDescriptor *)$an_item returnID];
			 ]"
		end

	objc_transaction_id (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSAppleEventDescriptor *)$an_item transactionID];
			 ]"
		end

	objc_set_param_descriptor__for_keyword_ (an_item: POINTER; a_descriptor: POINTER; a_keyword: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAppleEventDescriptor *)$an_item setParamDescriptor:$a_descriptor forKeyword:$a_keyword];
			 ]"
		end

	objc_param_descriptor_for_keyword_ (an_item: POINTER; a_keyword: NATURAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleEventDescriptor *)$an_item paramDescriptorForKeyword:$a_keyword];
			 ]"
		end

	objc_remove_param_descriptor_with_keyword_ (an_item: POINTER; a_keyword: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAppleEventDescriptor *)$an_item removeParamDescriptorWithKeyword:$a_keyword];
			 ]"
		end

	objc_set_attribute_descriptor__for_keyword_ (an_item: POINTER; a_descriptor: POINTER; a_keyword: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAppleEventDescriptor *)$an_item setAttributeDescriptor:$a_descriptor forKeyword:$a_keyword];
			 ]"
		end

	objc_attribute_descriptor_for_keyword_ (an_item: POINTER; a_keyword: NATURAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleEventDescriptor *)$an_item attributeDescriptorForKeyword:$a_keyword];
			 ]"
		end

	objc_number_of_items (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSAppleEventDescriptor *)$an_item numberOfItems];
			 ]"
		end

	objc_insert_descriptor__at_index_ (an_item: POINTER; a_descriptor: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAppleEventDescriptor *)$an_item insertDescriptor:$a_descriptor atIndex:$a_index];
			 ]"
		end

	objc_descriptor_at_index_ (an_item: POINTER; a_index: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleEventDescriptor *)$an_item descriptorAtIndex:$a_index];
			 ]"
		end

	objc_remove_descriptor_at_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAppleEventDescriptor *)$an_item removeDescriptorAtIndex:$a_index];
			 ]"
		end

	objc_set_descriptor__for_keyword_ (an_item: POINTER; a_descriptor: POINTER; a_keyword: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAppleEventDescriptor *)$an_item setDescriptor:$a_descriptor forKeyword:$a_keyword];
			 ]"
		end

	objc_descriptor_for_keyword_ (an_item: POINTER; a_keyword: NATURAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleEventDescriptor *)$an_item descriptorForKeyword:$a_keyword];
			 ]"
		end

	objc_remove_descriptor_with_keyword_ (an_item: POINTER; a_keyword: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAppleEventDescriptor *)$an_item removeDescriptorWithKeyword:$a_keyword];
			 ]"
		end

	objc_keyword_for_descriptor_at_index_ (an_item: POINTER; a_index: INTEGER_64): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSAppleEventDescriptor *)$an_item keywordForDescriptorAtIndex:$a_index];
			 ]"
		end

	objc_coerce_to_descriptor_type_ (an_item: POINTER; a_descriptor_type: NATURAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleEventDescriptor *)$an_item coerceToDescriptorType:$a_descriptor_type];
			 ]"
		end

feature -- NSAppleEventDescriptor

--	ae_desc: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_ae_desc (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like ae_desc} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like ae_desc} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	descriptor_type: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_descriptor_type (item)
		end

	data: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_data (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	boolean_value: CHARACTER
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_boolean_value (item)
		end

	enum_code_value: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_enum_code_value (item)
		end

	int32_value: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_int32_value (item)
		end

	type_code_value: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_type_code_value (item)
		end

	string_value: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string_value (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_value} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_value} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	event_class: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_event_class (item)
		end

	event_id: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_event_id (item)
		end

	return_id: INTEGER_16
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_return_id (item)
		end

	transaction_id: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_transaction_id (item)
		end

	set_param_descriptor__for_keyword_ (a_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR; a_keyword: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		local
			a_descriptor__item: POINTER
		do
			if attached a_descriptor as a_descriptor_attached then
				a_descriptor__item := a_descriptor_attached.item
			end
			objc_set_param_descriptor__for_keyword_ (item, a_descriptor__item, a_keyword)
		end

	param_descriptor_for_keyword_ (a_keyword: NATURAL_32): detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_param_descriptor_for_keyword_ (item, a_keyword)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like param_descriptor_for_keyword_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like param_descriptor_for_keyword_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	remove_param_descriptor_with_keyword_ (a_keyword: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_param_descriptor_with_keyword_ (item, a_keyword)
		end

	set_attribute_descriptor__for_keyword_ (a_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR; a_keyword: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		local
			a_descriptor__item: POINTER
		do
			if attached a_descriptor as a_descriptor_attached then
				a_descriptor__item := a_descriptor_attached.item
			end
			objc_set_attribute_descriptor__for_keyword_ (item, a_descriptor__item, a_keyword)
		end

	attribute_descriptor_for_keyword_ (a_keyword: NATURAL_32): detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attribute_descriptor_for_keyword_ (item, a_keyword)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attribute_descriptor_for_keyword_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attribute_descriptor_for_keyword_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_of_items: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_items (item)
		end

	insert_descriptor__at_index_ (a_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_descriptor__item: POINTER
		do
			if attached a_descriptor as a_descriptor_attached then
				a_descriptor__item := a_descriptor_attached.item
			end
			objc_insert_descriptor__at_index_ (item, a_descriptor__item, a_index)
		end

	descriptor_at_index_ (a_index: INTEGER_64): detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_descriptor_at_index_ (item, a_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like descriptor_at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like descriptor_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	remove_descriptor_at_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_descriptor_at_index_ (item, a_index)
		end

	set_descriptor__for_keyword_ (a_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR; a_keyword: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		local
			a_descriptor__item: POINTER
		do
			if attached a_descriptor as a_descriptor_attached then
				a_descriptor__item := a_descriptor_attached.item
			end
			objc_set_descriptor__for_keyword_ (item, a_descriptor__item, a_keyword)
		end

	descriptor_for_keyword_ (a_keyword: NATURAL_32): detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_descriptor_for_keyword_ (item, a_keyword)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like descriptor_for_keyword_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like descriptor_for_keyword_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	remove_descriptor_with_keyword_ (a_keyword: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_descriptor_with_keyword_ (item, a_keyword)
		end

	keyword_for_descriptor_at_index_ (a_index: INTEGER_64): NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_keyword_for_descriptor_at_index_ (item, a_index)
		end

	coerce_to_descriptor_type_ (a_descriptor_type: NATURAL_32): detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_coerce_to_descriptor_type_ (item, a_descriptor_type)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like coerce_to_descriptor_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like coerce_to_descriptor_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSAppleEventDescriptor"
		end

end
