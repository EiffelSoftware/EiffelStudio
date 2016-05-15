note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ARCHIVER

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

	make_for_writing_with_mutable_data_ (a_mdata: detachable NS_MUTABLE_DATA)
			-- Initialize `Current'.
		local
			a_mdata__item: POINTER
		do
			if attached a_mdata as a_mdata_attached then
				a_mdata__item := a_mdata_attached.item
			end
			make_with_pointer (objc_init_for_writing_with_mutable_data_(allocate_object, a_mdata__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSArchiver Externals

	objc_init_for_writing_with_mutable_data_ (an_item: POINTER; a_mdata: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArchiver *)$an_item initForWritingWithMutableData:$a_mdata];
			 ]"
		end

	objc_archiver_data (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArchiver *)$an_item archiverData];
			 ]"
		end

	objc_encode_class_name__into_class_name_ (an_item: POINTER; a_true_name: POINTER; a_in_archive_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSArchiver *)$an_item encodeClassName:$a_true_name intoClassName:$a_in_archive_name];
			 ]"
		end

	objc_class_name_encoded_for_true_class_name_ (an_item: POINTER; a_true_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArchiver *)$an_item classNameEncodedForTrueClassName:$a_true_name];
			 ]"
		end

	objc_replace_object__with_object_ (an_item: POINTER; a_object: POINTER; a_new_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSArchiver *)$an_item replaceObject:$a_object withObject:$a_new_object];
			 ]"
		end

feature -- NSArchiver

	archiver_data: detachable NS_MUTABLE_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_archiver_data (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like archiver_data} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like archiver_data} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	encode_class_name__into_class_name_ (a_true_name: detachable NS_STRING; a_in_archive_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_true_name__item: POINTER
			a_in_archive_name__item: POINTER
		do
			if attached a_true_name as a_true_name_attached then
				a_true_name__item := a_true_name_attached.item
			end
			if attached a_in_archive_name as a_in_archive_name_attached then
				a_in_archive_name__item := a_in_archive_name_attached.item
			end
			objc_encode_class_name__into_class_name_ (item, a_true_name__item, a_in_archive_name__item)
		end

	class_name_encoded_for_true_class_name_ (a_true_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_true_name__item: POINTER
		do
			if attached a_true_name as a_true_name_attached then
				a_true_name__item := a_true_name_attached.item
			end
			result_pointer := objc_class_name_encoded_for_true_class_name_ (item, a_true_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_name_encoded_for_true_class_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_name_encoded_for_true_class_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	replace_object__with_object_ (a_object: detachable NS_OBJECT; a_new_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
			a_new_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			if attached a_new_object as a_new_object_attached then
				a_new_object__item := a_new_object_attached.item
			end
			objc_replace_object__with_object_ (item, a_object__item, a_new_object__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSArchiver"
		end

end
