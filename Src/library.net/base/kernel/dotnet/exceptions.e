indexing

	description: "[
		Facilities for adapting the exception handling mechanism.
		This class may be used as ancestor by classes needing its facilities.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EXCEPTIONS

inherit

	EXCEP_CONST

feature -- Status report

	meaning (except: INTEGER): STRING is
			-- A message in English describing what `except' is
		do
			if valid_code (except) then
				Result := exception_names @ except
			end
		end

	assertion_violation: BOOLEAN is
			-- Is last exception originally due to a violated
			-- assertion or non-decreasing variant?
		do
			Result :=
				(original_exception = Check_instruction) or else
				(original_exception = Class_invariant) or else
				(original_exception = Loop_invariant) or else
				(original_exception = Loop_variant) or else
				(original_exception = Postcondition) or else
				(original_exception = Precondition)
		end

	is_developer_exception: BOOLEAN is
			-- Is the last exception originally due to
			-- a developer exception?
		do
			Result := (original_exception = Developer_exception)
		end

	is_developer_exception_of_name (name: STRING): BOOLEAN is
			-- Is the last exception originally due to a developer
			-- exception of name `name'?
		do
			Result := is_developer_exception and then
						equal (name, developer_exception_name)
		end

	developer_exception_name: STRING is
			-- Name of last developer-raised exception
		require
			applicable: is_developer_exception
		local
			le: EXCEPTION
			conv_de: EIFFEL_EXCEPTION
		do
			conv_de ?= feature {EXCEPTION_MANAGER}.last_exception
			Result := conv_de.tag
		end

	is_signal: BOOLEAN is
			-- Is last exception originally due to an external
			-- event (operating system signal)?
		do
			Result := (original_exception = Signal_exception)
		end

	is_system_exception: BOOLEAN is
			-- Is last exception originally due to an
			-- external event (operating system error)?
		do
			Result :=
				(original_exception = External_exception) or else
				(original_exception = Operating_system_exception)
		end

	tag_name: STRING is
			-- Tag of last violated assertion clause
		local
			conv_fl: EIFFEL_EXCEPTION
			le: EXCEPTION
		do
			le := feature {EXCEPTION_MANAGER}.last_exception
			if le /= Void then
				conv_fl ?= le
				if conv_fl /= Void then
					Result := conv_fl.tag
				else
					create Result.make_from_cil (le.get_message)
				end
			else
				create Result.make (0)
			end
		end

	recipient_name: STRING is
			-- Name of the routine whose execution was
			-- interrupted by last exception
		local
			le: EXCEPTION
		do
			le := feature {EXCEPTION_MANAGER}.last_exception
			if le /= Void then
				create Result.make_from_cil (le.get_target_site.get_name)
			else
				create Result.make (0)
			end
		end

	class_name: STRING is
			-- Name of the class that includes the recipient
			-- of original form of last exception
		local
			le: EXCEPTION
		do
			le := feature {EXCEPTION_MANAGER}.last_exception
			if le /= Void then
				create Result.make_from_cil (le.get_target_site.get_reflected_type.get_full_name)
			else
				create Result.make (0)
			end
		end

	exception: INTEGER is
			-- Code of last exception that occurred
		local
			le: EXCEPTION
		do
			le := feature {EXCEPTION_MANAGER}.last_exception
			if le /= Void then
				Result := exception_to_code (le)
			else
				Result := 0
			end
		end

	exception_trace: STRING is
			-- String representation of the exception trace
		local
			le: EXCEPTION
		do
			le := feature {EXCEPTION_MANAGER}.last_exception
			if le /= Void then
				create Result.make_from_cil (le.get_stack_trace)
			else
				create Result.make (0)
			end
		end

	original_tag_name: STRING is
			-- Assertion tag for original form of last
			-- assertion violation.
		local
			conv_fl: EIFFEL_EXCEPTION
			le: EXCEPTION
		do
			le := feature {EXCEPTION_MANAGER}.last_exception
			if le /= Void and then le.get_inner_exception /= Void then
				le := le.get_inner_exception
				conv_fl ?= le
				if conv_fl /= Void then
					Result := conv_fl.tag
				else
					create Result.make_from_cil (le.get_message)
				end
			else
				create Result.make (0)
			end
		end

	original_exception: INTEGER is
			-- Original code of last exception that triggered
			-- current exception
		local
			le: EXCEPTION
		do
			le := feature {EXCEPTION_MANAGER}.last_exception
			if le /= Void and then le.get_inner_exception /= Void then
				Result := exception_to_code (le.get_inner_exception)
			else
				Result := 0
			end
		end

	original_recipient_name: STRING is
			-- Name of the routine whose execution was
			-- interrupted by original form of last exception
		local
			le: EXCEPTION
		do
			le := feature {EXCEPTION_MANAGER}.last_exception
			if le /= Void and then le.get_inner_exception /= Void then
				le := le.get_inner_exception
				create Result.make_from_cil (le.get_target_site.get_name)
			else
				create Result.make (0)
			end
		end

	original_class_name: STRING is
			-- Name of the class that includes the recipient
			-- of original form of last exception
		local
			le: EXCEPTION
		do
			le := feature {EXCEPTION_MANAGER}.last_exception
			if le /= Void and then le.get_inner_exception /= Void then
				le := le.get_inner_exception
				create Result.make_from_cil (le.get_target_site.get_reflected_type.get_full_name)
			else
				create Result.make (0)
			end
		end

feature -- Status setting

	catch (code: INTEGER) is
			-- Make sure that any exception of code `code' will be
			-- caught. This is the default.
		do
			check
				False
				--| Not supported.
			end
		end

	ignore (code: INTEGER) is
			-- Make sure that any exception of code `code' will be
			-- ignored. This is not the default.
		do
			check
				False
				--| Not supported.
			end
		end

	raise (name: STRING) is
			-- Raise a developer exception of name `name'.
		local
			fle: EIFFEL_EXCEPTION
		do
			create fle.make (Developer_exception, name)
			feature {EXCEPTION_MANAGER}.raise (fle)
		end

	die (code: INTEGER) is
			-- Terminate execution with exit status `code',
			-- without triggering an exception.
		do
			feature {ENVIRONMENT}.exit (code)
		end

	new_die (code: INTEGER) is obsolete "Use ``die''"
			-- Terminate execution with exit status `code',
			-- without triggering an exception.
		do
			die (code)
		end

	message_on_failure is
			-- Print an exception history table
			-- in case of failure.
			-- This is the default.
		do
			check
				False
				--| Not supported.
			end
		end

	no_message_on_failure is
			-- Do not print an exception history table
			-- in case of failure.
		do
			check
				False
				--| Not supported.
			end
		end

feature {NONE} -- Implementation

	exception_to_code (ex: EXCEPTION): INTEGER is
			-- Return the Eiffel code corresponding to exception `ex'.
		require
			valid_ex: ex /= Void
		local
			conv_io: IOEXCEPTION
			conv_sys: SYSTEM_EXCEPTION
			conv_acc: UNAUTHORIZED_ACCESS_EXCEPTION
			conv_sec: SECURITY_EXCEPTION
			conv_fl: EIFFEL_EXCEPTION
		do
			conv_fl ?= ex
			if conv_fl /= Void then
				Result := conv_fl.code
			else
				conv_sys ?= ex
				if conv_sys /= Void then
					Result := Operating_system_exception
				else
					conv_acc ?= ex
					conv_sec ?= ex
					conv_io ?= ex
					if conv_io /= Void or conv_sec /= Void or conv_acc /= Void then
						Result := Io_exception
					else
						Result := Signal_exception
					end
				end
			end
		ensure
			valid_code: valid_code (Result)
		end

	exception_names: ARRAY [STRING] is
			-- Names describing each type of exception.
		once
			create Result.make (1, number_of_codes)
			Result.put ("Feature call on void target.", Void_call_target)
			Result.put ("No more memory.", No_more_memory)
			Result.put ("Precondition violated.", Precondition)
			Result.put ("Postcondition violated.", Postcondition)
			Result.put ("Floating point exception.", Floating_point_exception)
			Result.put ("Class invariant violated.", Class_invariant)
			Result.put ("Assertion violated.", Check_instruction)
			Result.put ("Routine failure.", Routine_failure)
			Result.put ("Unmatched inspect value.", Incorrect_inspect_value)
			Result.put ("Non-decreasing loop variant.", Loop_variant)
			Result.put ("Loop invariant violated.", Loop_invariant)
			Result.put ("Operating system signal.", Signal_exception)
			Result.put ("Eiffel run-time panic.", 13)
			Result.put ("Exception in rescue clause.", Rescue_exception)
			Result.put ("Out of memory.", 15)
			Result.put ("Resumption attempt failed.", 16)
			Result.put ("Create on deferred.", 17)
			Result.put ("External event.", External_exception)
			Result.put ("Void assigned to expanded.", Void_assigned_to_expanded)
			Result.put ("Exception in signal handler.", 20)
			Result.put ("I/O error.", Io_exception)
			Result.put ("Operating system error.", Operating_system_exception)
			Result.put ("Retrieval error.", Retrieve_exception)
			Result.put ("Developer exception.", Developer_exception)
			Result.put ("Eiffel run-time fatal error.", 25)
			Result.put ("CECIL cannot call melted code", 26)
			Result.put ("Runtime I/O error.", Runtime_io_exception)
			Result.put ("COM error.", Com_exception)
  		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class EXCEPTIONS


