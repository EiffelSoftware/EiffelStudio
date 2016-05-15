note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DECIMAL_NUMBER_HANDLER_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSDecimalNumberHandler

	default_decimal_number_handler: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_default_decimal_number_handler (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like default_decimal_number_handler} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like default_decimal_number_handler} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decimal_number_handler_with_rounding_mode__scale__raise_on_exactness__raise_on_overflow__raise_on_underflow__raise_on_divide_by_zero_ (a_rounding_mode: NATURAL_64; a_scale: INTEGER_16; a_exact: BOOLEAN; a_overflow: BOOLEAN; a_underflow: BOOLEAN; a_divide_by_zero: BOOLEAN): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_decimal_number_handler_with_rounding_mode__scale__raise_on_exactness__raise_on_overflow__raise_on_underflow__raise_on_divide_by_zero_ (l_objc_class.item, a_rounding_mode, a_scale, a_exact, a_overflow, a_underflow, a_divide_by_zero)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_number_handler_with_rounding_mode__scale__raise_on_exactness__raise_on_overflow__raise_on_underflow__raise_on_divide_by_zero_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_number_handler_with_rounding_mode__scale__raise_on_exactness__raise_on_overflow__raise_on_underflow__raise_on_divide_by_zero_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSDecimalNumberHandler Externals

	objc_default_decimal_number_handler (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object defaultDecimalNumberHandler];
			 ]"
		end

	objc_decimal_number_handler_with_rounding_mode__scale__raise_on_exactness__raise_on_overflow__raise_on_underflow__raise_on_divide_by_zero_ (a_class_object: POINTER; a_rounding_mode: NATURAL_64; a_scale: INTEGER_16; a_exact: BOOLEAN; a_overflow: BOOLEAN; a_underflow: BOOLEAN; a_divide_by_zero: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object decimalNumberHandlerWithRoundingMode:$a_rounding_mode scale:$a_scale raiseOnExactness:$a_exact raiseOnOverflow:$a_overflow raiseOnUnderflow:$a_underflow raiseOnDivideByZero:$a_divide_by_zero];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDecimalNumberHandler"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
