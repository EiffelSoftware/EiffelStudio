note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OPERATION_QUEUE

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

feature -- NSOperationQueue

	add_operation_ (a_op: detachable NS_OPERATION)
			-- Auto generated Objective-C wrapper.
		local
			a_op__item: POINTER
		do
			if attached a_op as a_op_attached then
				a_op__item := a_op_attached.item
			end
			objc_add_operation_ (item, a_op__item)
		end

	add_operations__wait_until_finished_ (a_ops: detachable NS_ARRAY; a_wait: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_ops__item: POINTER
		do
			if attached a_ops as a_ops_attached then
				a_ops__item := a_ops_attached.item
			end
			objc_add_operations__wait_until_finished_ (item, a_ops__item, a_wait)
		end

--	add_operation_with_block_ (a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_add_operation_with_block_ (item, )
--		end

	operations: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_operations (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like operations} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like operations} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	operation_count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_operation_count (item)
		end

	max_concurrent_operation_count: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_max_concurrent_operation_count (item)
		end

	set_max_concurrent_operation_count_ (a_cnt: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_max_concurrent_operation_count_ (item, a_cnt)
		end

	set_suspended_ (a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_suspended_ (item, a_b)
		end

	is_suspended: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_suspended (item)
		end

	set_name_ (a_n: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_n__item: POINTER
		do
			if attached a_n as a_n_attached then
				a_n__item := a_n_attached.item
			end
			objc_set_name_ (item, a_n__item)
		end

	name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	cancel_all_operations
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_cancel_all_operations (item)
		end

	wait_until_all_operations_are_finished
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_wait_until_all_operations_are_finished (item)
		end

feature {NONE} -- NSOperationQueue Externals

	objc_add_operation_ (an_item: POINTER; a_op: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSOperationQueue *)$an_item addOperation:$a_op];
			 ]"
		end

	objc_add_operations__wait_until_finished_ (an_item: POINTER; a_ops: POINTER; a_wait: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSOperationQueue *)$an_item addOperations:$a_ops waitUntilFinished:$a_wait];
			 ]"
		end

--	objc_add_operation_with_block_ (an_item: POINTER; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSOperationQueue *)$an_item addOperationWithBlock:];
--			 ]"
--		end

	objc_operations (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOperationQueue *)$an_item operations];
			 ]"
		end

	objc_operation_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSOperationQueue *)$an_item operationCount];
			 ]"
		end

	objc_max_concurrent_operation_count (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSOperationQueue *)$an_item maxConcurrentOperationCount];
			 ]"
		end

	objc_set_max_concurrent_operation_count_ (an_item: POINTER; a_cnt: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSOperationQueue *)$an_item setMaxConcurrentOperationCount:$a_cnt];
			 ]"
		end

	objc_set_suspended_ (an_item: POINTER; a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSOperationQueue *)$an_item setSuspended:$a_b];
			 ]"
		end

	objc_is_suspended (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSOperationQueue *)$an_item isSuspended];
			 ]"
		end

	objc_set_name_ (an_item: POINTER; a_n: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSOperationQueue *)$an_item setName:$a_n];
			 ]"
		end

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOperationQueue *)$an_item name];
			 ]"
		end

	objc_cancel_all_operations (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSOperationQueue *)$an_item cancelAllOperations];
			 ]"
		end

	objc_wait_until_all_operations_are_finished (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSOperationQueue *)$an_item waitUntilAllOperationsAreFinished];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSOperationQueue"
		end

end
