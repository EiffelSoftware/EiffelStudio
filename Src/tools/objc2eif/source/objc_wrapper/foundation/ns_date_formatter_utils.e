note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DATE_FORMATTER_UTILS

inherit
	NS_FORMATTER_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSDateFormatter

	localized_string_from_date__date_style__time_style_ (a_date: detachable NS_DATE; a_dstyle: NATURAL_64; a_tstyle: NATURAL_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_localized_string_from_date__date_style__time_style_ (l_objc_class.item, a_date__item, a_dstyle, a_tstyle)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_string_from_date__date_style__time_style_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_string_from_date__date_style__time_style_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	date_format_from_template__options__locale_ (a_tmplate: detachable NS_STRING; a_opts: NATURAL_64; a_locale: detachable NS_LOCALE): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_tmplate__item: POINTER
			a_locale__item: POINTER
		do
			if attached a_tmplate as a_tmplate_attached then
				a_tmplate__item := a_tmplate_attached.item
			end
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_date_format_from_template__options__locale_ (l_objc_class.item, a_tmplate__item, a_opts, a_locale__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like date_format_from_template__options__locale_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like date_format_from_template__options__locale_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	default_formatter_behavior: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_default_formatter_behavior (l_objc_class.item)
		end

	set_default_formatter_behavior_ (a_behavior: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_default_formatter_behavior_ (l_objc_class.item, a_behavior)
		end

feature {NONE} -- NSDateFormatter Externals

	objc_localized_string_from_date__date_style__time_style_ (a_class_object: POINTER; a_date: POINTER; a_dstyle: NATURAL_64; a_tstyle: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object localizedStringFromDate:$a_date dateStyle:$a_dstyle timeStyle:$a_tstyle];
			 ]"
		end

	objc_date_format_from_template__options__locale_ (a_class_object: POINTER; a_tmplate: POINTER; a_opts: NATURAL_64; a_locale: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dateFormatFromTemplate:$a_tmplate options:$a_opts locale:$a_locale];
			 ]"
		end

	objc_default_formatter_behavior (a_class_object: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object defaultFormatterBehavior];
			 ]"
		end

	objc_set_default_formatter_behavior_ (a_class_object: POINTER; a_behavior: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object setDefaultFormatterBehavior:$a_behavior];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDateFormatter"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
