note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL_REQUEST

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_COPYING_PROTOCOL
	NS_MUTABLE_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_ur_l_,
	make_with_ur_l__cache_policy__timeout_interval_,
	make

feature {NONE} -- Initialization

	make_with_ur_l_ (a_url: detachable NS_URL)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			make_with_pointer (objc_init_with_ur_l_(allocate_object, a_url__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_ur_l__cache_policy__timeout_interval_ (a_url: detachable NS_URL; a_cache_policy: NATURAL_64; a_timeout_interval: REAL_64)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			make_with_pointer (objc_init_with_ur_l__cache_policy__timeout_interval_(allocate_object, a_url__item, a_cache_policy, a_timeout_interval))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSURLRequest Externals

	objc_init_with_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLRequest *)$an_item initWithURL:$a_url];
			 ]"
		end

	objc_init_with_ur_l__cache_policy__timeout_interval_ (an_item: POINTER; a_url: POINTER; a_cache_policy: NATURAL_64; a_timeout_interval: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLRequest *)$an_item initWithURL:$a_url cachePolicy:$a_cache_policy timeoutInterval:$a_timeout_interval];
			 ]"
		end

	objc_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLRequest *)$an_item URL];
			 ]"
		end

	objc_cache_policy (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURLRequest *)$an_item cachePolicy];
			 ]"
		end

	objc_timeout_interval (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURLRequest *)$an_item timeoutInterval];
			 ]"
		end

	objc_main_document_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLRequest *)$an_item mainDocumentURL];
			 ]"
		end

feature -- NSURLRequest

	url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	cache_policy: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_cache_policy (item)
		end

	timeout_interval: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_timeout_interval (item)
		end

	main_document_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_main_document_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like main_document_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like main_document_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature -- NSHTTPURLRequest

	http_method: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_http_method (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like http_method} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like http_method} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	all_http_header_fields: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_all_http_header_fields (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like all_http_header_fields} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like all_http_header_fields} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	value_for_http_header_field_ (a_field: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_field__item: POINTER
		do
			if attached a_field as a_field_attached then
				a_field__item := a_field_attached.item
			end
			result_pointer := objc_value_for_http_header_field_ (item, a_field__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_for_http_header_field_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_for_http_header_field_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	http_body: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_http_body (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like http_body} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like http_body} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	http_body_stream: detachable NS_INPUT_STREAM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_http_body_stream (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like http_body_stream} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like http_body_stream} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	http_should_handle_cookies: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_http_should_handle_cookies (item)
		end

feature {NONE} -- NSHTTPURLRequest Externals

	objc_http_method (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLRequest *)$an_item HTTPMethod];
			 ]"
		end

	objc_all_http_header_fields (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLRequest *)$an_item allHTTPHeaderFields];
			 ]"
		end

	objc_value_for_http_header_field_ (an_item: POINTER; a_field: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLRequest *)$an_item valueForHTTPHeaderField:$a_field];
			 ]"
		end

	objc_http_body (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLRequest *)$an_item HTTPBody];
			 ]"
		end

	objc_http_body_stream (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLRequest *)$an_item HTTPBodyStream];
			 ]"
		end

	objc_http_should_handle_cookies (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURLRequest *)$an_item HTTPShouldHandleCookies];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURLRequest"
		end

end
