note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PASTEBOARD

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

feature -- NSPasteboard

	name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	change_count: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_change_count (item)
		end

	release_globally
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_release_globally (item)
		end

	clear_contents: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_clear_contents (item)
		end

	write_objects_ (a_objects: detachable NS_ARRAY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_objects__item: POINTER
		do
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			Result := objc_write_objects_ (item, a_objects__item)
		end

	read_objects_for_classes__options_ (a_class_array: detachable NS_ARRAY; a_options: detachable NS_DICTIONARY): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_class_array__item: POINTER
			a_options__item: POINTER
		do
			if attached a_class_array as a_class_array_attached then
				a_class_array__item := a_class_array_attached.item
			end
			if attached a_options as a_options_attached then
				a_options__item := a_options_attached.item
			end
			result_pointer := objc_read_objects_for_classes__options_ (item, a_class_array__item, a_options__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like read_objects_for_classes__options_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like read_objects_for_classes__options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	pasteboard_items: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_pasteboard_items (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pasteboard_items} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pasteboard_items} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	index_of_pasteboard_item_ (a_pasteboard_item: detachable NS_PASTEBOARD_ITEM): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_pasteboard_item__item: POINTER
		do
			if attached a_pasteboard_item as a_pasteboard_item_attached then
				a_pasteboard_item__item := a_pasteboard_item_attached.item
			end
			Result := objc_index_of_pasteboard_item_ (item, a_pasteboard_item__item)
		end

	can_read_item_with_data_conforming_to_types_ (a_types: detachable NS_ARRAY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_types__item: POINTER
		do
			if attached a_types as a_types_attached then
				a_types__item := a_types_attached.item
			end
			Result := objc_can_read_item_with_data_conforming_to_types_ (item, a_types__item)
		end

	can_read_object_for_classes__options_ (a_class_array: detachable NS_ARRAY; a_options: detachable NS_DICTIONARY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_class_array__item: POINTER
			a_options__item: POINTER
		do
			if attached a_class_array as a_class_array_attached then
				a_class_array__item := a_class_array_attached.item
			end
			if attached a_options as a_options_attached then
				a_options__item := a_options_attached.item
			end
			Result := objc_can_read_object_for_classes__options_ (item, a_class_array__item, a_options__item)
		end

	declare_types__owner_ (a_new_types: detachable NS_ARRAY; a_new_owner: detachable NS_OBJECT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_new_types__item: POINTER
			a_new_owner__item: POINTER
		do
			if attached a_new_types as a_new_types_attached then
				a_new_types__item := a_new_types_attached.item
			end
			if attached a_new_owner as a_new_owner_attached then
				a_new_owner__item := a_new_owner_attached.item
			end
			Result := objc_declare_types__owner_ (item, a_new_types__item, a_new_owner__item)
		end

	add_types__owner_ (a_new_types: detachable NS_ARRAY; a_new_owner: detachable NS_OBJECT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_new_types__item: POINTER
			a_new_owner__item: POINTER
		do
			if attached a_new_types as a_new_types_attached then
				a_new_types__item := a_new_types_attached.item
			end
			if attached a_new_owner as a_new_owner_attached then
				a_new_owner__item := a_new_owner_attached.item
			end
			Result := objc_add_types__owner_ (item, a_new_types__item, a_new_owner__item)
		end

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

	set_data__for_type_ (a_data: detachable NS_DATA; a_data_type: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_data__item: POINTER
			a_data_type__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			if attached a_data_type as a_data_type_attached then
				a_data_type__item := a_data_type_attached.item
			end
			Result := objc_set_data__for_type_ (item, a_data__item, a_data_type__item)
		end

	set_property_list__for_type_ (a_plist: detachable NS_OBJECT; a_data_type: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_plist__item: POINTER
			a_data_type__item: POINTER
		do
			if attached a_plist as a_plist_attached then
				a_plist__item := a_plist_attached.item
			end
			if attached a_data_type as a_data_type_attached then
				a_data_type__item := a_data_type_attached.item
			end
			Result := objc_set_property_list__for_type_ (item, a_plist__item, a_data_type__item)
		end

	set_string__for_type_ (a_string: detachable NS_STRING; a_data_type: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
			a_data_type__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			if attached a_data_type as a_data_type_attached then
				a_data_type__item := a_data_type_attached.item
			end
			Result := objc_set_string__for_type_ (item, a_string__item, a_data_type__item)
		end

	data_for_type_ (a_data_type: detachable NS_STRING): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_data_type__item: POINTER
		do
			if attached a_data_type as a_data_type_attached then
				a_data_type__item := a_data_type_attached.item
			end
			result_pointer := objc_data_for_type_ (item, a_data_type__item)
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

	property_list_for_type_ (a_data_type: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_data_type__item: POINTER
		do
			if attached a_data_type as a_data_type_attached then
				a_data_type__item := a_data_type_attached.item
			end
			result_pointer := objc_property_list_for_type_ (item, a_data_type__item)
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

	string_for_type_ (a_data_type: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_data_type__item: POINTER
		do
			if attached a_data_type as a_data_type_attached then
				a_data_type__item := a_data_type_attached.item
			end
			result_pointer := objc_string_for_type_ (item, a_data_type__item)
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

feature {NONE} -- NSPasteboard Externals

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPasteboard *)$an_item name];
			 ]"
		end

	objc_change_count (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboard *)$an_item changeCount];
			 ]"
		end

	objc_release_globally (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPasteboard *)$an_item releaseGlobally];
			 ]"
		end

	objc_clear_contents (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboard *)$an_item clearContents];
			 ]"
		end

	objc_write_objects_ (an_item: POINTER; a_objects: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboard *)$an_item writeObjects:$a_objects];
			 ]"
		end

	objc_read_objects_for_classes__options_ (an_item: POINTER; a_class_array: POINTER; a_options: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPasteboard *)$an_item readObjectsForClasses:$a_class_array options:$a_options];
			 ]"
		end

	objc_pasteboard_items (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPasteboard *)$an_item pasteboardItems];
			 ]"
		end

	objc_index_of_pasteboard_item_ (an_item: POINTER; a_pasteboard_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboard *)$an_item indexOfPasteboardItem:$a_pasteboard_item];
			 ]"
		end

	objc_can_read_item_with_data_conforming_to_types_ (an_item: POINTER; a_types: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboard *)$an_item canReadItemWithDataConformingToTypes:$a_types];
			 ]"
		end

	objc_can_read_object_for_classes__options_ (an_item: POINTER; a_class_array: POINTER; a_options: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboard *)$an_item canReadObjectForClasses:$a_class_array options:$a_options];
			 ]"
		end

	objc_declare_types__owner_ (an_item: POINTER; a_new_types: POINTER; a_new_owner: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboard *)$an_item declareTypes:$a_new_types owner:$a_new_owner];
			 ]"
		end

	objc_add_types__owner_ (an_item: POINTER; a_new_types: POINTER; a_new_owner: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboard *)$an_item addTypes:$a_new_types owner:$a_new_owner];
			 ]"
		end

	objc_types (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPasteboard *)$an_item types];
			 ]"
		end

	objc_available_type_from_array_ (an_item: POINTER; a_types: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPasteboard *)$an_item availableTypeFromArray:$a_types];
			 ]"
		end

	objc_set_data__for_type_ (an_item: POINTER; a_data: POINTER; a_data_type: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboard *)$an_item setData:$a_data forType:$a_data_type];
			 ]"
		end

	objc_set_property_list__for_type_ (an_item: POINTER; a_plist: POINTER; a_data_type: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboard *)$an_item setPropertyList:$a_plist forType:$a_data_type];
			 ]"
		end

	objc_set_string__for_type_ (an_item: POINTER; a_string: POINTER; a_data_type: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboard *)$an_item setString:$a_string forType:$a_data_type];
			 ]"
		end

	objc_data_for_type_ (an_item: POINTER; a_data_type: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPasteboard *)$an_item dataForType:$a_data_type];
			 ]"
		end

	objc_property_list_for_type_ (an_item: POINTER; a_data_type: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPasteboard *)$an_item propertyListForType:$a_data_type];
			 ]"
		end

	objc_string_for_type_ (an_item: POINTER; a_data_type: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPasteboard *)$an_item stringForType:$a_data_type];
			 ]"
		end

feature -- NSFileContents

	write_file_contents_ (a_filename: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_filename__item: POINTER
		do
			if attached a_filename as a_filename_attached then
				a_filename__item := a_filename_attached.item
			end
			Result := objc_write_file_contents_ (item, a_filename__item)
		end

	read_file_contents_type__to_file_ (a_type: detachable NS_STRING; a_filename: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_type__item: POINTER
			a_filename__item: POINTER
		do
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			if attached a_filename as a_filename_attached then
				a_filename__item := a_filename_attached.item
			end
			result_pointer := objc_read_file_contents_type__to_file_ (item, a_type__item, a_filename__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like read_file_contents_type__to_file_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like read_file_contents_type__to_file_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	write_file_wrapper_ (a_wrapper: detachable NS_FILE_WRAPPER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_wrapper__item: POINTER
		do
			if attached a_wrapper as a_wrapper_attached then
				a_wrapper__item := a_wrapper_attached.item
			end
			Result := objc_write_file_wrapper_ (item, a_wrapper__item)
		end

	read_file_wrapper: detachable NS_FILE_WRAPPER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_read_file_wrapper (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like read_file_wrapper} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like read_file_wrapper} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSFileContents Externals

	objc_write_file_contents_ (an_item: POINTER; a_filename: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboard *)$an_item writeFileContents:$a_filename];
			 ]"
		end

	objc_read_file_contents_type__to_file_ (an_item: POINTER; a_type: POINTER; a_filename: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPasteboard *)$an_item readFileContentsType:$a_type toFile:$a_filename];
			 ]"
		end

	objc_write_file_wrapper_ (an_item: POINTER; a_wrapper: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPasteboard *)$an_item writeFileWrapper:$a_wrapper];
			 ]"
		end

	objc_read_file_wrapper (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPasteboard *)$an_item readFileWrapper];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPasteboard"
		end

end
