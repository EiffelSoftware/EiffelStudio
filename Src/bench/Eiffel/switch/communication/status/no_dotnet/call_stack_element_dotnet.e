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

feature -- Properties

	routine: E_FEATURE
			-- Routine being called
			-- Note from Arnaud: Computation has been deferred for optimisation purpose

	result_value: ABSTRACT_DEBUG_VALUE is
			-- Result value of routine
		do
		end

	current_object: ABSTRACT_DEBUG_VALUE is
			-- Current object value
		do
		end

	locals: LIST [ABSTRACT_DEBUG_VALUE] is
			-- Value of local variables
		do
		end

	arguments: LIST [ABSTRACT_DEBUG_VALUE] is
			-- Value of arguments
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
			
feature -- Dotnet Properties

	dotnet_module_name: STRING is
		do
		end

feature -- Output

	display_arguments (st: STRUCTURED_TEXT) is
			-- Display the arguments passed to the routine
			-- associated with Current call.
		do
		end

	display_locals (st: STRUCTURED_TEXT) is
			-- Display the local entities and result (if it exists) of 
			-- the routine associated with Current call.
		do
		end

	display_feature (st: STRUCTURED_TEXT) is
			-- Display information about associated routine.
		do
		end

end -- class CALL_STACK_ELEMENT_DOTNET

