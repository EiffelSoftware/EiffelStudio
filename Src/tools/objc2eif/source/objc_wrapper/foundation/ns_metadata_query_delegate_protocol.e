note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_METADATA_QUERY_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	metadata_query__replacement_object_for_result_object_ (a_query: detachable NS_METADATA_QUERY; a_result: detachable NS_METADATA_ITEM): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_metadata_query__replacement_object_for_result_object_: has_metadata_query__replacement_object_for_result_object_
		local
			result_pointer: POINTER
			a_query__item: POINTER
			a_result__item: POINTER
		do
			if attached a_query as a_query_attached then
				a_query__item := a_query_attached.item
			end
			if attached a_result as a_result_attached then
				a_result__item := a_result_attached.item
			end
			result_pointer := objc_metadata_query__replacement_object_for_result_object_ (item, a_query__item, a_result__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like metadata_query__replacement_object_for_result_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like metadata_query__replacement_object_for_result_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	metadata_query__replacement_value_for_attribute__value_ (a_query: detachable NS_METADATA_QUERY; a_attr_name: detachable NS_STRING; a_attr_value: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_metadata_query__replacement_value_for_attribute__value_: has_metadata_query__replacement_value_for_attribute__value_
		local
			result_pointer: POINTER
			a_query__item: POINTER
			a_attr_name__item: POINTER
			a_attr_value__item: POINTER
		do
			if attached a_query as a_query_attached then
				a_query__item := a_query_attached.item
			end
			if attached a_attr_name as a_attr_name_attached then
				a_attr_name__item := a_attr_name_attached.item
			end
			if attached a_attr_value as a_attr_value_attached then
				a_attr_value__item := a_attr_value_attached.item
			end
			result_pointer := objc_metadata_query__replacement_value_for_attribute__value_ (item, a_query__item, a_attr_name__item, a_attr_value__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like metadata_query__replacement_value_for_attribute__value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like metadata_query__replacement_value_for_attribute__value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature -- Status Report

	has_metadata_query__replacement_object_for_result_object_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_metadata_query__replacement_object_for_result_object_ (item)
		end

	has_metadata_query__replacement_value_for_attribute__value_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_metadata_query__replacement_value_for_attribute__value_ (item)
		end

feature -- Status Report Externals

	objc_has_metadata_query__replacement_object_for_result_object_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(metadataQuery:replacementObjectForResultObject:)];
			 ]"
		end

	objc_has_metadata_query__replacement_value_for_attribute__value_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(metadataQuery:replacementValueForAttribute:value:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_metadata_query__replacement_object_for_result_object_ (an_item: POINTER; a_query: POINTER; a_result: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSMetadataQueryDelegate>)$an_item metadataQuery:$a_query replacementObjectForResultObject:$a_result];
			 ]"
		end

	objc_metadata_query__replacement_value_for_attribute__value_ (an_item: POINTER; a_query: POINTER; a_attr_name: POINTER; a_attr_value: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSMetadataQueryDelegate>)$an_item metadataQuery:$a_query replacementValueForAttribute:$a_attr_name value:$a_attr_value];
			 ]"
		end

end
