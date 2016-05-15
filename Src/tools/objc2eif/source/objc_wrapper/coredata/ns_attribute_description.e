note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ATTRIBUTE_DESCRIPTION

inherit
	NS_PROPERTY_DESCRIPTION
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSAttributeDescription

	attribute_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_attribute_type (item)
		end

	set_attribute_type_ (a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_attribute_type_ (item, a_type)
		end

	attribute_value_class_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attribute_value_class_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attribute_value_class_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attribute_value_class_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	default_value: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_default_value (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like default_value} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like default_value} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_default_value_ (a_value: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			objc_set_default_value_ (item, a_value__item)
		end

	set_attribute_value_class_name_ (a_class_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_class_name__item: POINTER
		do
			if attached a_class_name as a_class_name_attached then
				a_class_name__item := a_class_name_attached.item
			end
			objc_set_attribute_value_class_name_ (item, a_class_name__item)
		end

	value_transformer_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_value_transformer_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_transformer_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_transformer_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_value_transformer_name_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_value_transformer_name_ (item, a_string__item)
		end

feature {NONE} -- NSAttributeDescription Externals

	objc_attribute_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSAttributeDescription *)$an_item attributeType];
			 ]"
		end

	objc_set_attribute_type_ (an_item: POINTER; a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSAttributeDescription *)$an_item setAttributeType:$a_type];
			 ]"
		end

	objc_attribute_value_class_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAttributeDescription *)$an_item attributeValueClassName];
			 ]"
		end

	objc_default_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAttributeDescription *)$an_item defaultValue];
			 ]"
		end

	objc_set_default_value_ (an_item: POINTER; a_value: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSAttributeDescription *)$an_item setDefaultValue:$a_value];
			 ]"
		end

	objc_set_attribute_value_class_name_ (an_item: POINTER; a_class_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSAttributeDescription *)$an_item setAttributeValueClassName:$a_class_name];
			 ]"
		end

	objc_value_transformer_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAttributeDescription *)$an_item valueTransformerName];
			 ]"
		end

	objc_set_value_transformer_name_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSAttributeDescription *)$an_item setValueTransformerName:$a_string];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSAttributeDescription"
		end

end
