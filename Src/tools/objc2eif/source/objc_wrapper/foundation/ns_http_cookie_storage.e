note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_HTTP_COOKIE_STORAGE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_storage_location_,
	make

feature {NONE} -- Initialization

	make_with_storage_location_ (a_storage_file_url: detachable NS_URL)
			-- Initialize `Current'.
		local
			a_storage_file_url__item: POINTER
		do
			if attached a_storage_file_url as a_storage_file_url_attached then
				a_storage_file_url__item := a_storage_file_url_attached.item
			end
			make_with_pointer (objc_init_with_storage_location_(allocate_object, a_storage_file_url__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSHTTPCookieStorage Externals

	objc_init_with_storage_location_ (an_item: POINTER; a_storage_file_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHTTPCookieStorage *)$an_item initWithStorageLocation:$a_storage_file_url];
			 ]"
		end

	objc_cookies (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHTTPCookieStorage *)$an_item cookies];
			 ]"
		end

	objc_set_cookie_ (an_item: POINTER; a_cookie: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSHTTPCookieStorage *)$an_item setCookie:$a_cookie];
			 ]"
		end

	objc_delete_cookie_ (an_item: POINTER; a_cookie: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSHTTPCookieStorage *)$an_item deleteCookie:$a_cookie];
			 ]"
		end

	objc_cookies_for_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHTTPCookieStorage *)$an_item cookiesForURL:$a_url];
			 ]"
		end

	objc_set_cookies__for_ur_l__main_document_ur_l_ (an_item: POINTER; a_cookies: POINTER; a_url: POINTER; a_main_document_url: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSHTTPCookieStorage *)$an_item setCookies:$a_cookies forURL:$a_url mainDocumentURL:$a_main_document_url];
			 ]"
		end

	objc_cookie_accept_policy (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSHTTPCookieStorage *)$an_item cookieAcceptPolicy];
			 ]"
		end

	objc_set_cookie_accept_policy_ (an_item: POINTER; a_cookie_accept_policy: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSHTTPCookieStorage *)$an_item setCookieAcceptPolicy:$a_cookie_accept_policy];
			 ]"
		end

feature -- NSHTTPCookieStorage

	cookies: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_cookies (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cookies} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cookies} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_cookie_ (a_cookie: detachable NS_HTTP_COOKIE)
			-- Auto generated Objective-C wrapper.
		local
			a_cookie__item: POINTER
		do
			if attached a_cookie as a_cookie_attached then
				a_cookie__item := a_cookie_attached.item
			end
			objc_set_cookie_ (item, a_cookie__item)
		end

	delete_cookie_ (a_cookie: detachable NS_HTTP_COOKIE)
			-- Auto generated Objective-C wrapper.
		local
			a_cookie__item: POINTER
		do
			if attached a_cookie as a_cookie_attached then
				a_cookie__item := a_cookie_attached.item
			end
			objc_delete_cookie_ (item, a_cookie__item)
		end

	cookies_for_ur_l_ (a_url: detachable NS_URL): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			result_pointer := objc_cookies_for_ur_l_ (item, a_url__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cookies_for_ur_l_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cookies_for_ur_l_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_cookies__for_ur_l__main_document_ur_l_ (a_cookies: detachable NS_ARRAY; a_url: detachable NS_URL; a_main_document_url: detachable NS_URL)
			-- Auto generated Objective-C wrapper.
		local
			a_cookies__item: POINTER
			a_url__item: POINTER
			a_main_document_url__item: POINTER
		do
			if attached a_cookies as a_cookies_attached then
				a_cookies__item := a_cookies_attached.item
			end
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			if attached a_main_document_url as a_main_document_url_attached then
				a_main_document_url__item := a_main_document_url_attached.item
			end
			objc_set_cookies__for_ur_l__main_document_ur_l_ (item, a_cookies__item, a_url__item, a_main_document_url__item)
		end

	cookie_accept_policy: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_cookie_accept_policy (item)
		end

	set_cookie_accept_policy_ (a_cookie_accept_policy: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_cookie_accept_policy_ (item, a_cookie_accept_policy)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSHTTPCookieStorage"
		end

end
