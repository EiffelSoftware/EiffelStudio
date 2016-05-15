note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_VALUE_TRANSFORMER_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSValueTransformer

	set_value_transformer__for_name_ (a_transformer: detachable NS_VALUE_TRANSFORMER; a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_transformer__item: POINTER
			a_name__item: POINTER
		do
			if attached a_transformer as a_transformer_attached then
				a_transformer__item := a_transformer_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_value_transformer__for_name_ (l_objc_class.item, a_transformer__item, a_name__item)
		end

	value_transformer_for_name_ (a_name: detachable NS_STRING): detachable NS_VALUE_TRANSFORMER
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
			result_pointer := objc_value_transformer_for_name_ (l_objc_class.item, a_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_transformer_for_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_transformer_for_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	value_transformer_names: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_value_transformer_names (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_transformer_names} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_transformer_names} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	transformed_value_class: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_transformed_value_class (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like transformed_value_class} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like transformed_value_class} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	allows_reverse_transformation: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_allows_reverse_transformation (l_objc_class.item)
		end

feature {NONE} -- NSValueTransformer Externals

	objc_set_value_transformer__for_name_ (a_class_object: POINTER; a_transformer: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object setValueTransformer:$a_transformer forName:$a_name];
			 ]"
		end

	objc_value_transformer_for_name_ (a_class_object: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object valueTransformerForName:$a_name];
			 ]"
		end

	objc_value_transformer_names (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object valueTransformerNames];
			 ]"
		end

	objc_transformed_value_class (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object transformedValueClass];
			 ]"
		end

	objc_allows_reverse_transformation (a_class_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object allowsReverseTransformation];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSValueTransformer"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
