note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MUTABLE_DATA

inherit
	NS_DATA
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_capacity_,
	make_with_length_,
	make_with_contents_of_file_,
	make_with_contents_of_ur_l_,
	make_with_contents_of_mapped_file_,
	make_with_data_,
	make

feature -- NSMutableData

--	mutable_bytes: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_mutable_bytes (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like mutable_bytes} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like mutable_bytes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	set_length_ (a_length: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_length_ (item, a_length)
		end

feature {NONE} -- NSMutableData Externals

--	objc_mutable_bytes (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSMutableData *)$an_item mutableBytes];
--			 ]"
--		end

	objc_set_length_ (an_item: POINTER; a_length: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableData *)$an_item setLength:$a_length];
			 ]"
		end

feature -- NSExtendedMutableData

--	append_bytes__length_ (a_bytes: UNSUPPORTED_TYPE; a_length: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_bytes__item: POINTER
--		do
--			if attached a_bytes as a_bytes_attached then
--				a_bytes__item := a_bytes_attached.item
--			end
--			objc_append_bytes__length_ (item, a_bytes__item, a_length)
--		end

	append_data_ (a_other: detachable NS_DATA)
			-- Auto generated Objective-C wrapper.
		local
			a_other__item: POINTER
		do
			if attached a_other as a_other_attached then
				a_other__item := a_other_attached.item
			end
			objc_append_data_ (item, a_other__item)
		end

	increase_length_by_ (a_extra_length: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_increase_length_by_ (item, a_extra_length)
		end

--	replace_bytes_in_range__with_bytes_ (a_range: NS_RANGE; a_bytes: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_bytes__item: POINTER
--		do
--			if attached a_bytes as a_bytes_attached then
--				a_bytes__item := a_bytes_attached.item
--			end
--			objc_replace_bytes_in_range__with_bytes_ (item, a_range.item, a_bytes__item)
--		end

	reset_bytes_in_range_ (a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reset_bytes_in_range_ (item, a_range.item)
		end

	set_data_ (a_data: detachable NS_DATA)
			-- Auto generated Objective-C wrapper.
		local
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			objc_set_data_ (item, a_data__item)
		end

--	replace_bytes_in_range__with_bytes__length_ (a_range: NS_RANGE; a_replacement_bytes: UNSUPPORTED_TYPE; a_replacement_length: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_replacement_bytes__item: POINTER
--		do
--			if attached a_replacement_bytes as a_replacement_bytes_attached then
--				a_replacement_bytes__item := a_replacement_bytes_attached.item
--			end
--			objc_replace_bytes_in_range__with_bytes__length_ (item, a_range.item, a_replacement_bytes__item, a_replacement_length)
--		end

feature {NONE} -- NSExtendedMutableData Externals

--	objc_append_bytes__length_ (an_item: POINTER; a_bytes: UNSUPPORTED_TYPE; a_length: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSMutableData *)$an_item appendBytes: length:$a_length];
--			 ]"
--		end

	objc_append_data_ (an_item: POINTER; a_other: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableData *)$an_item appendData:$a_other];
			 ]"
		end

	objc_increase_length_by_ (an_item: POINTER; a_extra_length: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableData *)$an_item increaseLengthBy:$a_extra_length];
			 ]"
		end

--	objc_replace_bytes_in_range__with_bytes_ (an_item: POINTER; a_range: POINTER; a_bytes: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSMutableData *)$an_item replaceBytesInRange:*((NSRange *)$a_range) withBytes:];
--			 ]"
--		end

	objc_reset_bytes_in_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableData *)$an_item resetBytesInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_set_data_ (an_item: POINTER; a_data: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableData *)$an_item setData:$a_data];
			 ]"
		end

--	objc_replace_bytes_in_range__with_bytes__length_ (an_item: POINTER; a_range: POINTER; a_replacement_bytes: UNSUPPORTED_TYPE; a_replacement_length: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSMutableData *)$an_item replaceBytesInRange:*((NSRange *)$a_range) withBytes: length:$a_replacement_length];
--			 ]"
--		end

feature {NONE} -- Initialization

	make_with_capacity_ (a_capacity: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_capacity_(allocate_object, a_capacity))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_length_ (a_length: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_length_(allocate_object, a_length))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSMutableDataCreation Externals

	objc_init_with_capacity_ (an_item: POINTER; a_capacity: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMutableData *)$an_item initWithCapacity:$a_capacity];
			 ]"
		end

	objc_init_with_length_ (an_item: POINTER; a_length: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMutableData *)$an_item initWithLength:$a_length];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMutableData"
		end

end
