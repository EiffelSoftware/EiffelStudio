note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CODER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSCoder

--	encode_value_of_obj_c_type__at_ (a_type: UNSUPPORTED_TYPE; a_addr: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_addr__item: POINTER
--		do
--			if attached a_addr as a_addr_attached then
--				a_addr__item := a_addr_attached.item
--			end
--			objc_encode_value_of_obj_c_type__at_ (item, , a_addr__item)
--		end

	encode_data_object_ (a_data: detachable NS_DATA)
			-- Auto generated Objective-C wrapper.
		local
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			objc_encode_data_object_ (item, a_data__item)
		end

--	decode_value_of_obj_c_type__at_ (a_type: UNSUPPORTED_TYPE; a_data: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_data__item: POINTER
--		do
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			objc_decode_value_of_obj_c_type__at_ (item, , a_data__item)
--		end

	decode_data_object: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_decode_data_object (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decode_data_object} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decode_data_object} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	version_for_class_name_ (a_class_name: detachable NS_STRING): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_class_name__item: POINTER
		do
			if attached a_class_name as a_class_name_attached then
				a_class_name__item := a_class_name_attached.item
			end
			Result := objc_version_for_class_name_ (item, a_class_name__item)
		end

feature {NONE} -- NSCoder Externals

--	objc_encode_value_of_obj_c_type__at_ (an_item: POINTER; a_type: POINTER; a_addr: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSCoder *)$an_item encodeValueOfObjCType:$a_type at:];
--			 ]"
--		end

	objc_encode_data_object_ (an_item: POINTER; a_data: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeDataObject:$a_data];
			 ]"
		end

--	objc_decode_value_of_obj_c_type__at_ (an_item: POINTER; a_type: POINTER; a_data: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSCoder *)$an_item decodeValueOfObjCType:$a_type at:];
--			 ]"
--		end

	objc_decode_data_object (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCoder *)$an_item decodeDataObject];
			 ]"
		end

	objc_version_for_class_name_ (an_item: POINTER; a_class_name: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCoder *)$an_item versionForClassName:$a_class_name];
			 ]"
		end

feature -- NSExtendedCoder

	encode_object_ (a_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_encode_object_ (item, a_object__item)
		end

	encode_root_object_ (a_root_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_root_object__item: POINTER
		do
			if attached a_root_object as a_root_object_attached then
				a_root_object__item := a_root_object_attached.item
			end
			objc_encode_root_object_ (item, a_root_object__item)
		end

	encode_bycopy_object_ (an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_encode_bycopy_object_ (item, an_object__item)
		end

	encode_byref_object_ (an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_encode_byref_object_ (item, an_object__item)
		end

	encode_conditional_object_ (a_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_encode_conditional_object_ (item, a_object__item)
		end

--	encode_array_of_obj_c_type__count__at_ (a_type: UNSUPPORTED_TYPE; a_count: NATURAL_64; a_array: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_array__item: POINTER
--		do
--			if attached a_array as a_array_attached then
--				a_array__item := a_array_attached.item
--			end
--			objc_encode_array_of_obj_c_type__count__at_ (item, , a_count, a_array__item)
--		end

--	encode_bytes__length_ (a_byteaddr: UNSUPPORTED_TYPE; a_length: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_byteaddr__item: POINTER
--		do
--			if attached a_byteaddr as a_byteaddr_attached then
--				a_byteaddr__item := a_byteaddr_attached.item
--			end
--			objc_encode_bytes__length_ (item, a_byteaddr__item, a_length)
--		end

	decode_object: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_decode_object (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decode_object} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decode_object} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	decode_array_of_obj_c_type__count__at_ (a_item_type: UNSUPPORTED_TYPE; a_count: NATURAL_64; a_array: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_array__item: POINTER
--		do
--			if attached a_array as a_array_attached then
--				a_array__item := a_array_attached.item
--			end
--			objc_decode_array_of_obj_c_type__count__at_ (item, , a_count, a_array__item)
--		end

--	decode_bytes_with_returned_length_ (a_lengthp: UNSUPPORTED_TYPE): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_lengthp__item: POINTER
--		do
--			if attached a_lengthp as a_lengthp_attached then
--				a_lengthp__item := a_lengthp_attached.item
--			end
--			result_pointer := objc_decode_bytes_with_returned_length_ (item, a_lengthp__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like decode_bytes_with_returned_length_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like decode_bytes_with_returned_length_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	encode_property_list_ (a_property_list: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_property_list__item: POINTER
		do
			if attached a_property_list as a_property_list_attached then
				a_property_list__item := a_property_list_attached.item
			end
			objc_encode_property_list_ (item, a_property_list__item)
		end

	decode_property_list: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_decode_property_list (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decode_property_list} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decode_property_list} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	set_object_zone_ (a_zone: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_zone__item: POINTER
--		do
--			if attached a_zone as a_zone_attached then
--				a_zone__item := a_zone_attached.item
--			end
--			objc_set_object_zone_ (item, a_zone__item)
--		end

--	object_zone: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_object_zone (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like object_zone} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like object_zone} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	system_version: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_system_version (item)
		end

	allows_keyed_coding: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_keyed_coding (item)
		end

	encode_object__for_key_ (a_objv: detachable NS_OBJECT; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_objv__item: POINTER
			a_key__item: POINTER
		do
			if attached a_objv as a_objv_attached then
				a_objv__item := a_objv_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_encode_object__for_key_ (item, a_objv__item, a_key__item)
		end

	encode_conditional_object__for_key_ (a_objv: detachable NS_OBJECT; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_objv__item: POINTER
			a_key__item: POINTER
		do
			if attached a_objv as a_objv_attached then
				a_objv__item := a_objv_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_encode_conditional_object__for_key_ (item, a_objv__item, a_key__item)
		end

	encode_bool__for_key_ (a_boolv: BOOLEAN; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_encode_bool__for_key_ (item, a_boolv, a_key__item)
		end

	encode_int__for_key_ (a_intv: INTEGER_32; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_encode_int__for_key_ (item, a_intv, a_key__item)
		end

	encode_int32__for_key_ (a_intv: INTEGER_32; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_encode_int32__for_key_ (item, a_intv, a_key__item)
		end

	encode_int64__for_key_ (a_intv: INTEGER_64; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_encode_int64__for_key_ (item, a_intv, a_key__item)
		end

	encode_float__for_key_ (a_realv: REAL_32; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_encode_float__for_key_ (item, a_realv, a_key__item)
		end

	encode_double__for_key_ (a_realv: REAL_64; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_encode_double__for_key_ (item, a_realv, a_key__item)
		end

--	encode_bytes__length__for_key_ (a_bytesp: UNSUPPORTED_TYPE; a_lenv: NATURAL_64; a_key: detachable NS_STRING)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_key__item: POINTER
--		do
--			if attached a_key as a_key_attached then
--				a_key__item := a_key_attached.item
--			end
--			objc_encode_bytes__length__for_key_ (item, , a_lenv, a_key__item)
--		end

	contains_value_for_key_ (a_key: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_contains_value_for_key_ (item, a_key__item)
		end

	decode_object_for_key_ (a_key: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_decode_object_for_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decode_object_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decode_object_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decode_bool_for_key_ (a_key: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_decode_bool_for_key_ (item, a_key__item)
		end

	decode_int_for_key_ (a_key: detachable NS_STRING): INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_decode_int_for_key_ (item, a_key__item)
		end

	decode_int32_for_key_ (a_key: detachable NS_STRING): INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_decode_int32_for_key_ (item, a_key__item)
		end

	decode_int64_for_key_ (a_key: detachable NS_STRING): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_decode_int64_for_key_ (item, a_key__item)
		end

	decode_float_for_key_ (a_key: detachable NS_STRING): REAL_32
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_decode_float_for_key_ (item, a_key__item)
		end

	decode_double_for_key_ (a_key: detachable NS_STRING): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_decode_double_for_key_ (item, a_key__item)
		end

--	decode_bytes_for_key__returned_length_ (a_key: detachable NS_STRING; a_lengthp: UNSUPPORTED_TYPE): detachable UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_key__item: POINTER
--			a_lengthp__item: POINTER
--		do
--			if attached a_key as a_key_attached then
--				a_key__item := a_key_attached.item
--			end
--			if attached a_lengthp as a_lengthp_attached then
--				a_lengthp__item := a_lengthp_attached.item
--			end
--			result_pointer := objc_decode_bytes_for_key__returned_length_ (item, a_key__item, a_lengthp__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like decode_bytes_for_key__returned_length_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like decode_bytes_for_key__returned_length_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	encode_integer__for_key_ (a_intv: INTEGER_64; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_encode_integer__for_key_ (item, a_intv, a_key__item)
		end

	decode_integer_for_key_ (a_key: detachable NS_STRING): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_decode_integer_for_key_ (item, a_key__item)
		end

feature {NONE} -- NSExtendedCoder Externals

	objc_encode_object_ (an_item: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeObject:$a_object];
			 ]"
		end

	objc_encode_root_object_ (an_item: POINTER; a_root_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeRootObject:$a_root_object];
			 ]"
		end

	objc_encode_bycopy_object_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeBycopyObject:$an_object];
			 ]"
		end

	objc_encode_byref_object_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeByrefObject:$an_object];
			 ]"
		end

	objc_encode_conditional_object_ (an_item: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeConditionalObject:$a_object];
			 ]"
		end

--	objc_encode_array_of_obj_c_type__count__at_ (an_item: POINTER; a_type: POINTER; a_count: NATURAL_64; a_array: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSCoder *)$an_item encodeArrayOfObjCType:$a_type count:$a_count at:];
--			 ]"
--		end

--	objc_encode_bytes__length_ (an_item: POINTER; a_byteaddr: UNSUPPORTED_TYPE; a_length: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSCoder *)$an_item encodeBytes: length:$a_length];
--			 ]"
--		end

	objc_decode_object (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCoder *)$an_item decodeObject];
			 ]"
		end

--	objc_decode_array_of_obj_c_type__count__at_ (an_item: POINTER; a_item_type: POINTER; a_count: NATURAL_64; a_array: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSCoder *)$an_item decodeArrayOfObjCType:$a_item_type count:$a_count at:];
--			 ]"
--		end

--	objc_decode_bytes_with_returned_length_ (an_item: POINTER; a_lengthp: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSCoder *)$an_item decodeBytesWithReturnedLength:];
--			 ]"
--		end

	objc_encode_property_list_ (an_item: POINTER; a_property_list: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodePropertyList:$a_property_list];
			 ]"
		end

	objc_decode_property_list (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCoder *)$an_item decodePropertyList];
			 ]"
		end

--	objc_set_object_zone_ (an_item: POINTER; a_zone: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSCoder *)$an_item setObjectZone:];
--			 ]"
--		end

--	objc_object_zone (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSCoder *)$an_item objectZone];
--			 ]"
--		end

	objc_system_version (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCoder *)$an_item systemVersion];
			 ]"
		end

	objc_allows_keyed_coding (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCoder *)$an_item allowsKeyedCoding];
			 ]"
		end

	objc_encode_object__for_key_ (an_item: POINTER; a_objv: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeObject:$a_objv forKey:$a_key];
			 ]"
		end

	objc_encode_conditional_object__for_key_ (an_item: POINTER; a_objv: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeConditionalObject:$a_objv forKey:$a_key];
			 ]"
		end

	objc_encode_bool__for_key_ (an_item: POINTER; a_boolv: BOOLEAN; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeBool:$a_boolv forKey:$a_key];
			 ]"
		end

	objc_encode_int__for_key_ (an_item: POINTER; a_intv: INTEGER_32; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeInt:$a_intv forKey:$a_key];
			 ]"
		end

	objc_encode_int32__for_key_ (an_item: POINTER; a_intv: INTEGER_32; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeInt32:$a_intv forKey:$a_key];
			 ]"
		end

	objc_encode_int64__for_key_ (an_item: POINTER; a_intv: INTEGER_64; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeInt64:$a_intv forKey:$a_key];
			 ]"
		end

	objc_encode_float__for_key_ (an_item: POINTER; a_realv: REAL_32; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeFloat:$a_realv forKey:$a_key];
			 ]"
		end

	objc_encode_double__for_key_ (an_item: POINTER; a_realv: REAL_64; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeDouble:$a_realv forKey:$a_key];
			 ]"
		end

--	objc_encode_bytes__length__for_key_ (an_item: POINTER; a_bytesp: POINTER; a_lenv: NATURAL_64; a_key: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSCoder *)$an_item encodeBytes:$a_bytesp length:$a_lenv forKey:$a_key];
--			 ]"
--		end

	objc_contains_value_for_key_ (an_item: POINTER; a_key: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCoder *)$an_item containsValueForKey:$a_key];
			 ]"
		end

	objc_decode_object_for_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCoder *)$an_item decodeObjectForKey:$a_key];
			 ]"
		end

	objc_decode_bool_for_key_ (an_item: POINTER; a_key: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCoder *)$an_item decodeBoolForKey:$a_key];
			 ]"
		end

	objc_decode_int_for_key_ (an_item: POINTER; a_key: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCoder *)$an_item decodeIntForKey:$a_key];
			 ]"
		end

	objc_decode_int32_for_key_ (an_item: POINTER; a_key: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCoder *)$an_item decodeInt32ForKey:$a_key];
			 ]"
		end

	objc_decode_int64_for_key_ (an_item: POINTER; a_key: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCoder *)$an_item decodeInt64ForKey:$a_key];
			 ]"
		end

	objc_decode_float_for_key_ (an_item: POINTER; a_key: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCoder *)$an_item decodeFloatForKey:$a_key];
			 ]"
		end

	objc_decode_double_for_key_ (an_item: POINTER; a_key: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCoder *)$an_item decodeDoubleForKey:$a_key];
			 ]"
		end

--	objc_decode_bytes_for_key__returned_length_ (an_item: POINTER; a_key: POINTER; a_lengthp: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSCoder *)$an_item decodeBytesForKey:$a_key returnedLength:];
--			 ]"
--		end

	objc_encode_integer__for_key_ (an_item: POINTER; a_intv: INTEGER_64; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeInteger:$a_intv forKey:$a_key];
			 ]"
		end

	objc_decode_integer_for_key_ (an_item: POINTER; a_key: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCoder *)$an_item decodeIntegerForKey:$a_key];
			 ]"
		end

feature -- NSGeometryCoding

	encode_point_ (a_point: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_encode_point_ (item, a_point.item)
		end

	decode_point: NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_decode_point (item, Result.item)
		end

	encode_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_encode_size_ (item, a_size.item)
		end

	decode_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_decode_size (item, Result.item)
		end

	encode_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_encode_rect_ (item, a_rect.item)
		end

	decode_rect: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_decode_rect (item, Result.item)
		end

feature {NONE} -- NSGeometryCoding Externals

	objc_encode_point_ (an_item: POINTER; a_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodePoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_decode_point (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSCoder *)$an_item decodePoint];
			 ]"
		end

	objc_encode_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_decode_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSCoder *)$an_item decodeSize];
			 ]"
		end

	objc_encode_rect_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_decode_rect (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSCoder *)$an_item decodeRect];
			 ]"
		end

feature -- NSGeometryKeyedCoding

	encode_point__for_key_ (a_point: NS_POINT; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_encode_point__for_key_ (item, a_point.item, a_key__item)
		end

	encode_size__for_key_ (a_size: NS_SIZE; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_encode_size__for_key_ (item, a_size.item, a_key__item)
		end

	encode_rect__for_key_ (a_rect: NS_RECT; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_encode_rect__for_key_ (item, a_rect.item, a_key__item)
		end

	decode_point_for_key_ (a_key: detachable NS_STRING): NS_POINT
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			create Result.make
			objc_decode_point_for_key_ (item, Result.item, a_key__item)
		end

	decode_size_for_key_ (a_key: detachable NS_STRING): NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			create Result.make
			objc_decode_size_for_key_ (item, Result.item, a_key__item)
		end

	decode_rect_for_key_ (a_key: detachable NS_STRING): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			create Result.make
			objc_decode_rect_for_key_ (item, Result.item, a_key__item)
		end

feature {NONE} -- NSGeometryKeyedCoding Externals

	objc_encode_point__for_key_ (an_item: POINTER; a_point: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodePoint:*((NSPoint *)$a_point) forKey:$a_key];
			 ]"
		end

	objc_encode_size__for_key_ (an_item: POINTER; a_size: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeSize:*((NSSize *)$a_size) forKey:$a_key];
			 ]"
		end

	objc_encode_rect__for_key_ (an_item: POINTER; a_rect: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCoder *)$an_item encodeRect:*((NSRect *)$a_rect) forKey:$a_key];
			 ]"
		end

	objc_decode_point_for_key_ (an_item: POINTER; result_pointer: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSCoder *)$an_item decodePointForKey:$a_key];
			 ]"
		end

	objc_decode_size_for_key_ (an_item: POINTER; result_pointer: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSCoder *)$an_item decodeSizeForKey:$a_key];
			 ]"
		end

	objc_decode_rect_for_key_ (an_item: POINTER; result_pointer: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSCoder *)$an_item decodeRectForKey:$a_key];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCoder"
		end

end
