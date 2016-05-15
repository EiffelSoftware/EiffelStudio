note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PASTEBOARD_ITEM

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_PASTEBOARD_WRITING_PROTOCOL
		undefine
			is_equal_,
			objc_is_equal_,
			hash,
			objc_hash,
			superclass,
			objc_superclass,
			class_objc,
			objc_class_objc,
			self,
			objc_self,
			perform_selector_,
			objc_perform_selector_,
			perform_selector__with_object_,
			objc_perform_selector__with_object_,
			perform_selector__with_object__with_object_,
			objc_perform_selector__with_object__with_object_,
			is_proxy,
			objc_is_proxy,
			is_kind_of_class_,
			objc_is_kind_of_class_,
			is_member_of_class_,
			objc_is_member_of_class_,
			responds_to_selector_,
			objc_responds_to_selector_,
			retain_count,
			objc_retain_count,
			description,
			objc_description
		end

	NS_PASTEBOARD_READING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSPasteboardItem

	types: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_types (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like types} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like types} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	available_type_from_array_ (a_types: detachable NS_ARRAY): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_types__item: POINTER
		do
			if attached a_types as a_types_attached then
				a_types__item := a_types_attached.item
			end
			result_pointer := objc_available_type_from_array_ (item, a_types__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like available_type_from_array_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like available_type_from_array_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_data_provider__for_types_ (a_data_provider: detachable NS_PASTEBOARD_ITEM_DATA_PROVIDER_PROTOCOL; a_types: detachable NS_ARRAY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_data_provider__item: POINTER
			a_types__item: POINTER
		do
			if attached a_data_provider as a_data_provider_attached then
				a_data_provider__item := a_data_provider_attached.item
			end
			if attached a_types as a_types_attached then
				a_types__item := a_types_attached.item
			end
			Result := objc_set_data_provider__for_types_ (item, a_data_provider__item, a_types__item)
		end

	set_data__for_type_ (a_data: detachable NS_DATA; a_type: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_data__item: POINTER
			a_type__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			Result := objc_set_data__for_type_ (item, a_data__item, a_type__item)
		end

	set_string__for_type_ (a_string: detachable NS_STRING; a_type: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
			a_type__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			Result := objc_set_string__for_type_ (item, a_string__item, a_type__item)
		end

	set_property_list__for_type_ (a_property_list: detachable NS_OBJECT; a_type: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_property_list__item: POINTER
			a_type__item: POINTER
		do
			if attached a_property_list as a_property_list_attached then
				a_property_list__item := a_property_list_attached.item
			end
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			Result := objc_set_property_list__for_type_ (item, a_property_list__item, a_type__item)
		end

	data_for_type_ (a_type: detachable NS_STRING): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_type__item: POINTER
		do
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			result_pointer := objc_data_for_type_ (item, a_type__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_for_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_for_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_for_type_ (a_type: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_type__item: POINTER
		do
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			result_pointer := objc_string_for_type_ (item, a_type__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_for_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_for_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	property_list_for_type_ (a_type: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_type__item: POINTER
		do
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			result_pointer := objc_property_list_for_type_ (item, a_type__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like property_list_for_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like property_list_for_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPasteboardItem Externals

	objc_types (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPasteboardItem *)$an_item types];
			 ]"
		end

	objc_available_type_from_array_ (an_item: POINTER; a_types: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPasteboardItem *)$an_item availableTypeFromArray:$a_types];
			 ]"
		end

	objc_set_data_provider__for_types_ (an_item: POINTER; a_data_provider: POINTER; a_types: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboardItem *)$an_item setDataProvider:$a_data_provider forTypes:$a_types];
			 ]"
		end

	objc_set_data__for_type_ (an_item: POINTER; a_data: POINTER; a_type: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboardItem *)$an_item setData:$a_data forType:$a_type];
			 ]"
		end

	objc_set_string__for_type_ (an_item: POINTER; a_string: POINTER; a_type: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboardItem *)$an_item setString:$a_string forType:$a_type];
			 ]"
		end

	objc_set_property_list__for_type_ (an_item: POINTER; a_property_list: POINTER; a_type: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboardItem *)$an_item setPropertyList:$a_property_list forType:$a_type];
			 ]"
		end

	objc_data_for_type_ (an_item: POINTER; a_type: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPasteboardItem *)$an_item dataForType:$a_type];
			 ]"
		end

	objc_string_for_type_ (an_item: POINTER; a_type: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPasteboardItem *)$an_item stringForType:$a_type];
			 ]"
		end

	objc_property_list_for_type_ (an_item: POINTER; a_type: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPasteboardItem *)$an_item propertyListForType:$a_type];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPasteboardItem"
		end

end
