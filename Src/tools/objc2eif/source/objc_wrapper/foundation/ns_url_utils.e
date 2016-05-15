note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSURL

	file_url_with_path__is_directory_ (a_path: detachable NS_STRING; a_is_dir: BOOLEAN): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_file_url_with_path__is_directory_ (l_objc_class.item, a_path__item, a_is_dir)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_url_with_path__is_directory_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_url_with_path__is_directory_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	file_url_with_path_ (a_path: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_file_url_with_path_ (l_objc_class.item, a_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_url_with_path_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_url_with_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_with_string_ (a_url_string: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_url_string__item: POINTER
		do
			if attached a_url_string as a_url_string_attached then
				a_url_string__item := a_url_string_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_url_with_string_ (l_objc_class.item, a_url_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_with_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_with_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_with_string__relative_to_ur_l_ (a_url_string: detachable NS_STRING; a_base_url: detachable NS_URL): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_url_string__item: POINTER
			a_base_url__item: POINTER
		do
			if attached a_url_string as a_url_string_attached then
				a_url_string__item := a_url_string_attached.item
			end
			if attached a_base_url as a_base_url_attached then
				a_base_url__item := a_base_url_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_url_with_string__relative_to_ur_l_ (l_objc_class.item, a_url_string__item, a_base_url__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_with_string__relative_to_ur_l_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_with_string__relative_to_ur_l_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	url_by_resolving_bookmark_data__options__relative_to_ur_l__bookmark_data_is_stale__error_ (a_bookmark_data: detachable NS_DATA; a_options: NATURAL_64; a_relative_url: detachable NS_URL; a_is_stale: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
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
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_url_by_resolving_bookmark_data__options__relative_to_ur_l__bookmark_data_is_stale__error_ (l_objc_class.item, a_bookmark_data__item, a_options, a_relative_url__item, a_is_stale__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like url_by_resolving_bookmark_data__options__relative_to_ur_l__bookmark_data_is_stale__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like url_by_resolving_bookmark_data__options__relative_to_ur_l__bookmark_data_is_stale__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	resource_values_for_keys__from_bookmark_data_ (a_keys: detachable NS_ARRAY; a_bookmark_data: detachable NS_DATA): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_keys__item: POINTER
			a_bookmark_data__item: POINTER
		do
			if attached a_keys as a_keys_attached then
				a_keys__item := a_keys_attached.item
			end
			if attached a_bookmark_data as a_bookmark_data_attached then
				a_bookmark_data__item := a_bookmark_data_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_resource_values_for_keys__from_bookmark_data_ (l_objc_class.item, a_keys__item, a_bookmark_data__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like resource_values_for_keys__from_bookmark_data_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like resource_values_for_keys__from_bookmark_data_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	write_bookmark_data__to_ur_l__options__error_ (a_bookmark_data: detachable NS_DATA; a_bookmark_file_url: detachable NS_URL; a_options: NATURAL_64; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			l_objc_class: OBJC_CLASS
--			a_bookmark_data__item: POINTER
--			a_bookmark_file_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_bookmark_data as a_bookmark_data_attached then
--				a_bookmark_data__item := a_bookmark_data_attached.item
--			end
--			if attached a_bookmark_file_url as a_bookmark_file_url_attached then
--				a_bookmark_file_url__item := a_bookmark_file_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			Result := objc_write_bookmark_data__to_ur_l__options__error_ (l_objc_class.item, a_bookmark_data__item, a_bookmark_file_url__item, a_options, a_error__item)
--		end

--	bookmark_data_with_contents_of_ur_l__error_ (a_bookmark_file_url: detachable NS_URL; a_error: UNSUPPORTED_TYPE): detachable NS_DATA
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_bookmark_file_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_bookmark_file_url as a_bookmark_file_url_attached then
--				a_bookmark_file_url__item := a_bookmark_file_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_bookmark_data_with_contents_of_ur_l__error_ (l_objc_class.item, a_bookmark_file_url__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like bookmark_data_with_contents_of_ur_l__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like bookmark_data_with_contents_of_ur_l__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSURL Externals

	objc_file_url_with_path__is_directory_ (a_class_object: POINTER; a_path: POINTER; a_is_dir: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object fileURLWithPath:$a_path isDirectory:$a_is_dir];
			 ]"
		end

	objc_file_url_with_path_ (a_class_object: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object fileURLWithPath:$a_path];
			 ]"
		end

	objc_url_with_string_ (a_class_object: POINTER; a_url_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object URLWithString:$a_url_string];
			 ]"
		end

	objc_url_with_string__relative_to_ur_l_ (a_class_object: POINTER; a_url_string: POINTER; a_base_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object URLWithString:$a_url_string relativeToURL:$a_base_url];
			 ]"
		end

--	objc_url_by_resolving_bookmark_data__options__relative_to_ur_l__bookmark_data_is_stale__error_ (a_class_object: POINTER; a_bookmark_data: POINTER; a_options: NATURAL_64; a_relative_url: POINTER; a_is_stale: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object URLByResolvingBookmarkData:$a_bookmark_data options:$a_options relativeToURL:$a_relative_url bookmarkDataIsStale: error:];
--			 ]"
--		end

	objc_resource_values_for_keys__from_bookmark_data_ (a_class_object: POINTER; a_keys: POINTER; a_bookmark_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object resourceValuesForKeys:$a_keys fromBookmarkData:$a_bookmark_data];
			 ]"
		end

--	objc_write_bookmark_data__to_ur_l__options__error_ (a_class_object: POINTER; a_bookmark_data: POINTER; a_bookmark_file_url: POINTER; a_options: NATURAL_64; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(Class)$a_class_object writeBookmarkData:$a_bookmark_data toURL:$a_bookmark_file_url options:$a_options error:];
--			 ]"
--		end

--	objc_bookmark_data_with_contents_of_ur_l__error_ (a_class_object: POINTER; a_bookmark_file_url: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object bookmarkDataWithContentsOfURL:$a_bookmark_file_url error:];
--			 ]"
--		end

feature -- NSURLPathUtilities

	file_url_with_path_components_ (a_components: detachable NS_ARRAY): detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_components__item: POINTER
		do
			if attached a_components as a_components_attached then
				a_components__item := a_components_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_file_url_with_path_components_ (l_objc_class.item, a_components__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_url_with_path_components_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_url_with_path_components_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSURLPathUtilities Externals

	objc_file_url_with_path_components_ (a_class_object: POINTER; a_components: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object fileURLWithPathComponents:$a_components];
			 ]"
		end

feature -- NSPasteboardSupport

	url_from_pasteboard_ (a_paste_board: detachable NS_PASTEBOARD): detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_paste_board__item: POINTER
		do
			if attached a_paste_board as a_paste_board_attached then
				a_paste_board__item := a_paste_board_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_url_from_pasteboard_ (l_objc_class.item, a_paste_board__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_from_pasteboard_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_from_pasteboard_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPasteboardSupport Externals

	objc_url_from_pasteboard_ (a_class_object: POINTER; a_paste_board: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object URLFromPasteboard:$a_paste_board];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURL"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
