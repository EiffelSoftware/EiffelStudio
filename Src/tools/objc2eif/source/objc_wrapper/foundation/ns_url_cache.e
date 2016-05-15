note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL_CACHE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_memory_capacity__disk_capacity__disk_path_,
	make

feature {NONE} -- Initialization

	make_with_memory_capacity__disk_capacity__disk_path_ (a_memory_capacity: NATURAL_64; a_disk_capacity: NATURAL_64; a_path: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			make_with_pointer (objc_init_with_memory_capacity__disk_capacity__disk_path_(allocate_object, a_memory_capacity, a_disk_capacity, a_path__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSURLCache Externals

	objc_init_with_memory_capacity__disk_capacity__disk_path_ (an_item: POINTER; a_memory_capacity: NATURAL_64; a_disk_capacity: NATURAL_64; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLCache *)$an_item initWithMemoryCapacity:$a_memory_capacity diskCapacity:$a_disk_capacity diskPath:$a_path];
			 ]"
		end

	objc_cached_response_for_request_ (an_item: POINTER; a_request: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLCache *)$an_item cachedResponseForRequest:$a_request];
			 ]"
		end

	objc_store_cached_response__for_request_ (an_item: POINTER; a_cached_response: POINTER; a_request: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLCache *)$an_item storeCachedResponse:$a_cached_response forRequest:$a_request];
			 ]"
		end

	objc_remove_cached_response_for_request_ (an_item: POINTER; a_request: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLCache *)$an_item removeCachedResponseForRequest:$a_request];
			 ]"
		end

	objc_remove_all_cached_responses (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLCache *)$an_item removeAllCachedResponses];
			 ]"
		end

	objc_memory_capacity (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURLCache *)$an_item memoryCapacity];
			 ]"
		end

	objc_disk_capacity (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURLCache *)$an_item diskCapacity];
			 ]"
		end

	objc_set_memory_capacity_ (an_item: POINTER; a_memory_capacity: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLCache *)$an_item setMemoryCapacity:$a_memory_capacity];
			 ]"
		end

	objc_set_disk_capacity_ (an_item: POINTER; a_disk_capacity: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLCache *)$an_item setDiskCapacity:$a_disk_capacity];
			 ]"
		end

	objc_current_memory_usage (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURLCache *)$an_item currentMemoryUsage];
			 ]"
		end

	objc_current_disk_usage (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURLCache *)$an_item currentDiskUsage];
			 ]"
		end

feature -- NSURLCache

	cached_response_for_request_ (a_request: detachable NS_URL_REQUEST): detachable NS_CACHED_URL_RESPONSE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_request__item: POINTER
		do
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			result_pointer := objc_cached_response_for_request_ (item, a_request__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cached_response_for_request_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cached_response_for_request_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	store_cached_response__for_request_ (a_cached_response: detachable NS_CACHED_URL_RESPONSE; a_request: detachable NS_URL_REQUEST)
			-- Auto generated Objective-C wrapper.
		local
			a_cached_response__item: POINTER
			a_request__item: POINTER
		do
			if attached a_cached_response as a_cached_response_attached then
				a_cached_response__item := a_cached_response_attached.item
			end
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			objc_store_cached_response__for_request_ (item, a_cached_response__item, a_request__item)
		end

	remove_cached_response_for_request_ (a_request: detachable NS_URL_REQUEST)
			-- Auto generated Objective-C wrapper.
		local
			a_request__item: POINTER
		do
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			objc_remove_cached_response_for_request_ (item, a_request__item)
		end

	remove_all_cached_responses
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_all_cached_responses (item)
		end

	memory_capacity: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_memory_capacity (item)
		end

	disk_capacity: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_disk_capacity (item)
		end

	set_memory_capacity_ (a_memory_capacity: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_memory_capacity_ (item, a_memory_capacity)
		end

	set_disk_capacity_ (a_disk_capacity: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_disk_capacity_ (item, a_disk_capacity)
		end

	current_memory_usage: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_current_memory_usage (item)
		end

	current_disk_usage: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_current_disk_usage (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURLCache"
		end

end
