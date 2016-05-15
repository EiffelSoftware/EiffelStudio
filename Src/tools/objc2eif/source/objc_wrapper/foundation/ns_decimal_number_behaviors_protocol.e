note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_DECIMAL_NUMBER_BEHAVIORS_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

	rounding_mode: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_rounding_mode (item)
		end

	scale: INTEGER_16
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_scale (item)
		end

	exception_during_operation__error__left_operand__right_operand_ (a_operation: detachable OBJC_SELECTOR; a_error: NATURAL_64; a_left_operand: detachable NS_DECIMAL_NUMBER; a_right_operand: detachable NS_DECIMAL_NUMBER): detachable NS_DECIMAL_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_operation__item: POINTER
			a_left_operand__item: POINTER
			a_right_operand__item: POINTER
		do
			if attached a_operation as a_operation_attached then
				a_operation__item := a_operation_attached.item
			end
			if attached a_left_operand as a_left_operand_attached then
				a_left_operand__item := a_left_operand_attached.item
			end
			if attached a_right_operand as a_right_operand_attached then
				a_right_operand__item := a_right_operand_attached.item
			end
			result_pointer := objc_exception_during_operation__error__left_operand__right_operand_ (item, a_operation__item, a_error, a_left_operand__item, a_right_operand__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like exception_during_operation__error__left_operand__right_operand_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like exception_during_operation__error__left_operand__right_operand_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Required Methods Externals

	objc_rounding_mode (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSDecimalNumberBehaviors>)$an_item roundingMode];
			 ]"
		end

	objc_scale (an_item: POINTER): INTEGER_16
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSDecimalNumberBehaviors>)$an_item scale];
			 ]"
		end

	objc_exception_during_operation__error__left_operand__right_operand_ (an_item: POINTER; a_operation: POINTER; a_error: NATURAL_64; a_left_operand: POINTER; a_right_operand: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSDecimalNumberBehaviors>)$an_item exceptionDuringOperation:$a_operation error:$a_error leftOperand:$a_left_operand rightOperand:$a_right_operand];
			 ]"
		end

end
