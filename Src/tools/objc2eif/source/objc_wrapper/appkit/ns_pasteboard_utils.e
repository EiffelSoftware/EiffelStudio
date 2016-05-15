note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PASTEBOARD_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSPasteboard

	general_pasteboard: detachable NS_PASTEBOARD
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_general_pasteboard (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like general_pasteboard} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like general_pasteboard} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	pasteboard_with_name_ (a_name: detachable NS_STRING): detachable NS_PASTEBOARD
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_pasteboard_with_name_ (l_objc_class.item, a_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pasteboard_with_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pasteboard_with_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	pasteboard_with_unique_name: detachable NS_PASTEBOARD
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_pasteboard_with_unique_name (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pasteboard_with_unique_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pasteboard_with_unique_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPasteboard Externals

	objc_general_pasteboard (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object generalPasteboard];
			 ]"
		end

	objc_pasteboard_with_name_ (a_class_object: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object pasteboardWithName:$a_name];
			 ]"
		end

	objc_pasteboard_with_unique_name (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object pasteboardWithUniqueName];
			 ]"
		end

feature -- FilterServices

	types_filterable_to_ (a_type: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_type__item: POINTER
		do
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_types_filterable_to_ (l_objc_class.item, a_type__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like types_filterable_to_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like types_filterable_to_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	pasteboard_by_filtering_file_ (a_filename: detachable NS_STRING): detachable NS_PASTEBOARD
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_filename__item: POINTER
		do
			if attached a_filename as a_filename_attached then
				a_filename__item := a_filename_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_pasteboard_by_filtering_file_ (l_objc_class.item, a_filename__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pasteboard_by_filtering_file_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pasteboard_by_filtering_file_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	pasteboard_by_filtering_data__of_type_ (a_data: detachable NS_DATA; a_type: detachable NS_STRING): detachable NS_PASTEBOARD
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_data__item: POINTER
			a_type__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_pasteboard_by_filtering_data__of_type_ (l_objc_class.item, a_data__item, a_type__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pasteboard_by_filtering_data__of_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pasteboard_by_filtering_data__of_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	pasteboard_by_filtering_types_in_pasteboard_ (a_pboard: detachable NS_PASTEBOARD): detachable NS_PASTEBOARD
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_pboard__item: POINTER
		do
			if attached a_pboard as a_pboard_attached then
				a_pboard__item := a_pboard_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_pasteboard_by_filtering_types_in_pasteboard_ (l_objc_class.item, a_pboard__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pasteboard_by_filtering_types_in_pasteboard_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pasteboard_by_filtering_types_in_pasteboard_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- FilterServices Externals

	objc_types_filterable_to_ (a_class_object: POINTER; a_type: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object typesFilterableTo:$a_type];
			 ]"
		end

	objc_pasteboard_by_filtering_file_ (a_class_object: POINTER; a_filename: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object pasteboardByFilteringFile:$a_filename];
			 ]"
		end

	objc_pasteboard_by_filtering_data__of_type_ (a_class_object: POINTER; a_data: POINTER; a_type: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object pasteboardByFilteringData:$a_data ofType:$a_type];
			 ]"
		end

	objc_pasteboard_by_filtering_types_in_pasteboard_ (a_class_object: POINTER; a_pboard: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object pasteboardByFilteringTypesInPasteboard:$a_pboard];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPasteboard"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
