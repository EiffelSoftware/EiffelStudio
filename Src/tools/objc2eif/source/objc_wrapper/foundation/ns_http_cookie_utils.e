note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_HTTP_COOKIE_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSHTTPCookie

	cookie_with_properties_ (a_properties: detachable NS_DICTIONARY): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_properties__item: POINTER
		do
			if attached a_properties as a_properties_attached then
				a_properties__item := a_properties_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_cookie_with_properties_ (l_objc_class.item, a_properties__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cookie_with_properties_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cookie_with_properties_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	request_header_fields_with_cookies_ (a_cookies: detachable NS_ARRAY): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_cookies__item: POINTER
		do
			if attached a_cookies as a_cookies_attached then
				a_cookies__item := a_cookies_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_request_header_fields_with_cookies_ (l_objc_class.item, a_cookies__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like request_header_fields_with_cookies_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like request_header_fields_with_cookies_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	cookies_with_response_header_fields__for_ur_l_ (a_header_fields: detachable NS_DICTIONARY; a_url: detachable NS_URL): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_header_fields__item: POINTER
			a_url__item: POINTER
		do
			if attached a_header_fields as a_header_fields_attached then
				a_header_fields__item := a_header_fields_attached.item
			end
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_cookies_with_response_header_fields__for_ur_l_ (l_objc_class.item, a_header_fields__item, a_url__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cookies_with_response_header_fields__for_ur_l_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cookies_with_response_header_fields__for_ur_l_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSHTTPCookie Externals

	objc_cookie_with_properties_ (a_class_object: POINTER; a_properties: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object cookieWithProperties:$a_properties];
			 ]"
		end

	objc_request_header_fields_with_cookies_ (a_class_object: POINTER; a_cookies: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object requestHeaderFieldsWithCookies:$a_cookies];
			 ]"
		end

	objc_cookies_with_response_header_fields__for_ur_l_ (a_class_object: POINTER; a_header_fields: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object cookiesWithResponseHeaderFields:$a_header_fields forURL:$a_url];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSHTTPCookie"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
