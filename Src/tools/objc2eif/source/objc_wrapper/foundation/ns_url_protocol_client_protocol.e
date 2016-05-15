note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_URL_PROTOCOL_CLIENT_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Required Methods

	url_protocol__was_redirected_to_request__redirect_response_ (a_protocol: detachable NS_URL_PROTOCOL; a_request: detachable NS_URL_REQUEST; a_redirect_response: detachable NS_URL_RESPONSE)
			-- Auto generated Objective-C wrapper.
		local
			a_protocol__item: POINTER
			a_request__item: POINTER
			a_redirect_response__item: POINTER
		do
			if attached a_protocol as a_protocol_attached then
				a_protocol__item := a_protocol_attached.item
			end
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			if attached a_redirect_response as a_redirect_response_attached then
				a_redirect_response__item := a_redirect_response_attached.item
			end
			objc_url_protocol__was_redirected_to_request__redirect_response_ (item, a_protocol__item, a_request__item, a_redirect_response__item)
		end

	url_protocol__cached_response_is_valid_ (a_protocol: detachable NS_URL_PROTOCOL; a_cached_response: detachable NS_CACHED_URL_RESPONSE)
			-- Auto generated Objective-C wrapper.
		local
			a_protocol__item: POINTER
			a_cached_response__item: POINTER
		do
			if attached a_protocol as a_protocol_attached then
				a_protocol__item := a_protocol_attached.item
			end
			if attached a_cached_response as a_cached_response_attached then
				a_cached_response__item := a_cached_response_attached.item
			end
			objc_url_protocol__cached_response_is_valid_ (item, a_protocol__item, a_cached_response__item)
		end

	url_protocol__did_receive_response__cache_storage_policy_ (a_protocol: detachable NS_URL_PROTOCOL; a_response: detachable NS_URL_RESPONSE; a_policy: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_protocol__item: POINTER
			a_response__item: POINTER
		do
			if attached a_protocol as a_protocol_attached then
				a_protocol__item := a_protocol_attached.item
			end
			if attached a_response as a_response_attached then
				a_response__item := a_response_attached.item
			end
			objc_url_protocol__did_receive_response__cache_storage_policy_ (item, a_protocol__item, a_response__item, a_policy)
		end

	url_protocol__did_load_data_ (a_protocol: detachable NS_URL_PROTOCOL; a_data: detachable NS_DATA)
			-- Auto generated Objective-C wrapper.
		local
			a_protocol__item: POINTER
			a_data__item: POINTER
		do
			if attached a_protocol as a_protocol_attached then
				a_protocol__item := a_protocol_attached.item
			end
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			objc_url_protocol__did_load_data_ (item, a_protocol__item, a_data__item)
		end

	url_protocol_did_finish_loading_ (a_protocol: detachable NS_URL_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_protocol__item: POINTER
		do
			if attached a_protocol as a_protocol_attached then
				a_protocol__item := a_protocol_attached.item
			end
			objc_url_protocol_did_finish_loading_ (item, a_protocol__item)
		end

	url_protocol__did_fail_with_error_ (a_protocol: detachable NS_URL_PROTOCOL; a_error: detachable NS_ERROR)
			-- Auto generated Objective-C wrapper.
		local
			a_protocol__item: POINTER
			a_error__item: POINTER
		do
			if attached a_protocol as a_protocol_attached then
				a_protocol__item := a_protocol_attached.item
			end
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			objc_url_protocol__did_fail_with_error_ (item, a_protocol__item, a_error__item)
		end

	url_protocol__did_receive_authentication_challenge_ (a_protocol: detachable NS_URL_PROTOCOL; a_challenge: detachable NS_URL_AUTHENTICATION_CHALLENGE)
			-- Auto generated Objective-C wrapper.
		local
			a_protocol__item: POINTER
			a_challenge__item: POINTER
		do
			if attached a_protocol as a_protocol_attached then
				a_protocol__item := a_protocol_attached.item
			end
			if attached a_challenge as a_challenge_attached then
				a_challenge__item := a_challenge_attached.item
			end
			objc_url_protocol__did_receive_authentication_challenge_ (item, a_protocol__item, a_challenge__item)
		end

	url_protocol__did_cancel_authentication_challenge_ (a_protocol: detachable NS_URL_PROTOCOL; a_challenge: detachable NS_URL_AUTHENTICATION_CHALLENGE)
			-- Auto generated Objective-C wrapper.
		local
			a_protocol__item: POINTER
			a_challenge__item: POINTER
		do
			if attached a_protocol as a_protocol_attached then
				a_protocol__item := a_protocol_attached.item
			end
			if attached a_challenge as a_challenge_attached then
				a_challenge__item := a_challenge_attached.item
			end
			objc_url_protocol__did_cancel_authentication_challenge_ (item, a_protocol__item, a_challenge__item)
		end

feature {NONE} -- Required Methods Externals

	objc_url_protocol__was_redirected_to_request__redirect_response_ (an_item: POINTER; a_protocol: POINTER; a_request: POINTER; a_redirect_response: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSURLProtocolClient>)$an_item URLProtocol:$a_protocol wasRedirectedToRequest:$a_request redirectResponse:$a_redirect_response];
			 ]"
		end

	objc_url_protocol__cached_response_is_valid_ (an_item: POINTER; a_protocol: POINTER; a_cached_response: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSURLProtocolClient>)$an_item URLProtocol:$a_protocol cachedResponseIsValid:$a_cached_response];
			 ]"
		end

	objc_url_protocol__did_receive_response__cache_storage_policy_ (an_item: POINTER; a_protocol: POINTER; a_response: POINTER; a_policy: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSURLProtocolClient>)$an_item URLProtocol:$a_protocol didReceiveResponse:$a_response cacheStoragePolicy:$a_policy];
			 ]"
		end

	objc_url_protocol__did_load_data_ (an_item: POINTER; a_protocol: POINTER; a_data: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSURLProtocolClient>)$an_item URLProtocol:$a_protocol didLoadData:$a_data];
			 ]"
		end

	objc_url_protocol_did_finish_loading_ (an_item: POINTER; a_protocol: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSURLProtocolClient>)$an_item URLProtocolDidFinishLoading:$a_protocol];
			 ]"
		end

	objc_url_protocol__did_fail_with_error_ (an_item: POINTER; a_protocol: POINTER; a_error: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSURLProtocolClient>)$an_item URLProtocol:$a_protocol didFailWithError:$a_error];
			 ]"
		end

	objc_url_protocol__did_receive_authentication_challenge_ (an_item: POINTER; a_protocol: POINTER; a_challenge: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSURLProtocolClient>)$an_item URLProtocol:$a_protocol didReceiveAuthenticationChallenge:$a_challenge];
			 ]"
		end

	objc_url_protocol__did_cancel_authentication_challenge_ (an_item: POINTER; a_protocol: POINTER; a_challenge: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSURLProtocolClient>)$an_item URLProtocol:$a_protocol didCancelAuthenticationChallenge:$a_challenge];
			 ]"
		end

end
