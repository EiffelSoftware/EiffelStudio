note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCRIPT_COERCION_HANDLER

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

feature -- NSScriptCoercionHandler

	coerce_value__to_class_ (a_value: detachable NS_OBJECT; a_to_class: detachable OBJC_CLASS): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_value__item: POINTER
			a_to_class__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			if attached a_to_class as a_to_class_attached then
				a_to_class__item := a_to_class_attached.item
			end
			result_pointer := objc_coerce_value__to_class_ (item, a_value__item, a_to_class__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like coerce_value__to_class_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like coerce_value__to_class_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	register_coercer__selector__to_convert_from_class__to_class_ (a_coercer: detachable NS_OBJECT; a_selector: detachable OBJC_SELECTOR; a_from_class: detachable OBJC_CLASS; a_to_class: detachable OBJC_CLASS)
			-- Auto generated Objective-C wrapper.
		local
			a_coercer__item: POINTER
			a_selector__item: POINTER
			a_from_class__item: POINTER
			a_to_class__item: POINTER
		do
			if attached a_coercer as a_coercer_attached then
				a_coercer__item := a_coercer_attached.item
			end
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_from_class as a_from_class_attached then
				a_from_class__item := a_from_class_attached.item
			end
			if attached a_to_class as a_to_class_attached then
				a_to_class__item := a_to_class_attached.item
			end
			objc_register_coercer__selector__to_convert_from_class__to_class_ (item, a_coercer__item, a_selector__item, a_from_class__item, a_to_class__item)
		end

feature {NONE} -- NSScriptCoercionHandler Externals

	objc_coerce_value__to_class_ (an_item: POINTER; a_value: POINTER; a_to_class: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCoercionHandler *)$an_item coerceValue:$a_value toClass:$a_to_class];
			 ]"
		end

	objc_register_coercer__selector__to_convert_from_class__to_class_ (an_item: POINTER; a_coercer: POINTER; a_selector: POINTER; a_from_class: POINTER; a_to_class: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptCoercionHandler *)$an_item registerCoercer:$a_coercer selector:$a_selector toConvertFromClass:$a_from_class toClass:$a_to_class];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScriptCoercionHandler"
		end

end
