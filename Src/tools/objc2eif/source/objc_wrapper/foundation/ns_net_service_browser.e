note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NET_SERVICE_BROWSER

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

feature -- NSNetServiceBrowser

	delegate: detachable NS_NET_SERVICE_BROWSER_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_delegate_ (a_delegate: detachable NS_NET_SERVICE_BROWSER_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	schedule_in_run_loop__for_mode_ (a_run_loop: detachable NS_RUN_LOOP; a_mode: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_run_loop__item: POINTER
			a_mode__item: POINTER
		do
			if attached a_run_loop as a_run_loop_attached then
				a_run_loop__item := a_run_loop_attached.item
			end
			if attached a_mode as a_mode_attached then
				a_mode__item := a_mode_attached.item
			end
			objc_schedule_in_run_loop__for_mode_ (item, a_run_loop__item, a_mode__item)
		end

	remove_from_run_loop__for_mode_ (a_run_loop: detachable NS_RUN_LOOP; a_mode: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_run_loop__item: POINTER
			a_mode__item: POINTER
		do
			if attached a_run_loop as a_run_loop_attached then
				a_run_loop__item := a_run_loop_attached.item
			end
			if attached a_mode as a_mode_attached then
				a_mode__item := a_mode_attached.item
			end
			objc_remove_from_run_loop__for_mode_ (item, a_run_loop__item, a_mode__item)
		end

	search_for_browsable_domains
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_search_for_browsable_domains (item)
		end

	search_for_registration_domains
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_search_for_registration_domains (item)
		end

	search_for_services_of_type__in_domain_ (a_type: detachable NS_STRING; a_domain_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_type__item: POINTER
			a_domain_string__item: POINTER
		do
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			if attached a_domain_string as a_domain_string_attached then
				a_domain_string__item := a_domain_string_attached.item
			end
			objc_search_for_services_of_type__in_domain_ (item, a_type__item, a_domain_string__item)
		end

	stop
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_stop (item)
		end

feature {NONE} -- NSNetServiceBrowser Externals

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNetServiceBrowser *)$an_item delegate];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetServiceBrowser *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_schedule_in_run_loop__for_mode_ (an_item: POINTER; a_run_loop: POINTER; a_mode: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetServiceBrowser *)$an_item scheduleInRunLoop:$a_run_loop forMode:$a_mode];
			 ]"
		end

	objc_remove_from_run_loop__for_mode_ (an_item: POINTER; a_run_loop: POINTER; a_mode: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetServiceBrowser *)$an_item removeFromRunLoop:$a_run_loop forMode:$a_mode];
			 ]"
		end

	objc_search_for_browsable_domains (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetServiceBrowser *)$an_item searchForBrowsableDomains];
			 ]"
		end

	objc_search_for_registration_domains (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetServiceBrowser *)$an_item searchForRegistrationDomains];
			 ]"
		end

	objc_search_for_services_of_type__in_domain_ (an_item: POINTER; a_type: POINTER; a_domain_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetServiceBrowser *)$an_item searchForServicesOfType:$a_type inDomain:$a_domain_string];
			 ]"
		end

	objc_stop (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetServiceBrowser *)$an_item stop];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSNetServiceBrowser"
		end

end
