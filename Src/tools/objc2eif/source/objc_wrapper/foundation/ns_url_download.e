note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL_DOWNLOAD

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_request__delegate_,
	make_with_resume_data__delegate__path_,
	make

feature {NONE} -- Initialization

	make_with_request__delegate_ (a_request: detachable NS_URL_REQUEST; a_delegate: detachable NS_OBJECT)
			-- Initialize `Current'.
		local
			a_request__item: POINTER
			a_delegate__item: POINTER
		do
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			make_with_pointer (objc_init_with_request__delegate_(allocate_object, a_request__item, a_delegate__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_resume_data__delegate__path_ (a_resume_data: detachable NS_DATA; a_delegate: detachable NS_OBJECT; a_path: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_resume_data__item: POINTER
			a_delegate__item: POINTER
			a_path__item: POINTER
		do
			if attached a_resume_data as a_resume_data_attached then
				a_resume_data__item := a_resume_data_attached.item
			end
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			make_with_pointer (objc_init_with_resume_data__delegate__path_(allocate_object, a_resume_data__item, a_delegate__item, a_path__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSURLDownload Externals

	objc_init_with_request__delegate_ (an_item: POINTER; a_request: POINTER; a_delegate: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLDownload *)$an_item initWithRequest:$a_request delegate:$a_delegate];
			 ]"
		end

	objc_init_with_resume_data__delegate__path_ (an_item: POINTER; a_resume_data: POINTER; a_delegate: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLDownload *)$an_item initWithResumeData:$a_resume_data delegate:$a_delegate path:$a_path];
			 ]"
		end

	objc_cancel (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLDownload *)$an_item cancel];
			 ]"
		end

	objc_set_destination__allow_overwrite_ (an_item: POINTER; a_path: POINTER; a_allow_overwrite: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLDownload *)$an_item setDestination:$a_path allowOverwrite:$a_allow_overwrite];
			 ]"
		end

	objc_request (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLDownload *)$an_item request];
			 ]"
		end

	objc_resume_data (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLDownload *)$an_item resumeData];
			 ]"
		end

	objc_set_deletes_file_upon_failure_ (an_item: POINTER; a_deletes_file_upon_failure: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLDownload *)$an_item setDeletesFileUponFailure:$a_deletes_file_upon_failure];
			 ]"
		end

	objc_deletes_file_upon_failure (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURLDownload *)$an_item deletesFileUponFailure];
			 ]"
		end

feature -- NSURLDownload

	cancel
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_cancel (item)
		end

	set_destination__allow_overwrite_ (a_path: detachable NS_STRING; a_allow_overwrite: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			objc_set_destination__allow_overwrite_ (item, a_path__item, a_allow_overwrite)
		end

	request: detachable NS_URL_REQUEST
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_request (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like request} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like request} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	resume_data: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_resume_data (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like resume_data} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like resume_data} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_deletes_file_upon_failure_ (a_deletes_file_upon_failure: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_deletes_file_upon_failure_ (item, a_deletes_file_upon_failure)
		end

	deletes_file_upon_failure: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_deletes_file_upon_failure (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURLDownload"
		end

end
