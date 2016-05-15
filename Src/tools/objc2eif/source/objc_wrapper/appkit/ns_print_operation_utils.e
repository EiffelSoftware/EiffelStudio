note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PRINT_OPERATION_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSPrintOperation

	print_operation_with_view__print_info_ (a_view: detachable NS_VIEW; a_print_info: detachable NS_PRINT_INFO): detachable NS_PRINT_OPERATION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_view__item: POINTER
			a_print_info__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_print_info as a_print_info_attached then
				a_print_info__item := a_print_info_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_print_operation_with_view__print_info_ (l_objc_class.item, a_view__item, a_print_info__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like print_operation_with_view__print_info_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like print_operation_with_view__print_info_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	pdf_operation_with_view__inside_rect__to_data__print_info_ (a_view: detachable NS_VIEW; a_rect: NS_RECT; a_data: detachable NS_MUTABLE_DATA; a_print_info: detachable NS_PRINT_INFO): detachable NS_PRINT_OPERATION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_view__item: POINTER
			a_data__item: POINTER
			a_print_info__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			if attached a_print_info as a_print_info_attached then
				a_print_info__item := a_print_info_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_pdf_operation_with_view__inside_rect__to_data__print_info_ (l_objc_class.item, a_view__item, a_rect.item, a_data__item, a_print_info__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pdf_operation_with_view__inside_rect__to_data__print_info_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pdf_operation_with_view__inside_rect__to_data__print_info_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	pdf_operation_with_view__inside_rect__to_path__print_info_ (a_view: detachable NS_VIEW; a_rect: NS_RECT; a_path: detachable NS_STRING; a_print_info: detachable NS_PRINT_INFO): detachable NS_PRINT_OPERATION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_view__item: POINTER
			a_path__item: POINTER
			a_print_info__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			if attached a_print_info as a_print_info_attached then
				a_print_info__item := a_print_info_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_pdf_operation_with_view__inside_rect__to_path__print_info_ (l_objc_class.item, a_view__item, a_rect.item, a_path__item, a_print_info__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pdf_operation_with_view__inside_rect__to_path__print_info_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pdf_operation_with_view__inside_rect__to_path__print_info_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	eps_operation_with_view__inside_rect__to_data__print_info_ (a_view: detachable NS_VIEW; a_rect: NS_RECT; a_data: detachable NS_MUTABLE_DATA; a_print_info: detachable NS_PRINT_INFO): detachable NS_PRINT_OPERATION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_view__item: POINTER
			a_data__item: POINTER
			a_print_info__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			if attached a_print_info as a_print_info_attached then
				a_print_info__item := a_print_info_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_eps_operation_with_view__inside_rect__to_data__print_info_ (l_objc_class.item, a_view__item, a_rect.item, a_data__item, a_print_info__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like eps_operation_with_view__inside_rect__to_data__print_info_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like eps_operation_with_view__inside_rect__to_data__print_info_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	eps_operation_with_view__inside_rect__to_path__print_info_ (a_view: detachable NS_VIEW; a_rect: NS_RECT; a_path: detachable NS_STRING; a_print_info: detachable NS_PRINT_INFO): detachable NS_PRINT_OPERATION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_view__item: POINTER
			a_path__item: POINTER
			a_print_info__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			if attached a_print_info as a_print_info_attached then
				a_print_info__item := a_print_info_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_eps_operation_with_view__inside_rect__to_path__print_info_ (l_objc_class.item, a_view__item, a_rect.item, a_path__item, a_print_info__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like eps_operation_with_view__inside_rect__to_path__print_info_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like eps_operation_with_view__inside_rect__to_path__print_info_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	print_operation_with_view_ (a_view: detachable NS_VIEW): detachable NS_PRINT_OPERATION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_print_operation_with_view_ (l_objc_class.item, a_view__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like print_operation_with_view_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like print_operation_with_view_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	pdf_operation_with_view__inside_rect__to_data_ (a_view: detachable NS_VIEW; a_rect: NS_RECT; a_data: detachable NS_MUTABLE_DATA): detachable NS_PRINT_OPERATION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_view__item: POINTER
			a_data__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_pdf_operation_with_view__inside_rect__to_data_ (l_objc_class.item, a_view__item, a_rect.item, a_data__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pdf_operation_with_view__inside_rect__to_data_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pdf_operation_with_view__inside_rect__to_data_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	eps_operation_with_view__inside_rect__to_data_ (a_view: detachable NS_VIEW; a_rect: NS_RECT; a_data: detachable NS_MUTABLE_DATA): detachable NS_PRINT_OPERATION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_view__item: POINTER
			a_data__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_eps_operation_with_view__inside_rect__to_data_ (l_objc_class.item, a_view__item, a_rect.item, a_data__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like eps_operation_with_view__inside_rect__to_data_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like eps_operation_with_view__inside_rect__to_data_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	current_operation: detachable NS_PRINT_OPERATION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_current_operation (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_operation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_operation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_current_operation_ (a_operation: detachable NS_PRINT_OPERATION)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_operation__item: POINTER
		do
			if attached a_operation as a_operation_attached then
				a_operation__item := a_operation_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_current_operation_ (l_objc_class.item, a_operation__item)
		end

feature {NONE} -- NSPrintOperation Externals

	objc_print_operation_with_view__print_info_ (a_class_object: POINTER; a_view: POINTER; a_print_info: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object printOperationWithView:$a_view printInfo:$a_print_info];
			 ]"
		end

	objc_pdf_operation_with_view__inside_rect__to_data__print_info_ (a_class_object: POINTER; a_view: POINTER; a_rect: POINTER; a_data: POINTER; a_print_info: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object PDFOperationWithView:$a_view insideRect:*((NSRect *)$a_rect) toData:$a_data printInfo:$a_print_info];
			 ]"
		end

	objc_pdf_operation_with_view__inside_rect__to_path__print_info_ (a_class_object: POINTER; a_view: POINTER; a_rect: POINTER; a_path: POINTER; a_print_info: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object PDFOperationWithView:$a_view insideRect:*((NSRect *)$a_rect) toPath:$a_path printInfo:$a_print_info];
			 ]"
		end

	objc_eps_operation_with_view__inside_rect__to_data__print_info_ (a_class_object: POINTER; a_view: POINTER; a_rect: POINTER; a_data: POINTER; a_print_info: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object EPSOperationWithView:$a_view insideRect:*((NSRect *)$a_rect) toData:$a_data printInfo:$a_print_info];
			 ]"
		end

	objc_eps_operation_with_view__inside_rect__to_path__print_info_ (a_class_object: POINTER; a_view: POINTER; a_rect: POINTER; a_path: POINTER; a_print_info: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object EPSOperationWithView:$a_view insideRect:*((NSRect *)$a_rect) toPath:$a_path printInfo:$a_print_info];
			 ]"
		end

	objc_print_operation_with_view_ (a_class_object: POINTER; a_view: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object printOperationWithView:$a_view];
			 ]"
		end

	objc_pdf_operation_with_view__inside_rect__to_data_ (a_class_object: POINTER; a_view: POINTER; a_rect: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object PDFOperationWithView:$a_view insideRect:*((NSRect *)$a_rect) toData:$a_data];
			 ]"
		end

	objc_eps_operation_with_view__inside_rect__to_data_ (a_class_object: POINTER; a_view: POINTER; a_rect: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object EPSOperationWithView:$a_view insideRect:*((NSRect *)$a_rect) toData:$a_data];
			 ]"
		end

	objc_current_operation (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object currentOperation];
			 ]"
		end

	objc_set_current_operation_ (a_class_object: POINTER; a_operation: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setCurrentOperation:$a_operation];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPrintOperation"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
