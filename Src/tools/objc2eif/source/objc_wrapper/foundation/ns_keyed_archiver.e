note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_KEYED_ARCHIVER

inherit
	NS_CODER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_for_writing_with_mutable_data_,
	make

feature {NONE} -- Initialization

	make_for_writing_with_mutable_data_ (a_data: detachable NS_MUTABLE_DATA)
			-- Initialize `Current'.
		local
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			make_with_pointer (objc_init_for_writing_with_mutable_data_(allocate_object, a_data__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSKeyedArchiver Externals

	objc_init_for_writing_with_mutable_data_ (an_item: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSKeyedArchiver *)$an_item initForWritingWithMutableData:$a_data];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSKeyedArchiver *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSKeyedArchiver *)$an_item delegate];
			 ]"
		end

	objc_set_output_format_ (an_item: POINTER; a_format: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSKeyedArchiver *)$an_item setOutputFormat:$a_format];
			 ]"
		end

	objc_output_format (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSKeyedArchiver *)$an_item outputFormat];
			 ]"
		end

	objc_finish_encoding (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSKeyedArchiver *)$an_item finishEncoding];
			 ]"
		end

feature -- NSKeyedArchiver

	set_delegate_ (a_delegate: detachable NS_KEYED_ARCHIVER_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	delegate: detachable NS_KEYED_ARCHIVER_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_output_format_ (a_format: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_output_format_ (item, a_format)
		end

	output_format: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_output_format (item)
		end

	finish_encoding
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_finish_encoding (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSKeyedArchiver"
		end

end
