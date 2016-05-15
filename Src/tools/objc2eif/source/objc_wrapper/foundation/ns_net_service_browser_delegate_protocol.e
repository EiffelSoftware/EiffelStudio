note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_NET_SERVICE_BROWSER_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	net_service_browser_will_search_ (a_net_service_browser: detachable NS_NET_SERVICE_BROWSER)
			-- Auto generated Objective-C wrapper.
		require
			has_net_service_browser_will_search_: has_net_service_browser_will_search_
		local
			a_net_service_browser__item: POINTER
		do
			if attached a_net_service_browser as a_net_service_browser_attached then
				a_net_service_browser__item := a_net_service_browser_attached.item
			end
			objc_net_service_browser_will_search_ (item, a_net_service_browser__item)
		end

	net_service_browser_did_stop_search_ (a_net_service_browser: detachable NS_NET_SERVICE_BROWSER)
			-- Auto generated Objective-C wrapper.
		require
			has_net_service_browser_did_stop_search_: has_net_service_browser_did_stop_search_
		local
			a_net_service_browser__item: POINTER
		do
			if attached a_net_service_browser as a_net_service_browser_attached then
				a_net_service_browser__item := a_net_service_browser_attached.item
			end
			objc_net_service_browser_did_stop_search_ (item, a_net_service_browser__item)
		end

	net_service_browser__did_not_search_ (a_net_service_browser: detachable NS_NET_SERVICE_BROWSER; a_error_dict: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		require
			has_net_service_browser__did_not_search_: has_net_service_browser__did_not_search_
		local
			a_net_service_browser__item: POINTER
			a_error_dict__item: POINTER
		do
			if attached a_net_service_browser as a_net_service_browser_attached then
				a_net_service_browser__item := a_net_service_browser_attached.item
			end
			if attached a_error_dict as a_error_dict_attached then
				a_error_dict__item := a_error_dict_attached.item
			end
			objc_net_service_browser__did_not_search_ (item, a_net_service_browser__item, a_error_dict__item)
		end

	net_service_browser__did_find_domain__more_coming_ (a_net_service_browser: detachable NS_NET_SERVICE_BROWSER; a_domain_string: detachable NS_STRING; a_more_coming: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		require
			has_net_service_browser__did_find_domain__more_coming_: has_net_service_browser__did_find_domain__more_coming_
		local
			a_net_service_browser__item: POINTER
			a_domain_string__item: POINTER
		do
			if attached a_net_service_browser as a_net_service_browser_attached then
				a_net_service_browser__item := a_net_service_browser_attached.item
			end
			if attached a_domain_string as a_domain_string_attached then
				a_domain_string__item := a_domain_string_attached.item
			end
			objc_net_service_browser__did_find_domain__more_coming_ (item, a_net_service_browser__item, a_domain_string__item, a_more_coming)
		end

	net_service_browser__did_find_service__more_coming_ (a_net_service_browser: detachable NS_NET_SERVICE_BROWSER; a_net_service: detachable NS_NET_SERVICE; a_more_coming: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		require
			has_net_service_browser__did_find_service__more_coming_: has_net_service_browser__did_find_service__more_coming_
		local
			a_net_service_browser__item: POINTER
			a_net_service__item: POINTER
		do
			if attached a_net_service_browser as a_net_service_browser_attached then
				a_net_service_browser__item := a_net_service_browser_attached.item
			end
			if attached a_net_service as a_net_service_attached then
				a_net_service__item := a_net_service_attached.item
			end
			objc_net_service_browser__did_find_service__more_coming_ (item, a_net_service_browser__item, a_net_service__item, a_more_coming)
		end

	net_service_browser__did_remove_domain__more_coming_ (a_net_service_browser: detachable NS_NET_SERVICE_BROWSER; a_domain_string: detachable NS_STRING; a_more_coming: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		require
			has_net_service_browser__did_remove_domain__more_coming_: has_net_service_browser__did_remove_domain__more_coming_
		local
			a_net_service_browser__item: POINTER
			a_domain_string__item: POINTER
		do
			if attached a_net_service_browser as a_net_service_browser_attached then
				a_net_service_browser__item := a_net_service_browser_attached.item
			end
			if attached a_domain_string as a_domain_string_attached then
				a_domain_string__item := a_domain_string_attached.item
			end
			objc_net_service_browser__did_remove_domain__more_coming_ (item, a_net_service_browser__item, a_domain_string__item, a_more_coming)
		end

	net_service_browser__did_remove_service__more_coming_ (a_net_service_browser: detachable NS_NET_SERVICE_BROWSER; a_net_service: detachable NS_NET_SERVICE; a_more_coming: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		require
			has_net_service_browser__did_remove_service__more_coming_: has_net_service_browser__did_remove_service__more_coming_
		local
			a_net_service_browser__item: POINTER
			a_net_service__item: POINTER
		do
			if attached a_net_service_browser as a_net_service_browser_attached then
				a_net_service_browser__item := a_net_service_browser_attached.item
			end
			if attached a_net_service as a_net_service_attached then
				a_net_service__item := a_net_service_attached.item
			end
			objc_net_service_browser__did_remove_service__more_coming_ (item, a_net_service_browser__item, a_net_service__item, a_more_coming)
		end

feature -- Status Report

	has_net_service_browser_will_search_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_net_service_browser_will_search_ (item)
		end

	has_net_service_browser_did_stop_search_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_net_service_browser_did_stop_search_ (item)
		end

	has_net_service_browser__did_not_search_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_net_service_browser__did_not_search_ (item)
		end

	has_net_service_browser__did_find_domain__more_coming_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_net_service_browser__did_find_domain__more_coming_ (item)
		end

	has_net_service_browser__did_find_service__more_coming_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_net_service_browser__did_find_service__more_coming_ (item)
		end

	has_net_service_browser__did_remove_domain__more_coming_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_net_service_browser__did_remove_domain__more_coming_ (item)
		end

	has_net_service_browser__did_remove_service__more_coming_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_net_service_browser__did_remove_service__more_coming_ (item)
		end

feature -- Status Report Externals

	objc_has_net_service_browser_will_search_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(netServiceBrowserWillSearch:)];
			 ]"
		end

	objc_has_net_service_browser_did_stop_search_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(netServiceBrowserDidStopSearch:)];
			 ]"
		end

	objc_has_net_service_browser__did_not_search_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(netServiceBrowser:didNotSearch:)];
			 ]"
		end

	objc_has_net_service_browser__did_find_domain__more_coming_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(netServiceBrowser:didFindDomain:moreComing:)];
			 ]"
		end

	objc_has_net_service_browser__did_find_service__more_coming_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(netServiceBrowser:didFindService:moreComing:)];
			 ]"
		end

	objc_has_net_service_browser__did_remove_domain__more_coming_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(netServiceBrowser:didRemoveDomain:moreComing:)];
			 ]"
		end

	objc_has_net_service_browser__did_remove_service__more_coming_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(netServiceBrowser:didRemoveService:moreComing:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_net_service_browser_will_search_ (an_item: POINTER; a_net_service_browser: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSNetServiceBrowserDelegate>)$an_item netServiceBrowserWillSearch:$a_net_service_browser];
			 ]"
		end

	objc_net_service_browser_did_stop_search_ (an_item: POINTER; a_net_service_browser: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSNetServiceBrowserDelegate>)$an_item netServiceBrowserDidStopSearch:$a_net_service_browser];
			 ]"
		end

	objc_net_service_browser__did_not_search_ (an_item: POINTER; a_net_service_browser: POINTER; a_error_dict: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSNetServiceBrowserDelegate>)$an_item netServiceBrowser:$a_net_service_browser didNotSearch:$a_error_dict];
			 ]"
		end

	objc_net_service_browser__did_find_domain__more_coming_ (an_item: POINTER; a_net_service_browser: POINTER; a_domain_string: POINTER; a_more_coming: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSNetServiceBrowserDelegate>)$an_item netServiceBrowser:$a_net_service_browser didFindDomain:$a_domain_string moreComing:$a_more_coming];
			 ]"
		end

	objc_net_service_browser__did_find_service__more_coming_ (an_item: POINTER; a_net_service_browser: POINTER; a_net_service: POINTER; a_more_coming: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSNetServiceBrowserDelegate>)$an_item netServiceBrowser:$a_net_service_browser didFindService:$a_net_service moreComing:$a_more_coming];
			 ]"
		end

	objc_net_service_browser__did_remove_domain__more_coming_ (an_item: POINTER; a_net_service_browser: POINTER; a_domain_string: POINTER; a_more_coming: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSNetServiceBrowserDelegate>)$an_item netServiceBrowser:$a_net_service_browser didRemoveDomain:$a_domain_string moreComing:$a_more_coming];
			 ]"
		end

	objc_net_service_browser__did_remove_service__more_coming_ (an_item: POINTER; a_net_service_browser: POINTER; a_net_service: POINTER; a_more_coming: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSNetServiceBrowserDelegate>)$an_item netServiceBrowser:$a_net_service_browser didRemoveService:$a_net_service moreComing:$a_more_coming];
			 ]"
		end

end
