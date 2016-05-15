note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NUMBER_FORMATTER_UTILS

inherit
	NS_FORMATTER_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSNumberFormatter

	localized_string_from_number__number_style_ (a_num: detachable NS_NUMBER; a_nstyle: NATURAL_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_num__item: POINTER
		do
			if attached a_num as a_num_attached then
				a_num__item := a_num_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_localized_string_from_number__number_style_ (l_objc_class.item, a_num__item, a_nstyle)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_string_from_number__number_style_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_string_from_number__number_style_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
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

feature {NONE} -- NSNumberFormatter Externals

	objc_localized_string_from_number__number_style_ (a_class_object: POINTER; a_num: POINTER; a_nstyle: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object localizedStringFromNumber:$a_num numberStyle:$a_nstyle];
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
			Result := "NSNumberFormatter"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
