note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PRINTER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSPrinter

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

	type: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_type (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like type} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like type} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	language_level: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_language_level (item)
		end

	page_size_for_paper_ (a_paper_name: detachable NS_STRING): NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
			a_paper_name__item: POINTER
		do
			if attached a_paper_name as a_paper_name_attached then
				a_paper_name__item := a_paper_name_attached.item
			end
			create Result.make
			objc_page_size_for_paper_ (item, Result.item, a_paper_name__item)
		end

	status_for_table_ (a_table_name: detachable NS_STRING): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_table_name__item: POINTER
		do
			if attached a_table_name as a_table_name_attached then
				a_table_name__item := a_table_name_attached.item
			end
			Result := objc_status_for_table_ (item, a_table_name__item)
		end

	is_key__in_table_ (a_key: detachable NS_STRING; a_table: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
			a_table__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_table as a_table_attached then
				a_table__item := a_table_attached.item
			end
			Result := objc_is_key__in_table_ (item, a_key__item, a_table__item)
		end

	boolean_for_key__in_table_ (a_key: detachable NS_STRING; a_table: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
			a_table__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_table as a_table_attached then
				a_table__item := a_table_attached.item
			end
			Result := objc_boolean_for_key__in_table_ (item, a_key__item, a_table__item)
		end

	float_for_key__in_table_ (a_key: detachable NS_STRING; a_table: detachable NS_STRING): REAL_32
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
			a_table__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_table as a_table_attached then
				a_table__item := a_table_attached.item
			end
			Result := objc_float_for_key__in_table_ (item, a_key__item, a_table__item)
		end

	int_for_key__in_table_ (a_key: detachable NS_STRING; a_table: detachable NS_STRING): INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
			a_table__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_table as a_table_attached then
				a_table__item := a_table_attached.item
			end
			Result := objc_int_for_key__in_table_ (item, a_key__item, a_table__item)
		end

	rect_for_key__in_table_ (a_key: detachable NS_STRING; a_table: detachable NS_STRING): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
			a_table__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_table as a_table_attached then
				a_table__item := a_table_attached.item
			end
			create Result.make
			objc_rect_for_key__in_table_ (item, Result.item, a_key__item, a_table__item)
		end

	size_for_key__in_table_ (a_key: detachable NS_STRING; a_table: detachable NS_STRING): NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
			a_table__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_table as a_table_attached then
				a_table__item := a_table_attached.item
			end
			create Result.make
			objc_size_for_key__in_table_ (item, Result.item, a_key__item, a_table__item)
		end

	string_for_key__in_table_ (a_key: detachable NS_STRING; a_table: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
			a_table__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_table as a_table_attached then
				a_table__item := a_table_attached.item
			end
			result_pointer := objc_string_for_key__in_table_ (item, a_key__item, a_table__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_for_key__in_table_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_for_key__in_table_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_list_for_key__in_table_ (a_key: detachable NS_STRING; a_table: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
			a_table__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_table as a_table_attached then
				a_table__item := a_table_attached.item
			end
			result_pointer := objc_string_list_for_key__in_table_ (item, a_key__item, a_table__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_list_for_key__in_table_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_list_for_key__in_table_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	device_description: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_device_description (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like device_description} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like device_description} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPrinter Externals

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrinter *)$an_item name];
			 ]"
		end

	objc_type (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrinter *)$an_item type];
			 ]"
		end

	objc_language_level (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrinter *)$an_item languageLevel];
			 ]"
		end

	objc_page_size_for_paper_ (an_item: POINTER; result_pointer: POINTER; a_paper_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSPrinter *)$an_item pageSizeForPaper:$a_paper_name];
			 ]"
		end

	objc_status_for_table_ (an_item: POINTER; a_table_name: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrinter *)$an_item statusForTable:$a_table_name];
			 ]"
		end

	objc_is_key__in_table_ (an_item: POINTER; a_key: POINTER; a_table: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrinter *)$an_item isKey:$a_key inTable:$a_table];
			 ]"
		end

	objc_boolean_for_key__in_table_ (an_item: POINTER; a_key: POINTER; a_table: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrinter *)$an_item booleanForKey:$a_key inTable:$a_table];
			 ]"
		end

	objc_float_for_key__in_table_ (an_item: POINTER; a_key: POINTER; a_table: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrinter *)$an_item floatForKey:$a_key inTable:$a_table];
			 ]"
		end

	objc_int_for_key__in_table_ (an_item: POINTER; a_key: POINTER; a_table: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrinter *)$an_item intForKey:$a_key inTable:$a_table];
			 ]"
		end

	objc_rect_for_key__in_table_ (an_item: POINTER; result_pointer: POINTER; a_key: POINTER; a_table: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSPrinter *)$an_item rectForKey:$a_key inTable:$a_table];
			 ]"
		end

	objc_size_for_key__in_table_ (an_item: POINTER; result_pointer: POINTER; a_key: POINTER; a_table: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSPrinter *)$an_item sizeForKey:$a_key inTable:$a_table];
			 ]"
		end

	objc_string_for_key__in_table_ (an_item: POINTER; a_key: POINTER; a_table: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrinter *)$an_item stringForKey:$a_key inTable:$a_table];
			 ]"
		end

	objc_string_list_for_key__in_table_ (an_item: POINTER; a_key: POINTER; a_table: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrinter *)$an_item stringListForKey:$a_key inTable:$a_table];
			 ]"
		end

	objc_device_description (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrinter *)$an_item deviceDescription];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPrinter"
		end

end
