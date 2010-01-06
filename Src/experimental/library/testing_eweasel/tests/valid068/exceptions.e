indexing
	description: "[
		Facilities for adapting the exception handling mechanism.
		This class may be used as ancestor by classes needing its facilities.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2004, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EXCEPTIONS

inherit

	EXCEP_CONST

feature -- Status report

	meaning (except: INTEGER): STRING is
			-- A message in English describing what `except' is
		do
		end

	assertion_violation: BOOLEAN is
			-- Is last exception originally due to a violated
			-- assertion or non-decreasing variant?
		do
		end

	is_developer_exception: BOOLEAN is
			-- Is the last exception originally due to
			-- a developer exception?
		do
		end

	is_developer_exception_of_name (name: STRING): BOOLEAN is
			-- Is the last exception originally due to a developer
			-- exception of name `name'?
		do
		end

	developer_exception_name: STRING is
			-- Name of last developer-raised exception
		do
		end

	is_signal: BOOLEAN is
			-- Is last exception originally due to an external
			-- event (operating system signal)?
		do
		end

	is_system_exception: BOOLEAN is
			-- Is last exception originally due to an
			-- external event (operating system error)?
		do
		end

	tag_name: STRING is
			-- Tag of last violated assertion clause
		do
		end

	recipient_name: STRING is
			-- Name of the routine whose execution was
			-- interrupted by last exception
		do
		end

	class_name: STRING is
			-- Name of the class that includes the recipient
			-- of original form of last exception
		do
		end

	exception: INTEGER is
			-- Code of last exception that occurred
		do
		end

	exception_trace: STRING is
			-- String representation of the exception trace
		do
		end

	original_tag_name: STRING is
			-- Assertion tag for original form of last
			-- assertion violation.
		do
		end

	original_exception: INTEGER is
			-- Original code of last exception that triggered
			-- current exception
		do
		end

	original_recipient_name: STRING is
			-- Name of the routine whose execution was
			-- interrupted by original form of last exception
		do
		end

	original_class_name: STRING is
			-- Name of the class that includes the recipient
			-- of original form of last exception
		do
		end

feature -- Status setting

	catch (code: INTEGER) is
			-- Make sure that any exception of code `code' will be
			-- caught. This is the default.
		do
		end

	ignore (code: INTEGER) is
			-- Make sure that any exception of code `code' will be
			-- ignored. This is not the default.
		do
		end

	raise (name: STRING) is
			-- Raise a developer exception of name `name'.
		do
		end

	raise_retrieval_exception (name: STRING) is
			-- Raise a retrieval exception of name `name'.
		do
		end

	die (code: INTEGER) is
			-- Terminate execution with exit status `code',
			-- without triggering an exception.
		do
		end

	new_die (code: INTEGER) is obsolete "Use ``die''"
			-- Terminate execution with exit status `code',
			-- without triggering an exception.
		do
		end

	message_on_failure is
			-- Print an exception history table
			-- in case of failure.
			-- This is the default.
		do
		end

	no_message_on_failure is
			-- Do not print an exception history table
			-- in case of failure.
		do
		end

end
