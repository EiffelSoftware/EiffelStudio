indexing
	description	: "Information about a call in the calling stack."
	date		: "$Date$"
	revision	: "$Revision $"

deferred class CALL_STACK_ELEMENT

inherit

	COMPILER_EXPORTER

	SHARED_EIFFEL_PROJECT

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (level: INTEGER) is
		require
			valid_level: level >= 1
		deferred
		end
	
feature -- Properties

	class_name: STRING
			-- Associated class name

	routine_name: STRING
			-- Associated routine name

	level_in_stack: INTEGER
			-- Where is this element situated in the call stack?
			-- 1 means on the top.

	break_index: INTEGER
			-- the "Line number" where application is stopped within current feature

	object_address: STRING is
			-- Hector address of associated object 
			--| Because the debugger is already in communication with
			--| the application (retrieving information such as locals ...)
			--| it doesn't ask an hector address for that object until
			--| the "line" between the two processes is free.
			--| Initialially it is the physical address but is then
			--| protected in the `set_hector_addr_for_current_object' routine.
		deferred
		end

feature -- Output

	display_arguments (st: STRUCTURED_TEXT) is
			-- Display the arguments passed to the routine
			-- associated with Current call.
		deferred
		end

	display_locals (st: STRUCTURED_TEXT) is
			-- Display the local entities and result (if it exists) of 
			-- the routine associated with Current call.
		deferred
		end
		
	display_feature (st: STRUCTURED_TEXT) is
			-- Display information about associated routine.
		deferred
		end

	display_object_address: like object_address is
		deferred
		end

end -- class CALL_STACK_ELEMENT
