note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_INPUT_STREAM

inherit
	NS_STREAM
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_data_,
	make_with_file_at_path_,
	make_with_ur_l_,
	make

feature -- NSInputStream

--	read__max_length_ (a_buffer: UNSUPPORTED_TYPE; a_len: NATURAL_64): INTEGER_64
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			Result := objc_read__max_length_ (item, , a_len)
--		end

--	get_buffer__length_ (a_buffer: UNSUPPORTED_TYPE; a_len: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_buffer__item: POINTER
--			a_len__item: POINTER
--		do
--			if attached a_buffer as a_buffer_attached then
--				a_buffer__item := a_buffer_attached.item
--			end
--			if attached a_len as a_len_attached then
--				a_len__item := a_len_attached.item
--			end
--			Result := objc_get_buffer__length_ (item, a_buffer__item, a_len__item)
--		end

	has_bytes_available: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_bytes_available (item)
		end

feature {NONE} -- NSInputStream Externals

--	objc_read__max_length_ (an_item: POINTER; a_buffer: POINTER; a_len: NATURAL_64): INTEGER_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSInputStream *)$an_item read:$a_buffer maxLength:$a_len];
--			 ]"
--		end

--	objc_get_buffer__length_ (an_item: POINTER; a_buffer: UNSUPPORTED_TYPE; a_len: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSInputStream *)$an_item getBuffer: length:];
--			 ]"
--		end

	objc_has_bytes_available (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSInputStream *)$an_item hasBytesAvailable];
			 ]"
		end

feature {NONE} -- Initialization

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

	make_with_file_at_path_ (a_path: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			make_with_pointer (objc_init_with_file_at_path_(allocate_object, a_path__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_ur_l_ (a_url: detachable NS_URL)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			make_with_pointer (objc_init_with_ur_l_(allocate_object, a_url__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSInputStreamExtensions Externals

	objc_init_with_data_ (an_item: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSInputStream *)$an_item initWithData:$a_data];
			 ]"
		end

	objc_init_with_file_at_path_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSInputStream *)$an_item initWithFileAtPath:$a_path];
			 ]"
		end

	objc_init_with_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSInputStream *)$an_item initWithURL:$a_url];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSInputStream"
		end

end
