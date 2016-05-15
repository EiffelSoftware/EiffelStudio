note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_HTTPURL_RESPONSE

inherit
	NS_URL_RESPONSE
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_ur_l__mime_type__expected_content_length__text_encoding_name_,
	make

feature -- NSHTTPURLResponse

	status_code: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_status_code (item)
		end

	all_header_fields: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_all_header_fields (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like all_header_fields} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like all_header_fields} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSHTTPURLResponse Externals

	objc_status_code (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSHTTPURLResponse *)$an_item statusCode];
			 ]"
		end

	objc_all_header_fields (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHTTPURLResponse *)$an_item allHeaderFields];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSHTTPURLResponse"
		end

end
