note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_NET_SERVICE_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	net_service_will_publish_ (a_sender: detachable NS_NET_SERVICE)
			-- Auto generated Objective-C wrapper.
		require
			has_net_service_will_publish_: has_net_service_will_publish_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_net_service_will_publish_ (item, a_sender__item)
		end

	net_service_did_publish_ (a_sender: detachable NS_NET_SERVICE)
			-- Auto generated Objective-C wrapper.
		require
			has_net_service_did_publish_: has_net_service_did_publish_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_net_service_did_publish_ (item, a_sender__item)
		end

	net_service__did_not_publish_ (a_sender: detachable NS_NET_SERVICE; a_error_dict: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		require
			has_net_service__did_not_publish_: has_net_service__did_not_publish_
		local
			a_sender__item: POINTER
			a_error_dict__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_error_dict as a_error_dict_attached then
				a_error_dict__item := a_error_dict_attached.item
			end
			objc_net_service__did_not_publish_ (item, a_sender__item, a_error_dict__item)
		end

	net_service_will_resolve_ (a_sender: detachable NS_NET_SERVICE)
			-- Auto generated Objective-C wrapper.
		require
			has_net_service_will_resolve_: has_net_service_will_resolve_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_net_service_will_resolve_ (item, a_sender__item)
		end

	net_service_did_resolve_address_ (a_sender: detachable NS_NET_SERVICE)
			-- Auto generated Objective-C wrapper.
		require
			has_net_service_did_resolve_address_: has_net_service_did_resolve_address_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_net_service_did_resolve_address_ (item, a_sender__item)
		end

	net_service__did_not_resolve_ (a_sender: detachable NS_NET_SERVICE; a_error_dict: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		require
			has_net_service__did_not_resolve_: has_net_service__did_not_resolve_
		local
			a_sender__item: POINTER
			a_error_dict__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_error_dict as a_error_dict_attached then
				a_error_dict__item := a_error_dict_attached.item
			end
			objc_net_service__did_not_resolve_ (item, a_sender__item, a_error_dict__item)
		end

	net_service_did_stop_ (a_sender: detachable NS_NET_SERVICE)
			-- Auto generated Objective-C wrapper.
		require
			has_net_service_did_stop_: has_net_service_did_stop_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_net_service_did_stop_ (item, a_sender__item)
		end

	net_service__did_update_txt_record_data_ (a_sender: detachable NS_NET_SERVICE; a_data: detachable NS_DATA)
			-- Auto generated Objective-C wrapper.
		require
			has_net_service__did_update_txt_record_data_: has_net_service__did_update_txt_record_data_
		local
			a_sender__item: POINTER
			a_data__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			objc_net_service__did_update_txt_record_data_ (item, a_sender__item, a_data__item)
		end

feature -- Status Report

	has_net_service_will_publish_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_net_service_will_publish_ (item)
		end

	has_net_service_did_publish_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_net_service_did_publish_ (item)
		end

	has_net_service__did_not_publish_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_net_service__did_not_publish_ (item)
		end

	has_net_service_will_resolve_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_net_service_will_resolve_ (item)
		end

	has_net_service_did_resolve_address_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_net_service_did_resolve_address_ (item)
		end

	has_net_service__did_not_resolve_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_net_service__did_not_resolve_ (item)
		end

	has_net_service_did_stop_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_net_service_did_stop_ (item)
		end

	has_net_service__did_update_txt_record_data_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_net_service__did_update_txt_record_data_ (item)
		end

feature -- Status Report Externals

	objc_has_net_service_will_publish_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(netServiceWillPublish:)];
			 ]"
		end

	objc_has_net_service_did_publish_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(netServiceDidPublish:)];
			 ]"
		end

	objc_has_net_service__did_not_publish_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(netService:didNotPublish:)];
			 ]"
		end

	objc_has_net_service_will_resolve_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(netServiceWillResolve:)];
			 ]"
		end

	objc_has_net_service_did_resolve_address_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(netServiceDidResolveAddress:)];
			 ]"
		end

	objc_has_net_service__did_not_resolve_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(netService:didNotResolve:)];
			 ]"
		end

	objc_has_net_service_did_stop_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(netServiceDidStop:)];
			 ]"
		end

	objc_has_net_service__did_update_txt_record_data_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(netService:didUpdateTXTRecordData:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_net_service_will_publish_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSNetServiceDelegate>)$an_item netServiceWillPublish:$a_sender];
			 ]"
		end

	objc_net_service_did_publish_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSNetServiceDelegate>)$an_item netServiceDidPublish:$a_sender];
			 ]"
		end

	objc_net_service__did_not_publish_ (an_item: POINTER; a_sender: POINTER; a_error_dict: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSNetServiceDelegate>)$an_item netService:$a_sender didNotPublish:$a_error_dict];
			 ]"
		end

	objc_net_service_will_resolve_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSNetServiceDelegate>)$an_item netServiceWillResolve:$a_sender];
			 ]"
		end

	objc_net_service_did_resolve_address_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSNetServiceDelegate>)$an_item netServiceDidResolveAddress:$a_sender];
			 ]"
		end

	objc_net_service__did_not_resolve_ (an_item: POINTER; a_sender: POINTER; a_error_dict: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSNetServiceDelegate>)$an_item netService:$a_sender didNotResolve:$a_error_dict];
			 ]"
		end

	objc_net_service_did_stop_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSNetServiceDelegate>)$an_item netServiceDidStop:$a_sender];
			 ]"
		end

	objc_net_service__did_update_txt_record_data_ (an_item: POINTER; a_sender: POINTER; a_data: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSNetServiceDelegate>)$an_item netService:$a_sender didUpdateTXTRecordData:$a_data];
			 ]"
		end

end
