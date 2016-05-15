note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL_RESPONSE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_ur_l__mime_type__expected_content_length__text_encoding_name_,
	make

feature {NONE} -- Initialization

	make_with_ur_l__mime_type__expected_content_length__text_encoding_name_ (a_url: detachable NS_URL; a_mime_type: detachable NS_STRING; a_length: INTEGER_64; a_name: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
			a_mime_type__item: POINTER
			a_name__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			if attached a_mime_type as a_mime_type_attached then
				a_mime_type__item := a_mime_type_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			make_with_pointer (objc_init_with_ur_l__mime_type__expected_content_length__text_encoding_name_(allocate_object, a_url__item, a_mime_type__item, a_length, a_name__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSURLResponse Externals

	objc_init_with_ur_l__mime_type__expected_content_length__text_encoding_name_ (an_item: POINTER; a_url: POINTER; a_mime_type: POINTER; a_length: INTEGER_64; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLResponse *)$an_item initWithURL:$a_url MIMEType:$a_mime_type expectedContentLength:$a_length textEncodingName:$a_name];
			 ]"
		end

	objc_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLResponse *)$an_item URL];
			 ]"
		end

	objc_mime_type (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLResponse *)$an_item MIMEType];
			 ]"
		end

	objc_expected_content_length (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURLResponse *)$an_item expectedContentLength];
			 ]"
		end

	objc_text_encoding_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLResponse *)$an_item textEncodingName];
			 ]"
		end

	objc_suggested_filename (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLResponse *)$an_item suggestedFilename];
			 ]"
		end

feature -- NSURLResponse

	url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	mime_type: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_mime_type (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mime_type} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mime_type} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	expected_content_length: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_expected_content_length (item)
		end

	text_encoding_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_encoding_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_encoding_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_encoding_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	suggested_filename: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_suggested_filename (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like suggested_filename} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like suggested_filename} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURLResponse"
		end

end
