note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PARAGRAPH_STYLE_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSParagraphStyle

	default_paragraph_style: detachable NS_PARAGRAPH_STYLE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_default_paragraph_style (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like default_paragraph_style} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like default_paragraph_style} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	default_writing_direction_for_language_ (a_language_name: detachable NS_STRING): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_language_name__item: POINTER
		do
			if attached a_language_name as a_language_name_attached then
				a_language_name__item := a_language_name_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_default_writing_direction_for_language_ (l_objc_class.item, a_language_name__item)
		end

feature {NONE} -- NSParagraphStyle Externals

	objc_default_paragraph_style (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object defaultParagraphStyle];
			 ]"
		end

	objc_default_writing_direction_for_language_ (a_class_object: POINTER; a_language_name: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object defaultWritingDirectionForLanguage:$a_language_name];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSParagraphStyle"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
