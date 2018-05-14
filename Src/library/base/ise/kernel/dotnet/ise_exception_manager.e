note
	description: "Exception manager."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ISE_EXCEPTION_MANAGER

inherit
	RT_EXCEPTION_MANAGER

	EXCEPTION_MANAGER
		redefine
			last_exception,
			raise,
			ignore,
			catch,
			set_is_ignored,
			is_ignorable,
			is_raisable,
			is_ignored,
			is_caught,
			type_of_code,
			exception_from_code
		end

feature -- Access

	last_exception: detachable EXCEPTION
			-- Last exception
		do
			if attached {like last_exception} {ISE_RUNTIME}.last_exception as e then
				Result := e
			end
		end

feature -- Raise

	raise (a_exception: EXCEPTION)
			-- Raise `a_exception'.
			-- Raising `a_exception' by this routine makes `a_exception' accessible by `last_exception'
			-- in rescue clause. Hence causes removal of original `last_exception'.
		do
			if not a_exception.is_ignored then
				{ISE_RUNTIME}.raise (a_exception)
			end
		end

feature -- Status setting

	ignore (a_exception: TYPE [EXCEPTION])
			-- Make sure that any exception of code `code' will be
			-- ignored. This is not the default.
		local
			l_type: INTEGER
		do
			l_type := a_exception.type_id
			ignored_exceptions.force (l_type, l_type)
		end

	catch (a_exception: TYPE [EXCEPTION])
			-- Set type of `a_exception' `is_ignored'.
		do
			ignored_exceptions.remove (a_exception.type_id)
		end

	set_is_ignored (a_exception: TYPE [EXCEPTION]; a_ignored: BOOLEAN)
			-- Set type of `a_exception' to be `a_ignored'.
		do
			if a_ignored then
				ignore (a_exception)
			else
				catch (a_exception)
			end
		end

feature -- Status report

	is_ignorable (a_exception: TYPE [EXCEPTION]): BOOLEAN
			-- If set, type of `a_exception' is ignorable.
		do
			Result := not unignorable_exceptions.has (a_exception.type_id)
		end

	is_raisable (a_exception: TYPE [EXCEPTION]): BOOLEAN
			-- If set, type of `a_exception' is raisable.
		do
			Result := not unraisable_exceptions.has (a_exception.type_id)
		end

	is_ignored (a_exception: TYPE [EXCEPTION]): BOOLEAN
			-- If set, type of `a_exception' is not raised.
		do
			Result := ignored_exceptions.has (a_exception.type_id)
		end

	is_caught (a_exception: TYPE [EXCEPTION]): BOOLEAN
			-- If set, type of `a_exception' is raised.
		do
			Result := not ignored_exceptions.has (a_exception.type_id)
		end

feature {EXCEPTIONS} -- Backward compatibility support

	type_of_code (a_code: INTEGER): detachable TYPE [EXCEPTION]
			-- Exception type of `a_code'
		do
			inspect a_code
			when {EXCEP_CONST}.void_call_target then
				Result := {VOID_TARGET}
			when {EXCEP_CONST}.No_more_memory then
				Result := {NO_MORE_MEMORY}
			when {EXCEP_CONST}.Precondition then
				Result := {PRECONDITION_VIOLATION}
			when {EXCEP_CONST}.Postcondition then
				Result := {POSTCONDITION_VIOLATION}
			when {EXCEP_CONST}.Floating_point_exception then
				Result := {FLOATING_POINT_FAILURE}
			when {EXCEP_CONST}.Class_invariant then
				Result := {INVARIANT_VIOLATION}
			when {EXCEP_CONST}.Check_instruction then
				Result := {CHECK_VIOLATION}
			when {EXCEP_CONST}.Routine_failure then
				Result := {ROUTINE_FAILURE}
			when {EXCEP_CONST}.Incorrect_inspect_value then
				Result := {BAD_INSPECT_VALUE}
			when {EXCEP_CONST}.Loop_variant then
				Result := {VARIANT_VIOLATION}
			when {EXCEP_CONST}.Loop_invariant then
				Result := {LOOP_INVARIANT_VIOLATION}
			when {EXCEP_CONST}.Signal_exception then
				Result := {OPERATING_SYSTEM_SIGNAL_FAILURE}
			when {EXCEP_CONST}.Eiffel_runtime_panic then
				Result := {EIFFEL_RUNTIME_PANIC}
			when {EXCEP_CONST}.Rescue_exception then
					-- Obselete
				Result := {RESCUE_FAILURE}
			when {EXCEP_CONST}.Out_of_memory then
					-- Merged with `No_more_memory'
				Result := {NO_MORE_MEMORY}
			when {EXCEP_CONST}.Resumption_failed then
					-- Obselete
				Result := {RESUMPTION_FAILURE}
			when {EXCEP_CONST}.Create_on_deferred then
				Result := {CREATE_ON_DEFERRED}
			when {EXCEP_CONST}.External_exception then
				Result := {EXTERNAL_FAILURE}
			when {EXCEP_CONST}.Void_assigned_to_expanded then
				Result := {VOID_ASSIGNED_TO_EXPANDED}
			when {EXCEP_CONST}.Exception_in_signal_handler then
					-- Obselete
				Result := {EXCEPTION_IN_SIGNAL_HANDLER_FAILURE}
			when {EXCEP_CONST}.Io_exception then
				Result := {IO_FAILURE}
			when {EXCEP_CONST}.Operating_system_exception then
				Result := {OPERATING_SYSTEM_FAILURE}
			when {EXCEP_CONST}.Retrieve_exception then
				Result := {MISMATCH_FAILURE}
			when {EXCEP_CONST}.Developer_exception then
				Result := {DEVELOPER_EXCEPTION}
			when {EXCEP_CONST}.Eiffel_runtime_fatal_error then
					-- Merged with `Eiffel_runtime_panic'
				Result := {EIFFEL_RUNTIME_PANIC}
			when {EXCEP_CONST}.Dollar_applied_to_melted_feature then
				Result := {ADDRESS_APPLIED_TO_MELTED_FEATURE}
			when {EXCEP_CONST}.Runtime_io_exception then
					-- Merged with `Io_exception'
				Result := {IO_FAILURE}
			when {EXCEP_CONST}.Com_exception then
				Result := {COM_FAILURE}
			when {EXCEP_CONST}.Runtime_check_exception then
				Result := {CHECK_VIOLATION}
			when {EXCEP_CONST}.old_exception then
				Result := {OLD_VIOLATION}
			when {EXCEP_CONST}.serialization_exception then
				Result := {SERIALIZATION_FAILURE}
			else
				Result := Void
			end
		end

	exception_from_code (a_code: INTEGER): detachable EXCEPTION
			-- Create exception object from `a_code'
		local
			l_rt_panic: EIFFEL_RUNTIME_PANIC
			l_io_failure: IO_FAILURE
			l_no_more_mem: NO_MORE_MEMORY
		do
			inspect a_code
			when {EXCEP_CONST}.void_call_target then
				create {VOID_TARGET}Result
			when {EXCEP_CONST}.No_more_memory then
				create l_no_more_mem
				l_no_more_mem.set_code ({EXCEP_CONST}.No_more_memory)
				Result := l_no_more_mem
			when {EXCEP_CONST}.Precondition then
				create {PRECONDITION_VIOLATION}Result
			when {EXCEP_CONST}.Postcondition then
				create {POSTCONDITION_VIOLATION}Result
			when {EXCEP_CONST}.Floating_point_exception then
				create {FLOATING_POINT_FAILURE}Result
			when {EXCEP_CONST}.Class_invariant then
				create {INVARIANT_VIOLATION}Result
			when {EXCEP_CONST}.Check_instruction then
				create {CHECK_VIOLATION}Result
			when {EXCEP_CONST}.Routine_failure then
				create {ROUTINE_FAILURE}Result
			when {EXCEP_CONST}.Incorrect_inspect_value then
				create {BAD_INSPECT_VALUE}Result
			when {EXCEP_CONST}.Loop_variant then
				create {VARIANT_VIOLATION}Result
			when {EXCEP_CONST}.Loop_invariant then
				create {LOOP_INVARIANT_VIOLATION}Result
			when {EXCEP_CONST}.Signal_exception then
				create {OPERATING_SYSTEM_SIGNAL_FAILURE}Result
			when {EXCEP_CONST}.Eiffel_runtime_panic then
				create l_rt_panic
				l_rt_panic.set_code ({EXCEP_CONST}.Eiffel_runtime_panic)
				Result := l_rt_panic
			when {EXCEP_CONST}.Rescue_exception then
					-- Obselete
				create {RESCUE_FAILURE}Result
			when {EXCEP_CONST}.Out_of_memory then
					-- Merged with `No_more_memory'
				create l_no_more_mem
				l_no_more_mem.set_code ({EXCEP_CONST}.Out_of_memory)
				Result := l_no_more_mem
			when {EXCEP_CONST}.Resumption_failed then
					-- Obselete
				create {RESUMPTION_FAILURE}Result
			when {EXCEP_CONST}.Create_on_deferred then
				create {CREATE_ON_DEFERRED}Result
			when {EXCEP_CONST}.External_exception then
				create {EXTERNAL_FAILURE}Result
			when {EXCEP_CONST}.Void_assigned_to_expanded then
				create {VOID_ASSIGNED_TO_EXPANDED}Result
			when {EXCEP_CONST}.Exception_in_signal_handler then
					-- Obselete
				create {EXCEPTION_IN_SIGNAL_HANDLER_FAILURE}Result
			when {EXCEP_CONST}.Io_exception then
				create l_io_failure
				l_io_failure.set_code ({EXCEP_CONST}.Io_exception)
				Result := l_io_failure
			when {EXCEP_CONST}.Operating_system_exception then
				create {OPERATING_SYSTEM_FAILURE}Result
			when {EXCEP_CONST}.Retrieve_exception then
				create {MISMATCH_FAILURE}Result
			when {EXCEP_CONST}.Developer_exception then
				create {DEVELOPER_EXCEPTION}Result
			when {EXCEP_CONST}.Eiffel_runtime_fatal_error then
					-- Merged with `Eiffel_runtime_panic'
				create l_rt_panic
				l_rt_panic.set_code ({EXCEP_CONST}.Eiffel_runtime_fatal_error)
				Result := l_rt_panic
			when {EXCEP_CONST}.Dollar_applied_to_melted_feature then
				create {ADDRESS_APPLIED_TO_MELTED_FEATURE}Result
			when {EXCEP_CONST}.Runtime_io_exception then
					-- Merged with `Io_exception'
				create l_io_failure
				l_io_failure.set_code ({EXCEP_CONST}.Runtime_io_exception)
				Result := l_io_failure
			when {EXCEP_CONST}.Com_exception then
				create {COM_FAILURE}Result
			when {EXCEP_CONST}.Runtime_check_exception then
				create {CHECK_VIOLATION}Result
			when {EXCEP_CONST}.old_exception then
				create {OLD_VIOLATION}Result
			when {EXCEP_CONST}.serialization_exception then
				create {SERIALIZATION_FAILURE}Result
			else
			end
		end

feature {NONE} -- Element change

	compute_last_exception (a_last_exception: NATIVE_EXCEPTION): detachable EXCEPTION
			-- Set `last_exception' with `a_last_exception'.
		do
			if a_last_exception /= Void then
				Result := constructed_exception_chain (a_last_exception)
			end
		end

feature {NONE} -- Implementation, ignoring

	ignored_exceptions: HASH_TABLE [INTEGER, INTEGER]
			-- Ignored exceptions
		once
			create Result.make (0)
		ensure
			instance_free: class
		end

	unignorable_exceptions: HASH_TABLE [INTEGER, INTEGER]
			-- Unignorable exceptions
		local
			l_type: INTEGER
		once
			create Result.make (1)
			l_type := ({VOID_TARGET}).type_id
			Result.force (l_type, l_type)
		ensure
			instance_free: class
		end

	unraisable_exceptions: HASH_TABLE [INTEGER, INTEGER]
			-- Unraisable exceptions
		local
			l_type: INTEGER
		once
			create Result.make (2)
			l_type := ({ROUTINE_FAILURE}).type_id
			Result.force (l_type, l_type)
			l_type := ({OLD_VIOLATION}).type_id
			Result.force (l_type, l_type)
		ensure
			instance_free: class
		end

feature {NONE} -- Implementation, exception chain

	constructed_exception_chain (a_last_exception: NATIVE_EXCEPTION): EXCEPTION
			-- Construct exception chain
		require
			a_last_exception_not_viod: a_last_exception /= Void
		local
			l_rs: like recipient_and_type_name
			l_to_skip: INTEGER
		do
			if attached {ROUTINE_FAILURE} a_last_exception as l_rf then
				l_to_skip := 2
			else
					-- Skip a frame for precondition violation and invariant violation on entry
					-- To get the caller.
				if attached {PRECONDITION_VIOLATION} a_last_exception as l_pre or {ISE_RUNTIME}.in_precondition then
					l_to_skip := 2	-- The number is decided because for a normal Eiffel call, there are two frames.
				end
			end

			l_rs := recipient_and_type_name (create {STACK_TRACE}.make (a_last_exception), l_to_skip)
			Result := wrapped_exception (a_last_exception)
			Result.set_recipient_name (l_rs.recipient)
			Result.set_type_name (l_rs.type)
			Result.set_line_number (l_rs.line_number)
			if {ISE_RUNTIME}.exception_from_rescue then
				Result.original.set_throwing_exception (last_exception)
			end
		ensure
			constructed_exception_chain_not_void: Result /= Void
		end

	wrapped_exception (a_exception: NATIVE_EXCEPTION): EXCEPTION
			-- Wrapped .NET exception
		require
			a_exception_not_void: a_exception /= Void
		do
			if attached {EXCEPTION} a_exception as e then
					-- An Eiffel exception.
				Result := e
			else
					-- A pure .NET exception
				if attached {NULL_REFERENCE_EXCEPTION} a_exception as l_nullref then
						-- Replace NullReferenceException with VOID_TARGET
					create {VOID_TARGET} Result.make_dotnet_exception (a_exception)
				elseif
					attached {UNAUTHORIZED_ACCESS_EXCEPTION} a_exception or else
					attached {SECURITY_EXCEPTION} a_exception or else
					attached {IO_EXCEPTION} a_exception
				then
					create {IO_FAILURE} Result.make_dotnet_exception (a_exception)
				else
					create {OPERATING_SYSTEM_SIGNAL_FAILURE} Result.make_dotnet_exception (a_exception)
				end
				Result.set_description ("")
			end
		end

	recipient_and_type_name (a_st: STACK_TRACE; a_skip: INTEGER): TUPLE [recipient, type: detachable STRING; line_number: INTEGER]
			-- Compute recipient name, type name and possible line number via `a_st'.
			-- `a_skip' is number of first caught frames to though away.
		require
			a_st_not_void: a_st /= Void
		local
			l_routine_name, l_class: detachable STRING
			l_stack_trace: STACK_TRACE
			l_frame_count, i: INTEGER
			l_skipped, l_to_skip: INTEGER
			l_line_number: INTEGER
			l_found: BOOLEAN
			l_type: detachable SYSTEM_TYPE
		do
			l_stack_trace := a_st
			l_frame_count := l_stack_trace.frame_count
			l_to_skip := a_skip
			from
				i := 0
			until
				i >= l_frame_count or else l_found
			loop
				if
					attached l_stack_trace.get_frame (i) as l_frame and then
					attached l_frame.get_method as l_method and then
					is_filtered_routine (l_method)
				then
					if l_skipped >= l_to_skip then
						create l_routine_name.make_from_cil (l_method.name)
						if l_routine_name.count > 2 and then
							l_routine_name.item (1).is_equal ('$') and then
							l_routine_name.item (2).is_equal ('$')
						then
							l_routine_name := l_routine_name.substring (3, l_routine_name.count)
						end
						l_type := l_method.declaring_type
						check l_type /= Void then
							create l_class.make_from_cil (l_type.name)
						end
						l_line_number := l_frame.get_file_line_number
						l_found := True
					else
						l_skipped := l_skipped + 1
					end
				end
				i := i + 1
			end
			Result := [l_routine_name, l_class, l_line_number]
		ensure
			result_not_void: Result /= Void
		end

	is_filtered_routine (a_method: METHOD_BASE): BOOLEAN
			-- Is `a_name' filtered?
			-- Implementations, routines out of Eiffel classes and some routines in the manager are filtered.
		require
			a_method_not_void: a_method /= Void
		do
			if
				attached a_method.declaring_type as l_type and then
				attached l_type.get_custom_attributes ({EIFFEL_NAME_ATTRIBUTE}, False) as l_attributes and then
				l_attributes.count = 1 and then
				attached {EIFFEL_NAME_ATTRIBUTE} l_attributes.item (0) as l_attr and then
				not filtered_class.has (create {STRING}.make_from_cil(l_attr.name))
			then
				Result := not filtered_routines.has (create {STRING}.make_from_cil (a_method.name))
			end
		end

	filtered_class: HASH_TABLE [INTEGER, STRING]
			-- Filterred routines
		once
			create Result.make (2)
			Result.put (0, "IseExceptionManager")
			Result.put (0, "ISE_EXCEPTION_MANAGER")
		end

	filtered_routines: HASH_TABLE [INTEGER, STRING]
			-- Filterred routines
		once
			create Result.make (15)
			Result.put (0, "Main")
			Result.put (0, "raise")
			Result.put (0, "$$raise")
			Result.put (0, "internal_raise")
			Result.put (0, "$$internal_raise")
			Result.put (0, "internal_raise_old")
			Result.put (0, "$$internal_raise_old")
			Result.put (0, "raise_code")
			Result.put (0, "$$raise_code")
			Result.put (0, "_invariant")
			Result.put (0, "$$_invariant")
			Result.put (0, "throw_last_exception")
			Result.put (0, "$$throw_last_exception")
			Result.put (0, "check_invariant")
			Result.put (0, "create_and_call_root_object")
		end

feature {NONE} -- Internal raise, Implementation of RT_EXCEPTION_MANAGER

	internal_raise (e_code: INTEGER; msg: SYSTEM_STRING)
			-- Internal raise exception of code `e_code'
		local
			l_saved_assertion, l_assertion_set: BOOLEAN
			l_assertion_tag: STRING_32
		do
			if is_assertion_violation (e_code) then
					-- Disable assertion check in assertions.
				l_assertion_set := True
				l_saved_assertion := {ISE_RUNTIME}.check_assert (False)
			end
			check attached exception_from_code (e_code) as l_exception then
				if attached {INVARIANT_VIOLATION} l_exception as i then
					i.set_is_entry ({ISE_RUNTIME}.invariant_entry)
				end
				if msg /= Void then
					create l_assertion_tag.make_from_cil (msg)
					l_exception.set_description (l_assertion_tag)
				else
					create l_assertion_tag.make_empty
				end
				if not l_exception.is_ignored then
						-- Restore assertion level just before throwing the exception.
					if l_assertion_set then
						l_saved_assertion := {ISE_RUNTIME}.check_assert (l_saved_assertion)
					end
					{ISE_RUNTIME}.raise (l_exception)
				end
					-- The exception is ingored. Restore assertion level.
				if l_assertion_set then
					l_saved_assertion := {ISE_RUNTIME}.check_assert (l_saved_assertion)
				end
			end
		end

	internal_raise_old (a_exception: NATIVE_EXCEPTION)
			-- Raise OLD_VIOLATION with original of `a_exception'
		local
			l_exception: OLD_VIOLATION
		do
			create l_exception
			if not l_exception.is_ignored then
				l_exception.set_throwing_exception (constructed_exception_chain (a_exception))
				{ISE_RUNTIME}.raise (l_exception)
			end
		end

	throw_last_exception (a_exception: detachable NATIVE_EXCEPTION; a_for_once: BOOLEAN)
			-- Rethrow the exception at the end of rescue clause.
			--| This feature is called by {ISE_RUNTIME}.rethrow, which passes
			--| `_last_exception' as an argument. In setter of `_last_exception',
			--| `_last_exception' is always computed by Eiffel code
			--| `compute_last_exception' which returns EXCEPTION.
		local
			l_failure: ROUTINE_FAILURE
			l_stack_trace: STACK_TRACE
			l_rs: like recipient_and_type_name
		do
				-- The exception should be always EXCEPTION.
			check
				ensured_by_run_time: attached {EXCEPTION} a_exception as l_exception
			then
				if not a_for_once then
					create l_failure
					l_failure.set_throwing_exception (l_exception)

					create l_stack_trace.make
					l_rs := recipient_and_type_name (l_stack_trace, 0)
					l_failure.set_routine_name (l_rs.recipient)
					l_failure.set_class_name (l_rs.type)
						-- Substitute `last_exception' for the use at the beginning of a `rescue',
						-- where we setup possible `cause'.
					{ISE_RUNTIME}.restore_last_exception (l_failure)
					{ISE_RUNTIME}.raise (l_failure)
				else
					{ISE_RUNTIME}.raise (l_exception)
				end
			end
		end

	is_assertion_violation (a_code: INTEGER): BOOLEAN
			-- Is `a_code' exception of assertion violation?
		do
			Result := 	a_code = {EXCEP_CONST}.precondition or else
						a_code = {EXCEP_CONST}.postcondition or else
						a_code = {EXCEP_CONST}.check_instruction or else
						a_code = {EXCEP_CONST}.class_invariant or else
						a_code = {EXCEP_CONST}.loop_invariant or else
						a_code = {EXCEP_CONST}.loop_variant
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
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
