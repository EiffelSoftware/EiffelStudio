note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DATA

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_MUTABLE_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_contents_of_file_,
	make_with_contents_of_ur_l_,
	make_with_contents_of_mapped_file_,
	make_with_data_,
	make

feature -- NSData

	length: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_length (item)
		end

--	bytes: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_bytes (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like bytes} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like bytes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSData Externals

	objc_length (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSData *)$an_item length];
			 ]"
		end

--	objc_bytes (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSData *)$an_item bytes];
--			 ]"
--		end

feature -- NSExtendedData

--	get_bytes__length_ (a_buffer: UNSUPPORTED_TYPE; a_length: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_buffer__item: POINTER
--		do
--			if attached a_buffer as a_buffer_attached then
--				a_buffer__item := a_buffer_attached.item
--			end
--			objc_get_bytes__length_ (item, a_buffer__item, a_length)
--		end

--	get_bytes__range_ (a_buffer: UNSUPPORTED_TYPE; a_range: NS_RANGE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_buffer__item: POINTER
--		do
--			if attached a_buffer as a_buffer_attached then
--				a_buffer__item := a_buffer_attached.item
--			end
--			objc_get_bytes__range_ (item, a_buffer__item, a_range.item)
--		end

	is_equal_to_data_ (a_other: detachable NS_DATA): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_other__item: POINTER
		do
			if attached a_other as a_other_attached then
				a_other__item := a_other_attached.item
			end
			Result := objc_is_equal_to_data_ (item, a_other__item)
		end

	subdata_with_range_ (a_range: NS_RANGE): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_subdata_with_range_ (item, a_range.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like subdata_with_range_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like subdata_with_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	write_to_file__atomically_ (a_path: detachable NS_STRING; a_use_auxiliary_file: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_write_to_file__atomically_ (item, a_path__item, a_use_auxiliary_file)
		end

	write_to_ur_l__atomically_ (a_url: detachable NS_URL; a_atomically: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			Result := objc_write_to_ur_l__atomically_ (item, a_url__item, a_atomically)
		end

--	write_to_file__options__error_ (a_path: detachable NS_STRING; a_write_options_mask: NATURAL_64; a_error_ptr: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_path__item: POINTER
--			a_error_ptr__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_error_ptr as a_error_ptr_attached then
--				a_error_ptr__item := a_error_ptr_attached.item
--			end
--			Result := objc_write_to_file__options__error_ (item, a_path__item, a_write_options_mask, a_error_ptr__item)
--		end

--	write_to_ur_l__options__error_ (a_url: detachable NS_URL; a_write_options_mask: NATURAL_64; a_error_ptr: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_url__item: POINTER
--			a_error_ptr__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error_ptr as a_error_ptr_attached then
--				a_error_ptr__item := a_error_ptr_attached.item
--			end
--			Result := objc_write_to_ur_l__options__error_ (item, a_url__item, a_write_options_mask, a_error_ptr__item)
--		end

	range_of_data__options__range_ (a_data_to_find: detachable NS_DATA; a_mask: NATURAL_64; a_search_range: NS_RANGE): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_data_to_find__item: POINTER
		do
			if attached a_data_to_find as a_data_to_find_attached then
				a_data_to_find__item := a_data_to_find_attached.item
			end
			create Result.make
			objc_range_of_data__options__range_ (item, Result.item, a_data_to_find__item, a_mask, a_search_range.item)
		end

feature {NONE} -- NSExtendedData Externals

--	objc_get_bytes__length_ (an_item: POINTER; a_buffer: UNSUPPORTED_TYPE; a_length: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSData *)$an_item getBytes: length:$a_length];
--			 ]"
--		end

--	objc_get_bytes__range_ (an_item: POINTER; a_buffer: UNSUPPORTED_TYPE; a_range: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSData *)$an_item getBytes: range:*((NSRange *)$a_range)];
--			 ]"
--		end

	objc_is_equal_to_data_ (an_item: POINTER; a_other: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSData *)$an_item isEqualToData:$a_other];
			 ]"
		end

	objc_subdata_with_range_ (an_item: POINTER; a_range: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSData *)$an_item subdataWithRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_write_to_file__atomically_ (an_item: POINTER; a_path: POINTER; a_use_auxiliary_file: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSData *)$an_item writeToFile:$a_path atomically:$a_use_auxiliary_file];
			 ]"
		end

	objc_write_to_ur_l__atomically_ (an_item: POINTER; a_url: POINTER; a_atomically: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSData *)$an_item writeToURL:$a_url atomically:$a_atomically];
			 ]"
		end

--	objc_write_to_file__options__error_ (an_item: POINTER; a_path: POINTER; a_write_options_mask: NATURAL_64; a_error_ptr: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSData *)$an_item writeToFile:$a_path options:$a_write_options_mask error:];
--			 ]"
--		end

--	objc_write_to_ur_l__options__error_ (an_item: POINTER; a_url: POINTER; a_write_options_mask: NATURAL_64; a_error_ptr: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSData *)$an_item writeToURL:$a_url options:$a_write_options_mask error:];
--			 ]"
--		end

	objc_range_of_data__options__range_ (an_item: POINTER; result_pointer: POINTER; a_data_to_find: POINTER; a_mask: NATURAL_64; a_search_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSData *)$an_item rangeOfData:$a_data_to_find options:$a_mask range:*((NSRange *)$a_search_range)];
			 ]"
		end

feature {NONE} -- Initialization

--	make_with_bytes__length_ (a_bytes: UNSUPPORTED_TYPE; a_length: NATURAL_64)
--			-- Initialize `Current'.
--		local
--			a_bytes__item: POINTER
--		do
--			if attached a_bytes as a_bytes_attached then
--				a_bytes__item := a_bytes_attached.item
--			end
--			make_with_pointer (objc_init_with_bytes__length_(allocate_object, a_bytes__item, a_length))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_bytes_no_copy__length_ (a_bytes: UNSUPPORTED_TYPE; a_length: NATURAL_64)
--			-- Initialize `Current'.
--		local
--			a_bytes__item: POINTER
--		do
--			if attached a_bytes as a_bytes_attached then
--				a_bytes__item := a_bytes_attached.item
--			end
--			make_with_pointer (objc_init_with_bytes_no_copy__length_(allocate_object, a_bytes__item, a_length))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_bytes_no_copy__length__free_when_done_ (a_bytes: UNSUPPORTED_TYPE; a_length: NATURAL_64; a_b: BOOLEAN)
--			-- Initialize `Current'.
--		local
--			a_bytes__item: POINTER
--		do
--			if attached a_bytes as a_bytes_attached then
--				a_bytes__item := a_bytes_attached.item
--			end
--			make_with_pointer (objc_init_with_bytes_no_copy__length__free_when_done_(allocate_object, a_bytes__item, a_length, a_b))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_contents_of_file__options__error_ (a_path: detachable NS_STRING; a_read_options_mask: NATURAL_64; a_error_ptr: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_path__item: POINTER
--			a_error_ptr__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_error_ptr as a_error_ptr_attached then
--				a_error_ptr__item := a_error_ptr_attached.item
--			end
--			make_with_pointer (objc_init_with_contents_of_file__options__error_(allocate_object, a_path__item, a_read_options_mask, a_error_ptr__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_contents_of_ur_l__options__error_ (a_url: detachable NS_URL; a_read_options_mask: NATURAL_64; a_error_ptr: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_url__item: POINTER
--			a_error_ptr__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error_ptr as a_error_ptr_attached then
--				a_error_ptr__item := a_error_ptr_attached.item
--			end
--			make_with_pointer (objc_init_with_contents_of_ur_l__options__error_(allocate_object, a_url__item, a_read_options_mask, a_error_ptr__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_with_contents_of_file_ (a_path: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			make_with_pointer (objc_init_with_contents_of_file_(allocate_object, a_path__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_contents_of_ur_l_ (a_url: detachable NS_URL)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			make_with_pointer (objc_init_with_contents_of_ur_l_(allocate_object, a_url__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_contents_of_mapped_file_ (a_path: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			make_with_pointer (objc_init_with_contents_of_mapped_file_(allocate_object, a_path__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_data_ (a_data: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			make_with_pointer (objc_init_with_data_(allocate_object, a_data__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSDataCreation Externals

--	objc_init_with_bytes__length_ (an_item: POINTER; a_bytes: UNSUPPORTED_TYPE; a_length: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSData *)$an_item initWithBytes: length:$a_length];
--			 ]"
--		end

--	objc_init_with_bytes_no_copy__length_ (an_item: POINTER; a_bytes: UNSUPPORTED_TYPE; a_length: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSData *)$an_item initWithBytesNoCopy: length:$a_length];
--			 ]"
--		end

--	objc_init_with_bytes_no_copy__length__free_when_done_ (an_item: POINTER; a_bytes: UNSUPPORTED_TYPE; a_length: NATURAL_64; a_b: BOOLEAN): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSData *)$an_item initWithBytesNoCopy: length:$a_length freeWhenDone:$a_b];
--			 ]"
--		end

--	objc_init_with_contents_of_file__options__error_ (an_item: POINTER; a_path: POINTER; a_read_options_mask: NATURAL_64; a_error_ptr: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSData *)$an_item initWithContentsOfFile:$a_path options:$a_read_options_mask error:];
--			 ]"
--		end

--	objc_init_with_contents_of_ur_l__options__error_ (an_item: POINTER; a_url: POINTER; a_read_options_mask: NATURAL_64; a_error_ptr: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSData *)$an_item initWithContentsOfURL:$a_url options:$a_read_options_mask error:];
--			 ]"
--		end

	objc_init_with_contents_of_file_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSData *)$an_item initWithContentsOfFile:$a_path];
			 ]"
		end

	objc_init_with_contents_of_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSData *)$an_item initWithContentsOfURL:$a_url];
			 ]"
		end

	objc_init_with_contents_of_mapped_file_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSData *)$an_item initWithContentsOfMappedFile:$a_path];
			 ]"
		end

	objc_init_with_data_ (an_item: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSData *)$an_item initWithData:$a_data];
			 ]"
		end

feature -- NSDeprecated

--	get_bytes_ (a_buffer: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_buffer__item: POINTER
--		do
--			if attached a_buffer as a_buffer_attached then
--				a_buffer__item := a_buffer_attached.item
--			end
--			objc_get_bytes_ (item, a_buffer__item)
--		end

feature {NONE} -- NSDeprecated Externals

--	objc_get_bytes_ (an_item: POINTER; a_buffer: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSData *)$an_item getBytes:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSData"
		end

end
