indexing
	description: "[
		Ancestor of all exception classes.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	EXCEPTION

inherit
	APPLICATION_EXCEPTION
		rename
			message as dotnet_message
		redefine
			dotnet_message
		end

feature -- Raise

	raise is
			-- Raise current exception
		require
			is_raisable: is_raisable
		do
			(create {EXCEPTION_MANAGER}).raise (Current)
		end

feature -- Access

	meaning: STRING is
			-- A message in English describing what `except' is
		do
			Result := internal_meaning
		end

	message: STRING
			-- A message in English describing what `except' is

	exception_trace: STRING is
			-- String representation of current exception trace
		do
			create Result.make_from_cil (stack_trace)
		end

	frozen original: EXCEPTION is
			-- The original exception caused current exception
		do
			if throwing_exception = Current or else throwing_exception = Void then
				Result := Current
			else
				Result := throwing_exception.original
			end
		ensure
			original_not_void: Result /= Void
		end

	code: INTEGER is
			-- Code of the exception.
		do
		end

	frozen throwing_exception: EXCEPTION
			-- The exception throwing current exception

	frozen recipient_name: STRING
			-- Name of the routine whose execution was
			-- interrupted by current exception

	frozen type_name: STRING
			-- Name of the class that includes the recipient
			-- of original form of current exception

	frozen line_number: INTEGER
			-- Line number

feature -- Status settings

	set_message (a_message: like message) is
			-- Set `message' with `a_message'.
		do
			message := a_message
		ensure
			message_set: message = a_message
		end

feature -- Status report

	frozen is_ignorable: BOOLEAN is
			-- Is current exception ignorable?
		local
			l_internal: INTERNAL
			l_type: TYPE [EXCEPTION]
		do
			create l_internal
			l_type ?= l_internal.type_of (Current)
			Result := (create {EXCEPTION_MANAGER}).is_ignorable (l_type)
		end

	frozen is_raisable: BOOLEAN is
			-- Is current exception raisable by `raise'?
		local
			l_internal: INTERNAL
			l_type: TYPE [EXCEPTION]
		do
			create l_internal
			l_type ?= l_internal.type_of (Current)
			Result := (create {EXCEPTION_MANAGER}).is_raisable (l_type)
		end

	frozen is_ignored: BOOLEAN is
			-- If set, no exception is raised.
		local
			l_internal: INTERNAL
			l_type: TYPE [EXCEPTION]
		do
			create l_internal
			l_type ?= l_internal.type_of (Current)
			Result := (create {EXCEPTION_MANAGER}).is_ignored (l_type)
		ensure
			is_ignored_implies_is_ignorable: Result implies is_ignorable
			not_is_caught: Result = not is_caught
		end

	frozen is_caught: BOOLEAN is
			-- If set, exception is raised.
		do
			Result := not is_ignored
		ensure
			not_is_caught_implies_is_ignorable: not Result implies is_ignorable
			not_is_ignored: Result = not is_ignored
		end

feature {EXCEPTION_MANAGER} -- Implementation

	frozen set_throwing_exception (a_exception: EXCEPTION) is
			-- Set `throwing_exception' with `a_exception'.
		require
			not_throwing_a_exception: a_exception /= Void implies not is_throwing (a_exception)
		do
			throwing_exception := a_exception
		ensure
			throwing_exception_set: throwing_exception = a_exception
		end

	frozen is_throwing (a_exception: EXCEPTION): BOOLEAN is
			-- Is current exception throwing `a_exception'?
			-- If the throwing exception is current, return False.
		require
			a_exception_not_viod: a_exception /= Void
		local
			l_exception: EXCEPTION
		do
			if a_exception /= Current and then a_exception.throwing_exception /= a_exception then
				from
					l_exception := a_exception.throwing_exception
				until
					l_exception = Void or else Result
				loop
					if l_exception = Current then
						Result := True
					else
						l_exception := l_exception.throwing_exception
					end
				end
			end
		end

	frozen set_type_name (a_type: like type_name) is
			-- Set `type_name' with `a_type'
		do
			type_name := a_type
		end

	frozen set_recipient_name (a_name: like recipient_name) is
			-- Set `recipient_name' with `a_name'
		do
			recipient_name := a_name
		end

	frozen set_line_number (a_number: like line_number) is
			-- Set `line_number' with `a_number'.
		do
			line_number := a_number
		end

	frozen internal_is_ignorable: BOOLEAN
			-- Internal `is_ignorable'

	internal_meaning: STRING is
			-- Internal `meaning'
		once
			Result := "General exception."
		end

	exception_message: STRING is
		do
			Result := internal_meaning
			if Result /= Void then
				Result := "Code: " + code.out + " (" + Result + ")"
			else
				Result := "Code: " + code.out
			end
			if message /= Void then
				Result := Result + " Tag: " + message
			end
		end

	frozen dotnet_message: SYSTEM_STRING is
			-- Message for the .NET runtime.
		do
			Result := exception_message
		end

end
