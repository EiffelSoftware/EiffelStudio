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

--create {EIFFEL_CALL_STACK}
--	make
--create {STOPPED_HDLR,APPLICATION_EXECUTION}
--	dummy_make

feature {NONE} -- Initialization

	make (level: INTEGER) is
		require
			valid_level: level >= 1
		deferred
		end
	
feature -- Properties

	routine_name: STRING
			-- Associated routine name

	level_in_stack: INTEGER
			-- Where is this element situated in the call stack?
			-- 1 means on the top.

	body_index: INTEGER is
			-- body index of the associated routine
		do
			if private_body_index = -1 then
				private_body_index := routine.body_index
			end
			Result := private_body_index
		end			

	is_melted: BOOLEAN
			-- Is the associated routine melted.
			-- Only in that case can we request the locals
			-- and the arguments.

	break_index: INTEGER
			-- the "Line number" where application is stopped within current feature

	dynamic_class: CLASS_C
			-- Dynamic class where routine is called from

	origin_class: CLASS_C
			-- Class where routine is written in

	routine: E_FEATURE is
			-- Routine being called
			-- Note from Arnaud: Computation has been deferred for optimisation purpose
		deferred
		end
		
	result_value: ABSTRACT_DEBUG_VALUE is
			-- Result value of routine
		deferred
		ensure
			is_function_non_void: routine.is_function implies Result /= Void
		end

	locals: LIST [ABSTRACT_DEBUG_VALUE] is
			-- Value of local variables
		deferred
		ensure
			non_void_implies_not_empty: Result /= Void implies not Result.is_empty
		end

	arguments: LIST [ABSTRACT_DEBUG_VALUE] is
			-- Value of arguments
		deferred
		ensure
			non_void_implies_not_empty: Result /= Void implies not Result.is_empty
		end

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

feature {NONE} -- Implementation Properties

	private_body_index: like body_index
			-- Associated body index		

invariant
--
--	non_empty_args_if_exists: private_arguments /= Void implies 
--				not private_arguments.is_empty
--	non_empty_locs_if_exists: private_locals /= Void implies 
--				not private_locals.is_empty
--	valid_level: level_in_stack >= 1

end -- class CALL_STACK_ELEMENT
