note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL_PROTOCOL_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSURLProtocol

	can_init_with_request_ (a_request: detachable NS_URL_REQUEST): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_request__item: POINTER
		do
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_can_init_with_request_ (l_objc_class.item, a_request__item)
		end

	canonical_request_for_request_ (a_request: detachable NS_URL_REQUEST): detachable NS_URL_REQUEST
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_request__item: POINTER
		do
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_canonical_request_for_request_ (l_objc_class.item, a_request__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like canonical_request_for_request_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like canonical_request_for_request_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	request_is_cache_equivalent__to_request_ (a_a: detachable NS_URL_REQUEST; a_b: detachable NS_URL_REQUEST): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_a__item: POINTER
			a_b__item: POINTER
		do
			if attached a_a as a_a_attached then
				a_a__item := a_a_attached.item
			end
			if attached a_b as a_b_attached then
				a_b__item := a_b_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_request_is_cache_equivalent__to_request_ (l_objc_class.item, a_a__item, a_b__item)
		end

	property_for_key__in_request_ (a_key: detachable NS_STRING; a_request: detachable NS_URL_REQUEST): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_key__item: POINTER
			a_request__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_property_for_key__in_request_ (l_objc_class.item, a_key__item, a_request__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like property_for_key__in_request_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like property_for_key__in_request_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_property__for_key__in_request_ (a_value: detachable NS_OBJECT; a_key: detachable NS_STRING; a_request: detachable NS_MUTABLE_URL_REQUEST)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_value__item: POINTER
			a_key__item: POINTER
			a_request__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_property__for_key__in_request_ (l_objc_class.item, a_value__item, a_key__item, a_request__item)
		end

	remove_property_for_key__in_request_ (a_key: detachable NS_STRING; a_request: detachable NS_MUTABLE_URL_REQUEST)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_key__item: POINTER
			a_request__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_remove_property_for_key__in_request_ (l_objc_class.item, a_key__item, a_request__item)
		end

	register_class_ (a_protocol_class: detachable OBJC_CLASS): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_protocol_class__item: POINTER
		do
			if attached a_protocol_class as a_protocol_class_attached then
				a_protocol_class__item := a_protocol_class_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_register_class_ (l_objc_class.item, a_protocol_class__item)
		end

	unregister_class_ (a_protocol_class: detachable OBJC_CLASS)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_protocol_class__item: POINTER
		do
			if attached a_protocol_class as a_protocol_class_attached then
				a_protocol_class__item := a_protocol_class_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_unregister_class_ (l_objc_class.item, a_protocol_class__item)
		end

feature {NONE} -- NSURLProtocol Externals

	objc_can_init_with_request_ (a_class_object: POINTER; a_request: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object canInitWithRequest:$a_request];
			 ]"
		end

	objc_canonical_request_for_request_ (a_class_object: POINTER; a_request: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object canonicalRequestForRequest:$a_request];
			 ]"
		end

	objc_request_is_cache_equivalent__to_request_ (a_class_object: POINTER; a_a: POINTER; a_b: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object requestIsCacheEquivalent:$a_a toRequest:$a_b];
			 ]"
		end

	objc_property_for_key__in_request_ (a_class_object: POINTER; a_key: POINTER; a_request: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object propertyForKey:$a_key inRequest:$a_request];
			 ]"
		end

	objc_set_property__for_key__in_request_ (a_class_object: POINTER; a_value: POINTER; a_key: POINTER; a_request: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object setProperty:$a_value forKey:$a_key inRequest:$a_request];
			 ]"
		end

	objc_remove_property_for_key__in_request_ (a_class_object: POINTER; a_key: POINTER; a_request: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object removePropertyForKey:$a_key inRequest:$a_request];
			 ]"
		end

	objc_register_class_ (a_class_object: POINTER; a_protocol_class: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object registerClass:$a_protocol_class];
			 ]"
		end

	objc_unregister_class_ (a_class_object: POINTER; a_protocol_class: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object unregisterClass:$a_protocol_class];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURLProtocol"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
