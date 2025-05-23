note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PRINT_INFO_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSPrintInfo

	set_shared_print_info_ (a_print_info: detachable NS_PRINT_INFO)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_print_info__item: POINTER
		do
			if attached a_print_info as a_print_info_attached then
				a_print_info__item := a_print_info_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_shared_print_info_ (l_objc_class.item, a_print_info__item)
		end

	shared_print_info: detachable NS_PRINT_INFO
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_shared_print_info (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like shared_print_info} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like shared_print_info} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	default_printer: detachable NS_PRINTER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_default_printer (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like default_printer} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like default_printer} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPrintInfo Externals

	objc_set_shared_print_info_ (a_class_object: POINTER; a_print_info: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setSharedPrintInfo:$a_print_info];
			 ]"
		end

	objc_shared_print_info (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object sharedPrintInfo];
			 ]"
		end

	objc_default_printer (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object defaultPrinter];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPrintInfo"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
