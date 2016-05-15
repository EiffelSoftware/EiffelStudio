note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL_PROTOCOL

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_request__cached_response__client_,
	make

feature {NONE} -- Initialization

	make_with_request__cached_response__client_ (a_request: detachable NS_URL_REQUEST; a_cached_response: detachable NS_CACHED_URL_RESPONSE; a_client: detachable NS_URL_PROTOCOL_CLIENT_PROTOCOL)
			-- Initialize `Current'.
		local
			a_request__item: POINTER
			a_cached_response__item: POINTER
			a_client__item: POINTER
		do
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			if attached a_cached_response as a_cached_response_attached then
				a_cached_response__item := a_cached_response_attached.item
			end
			if attached a_client as a_client_attached then
				a_client__item := a_client_attached.item
			end
			make_with_pointer (objc_init_with_request__cached_response__client_(allocate_object, a_request__item, a_cached_response__item, a_client__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSURLProtocol Externals

	objc_init_with_request__cached_response__client_ (an_item: POINTER; a_request: POINTER; a_cached_response: POINTER; a_client: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLProtocol *)$an_item initWithRequest:$a_request cachedResponse:$a_cached_response client:$a_client];
			 ]"
		end

	objc_client (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLProtocol *)$an_item client];
			 ]"
		end

	objc_request (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLProtocol *)$an_item request];
			 ]"
		end

	objc_cached_response (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLProtocol *)$an_item cachedResponse];
			 ]"
		end

	objc_start_loading (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLProtocol *)$an_item startLoading];
			 ]"
		end

	objc_stop_loading (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLProtocol *)$an_item stopLoading];
			 ]"
		end

feature -- NSURLProtocol

	client: detachable NS_URL_PROTOCOL_CLIENT_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_client (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like client} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like client} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	request: detachable NS_URL_REQUEST
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_request (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like request} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like request} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	cached_response: detachable NS_CACHED_URL_RESPONSE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_cached_response (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cached_response} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cached_response} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	start_loading
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_start_loading (item)
		end

	stop_loading
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_stop_loading (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURLProtocol"
		end

end
