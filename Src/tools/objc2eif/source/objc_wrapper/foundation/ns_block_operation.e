note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BLOCK_OPERATION

inherit
	NS_OPERATION
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSBlockOperation

--	add_execution_block_ (a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_add_execution_block_ (item, )
--		end

	execution_blocks: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_execution_blocks (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like execution_blocks} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like execution_blocks} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSBlockOperation Externals

--	objc_add_execution_block_ (an_item: POINTER; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSBlockOperation *)$an_item addExecutionBlock:];
--			 ]"
--		end

	objc_execution_blocks (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBlockOperation *)$an_item executionBlocks];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSBlockOperation"
		end

end
