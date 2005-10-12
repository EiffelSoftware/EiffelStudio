indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_STATUS_DOTNET

inherit
	APPLICATION_STATUS
	
create
	make
		
feature -- Class stack creation

	new_current_callstack_with (a_stack_max_depth: INTEGER): EIFFEL_CALL_STACK is
		do
		end

feature -- Values
		
	current_call_stack_element_dotnet: CALL_STACK_ELEMENT_DOTNET is
		do
		end

	refresh_current_thread_id is
		do
		end
		
	exception_debug_value: ABSTRACT_DEBUG_VALUE	 is do end	
		
	exception_to_string, 
	exception_module_name, 
	exception_class_name: STRING is do end
		
	exception_handled: BOOLEAN is False
	
	exception_occurred: BOOLEAN is False
	
	exception_message: STRING is do end	

end -- class APPLICATION_STATUS_DOTNET
