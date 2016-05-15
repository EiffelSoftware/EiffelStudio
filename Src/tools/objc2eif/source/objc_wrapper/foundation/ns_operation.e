note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OPERATION

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

feature -- NSOperation

	start
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_start (item)
		end

	main
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_main (item)
		end

	is_cancelled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_cancelled (item)
		end

	cancel
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_cancel (item)
		end

	is_executing: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_executing (item)
		end

	is_finished: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_finished (item)
		end

	is_concurrent: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_concurrent (item)
		end

	is_ready: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_ready (item)
		end

	add_dependency_ (a_op: detachable NS_OPERATION)
			-- Auto generated Objective-C wrapper.
		local
			a_op__item: POINTER
		do
			if attached a_op as a_op_attached then
				a_op__item := a_op_attached.item
			end
			objc_add_dependency_ (item, a_op__item)
		end

	remove_dependency_ (a_op: detachable NS_OPERATION)
			-- Auto generated Objective-C wrapper.
		local
			a_op__item: POINTER
		do
			if attached a_op as a_op_attached then
				a_op__item := a_op_attached.item
			end
			objc_remove_dependency_ (item, a_op__item)
		end

	dependencies: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_dependencies (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dependencies} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dependencies} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	queue_priority: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_queue_priority (item)
		end

	set_queue_priority_ (a_p: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_queue_priority_ (item, a_p)
		end

--	completion_block: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			Result := objc_completion_block (item)
--		end

--	set_completion_block_ (a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_set_completion_block_ (item, )
--		end

	wait_until_finished
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_wait_until_finished (item)
		end

	thread_priority: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_thread_priority (item)
		end

	set_thread_priority_ (a_p: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_thread_priority_ (item, a_p)
		end

feature {NONE} -- NSOperation Externals

	objc_start (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSOperation *)$an_item start];
			 ]"
		end

	objc_main (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSOperation *)$an_item main];
			 ]"
		end

	objc_is_cancelled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSOperation *)$an_item isCancelled];
			 ]"
		end

	objc_cancel (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSOperation *)$an_item cancel];
			 ]"
		end

	objc_is_executing (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSOperation *)$an_item isExecuting];
			 ]"
		end

	objc_is_finished (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSOperation *)$an_item isFinished];
			 ]"
		end

	objc_is_concurrent (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSOperation *)$an_item isConcurrent];
			 ]"
		end

	objc_is_ready (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSOperation *)$an_item isReady];
			 ]"
		end

	objc_add_dependency_ (an_item: POINTER; a_op: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSOperation *)$an_item addDependency:$a_op];
			 ]"
		end

	objc_remove_dependency_ (an_item: POINTER; a_op: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSOperation *)$an_item removeDependency:$a_op];
			 ]"
		end

	objc_dependencies (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOperation *)$an_item dependencies];
			 ]"
		end

	objc_queue_priority (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSOperation *)$an_item queuePriority];
			 ]"
		end

	objc_set_queue_priority_ (an_item: POINTER; a_p: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSOperation *)$an_item setQueuePriority:$a_p];
			 ]"
		end

--	objc_completion_block (an_item: POINTER): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSOperation *)$an_item completionBlock];
--			 ]"
--		end

--	objc_set_completion_block_ (an_item: POINTER; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSOperation *)$an_item setCompletionBlock:];
--			 ]"
--		end

	objc_wait_until_finished (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSOperation *)$an_item waitUntilFinished];
			 ]"
		end

	objc_thread_priority (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSOperation *)$an_item threadPriority];
			 ]"
		end

	objc_set_thread_priority_ (an_item: POINTER; a_p: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSOperation *)$an_item setThreadPriority:$a_p];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSOperation"
		end

end
