note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_METADATA_QUERY_ATTRIBUTE_VALUE_TUPLE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSMetadataQueryAttributeValueTuple

	attribute_objc: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attribute_objc (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attribute_objc} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attribute_objc} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_count (item)
		end

feature {NONE} -- NSMetadataQueryAttributeValueTuple Externals

	objc_attribute_objc (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMetadataQueryAttributeValueTuple *)$an_item attribute];
			 ]"
		end

	objc_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSMetadataQueryAttributeValueTuple *)$an_item count];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMetadataQueryAttributeValueTuple"
		end

end
