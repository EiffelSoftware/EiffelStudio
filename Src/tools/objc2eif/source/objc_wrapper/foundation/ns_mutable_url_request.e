note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MUTABLE_URL_REQUEST

inherit
	NS_URL_REQUEST
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_ur_l_,
	make_with_ur_l__cache_policy__timeout_interval_,
	make

feature -- NSMutableURLRequest

	set_ur_l_ (a_url: detachable NS_URL)
			-- Auto generated Objective-C wrapper.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			objc_set_ur_l_ (item, a_url__item)
		end

	set_cache_policy_ (a_policy: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_cache_policy_ (item, a_policy)
		end

	set_timeout_interval_ (a_seconds: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_timeout_interval_ (item, a_seconds)
		end

	set_main_document_ur_l_ (a_url: detachable NS_URL)
			-- Auto generated Objective-C wrapper.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			objc_set_main_document_ur_l_ (item, a_url__item)
		end

feature {NONE} -- NSMutableURLRequest Externals

	objc_set_ur_l_ (an_item: POINTER; a_url: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableURLRequest *)$an_item setURL:$a_url];
			 ]"
		end

	objc_set_cache_policy_ (an_item: POINTER; a_policy: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableURLRequest *)$an_item setCachePolicy:$a_policy];
			 ]"
		end

	objc_set_timeout_interval_ (an_item: POINTER; a_seconds: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableURLRequest *)$an_item setTimeoutInterval:$a_seconds];
			 ]"
		end

	objc_set_main_document_ur_l_ (an_item: POINTER; a_url: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableURLRequest *)$an_item setMainDocumentURL:$a_url];
			 ]"
		end

feature -- NSMutableHTTPURLRequest

	set_http_method_ (a_method: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_method__item: POINTER
		do
			if attached a_method as a_method_attached then
				a_method__item := a_method_attached.item
			end
			objc_set_http_method_ (item, a_method__item)
		end

	set_all_http_header_fields_ (a_header_fields: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_header_fields__item: POINTER
		do
			if attached a_header_fields as a_header_fields_attached then
				a_header_fields__item := a_header_fields_attached.item
			end
			objc_set_all_http_header_fields_ (item, a_header_fields__item)
		end

	set_value__for_http_header_field_ (a_value: detachable NS_STRING; a_field: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
			a_field__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			if attached a_field as a_field_attached then
				a_field__item := a_field_attached.item
			end
			objc_set_value__for_http_header_field_ (item, a_value__item, a_field__item)
		end

	add_value__for_http_header_field_ (a_value: detachable NS_STRING; a_field: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
			a_field__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			if attached a_field as a_field_attached then
				a_field__item := a_field_attached.item
			end
			objc_add_value__for_http_header_field_ (item, a_value__item, a_field__item)
		end

	set_http_body_ (a_data: detachable NS_DATA)
			-- Auto generated Objective-C wrapper.
		local
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			objc_set_http_body_ (item, a_data__item)
		end

	set_http_body_stream_ (a_input_stream: detachable NS_INPUT_STREAM)
			-- Auto generated Objective-C wrapper.
		local
			a_input_stream__item: POINTER
		do
			if attached a_input_stream as a_input_stream_attached then
				a_input_stream__item := a_input_stream_attached.item
			end
			objc_set_http_body_stream_ (item, a_input_stream__item)
		end

	set_http_should_handle_cookies_ (a_should: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_http_should_handle_cookies_ (item, a_should)
		end

feature {NONE} -- NSMutableHTTPURLRequest Externals

	objc_set_http_method_ (an_item: POINTER; a_method: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableURLRequest *)$an_item setHTTPMethod:$a_method];
			 ]"
		end

	objc_set_all_http_header_fields_ (an_item: POINTER; a_header_fields: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableURLRequest *)$an_item setAllHTTPHeaderFields:$a_header_fields];
			 ]"
		end

	objc_set_value__for_http_header_field_ (an_item: POINTER; a_value: POINTER; a_field: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableURLRequest *)$an_item setValue:$a_value forHTTPHeaderField:$a_field];
			 ]"
		end

	objc_add_value__for_http_header_field_ (an_item: POINTER; a_value: POINTER; a_field: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableURLRequest *)$an_item addValue:$a_value forHTTPHeaderField:$a_field];
			 ]"
		end

	objc_set_http_body_ (an_item: POINTER; a_data: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableURLRequest *)$an_item setHTTPBody:$a_data];
			 ]"
		end

	objc_set_http_body_stream_ (an_item: POINTER; a_input_stream: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableURLRequest *)$an_item setHTTPBodyStream:$a_input_stream];
			 ]"
		end

	objc_set_http_should_handle_cookies_ (an_item: POINTER; a_should: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableURLRequest *)$an_item setHTTPShouldHandleCookies:$a_should];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMutableURLRequest"
		end

end
