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

	is_eiffel_call_stack_element: BOOLEAN is
		do
		end

	current_object: ABSTRACT_DEBUG_VALUE is
			-- Current object value
		do
		end

	object_address: STRING

	display_object_address: like object_address
			
feature -- Dotnet Properties

	dotnet_module_name: STRING is
		do
		end

	dotnet_module_filename: STRING is
		do
		end
		
feature
	
	display_feature (st: STRUCTURED_TEXT) is
			-- Display information about associated routine.
		do
		end
		
	display_locals (st: STRUCTURED_TEXT) is
			-- Display the local entities and result (if it exists) of
			-- the routine associated with Current call.
		do
		end		
		
	display_arguments (st: STRUCTURED_TEXT) is
			-- Display the arguments passed to the routine
			-- associated with Current call.
		do
		end		

end -- class CALL_STACK_ELEMENT_DOTNET

