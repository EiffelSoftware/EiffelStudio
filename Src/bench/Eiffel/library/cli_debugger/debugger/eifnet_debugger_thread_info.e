indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER_THREAD_INFO
	
inherit
	DISPOSABLE
		redefine
			dispose
		end
		
	ICOR_EXPORTER
		
create
	make
	
feature {NONE} -- Initialization

	make (p: POINTER) is -- ; icdth_id: INTEGER) is
			-- Initialize Current
		require
			icd_thread_pointer_not_null: p /= Default_pointer
		local
			r: INTEGER
		do
			icd_thread_pointer := p

			r := {ICOR_DEBUG_THREAD}.cpp_get_id (icd_thread_pointer, $thread_id)
			r := {CLI_COM}.add_ref (icd_thread_pointer)
			create pending_steppers.make (7)
		end

feature -- Cleaning

	clean is
			-- Clean data
		do
				-- FIXME jfiat: TODO

			clean_pending_steppers
		end
		
	clean_pending_steppers is
			-- Clean pending_steppers
		local
			s: ICOR_DEBUG_STEPPER
		do
			from
				pending_steppers.start
			until
				pending_steppers.after
			loop
				s := pending_steppers.item_for_iteration
				s.deactivate	-- could fail, when process exited
				s.clean_on_dispose
				pending_steppers.forth
			end
			pending_steppers.wipe_out
		end		

feature -- Access

	icd_thread: ICOR_DEBUG_THREAD is
			-- 
		do
			Result := opo_icd_thread
			if Result = Void then
				create opo_icd_thread.make_by_pointer (icd_thread_pointer)
				opo_icd_thread.add_ref
				Result := opo_icd_thread
			end
		ensure
			result_not_void: Result /= Void
		end
		
	new_stepper: ICOR_DEBUG_STEPPER is
			-- 
		local
			l_frame: ICOR_DEBUG_FRAME
			l_thread: ICOR_DEBUG_THREAD
			l_stepper: ICOR_DEBUG_STEPPER
			l_error: INTEGER
		do
			clean_pending_steppers
			-- FIXME jfiat: for now we do this way, find the way to reuse steppers
			l_thread := icd_thread
			if l_thread /= Void then
				l_frame := l_thread.get_active_frame
				if l_thread.last_call_succeed and then l_frame /= Void then
					l_stepper := l_frame.create_stepper			
					l_error := l_frame.last_call_success
					l_frame.clean_on_dispose
				else
					l_stepper := l_thread.create_stepper
					l_error := l_thread.last_call_success
				end	
				if l_error = 0 or l_error = 1 then
					Result := l_stepper
					Result.add_ref
					add_icd_stepper (Result.item)
				end
			end
		ensure
			Result /= Void
		end		
		
feature -- Change

	add_icd_stepper (p: POINTER) is
			-- Add pointer to Stepper
			--
			-- Nota: call AddRef before adding it
			--		maybe later, we'll do it here
		require
			stepper_not_null: p /= Default_pointer
		local
			s: ICOR_DEBUG_STEPPER
		do
			create s.make_by_pointer (p)
			pending_steppers.put (s, p)
		end
		
	has_icd_stepper (p: POINTER): BOOLEAN is
		require
			p /= Default_pointer
		do
			Result := pending_steppers.has (p)
		end
		
	remove_icd_stepper (p: POINTER) is
		require
			p /= Default_pointer
			has_icd_stepper: has_icd_stepper (p)
		local
			s: ICOR_DEBUG_STEPPER
		do
			s := pending_steppers.item (p)
			if s /= Void then
				s.deactivate
				s.clean_on_dispose
			end			
			pending_steppers.remove (p)
		end		
		
feature {NONE} -- Implementation

	opo_icd_thread: ICOR_DEBUG_THREAD
			-- Once per object for `icd_thread'
		
feature -- Properties

	super_fluous_first_step_complete_message_suppressed: BOOLEAN
	
	stepping_for_startup: BOOLEAN

	thread_id: INTEGER
	
	icd_thread_pointer: POINTER
	
	last_icd_func_eval: ICOR_DEBUG_EVAL
	
	pending_steppers: HASH_TABLE [ICOR_DEBUG_STEPPER, POINTER]

feature -- Disposable

	dispose is
		local
			n: INTEGER
		do
			opo_icd_thread := Void
			n := {CLI_COM}.release (icd_thread_pointer)
			icd_thread_pointer := Default_pointer
			pending_steppers := Void
			last_icd_func_eval := Void
		end

end -- class EIFNET_DEBUGGER_THREAD_INFO
