indexing
	description	: "Controls execution of debugged application under dotnet."
	date		: "$Date$"
	revision	: "$Revision$"

class APPLICATION_EXECUTION_DOTNET

inherit
	APPLICATION_EXECUTION_IMP
		redefine
			make
		end

create {SHARED_APPLICATION_EXECUTION}
	make
	
feature {SHARED_APPLICATION_EXECUTION} -- Initialization
	
	make is
			-- 
		do
		end

feature {APPLICATION_EXECUTION} -- load and save

	load_dotnet_debug_info is
			-- Load debug information (so far only the breakpoints)
		do
		end		

feature -- Properties

	status: APPLICATION_STATUS_DOTNET is
			-- Status of the running dotnet application
		do
			Result ?= Application.status
		end
		
feature {APPLICATION_EXECUTION} -- Properties

	is_valid_object_address (addr: STRING): BOOLEAN is
			-- Is object address `addr' valid?
			-- (i.e Does bench know about it)
		do
		end

feature -- Trigger eStudio done

	callback_notification_processed: BOOLEAN		
	
feature -- Bridge to Debugger

	exception_occured: BOOLEAN is
			-- Last callback is about exception ?
		do
		end

	exception_handled: BOOLEAN is
			-- Last Exception is handled ?
			-- if True => first chance
			-- if False => The execution will terminate after.
		do
		end

	exception_message: STRING is
		do
		end
		
	exception_details: TUPLE [STRING, STRING] is
			-- class details , module details
		do
		end

	exception_to_string: STRING is
			-- Exception to String
		do
		end

	string_value_from_string_class_object_value (icd_string_instance: ANY): STRING is
			-- String value of the `icd_string_instance'.
		do
		end
		
	debug_output_value_from_object_value (a_icd: ANY; a_icd_obj: ANY; 
										a_frame: ANY; a_class_type: ANY): STRING is
			-- Debug_output string value.			
		do
		end

feature -- Bridge to Debugger

	eifnet_debugger: EIFNET_DEBUGGER
			-- Access to the Dotnet Debugger
	
feature -- Execution

	run (args, cwd: STRING) is
			-- Run application with arguments `args' in directory `cwd'.
			-- If `is_running' is false after the
			-- execution of this routine, it means that
			-- the application was unable to be launched
			-- due to the time_out (see `eiffel_timeout_message').
			-- Before running the application you must check
			-- to see if the debugged information is up to date.
		do
		end

	continue (kept_objects: LINKED_SET [STRING]) is
			-- Continue the running of the application and keep the 
			-- objects addresses in `kept_objects'. Objects that are not in 
			-- `kept_objects' will be removed and will be not under the 
			-- control of bench. Therefore, these addresses cannot be
			-- referenced the next time we stop the application.
		do
		end

	interrupt is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
		do	
		end

	notify_newbreakpoint is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
			-- in order to record the new breakpoint(s) before
			-- automatically resuming its execution.
		do
		end		

	kill is
			-- Ask the application to terminate itself.
		do
		end

	process_termination is
			-- Process the termination of the executed
			-- application. Also execute the `termination_command'.
		do
		end

feature -- Object Keeper

	keep_object (adv: ABSTRACT_DEBUG_VALUE) is
		do
		end

	remove_kept_object_by_address (add: STRING) is
		do
		end

	recycle_kept_object is
		do
		end

	keep_only_objects (a_addresses: LIST [STRING]) is
		do
		end

	kept_object_item (a_address: STRING): ABSTRACT_DEBUG_VALUE is
		do
		end

	know_about_kept_object (a_address: STRING): BOOLEAN is
		do
		end		

end -- class APPLICATION_EXECUTION_DOTNET
