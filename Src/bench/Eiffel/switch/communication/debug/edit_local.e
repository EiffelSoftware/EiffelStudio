class
	EDIT_LOCAL

inherit
	EDIT_ITEM

creation
	default_create

feature {NONE} -- Implementation of deferred features

	generic_modify_item is
			-- send the first part of the 'modify-local' request
		do
			send_rqst_3(Rqst_modify_local, Application.current_execution_stack_number, item_type, item.item_number)
		end
	
	start_feature is
			-- What to do to initialize the modification of an item.
		do
			stack := Application.status.current_stack_element
			has_result := stack.routine.is_function

			-- FIXME ARNAUD -- To do: a beautiful interface...
			io.put_string("EDIT A LOCAL VARIABLE%N")
			io.put_string("----------------------------%N")
			io.put_string("Type of local item to edit ?%N")
			if stack.arguments /= Void then
				io.put_string("0. Argument%N")
			end
			if stack.locals /= Void then
				io.put_string("1. Local Variable%N")
			end
			if has_result then
				io.put_string("2. Result%N")
			end
			io.readline
			item_type := io.last_string.to_integer
			-- END FIXME

				-- set the place where we should search the name of the item
			inspect item_type
				when Dlt_argument then
					item_list := stack.arguments
				when Dlt_localvar then
					item_list := stack.locals
				else
					item_list := Void
			end

				-- deals with a special case: the Result
			if item_type = Dlt_result then
				item := stack.result_value
			end
		end

	update_display is
			-- update the call stack after local variable modification.
		local
			call_stack_elem: CALL_STACK_ELEMENT
			retry_clause: BOOLEAN
		do
			if not retry_clause then
				status.reload_call_stack
				call_stack_elem := status.current_stack_element
				if call_stack_elem /= Void then
					Project_tool.display_exception_stack
				end
			else -- retry_clause, something went wrong
				if Application.is_running then
					Application.process_termination
				end
			end
		rescue
			-- FIXME ARNAUD
			-- toTo: write a beautiful message box instead of this crappy message
			io.putstring("Error while getting Application callstack. Application will be terminated%N")
			-- END FIXME
			retry_clause := True
			retry
		end

feature {NONE} -- Private variables

	stack: CALL_STACK_ELEMENT
		-- Current call stack element being displayed.

	has_result: BOOLEAN
		-- has the active feature a Result?

	item_type: INTEGER
		-- type of the local item (Dlt_argument or Dlt_localvar or Dlt_result)

feature {NONE} -- Private Constants (defined in eif_debug.h for the run-time side)

	Dlt_argument: INTEGER is 0
	Dlt_localvar: INTEGER is 1
	Dlt_result	: INTEGER is 2

end -- class EDIT_LOCAL
