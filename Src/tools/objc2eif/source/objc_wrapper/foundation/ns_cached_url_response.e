note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CACHED_URL_RESPONSE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_response__data_,
	make_with_response__data__user_info__storage_policy_,
	make

feature {NONE} -- Initialization

	make_with_response__data_ (a_response: detachable NS_URL_RESPONSE; a_data: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_response__item: POINTER
			a_data__item: POINTER
		do
			if attached a_response as a_response_attached then
				a_response__item := a_response_attached.item
			end
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			make_with_pointer (objc_init_with_response__data_(allocate_object, a_response__item, a_data__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_response__data__user_info__storage_policy_ (a_response: detachable NS_URL_RESPONSE; a_data: detachable NS_DATA; a_user_info: detachable NS_DICTIONARY; a_storage_policy: NATURAL_64)
			-- Initialize `Current'.
		local
			a_response__item: POINTER
			a_data__item: POINTER
			a_user_info__item: POINTER
		do
			if attached a_response as a_response_attached then
				a_response__item := a_response_attached.item
			end
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			if attached a_user_info as a_user_info_attached then
				a_user_info__item := a_user_info_attached.item
			end
			make_with_pointer (objc_init_with_response__data__user_info__storage_policy_(allocate_object, a_response__item, a_data__item, a_user_info__item, a_storage_policy))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSCachedURLResponse Externals

	objc_init_with_response__data_ (an_item: POINTER; a_response: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCachedURLResponse *)$an_item initWithResponse:$a_response data:$a_data];
			 ]"
		end

	objc_init_with_response__data__user_info__storage_policy_ (an_item: POINTER; a_response: POINTER; a_data: POINTER; a_user_info: POINTER; a_storage_policy: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCachedURLResponse *)$an_item initWithResponse:$a_response data:$a_data userInfo:$a_user_info storagePolicy:$a_storage_policy];
			 ]"
		end

	objc_response (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCachedURLResponse *)$an_item response];
			 ]"
		end

	objc_data (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCachedURLResponse *)$an_item data];
			 ]"
		end

	objc_user_info (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCachedURLResponse *)$an_item userInfo];
			 ]"
		end

	objc_storage_policy (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCachedURLResponse *)$an_item storagePolicy];
			 ]"
		end

feature -- NSCachedURLResponse

	response: detachable NS_URL_RESPONSE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_response (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like response} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like response} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	data: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_data (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	user_info: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_user_info (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like user_info} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like user_info} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	storage_policy: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_storage_policy (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCachedURLResponse"
		end

end
