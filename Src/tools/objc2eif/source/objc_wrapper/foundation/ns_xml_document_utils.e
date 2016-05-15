note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_XML_DOCUMENT_UTILS

inherit
	NS_XML_NODE_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSXMLDocument

	replacement_class_for_class_ (a_cls: detachable OBJC_CLASS): detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_cls__item: POINTER
		do
			if attached a_cls as a_cls_attached then
				a_cls__item := a_cls_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_replacement_class_for_class_ (l_objc_class.item, a_cls__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like replacement_class_for_class_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like replacement_class_for_class_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSXMLDocument Externals

	objc_replacement_class_for_class_ (a_class_object: POINTER; a_cls: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object replacementClassForClass:$a_cls];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSXMLDocument"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
