indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_STATUS_DOTNET

inherit
	APPLICATION_STATUS
		redefine
			display_status,
			current_call_stack_element,
			current_call_stack,
			update,
			set_current_thread_id
		end
		
	EIFNET_DEBUGGER_INFO_ACCESSOR

create {APPLICATION_STATUS_EXPORTER}

	make
	
feature {NONE} -- Initialization

	make is
			-- Create Current
		do
			initialize
		end	
	
feature {APPLICATION_STATUS_EXPORTER} -- Initialization

	set_top_level is -- (n: STRING; obj: STRING; ot, dt, offs, reas: INTEGER) is
			-- Set the various attributes identifying current 
			-- position in source code.
		local
			l_curr_mod_name: STRING
			l_curr_class_tok, l_curr_feature_tok: INTEGER
			l_curr_il_offset: INTEGER
			l_dyn_class_type: CLASS_TYPE
			l_feature_i: FEATURE_I
			
			l_current_stack_info: EIFNET_DEBUGGER_STACK_INFO
		do
			Eifnet_debugger_info.init_current_callstack
			l_current_stack_info := Eifnet_debugger_info.current_stack_info
			if l_current_stack_info.is_synchronized then
				l_curr_mod_name := l_current_stack_info.current_module_name
				l_curr_class_tok := l_current_stack_info.current_class_token
				l_curr_feature_tok := l_current_stack_info.current_feature_token
				if Il_debug_info_recorder.has_info_about_module (l_curr_mod_name) then
					l_dyn_class_type := Il_debug_info_recorder.class_type_for_module_class_token (l_curr_mod_name, l_curr_class_tok)
					l_feature_i := Il_debug_info_recorder.feature_i_by_module_feature_token (l_curr_mod_name, l_curr_feature_tok)
					if l_dyn_class_type /= Void then
						dynamic_class := l_dyn_class_type.associated_class				
				
						if l_feature_i /= Void then
							e_feature := l_feature_i.e_feature
							body_index := e_feature.body_index
							origin_class := l_feature_i.written_class
			
							l_curr_il_offset := l_current_stack_info.current_il_offset			
							break_index := Il_debug_info_recorder.feature_eiffel_breakable_line_for_il_offset (l_dyn_class_type, l_feature_i, l_curr_il_offset)
						end
					end						
				else
					l_dyn_class_type := Void
					l_feature_i := Void					
				end
				object_address := l_current_stack_info.current_stack_address					
			end
		end
	
feature -- Values

	is_evaluating: BOOLEAN
			-- Is the debugged application evaluating expression ?	

feature -- Update

	update is
			-- Update data once the application is really stopped
		do
			if application.imp_dotnet.exception_occurred and is_stopped then
				exception_tag := application.imp_dotnet.exception_message			
			end
		end
		
feature -- settings

	set_is_evaluating (b: BOOLEAN) is
			-- set is_evaluating to `b'
		do
			is_evaluating := b
		end
		
feature -- Output
	
	display_status (st: STRUCTURED_TEXT) is
			-- Display status of debugged system
		do
			check
				il_generation: Eiffel_system.System.il_generation
			end

			if not is_stopped then
				st.add_string ("System is running")
				st.add_new_line
			end
			st.add_new_line
			-- NOTA jfiat [2004/07/02] : maybe we could display more information
			-- for instance if we run with or without break points
		end

feature -- Thread info

	set_current_thread_id (tid: INTEGER) is
			-- Set current thread ID.
		do
			Precursor {APPLICATION_STATUS} (tid)
			eifnet_debugger_info.set_last_icd_thread_id (tid)
		end
		
	refresh_current_thread_id is
		do
			if current_thread_id = 0 then
				set_current_thread_id (eifnet_debugger_info.last_icd_thread_id)
			end
			if not eifnet_debugger_info.is_valid_managed_thread_id (current_thread_id) then
				set_current_thread_id (eifnet_debugger_info.default_managed_thread.thread_id)
			end
		end
		
feature -- Call stack related

	current_call_stack: EIFFEL_CALL_STACK_DOTNET

	clean_current_call_stack is
			-- Clean Eiffel callstack data
		do
			if current_call_stack /= Void then
				current_call_stack.clean
			end
		end

feature {NONE} -- CallStack Impl

	new_current_callstack_with (a_stack_max_depth: INTEGER): like current_call_stack is
			-- Create Eiffel Callstack with a maximum depth of `a_stack_max_depth'
		do
			clean_current_call_stack
			create Result.make (a_stack_max_depth)
		end
			
	current_call_stack_element: CALL_STACK_ELEMENT is
			-- Current call stack element being displayed
		local
			ccs: EIFFEL_CALL_STACK_DOTNET
			cesn: INTEGER
		do
			ccs := current_call_stack
			cesn := Application.current_execution_stack_number
			if ccs.valid_index (cesn) then
				Result := ccs.i_th (cesn)				
			end
		end

feature -- Values

	current_call_stack_element_dotnet: CALL_STACK_ELEMENT_DOTNET is
			-- Current call stack element being displayed
		do
			Result ?= current_call_stack_element
		end
		
feature -- Reason for stopping

	set_reason (val: like reason) is
			-- Set reason of stopped state
		do
			reason := val
		ensure
			valid_reason
		end
		
	set_reason_as_break is
		do
			set_reason (feature {IPC_SHARED}.Pg_break)
		end

	set_reason_as_interrupt is
		do
			set_reason (feature {IPC_SHARED}.Pg_interrupt)
		end		
		
	set_reason_as_raise is
		do
			set_reason (feature {IPC_SHARED}.Pg_raise)
		end		

	set_reason_as_viol is
		do
			set_reason (feature {IPC_SHARED}.Pg_viol)
		end		
		
	set_reason_as_new_breakpoint is
		do
			set_reason (feature {IPC_SHARED}.Pg_new_breakpoint)
		end	
		
	set_reason_as_step is
		do
			set_reason (feature {IPC_SHARED}.Pg_step)
		end		

end -- class APPLICATION_STATUS_DOTNET
