indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_STATUS_CLASSIC

inherit
	APPLICATION_STATUS
		redefine
			call_stack
		end
		
create {APPLICATION_STATUS_EXPORTER}

	make
	
feature {NONE} -- Initialization

	make is
			-- Create Current
		do
			initialize
		end		

feature {STOPPED_HDLR} -- Initialization

	set (n: STRING; obj: STRING; ot, dt, offs, reas: INTEGER) is
			-- Set the various attributes identifying current 
			-- position in source code.
		local
--			stack_num: INTEGER
			cont_request: EWB_REQUEST
			ccs: EIFFEL_CALL_STACK_CLASSIC
		do
			object_address := obj
			reason := reas

			if (reason /= Pg_new_breakpoint) then
					-- Compute class type.
				dynamic_class := Eiffel_system.class_of_dynamic_id (dt)
	
					-- Compute origin class type
				origin_class := Eiffel_system.class_of_dynamic_id (ot)
				
					-- Compute feature (E_FEATURE)
					--|Note: the applicaiton sends us the original name.
				e_feature := origin_class.feature_with_name (n)
				body_index := e_feature.body_index
	
					-- Compute break position.
				break_index := offs
		
					-- create the call stack
				create ccs.dummy_make
				set_call_stack (current_thread_id, ccs)
	
--				stack_num := Application.current_execution_stack_number
--				if stack_num > ccs.count then
--					stack_num := ccs.count
--				end
--				Application.set_current_execution_stack (stack_num)
			else
				-- application has stopped to take into account the
				-- new breakpoints. So let's send the new breakpoints
				-- to the application and resume it.
				cont_request := Application.imp_classic.cont_request
				cont_request.send_breakpoints
				set_is_stopped (False)
				cont_request.send_rqst_3 (Rqst_resume, Resume_cont, Application.interrupt_number, application.critical_stack_depth)
			end

		ensure
			valid_break_index: break_index > 0
			valid_efeature: e_feature /= Void
		end

feature -- Class stack creation

	create_current_callstack_with (a_stack_max_depth: INTEGER) is
			-- Create Eiffel Callstack with a maximum depth of `a_stack_max_depth'
		local
			ecs: EIFFEL_CALL_STACK_CLASSIC
		do
			create ecs.make (a_stack_max_depth)
			set_call_stack (current_thread_id, ecs)
		end		

feature -- Values

	call_stack (tid: INTEGER): EIFFEL_CALL_STACK_CLASSIC is
			-- Eiffel call stack
		do
			Result ?= Precursor {APPLICATION_STATUS} (tid)
		end

end -- class APPLICATION_STATUS_CLASSIC
