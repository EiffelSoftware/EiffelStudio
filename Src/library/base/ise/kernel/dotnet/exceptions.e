indexing

	description: "[
		Facilities for adapting the exception handling mechanism.
		This class may be used as ancestor by classes needing its facilities.
		]"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXCEPTIONS

inherit

	EXCEP_CONST

feature -- Status report

	meaning (except: INTEGER): STRING is
			-- A message in English describing what `except' is
		local
			l_exception: EXCEPTION
		do
			l_exception := exception_manager.exception_from_code (except)
			if l_exception /= Void then
				Result := l_exception.meaning
			end
		end

	assertion_violation: BOOLEAN is
			-- Is last exception originally due to a violated
			-- assertion or non-decreasing variant?
		local
			l_exception: ASSERTION_VIOLATION
		do
			l_exception ?= exception_manager.last_exception
			Result := (l_exception /= Void)
		end

	is_developer_exception: BOOLEAN is
			-- Is the last exception originally due to
			-- a developer exception?
		local
			l_exception: DEVELOPER_EXCEPTION
		do
			l_exception ?= exception_manager.last_exception
			Result := (l_exception /= Void)
		end

	is_developer_exception_of_name (name: STRING): BOOLEAN is
			-- Is the last exception originally due to a developer
			-- exception of name `name'?
		local
			l_exception: DEVELOPER_EXCEPTION
		do
			l_exception ?= exception_manager.last_exception
			Result := is_developer_exception and then
						equal (name, l_exception.message)
		end

	developer_exception_name: STRING is
			-- Name of last developer-raised exception
		require
			applicable: is_developer_exception
		local
			l_exception: DEVELOPER_EXCEPTION
		do
			l_exception ?= exception_manager.last_exception
			Result := l_exception.message
		end

	is_signal: BOOLEAN is
			-- Is last exception originally due to an external
			-- event (operating system signal)?
		local
			l_exception: OPERATING_SYSTEM_SIGNAL_FAILURE
		do
			l_exception ?= exception_manager.last_exception
			Result := (l_exception /= Void)
		end

	is_system_exception: BOOLEAN is
			-- Is last exception originally due to an
			-- external event (operating system error)?
		local
			l_external: EXTERNAL_FAILURE
			l_system_failure: SYS_EXCEPTION
			l_exception: EXCEPTION
		do
			l_exception := exception_manager.last_exception
			l_external ?= l_exception
			Result := (l_external /= Void)
			if not Result then
				l_system_failure ?= l_exception
				Result := (l_system_failure /= Void)
			end
		end

	tag_name: STRING is
			-- Tag of last violated assertion clause
		local
			l_exception: EXCEPTION
		do
			l_exception ?= exception_manager.last_exception
			if l_exception /= Void then
				Result := l_exception.message
			end
		end

	recipient_name: STRING is
			-- Name of the routine whose execution was
			-- interrupted by last exception
		local
			l_exception: EXCEPTION
		do
			l_exception ?= exception_manager.last_exception
			if l_exception /= Void then
				Result := l_exception.recipient_name
			end
		end

	class_name: STRING is
			-- Name of the class that includes the recipient
			-- of original form of last exception
		local
			l_exception: EXCEPTION
		do
			l_exception ?= exception_manager.last_exception
			if l_exception /= Void then
				Result := l_exception.type_name
			end
		end

	exception: INTEGER is
			-- Code of last exception that occurred
		local
			l_exception: EXCEPTION
		do
			l_exception ?= exception_manager.last_exception
			if l_exception /= Void then
				Result := l_exception.code
			end
		end

	exception_trace: STRING is
			-- String representation of the exception trace
		local
			l_exception: EXCEPTION
		do
			l_exception ?= exception_manager.last_exception
			if l_exception /= Void then
				Result := l_exception.exception_trace
			end
		end

	original_tag_name: STRING is
			-- Assertion tag for original form of last
			-- assertion violation.
		local
			l_exception: EXCEPTION
		do
			l_exception ?= exception_manager.last_exception
			if l_exception /= Void then
				Result := l_exception.original.message
			end
		end

	original_exception: INTEGER is
			-- Original code of last exception that triggered
			-- current exception
		local
			l_exception: EXCEPTION
		do
			l_exception ?= exception_manager.last_exception
			if l_exception /= Void then
				Result := l_exception.original.code
			end
		end

	original_recipient_name: STRING is
			-- Name of the routine whose execution was
			-- interrupted by original form of last exception
		local
			l_exception: EXCEPTION
		do
			l_exception ?= exception_manager.last_exception
			if l_exception /= Void then
				Result := l_exception.original.recipient_name
			end
		end

	original_class_name: STRING is
			-- Name of the class that includes the recipient
			-- of original form of last exception
		local
			l_exception: EXCEPTION
		do
			l_exception ?= exception_manager.last_exception
			if l_exception /= Void then
				Result := l_exception.original.type_name
			end
		end

feature -- Status setting

	catch (code: INTEGER) is
			-- Make sure that any exception of code `code' will be
			-- caught. This is the default.
		local
			l_type: TYPE [EXCEPTION]
		do
			l_type := exception_manager.type_of_code (code)
			if l_type /= Void then
				exception_manager.catch (l_type)
			end
		end

	ignore (code: INTEGER) is
			-- Make sure that any exception of code `code' will be
			-- ignored. This is not the default.
		local
			l_type: TYPE [EXCEPTION]
		do
			l_type := exception_manager.type_of_code (code)
			if l_type /= Void then
				exception_manager.ignore (l_type)
			end
		end

	raise (name: STRING) is
			-- Raise a developer exception of name `name'.
		local
			l_exception: DEVELOPER_EXCEPTION
		do
			create l_exception
			l_exception.set_message (name)
			l_exception.raise
		end

	raise_retrieval_exception (name: STRING) is
			-- Raise a retrieval exception of name `name'.
		local
			l_exception: SERIALIZATION_FAILURE
		do
			create l_exception
			l_exception.set_message (name)
			l_exception.raise
		end

	die (code: INTEGER) is
			-- Terminate execution with exit status `code',
			-- without triggering an exception.
		do
			{ENVIRONMENT}.exit (code)
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

	exception_manager: EXCEPTION_MANAGER is
			-- Exception manager
		once
			create Result
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class EXCEPTIONS


