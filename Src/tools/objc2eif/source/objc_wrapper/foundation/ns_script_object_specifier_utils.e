note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCRIPT_OBJECT_SPECIFIER_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSScriptObjectSpecifier

	object_specifier_with_descriptor_ (a_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR): detachable NS_SCRIPT_OBJECT_SPECIFIER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_descriptor__item: POINTER
		do
			if attached a_descriptor as a_descriptor_attached then
				a_descriptor__item := a_descriptor_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_object_specifier_with_descriptor_ (l_objc_class.item, a_descriptor__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_specifier_with_descriptor_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_specifier_with_descriptor_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSScriptObjectSpecifier Externals

	objc_object_specifier_with_descriptor_ (a_class_object: POINTER; a_descriptor: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object objectSpecifierWithDescriptor:$a_descriptor];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScriptObjectSpecifier"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
