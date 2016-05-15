note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_VALUE_TRANSFORMER

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

feature -- NSValueTransformer

	transformed_value_ (a_value: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_value__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			result_pointer := objc_transformed_value_ (item, a_value__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like transformed_value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like transformed_value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	reverse_transformed_value_ (a_value: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_value__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			result_pointer := objc_reverse_transformed_value_ (item, a_value__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like reverse_transformed_value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like reverse_transformed_value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSValueTransformer Externals

	objc_transformed_value_ (an_item: POINTER; a_value: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSValueTransformer *)$an_item transformedValue:$a_value];
			 ]"
		end

	objc_reverse_transformed_value_ (an_item: POINTER; a_value: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSValueTransformer *)$an_item reverseTransformedValue:$a_value];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSValueTransformer"
		end

end
