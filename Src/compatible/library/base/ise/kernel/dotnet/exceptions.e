note

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

	EXCEPTION_MANAGER_FACTORY

feature -- Status report

	meaning (except: INTEGER): detachable STRING
			-- A message in English describing what `except' is
		local
			l_exception: detachable EXCEPTION
		do
			l_exception := exception_manager.exception_from_code (except)
			if l_exception /= Void then
				Result := l_exception.meaning
			end
		end

	assertion_violation: BOOLEAN
			-- Is last exception originally due to a violated
			-- assertion or non-decreasing variant?
		do
			Result := attached {EXCEPTION} exception_manager.last_exception as l_exception and then
						attached {ASSERTION_VIOLATION} l_exception.original as l_av
		end

	is_developer_exception: BOOLEAN
			-- Is the last exception originally due to
			-- a developer exception?
		do
			Result := attached {EXCEPTION} exception_manager.last_exception as l_exception and then
						attached {DEVELOPER_EXCEPTION} l_exception.original as l_de
		end

	is_developer_exception_of_name (name: detachable STRING): BOOLEAN
			-- Is the last exception originally due to a developer
			-- exception of name `name'?
		do
			if is_developer_exception then
				Result := equal (name, developer_exception_name)
			end
		end

	developer_exception_name: detachable STRING
			-- Name of last developer-raised exception
		require
			applicable: is_developer_exception
		do
			if attached {EXCEPTION} exception_manager.last_exception as l_exception then
				Result := l_exception.original.message
			end
		end

	is_signal: BOOLEAN
			-- Is last exception originally due to an external
			-- event (operating system signal)?
		do
			if attached {EXCEPTION} exception_manager.last_exception as l_exception then
				Result := attached {OPERATING_SYSTEM_SIGNAL_FAILURE} l_exception.original as l_sf
			end
		end

	is_system_exception: BOOLEAN
			-- Is last exception originally due to an
			-- external event (operating system error)?
		local
			l_exception, l_external: detachable EXCEPTION
		do
			l_exception := exception_manager.last_exception
			l_external := exception_manager.exception_from_code (external_exception)
			if l_exception /= Void and then l_external /= Void then
				Result := l_exception.original.conforms_to (l_external)
				if not Result then
					Result := attached {OPERATING_SYSTEM_FAILURE} l_exception.original as l_system_failure
				end
			end
		end

	tag_name: detachable STRING
			-- Tag of last violated assertion clause
		do
			if attached {EXCEPTION} exception_manager.last_exception as l_exception then
				Result := l_exception.message
			end
		end

	recipient_name: detachable STRING
			-- Name of the routine whose execution was
			-- interrupted by last exception
		do
			if attached {EXCEPTION} exception_manager.last_exception as l_exception then
				Result := l_exception.recipient_name
			end
		end

	class_name: detachable STRING
			-- Name of the class that includes the recipient
			-- of original form of last exception
		do
			if attached {EXCEPTION} exception_manager.last_exception as l_exception then
				Result := l_exception.type_name
			end
		end

	exception: INTEGER
			-- Code of last exception that occurred
		do
			if attached {EXCEPTION} exception_manager.last_exception as l_exception then
				Result := l_exception.code
			end
		end

	exception_trace: detachable STRING
			-- String representation of the exception trace
		do
			if attached {EXCEPTION} exception_manager.last_exception as l_exception then
				Result := l_exception.original.exception_trace
			end
		end

	original_tag_name: detachable STRING
			-- Assertion tag for original form of last
			-- assertion violation.
		do
			if attached {EXCEPTION} exception_manager.last_exception as l_exception then
				Result := l_exception.cause.original.message
			end
		end

	original_exception: INTEGER
			-- Original code of last exception that triggered
			-- current exception
		do
			if attached {EXCEPTION} exception_manager.last_exception as l_exception then
				Result := l_exception.cause.original.code
			end
		end

	original_recipient_name: detachable STRING
			-- Name of the routine whose execution was
			-- interrupted by original form of last exception
		do
			if attached {EXCEPTION} exception_manager.last_exception as l_exception then
				Result := l_exception.cause.original.recipient_name
			end
		end

	original_class_name: detachable STRING
			-- Name of the class that includes the recipient
			-- of original form of last exception
		do
			if attached {EXCEPTION} exception_manager.last_exception as l_exception then
				Result := l_exception.cause.original.type_name
			end
		end

feature -- Status setting

	catch (code: INTEGER)
			-- Make sure that any exception of code `code' will be
			-- caught. This is the default.
		local
			l_type: detachable TYPE [EXCEPTION]
		do
			l_type := exception_manager.type_of_code (code)
			if l_type /= Void then
				exception_manager.catch (l_type)
			end
		end

	ignore (code: INTEGER)
			-- Make sure that any exception of code `code' will be
			-- ignored. This is not the default.
		local
			l_type: detachable TYPE [EXCEPTION]
		do
			l_type := exception_manager.type_of_code (code)
			if l_type /= Void then
				exception_manager.ignore (l_type)
			end
		end

	raise (name: detachable STRING)
			-- Raise a developer exception of name `name'.
		local
			l_exception: DEVELOPER_EXCEPTION
		do
			create l_exception
			l_exception.set_message (name)
			l_exception.raise
		end

	raise_retrieval_exception (name: detachable STRING)
			-- Raise a retrieval exception of name `name'.
		local
			l_exception: detachable EXCEPTION
		do
			l_exception := exception_manager.exception_from_code (serialization_exception)
			if l_exception /= Void then
				l_exception.set_message (name)
				l_exception.raise
			end
		end

	die (code: INTEGER)
			-- Terminate execution with exit status `code',
			-- without triggering an exception.
		do
			{ENVIRONMENT}.exit (code)
		end

	new_die (code: INTEGER) obsolete "Use ``die''"
			-- Terminate execution with exit status `code',
			-- without triggering an exception.
		do
			die (code)
		end

	message_on_failure
			-- Print an exception history table
			-- in case of failure.
			-- This is the default.
		do
			check
				False
				--| Not supported.
			end
		end

	no_message_on_failure
			-- Do not print an exception history table
			-- in case of failure.
		do
			check
				False
				--| Not supported.
			end
		end

note
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


