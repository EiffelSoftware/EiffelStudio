indexing
	description	: "Information about a call in the calling stack."
	date		: "$Date$"
	revision	: "$Revision $"

class CALL_STACK_ELEMENT_DOTNET

inherit
	
	CALL_STACK_ELEMENT

feature {NONE} -- Initialization

	make (level: INTEGER) is
		do
		end

feature
	initialize_stack is
		do
		end

feature -- Properties

	routine: E_FEATURE
			-- Routine being called
			-- Note from Arnaud: Computation has been deferred for optimisation purpose

	current_object: ABSTRACT_DEBUG_VALUE is
			-- Current object value
		do
		end

	object_address: STRING
			-- Hector address of associated object 
			--| Because the debugger is already in communication with
			--| the application (retrieving information such as locals ...)
			--| it doesn't ask an hector address for that object until
			--| the "line" between the two processes is free.
			--| Initialially it is the physical address but is then
			--| protected in the `set_hector_addr_for_current_object' routine.

	display_object_address: like object_address
			
feature -- Dotnet Properties

	dotnet_module_name: STRING is
		do
		end

	dotnet_module_filename: STRING is
		do
		end

end -- class CALL_STACK_ELEMENT_DOTNET

