note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OUTPUT_STREAM

inherit
	NS_STREAM
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_to_memory,
	make_to_file_at_path__append_,
	make_with_ur_l__append_,
	make

feature -- NSOutputStream

--	write__max_length_ (a_buffer: UNSUPPORTED_TYPE; a_len: NATURAL_64): INTEGER_64
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			Result := objc_write__max_length_ (item, , a_len)
--		end

	has_space_available: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_space_available (item)
		end

feature {NONE} -- NSOutputStream Externals

--	objc_write__max_length_ (an_item: POINTER; a_buffer: POINTER; a_len: NATURAL_64): INTEGER_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSOutputStream *)$an_item write:$a_buffer maxLength:$a_len];
--			 ]"
--		end

	objc_has_space_available (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSOutputStream *)$an_item hasSpaceAvailable];
			 ]"
		end

feature {NONE} -- Initialization

	make_to_memory
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_to_memory(allocate_object))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_to_buffer__capacity_ (a_buffer: UNSUPPORTED_TYPE; a_capacity: NATURAL_64)
--			-- Initialize `Current'.
--		local
--		do
--			make_with_pointer (objc_init_to_buffer__capacity_(allocate_object, a_capacity))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_to_file_at_path__append_ (a_path: detachable NS_STRING; a_should_append: BOOLEAN)
			-- Initialize `Current'.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			make_with_pointer (objc_init_to_file_at_path__append_(allocate_object, a_path__item, a_should_append))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_ur_l__append_ (a_url: detachable NS_URL; a_should_append: BOOLEAN)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			make_with_pointer (objc_init_with_ur_l__append_(allocate_object, a_url__item, a_should_append))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSOutputStreamExtensions Externals

	objc_init_to_memory (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOutputStream *)$an_item initToMemory];
			 ]"
		end

--	objc_init_to_buffer__capacity_ (an_item: POINTER; a_buffer: POINTER; a_capacity: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSOutputStream *)$an_item initToBuffer:$a_buffer capacity:$a_capacity];
--			 ]"
--		end

	objc_init_to_file_at_path__append_ (an_item: POINTER; a_path: POINTER; a_should_append: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOutputStream *)$an_item initToFileAtPath:$a_path append:$a_should_append];
			 ]"
		end

	objc_init_with_ur_l__append_ (an_item: POINTER; a_url: POINTER; a_should_append: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOutputStream *)$an_item initWithURL:$a_url append:$a_should_append];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSOutputStream"
		end

end
