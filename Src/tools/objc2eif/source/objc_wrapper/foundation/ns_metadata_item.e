note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_METADATA_ITEM

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

feature -- NSMetadataItem

	value_for_attribute_ (a_key: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_value_for_attribute_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_for_attribute_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_for_attribute_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	values_for_attributes_ (a_keys: detachable NS_ARRAY): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_keys__item: POINTER
		do
			if attached a_keys as a_keys_attached then
				a_keys__item := a_keys_attached.item
			end
			result_pointer := objc_values_for_attributes_ (item, a_keys__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like values_for_attributes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like values_for_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	attributes: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSMetadataItem Externals

	objc_value_for_attribute_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMetadataItem *)$an_item valueForAttribute:$a_key];
			 ]"
		end

	objc_values_for_attributes_ (an_item: POINTER; a_keys: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMetadataItem *)$an_item valuesForAttributes:$a_keys];
			 ]"
		end

	objc_attributes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMetadataItem *)$an_item attributes];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMetadataItem"
		end

end
