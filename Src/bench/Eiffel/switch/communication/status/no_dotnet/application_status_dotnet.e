indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_STATUS_DOTNET

inherit
	APPLICATION_STATUS
		
feature -- Class stack creation

	new_current_callstack_with (a_stack_max_depth: INTEGER): EIFFEL_CALL_STACK is
		do
		end

feature -- Values

	current_stack_element_dotnet: CALL_STACK_ELEMENT_DOTNET is
		do
		end
		
	current_call_stack_element_dotnet: CALL_STACK_ELEMENT_DOTNET is
		do
		end

	refresh_current_thread_id is
		do
		end

end -- class APPLICATION_STATUS_DOTNET
