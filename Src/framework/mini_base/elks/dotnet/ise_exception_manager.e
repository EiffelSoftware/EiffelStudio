note
	description: "[
		Exception manager. 
		The manager handles all common operations of exception mechanism and interaction with the ISE runtime.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ISE_EXCEPTION_MANAGER

inherit
	RT_EXCEPTION_MANAGER

feature -- Access

	last_exception: detachable NATIVE_EXCEPTION
			-- Last exception
		do
			if attached {like last_exception} {ISE_RUNTIME}.last_exception as e then
				Result := e
			end
		end

feature {NONE} -- Element change

	compute_last_exception (a_last_exception: detachable NATIVE_EXCEPTION): detachable NATIVE_EXCEPTION
			-- Set `last_exception' with `a_last_exception'.
		do
			Result := a_last_exception
		end

feature {NONE} -- Internal raise, Implementation of RT_EXCEPTION_MANAGER

	internal_raise (e_code: INTEGER; msg: SYSTEM_STRING)
			-- Internal raise exception of code `e_code'
		do
		end

	internal_raise_old (a_exception: NATIVE_EXCEPTION)
			-- Raise OLD_VIOLATION with original of `a_exception'
		do
		end

	throw_last_exception (a_exception: detachable NATIVE_EXCEPTION; a_for_once: BOOLEAN)
			-- Rethrow the exception at the end of rescue clause.
			--| This feature is called by {ISE_RUNTIME}.rethrow, which passes
			--| `_last_exception' as an argument. In setter of `_last_exception',
			--| `_last_exception' is always computed by Eiffel code
			--| `compute_last_exception' which returns EXCEPTION.
		do
		end

feature {NONE} -- Exception codes, Implementation of RT_EXCEPTION_MANAGER

	Void_call_target:INTEGER do Result := {EXCEP_CONST}.Void_call_target end
	No_more_memory:INTEGER do Result := {EXCEP_CONST}.No_more_memory end
	Precondition:INTEGER do Result := {EXCEP_CONST}.Precondition end
	Postcondition:INTEGER do Result := {EXCEP_CONST}.Postcondition end
	Floating_point_exception:INTEGER do Result := {EXCEP_CONST}.Floating_point_exception end
	Class_invariant:INTEGER do Result := {EXCEP_CONST}.Class_invariant end
	Check_instruction:INTEGER do Result := {EXCEP_CONST}.Check_instruction end
	Routine_failure:INTEGER do Result := {EXCEP_CONST}.Routine_failure end
	Incorrect_inspect_value:INTEGER do Result := {EXCEP_CONST}.Incorrect_inspect_value end
	Loop_variant:INTEGER do Result := {EXCEP_CONST}.Loop_variant end
	Loop_invariant:INTEGER do Result := {EXCEP_CONST}.Loop_invariant end
	Signal_exception:INTEGER do Result := {EXCEP_CONST}.Signal_exception end
	Rescue_exception:INTEGER do Result := {EXCEP_CONST}.Rescue_exception end
	External_exception:INTEGER do Result := {EXCEP_CONST}.External_exception end
	Void_assigned_to_expanded:INTEGER do Result := {EXCEP_CONST}.Void_assigned_to_expanded end
	Io_exception:INTEGER do Result := {EXCEP_CONST}.Io_exception end
	Operating_system_exception:INTEGER do Result := {EXCEP_CONST}.Operating_system_exception end
	Retrieve_exception:INTEGER do Result := {EXCEP_CONST}.Retrieve_exception end
	Developer_exception:INTEGER do Result := {EXCEP_CONST}.Developer_exception end
	Runtime_io_exception:INTEGER do Result := {EXCEP_CONST}.Runtime_io_exception end
	Com_exception:INTEGER do Result := {EXCEP_CONST}.Com_exception end
	Runtime_check_exception:INTEGER do Result := {EXCEP_CONST}.Runtime_check_exception end
	old_exception:INTEGER do Result := {EXCEP_CONST}.old_exception end
	serialization_exception:INTEGER do Result := {EXCEP_CONST}.serialization_exception end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
