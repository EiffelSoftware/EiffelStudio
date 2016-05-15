note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BLOCK_OPERATION_UTILS

inherit
	NS_OPERATION_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSBlockOperation

--	block_operation_with_block_ (a_block: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--		do
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_block_operation_with_block_ (l_objc_class.item, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like block_operation_with_block_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like block_operation_with_block_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSBlockOperation Externals

--	objc_block_operation_with_block_ (a_class_object: POINTER; a_block: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object blockOperationWithBlock:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSBlockOperation"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
