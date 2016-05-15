note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DATA_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSDataCreation

	data: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_data (l_objc_class.item)
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

--	data_with_bytes__length_ (a_bytes: UNSUPPORTED_TYPE; a_length: NATURAL_64): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_bytes__item: POINTER
--		do
--			if attached a_bytes as a_bytes_attached then
--				a_bytes__item := a_bytes_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_data_with_bytes__length_ (l_objc_class.item, a_bytes__item, a_length)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like data_with_bytes__length_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like data_with_bytes__length_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	data_with_bytes_no_copy__length_ (a_bytes: UNSUPPORTED_TYPE; a_length: NATURAL_64): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_bytes__item: POINTER
--		do
--			if attached a_bytes as a_bytes_attached then
--				a_bytes__item := a_bytes_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_data_with_bytes_no_copy__length_ (l_objc_class.item, a_bytes__item, a_length)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like data_with_bytes_no_copy__length_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like data_with_bytes_no_copy__length_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	data_with_bytes_no_copy__length__free_when_done_ (a_bytes: UNSUPPORTED_TYPE; a_length: NATURAL_64; a_b: BOOLEAN): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_bytes__item: POINTER
--		do
--			if attached a_bytes as a_bytes_attached then
--				a_bytes__item := a_bytes_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_data_with_bytes_no_copy__length__free_when_done_ (l_objc_class.item, a_bytes__item, a_length, a_b)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like data_with_bytes_no_copy__length__free_when_done_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like data_with_bytes_no_copy__length__free_when_done_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	data_with_contents_of_file__options__error_ (a_path: detachable NS_STRING; a_read_options_mask: NATURAL_64; a_error_ptr: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_path__item: POINTER
--			a_error_ptr__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_error_ptr as a_error_ptr_attached then
--				a_error_ptr__item := a_error_ptr_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_data_with_contents_of_file__options__error_ (l_objc_class.item, a_path__item, a_read_options_mask, a_error_ptr__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like data_with_contents_of_file__options__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like data_with_contents_of_file__options__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	data_with_contents_of_ur_l__options__error_ (a_url: detachable NS_URL; a_read_options_mask: NATURAL_64; a_error_ptr: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_url__item: POINTER
--			a_error_ptr__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error_ptr as a_error_ptr_attached then
--				a_error_ptr__item := a_error_ptr_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_data_with_contents_of_ur_l__options__error_ (l_objc_class.item, a_url__item, a_read_options_mask, a_error_ptr__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like data_with_contents_of_ur_l__options__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like data_with_contents_of_ur_l__options__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	data_with_contents_of_file_ (a_path: detachable NS_STRING): detachable NS_OBJECT
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
			result_pointer := objc_data_with_contents_of_file_ (l_objc_class.item, a_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_with_contents_of_file_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_with_contents_of_file_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	data_with_contents_of_ur_l_ (a_url: detachable NS_URL): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_data_with_contents_of_ur_l_ (l_objc_class.item, a_url__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_with_contents_of_ur_l_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_with_contents_of_ur_l_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	data_with_contents_of_mapped_file_ (a_path: detachable NS_STRING): detachable NS_OBJECT
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
			result_pointer := objc_data_with_contents_of_mapped_file_ (l_objc_class.item, a_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_with_contents_of_mapped_file_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_with_contents_of_mapped_file_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	data_with_data_ (a_data: detachable NS_DATA): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_data_with_data_ (l_objc_class.item, a_data__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_with_data_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_with_data_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSDataCreation Externals

	objc_data (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object data];
			 ]"
		end

--	objc_data_with_bytes__length_ (a_class_object: POINTER; a_bytes: UNSUPPORTED_TYPE; a_length: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object dataWithBytes: length:$a_length];
--			 ]"
--		end

--	objc_data_with_bytes_no_copy__length_ (a_class_object: POINTER; a_bytes: UNSUPPORTED_TYPE; a_length: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object dataWithBytesNoCopy: length:$a_length];
--			 ]"
--		end

--	objc_data_with_bytes_no_copy__length__free_when_done_ (a_class_object: POINTER; a_bytes: UNSUPPORTED_TYPE; a_length: NATURAL_64; a_b: BOOLEAN): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object dataWithBytesNoCopy: length:$a_length freeWhenDone:$a_b];
--			 ]"
--		end

--	objc_data_with_contents_of_file__options__error_ (a_class_object: POINTER; a_path: POINTER; a_read_options_mask: NATURAL_64; a_error_ptr: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object dataWithContentsOfFile:$a_path options:$a_read_options_mask error:];
--			 ]"
--		end

--	objc_data_with_contents_of_ur_l__options__error_ (a_class_object: POINTER; a_url: POINTER; a_read_options_mask: NATURAL_64; a_error_ptr: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object dataWithContentsOfURL:$a_url options:$a_read_options_mask error:];
--			 ]"
--		end

	objc_data_with_contents_of_file_ (a_class_object: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dataWithContentsOfFile:$a_path];
			 ]"
		end

	objc_data_with_contents_of_ur_l_ (a_class_object: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dataWithContentsOfURL:$a_url];
			 ]"
		end

	objc_data_with_contents_of_mapped_file_ (a_class_object: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dataWithContentsOfMappedFile:$a_path];
			 ]"
		end

	objc_data_with_data_ (a_class_object: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dataWithData:$a_data];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSData"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
