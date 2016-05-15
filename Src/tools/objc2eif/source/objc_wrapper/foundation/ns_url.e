note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_COPYING_PROTOCOL
	NS_URL_HANDLE_CLIENT_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_scheme__host__path_,
	make_file_url_with_path__is_directory_,
	make_file_url_with_path_,
	make_with_string_,
	make_with_string__relative_to_ur_l_,
	make

feature {NONE} -- Initialization

	make_with_scheme__host__path_ (a_scheme: detachable NS_STRING; a_host: detachable NS_STRING; a_path: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_scheme__item: POINTER
			a_host__item: POINTER
			a_path__item: POINTER
		do
			if attached a_scheme as a_scheme_attached then
				a_scheme__item := a_scheme_attached.item
			end
			if attached a_host as a_host_attached then
				a_host__item := a_host_attached.item
			end
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			make_with_pointer (objc_init_with_scheme__host__path_(allocate_object, a_scheme__item, a_host__item, a_path__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_file_url_with_path__is_directory_ (a_path: detachable NS_STRING; a_is_dir: BOOLEAN)
			-- Initialize `Current'.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			make_with_pointer (objc_init_file_url_with_path__is_directory_(allocate_object, a_path__item, a_is_dir))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_file_url_with_path_ (a_path: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			make_with_pointer (objc_init_file_url_with_path_(allocate_object, a_path__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_string_ (a_url_string: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_url_string__item: POINTER
		do
			if attached a_url_string as a_url_string_attached then
				a_url_string__item := a_url_string_attached.item
			end
			make_with_pointer (objc_init_with_string_(allocate_object, a_url_string__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_string__relative_to_ur_l_ (a_url_string: detachable NS_STRING; a_base_url: detachable NS_URL)
			-- Initialize `Current'.
		local
			a_url_string__item: POINTER
			a_base_url__item: POINTER
		do
			if attached a_url_string as a_url_string_attached then
				a_url_string__item := a_url_string_attached.item
			end
			if attached a_base_url as a_base_url_attached then
				a_base_url__item := a_base_url_attached.item
			end
			make_with_pointer (objc_init_with_string__relative_to_ur_l_(allocate_object, a_url_string__item, a_base_url__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_by_resolving_bookmark_data__options__relative_to_ur_l__bookmark_data_is_stale__error_ (a_bookmark_data: detachable NS_DATA; a_options: NATURAL_64; a_relative_url: detachable NS_URL; a_is_stale: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_bookmark_data__item: POINTER
--			a_relative_url__item: POINTER
--			a_is_stale__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_bookmark_data as a_bookmark_data_attached then
--				a_bookmark_data__item := a_bookmark_data_attached.item
--			end
--			if attached a_relative_url as a_relative_url_attached then
--				a_relative_url__item := a_relative_url_attached.item
--			end
--			if attached a_is_stale as a_is_stale_attached then
--				a_is_stale__item := a_is_stale_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			make_with_pointer (objc_init_by_resolving_bookmark_data__options__relative_to_ur_l__bookmark_data_is_stale__error_(allocate_object, a_bookmark_data__item, a_options, a_relative_url__item, a_is_stale__item, a_error__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSURL Externals

	objc_init_with_scheme__host__path_ (an_item: POINTER; a_scheme: POINTER; a_host: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item initWithScheme:$a_scheme host:$a_host path:$a_path];
			 ]"
		end

	objc_init_file_url_with_path__is_directory_ (an_item: POINTER; a_path: POINTER; a_is_dir: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item initFileURLWithPath:$a_path isDirectory:$a_is_dir];
			 ]"
		end

	objc_init_file_url_with_path_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item initFileURLWithPath:$a_path];
			 ]"
		end

	objc_init_with_string_ (an_item: POINTER; a_url_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item initWithString:$a_url_string];
			 ]"
		end

	objc_init_with_string__relative_to_ur_l_ (an_item: POINTER; a_url_string: POINTER; a_base_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item initWithString:$a_url_string relativeToURL:$a_base_url];
			 ]"
		end

	objc_absolute_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item absoluteString];
			 ]"
		end

	objc_relative_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item relativeString];
			 ]"
		end

	objc_base_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item baseURL];
			 ]"
		end

	objc_absolute_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item absoluteURL];
			 ]"
		end

	objc_scheme (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item scheme];
			 ]"
		end

	objc_resource_specifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item resourceSpecifier];
			 ]"
		end

	objc_host (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item host];
			 ]"
		end

	objc_port (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item port];
			 ]"
		end

	objc_user (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item user];
			 ]"
		end

	objc_password (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item password];
			 ]"
		end

	objc_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item path];
			 ]"
		end

	objc_fragment (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item fragment];
			 ]"
		end

	objc_parameter_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item parameterString];
			 ]"
		end

	objc_query (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item query];
			 ]"
		end

	objc_relative_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item relativePath];
			 ]"
		end

	objc_is_file_url (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURL *)$an_item isFileURL];
			 ]"
		end

	objc_standardized_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item standardizedURL];
			 ]"
		end

--	objc_get_resource_value__for_key__error_ (an_item: POINTER; a_value: UNSUPPORTED_TYPE; a_key: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSURL *)$an_item getResourceValue: forKey:$a_key error:];
--			 ]"
--		end

--	objc_resource_values_for_keys__error_ (an_item: POINTER; a_keys: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSURL *)$an_item resourceValuesForKeys:$a_keys error:];
--			 ]"
--		end

--	objc_set_resource_value__for_key__error_ (an_item: POINTER; a_value: POINTER; a_key: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSURL *)$an_item setResourceValue:$a_value forKey:$a_key error:];
--			 ]"
--		end

--	objc_set_resource_values__error_ (an_item: POINTER; a_keyed_values: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSURL *)$an_item setResourceValues:$a_keyed_values error:];
--			 ]"
--		end

--	objc_check_resource_is_reachable_and_return_error_ (an_item: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSURL *)$an_item checkResourceIsReachableAndReturnError:];
--			 ]"
--		end

	objc_is_file_reference_url (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURL *)$an_item isFileReferenceURL];
			 ]"
		end

	objc_file_reference_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item fileReferenceURL];
			 ]"
		end

	objc_file_path_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item filePathURL];
			 ]"
		end

--	objc_bookmark_data_with_options__including_resource_values_for_keys__relative_to_ur_l__error_ (an_item: POINTER; a_options: NATURAL_64; a_keys: POINTER; a_relative_url: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSURL *)$an_item bookmarkDataWithOptions:$a_options includingResourceValuesForKeys:$a_keys relativeToURL:$a_relative_url error:];
--			 ]"
--		end

--	objc_init_by_resolving_bookmark_data__options__relative_to_ur_l__bookmark_data_is_stale__error_ (an_item: POINTER; a_bookmark_data: POINTER; a_options: NATURAL_64; a_relative_url: POINTER; a_is_stale: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSURL *)$an_item initByResolvingBookmarkData:$a_bookmark_data options:$a_options relativeToURL:$a_relative_url bookmarkDataIsStale: error:];
--			 ]"
--		end

feature -- NSURL

	absolute_string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_absolute_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like absolute_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like absolute_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	relative_string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_relative_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like relative_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like relative_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	base_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_base_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like base_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like base_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	absolute_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_absolute_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like absolute_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like absolute_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	scheme: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_scheme (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like scheme} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like scheme} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	resource_specifier: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_resource_specifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like resource_specifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like resource_specifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	host: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_host (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like host} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like host} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	port: detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_port (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like port} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like port} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	user: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_user (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like user} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like user} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	password: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_password (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like password} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like password} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	fragment: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_fragment (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like fragment} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like fragment} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	parameter_string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_parameter_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like parameter_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like parameter_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	query: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_query (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like query} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like query} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	relative_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_relative_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like relative_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like relative_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_file_url: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_file_url (item)
		end

	standardized_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_standardized_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like standardized_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like standardized_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	get_resource_value__for_key__error_ (a_value: UNSUPPORTED_TYPE; a_key: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_value__item: POINTER
--			a_key__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			if attached a_key as a_key_attached then
--				a_key__item := a_key_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_get_resource_value__for_key__error_ (item, a_value__item, a_key__item, a_error__item)
--		end

--	resource_values_for_keys__error_ (a_keys: detachable NS_ARRAY; a_error: UNSUPPORTED_TYPE): detachable NS_DICTIONARY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_keys__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_keys as a_keys_attached then
--				a_keys__item := a_keys_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_resource_values_for_keys__error_ (item, a_keys__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like resource_values_for_keys__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like resource_values_for_keys__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	set_resource_value__for_key__error_ (a_value: detachable NS_OBJECT; a_key: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_value__item: POINTER
--			a_key__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			if attached a_key as a_key_attached then
--				a_key__item := a_key_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_set_resource_value__for_key__error_ (item, a_value__item, a_key__item, a_error__item)
--		end

--	set_resource_values__error_ (a_keyed_values: detachable NS_DICTIONARY; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_keyed_values__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_keyed_values as a_keyed_values_attached then
--				a_keyed_values__item := a_keyed_values_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_set_resource_values__error_ (item, a_keyed_values__item, a_error__item)
--		end

--	check_resource_is_reachable_and_return_error_ (a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_error__item: POINTER
--		do
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_check_resource_is_reachable_and_return_error_ (item, a_error__item)
--		end

	is_file_reference_url: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_file_reference_url (item)
		end

	file_reference_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_reference_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_reference_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_reference_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	file_path_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_path_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_path_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_path_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	bookmark_data_with_options__including_resource_values_for_keys__relative_to_ur_l__error_ (a_options: NATURAL_64; a_keys: detachable NS_ARRAY; a_relative_url: detachable NS_URL; a_error: UNSUPPORTED_TYPE): detachable NS_DATA
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_keys__item: POINTER
--			a_relative_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_keys as a_keys_attached then
--				a_keys__item := a_keys_attached.item
--			end
--			if attached a_relative_url as a_relative_url_attached then
--				a_relative_url__item := a_relative_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_bookmark_data_with_options__including_resource_values_for_keys__relative_to_ur_l__error_ (item, a_options, a_keys__item, a_relative_url__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like bookmark_data_with_options__including_resource_values_for_keys__relative_to_ur_l__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like bookmark_data_with_options__including_resource_values_for_keys__relative_to_ur_l__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature -- NSURLPathUtilities

	path_components: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_path_components (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path_components} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path_components} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	last_path_component: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_last_path_component (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like last_path_component} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like last_path_component} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	path_extension: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_path_extension (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path_extension} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path_extension} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_by_appending_path_component_ (a_path_component: detachable NS_STRING): detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_path_component__item: POINTER
		do
			if attached a_path_component as a_path_component_attached then
				a_path_component__item := a_path_component_attached.item
			end
			result_pointer := objc_url_by_appending_path_component_ (item, a_path_component__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_by_appending_path_component_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_by_appending_path_component_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_by_deleting_last_path_component: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_url_by_deleting_last_path_component (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_by_deleting_last_path_component} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_by_deleting_last_path_component} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_by_appending_path_extension_ (a_path_extension: detachable NS_STRING): detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_path_extension__item: POINTER
		do
			if attached a_path_extension as a_path_extension_attached then
				a_path_extension__item := a_path_extension_attached.item
			end
			result_pointer := objc_url_by_appending_path_extension_ (item, a_path_extension__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_by_appending_path_extension_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_by_appending_path_extension_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_by_deleting_path_extension: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_url_by_deleting_path_extension (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_by_deleting_path_extension} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_by_deleting_path_extension} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_by_standardizing_path: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_url_by_standardizing_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_by_standardizing_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_by_standardizing_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_by_resolving_symlinks_in_path: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_url_by_resolving_symlinks_in_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_by_resolving_symlinks_in_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_by_resolving_symlinks_in_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSURLPathUtilities Externals

	objc_path_components (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item pathComponents];
			 ]"
		end

	objc_last_path_component (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item lastPathComponent];
			 ]"
		end

	objc_path_extension (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item pathExtension];
			 ]"
		end

	objc_url_by_appending_path_component_ (an_item: POINTER; a_path_component: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item URLByAppendingPathComponent:$a_path_component];
			 ]"
		end

	objc_url_by_deleting_last_path_component (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item URLByDeletingLastPathComponent];
			 ]"
		end

	objc_url_by_appending_path_extension_ (an_item: POINTER; a_path_extension: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item URLByAppendingPathExtension:$a_path_extension];
			 ]"
		end

	objc_url_by_deleting_path_extension (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item URLByDeletingPathExtension];
			 ]"
		end

	objc_url_by_standardizing_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item URLByStandardizingPath];
			 ]"
		end

	objc_url_by_resolving_symlinks_in_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURL *)$an_item URLByResolvingSymlinksInPath];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURL"
		end

end
