note
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
			dotnet_message, out
		end

	EXCEPTION_MANAGER_FACTORY
		redefine
			out
		end

create
	default_create,
	make_with_tag_and_trace

feature {NONE} -- Initialization

	make_with_tag_and_trace (a_tag, a_trace_string: STRING)
			-- Make `Current' with `tag' set to `a_tag'.
		obsolete
			"Use `default_create' and `set_message' instead."
		require
			tag_not_void: a_tag /= Void
			trace_string_not_void: a_trace_string /= Void
		do
			set_message (a_tag)
		ensure
			tag_set: tag ~ a_tag
		end

feature -- Raise

	raise
			-- Raise current exception
		require
			is_raisable: is_raisable
		do
			exception_manager.raise (Current)
		end

feature -- Access

	meaning: STRING
			-- A message in English describing what `except' is
		do
			Result := internal_meaning
		end

	message: ?STRING
			-- A message in English describing what `except' is

	exception_trace: ?STRING
			-- String representation of current exception trace
		do
			create Result.make_from_cil (stack_trace)
		end

	frozen original: EXCEPTION
			-- The original exception caused current exception
		do
			if {l_throwing_exception: like throwing_exception} throwing_exception and then l_throwing_exception /= Current then
				Result := l_throwing_exception.original
			else
				Result := Current
			end
		ensure
			original_not_void: Result /= Void
		end

	code: INTEGER
			-- Code of the exception.
		do
		end

	frozen throwing_exception: ?EXCEPTION
			-- The exception throwing current exception

	frozen recipient_name: ?STRING
			-- Name of the routine whose execution was
			-- interrupted by current exception

	frozen type_name: ?STRING
			-- Name of the class that includes the recipient
			-- of original form of current exception

	frozen line_number: INTEGER
			-- Line number

feature -- Access obselete

	tag: ?STRING
			-- Exception tag of `Current'
		obsolete
			"Use `message' instead."
		do
			Result := message
		end

	trace_as_string: ?STRING
			-- Exception trace represented as a string
		obsolete
			"Use `exception_trace' instead."
		do
			Result := exception_trace
		end

feature -- Status settings

	set_message (a_message: like message)
			-- Set `message' with `a_message'.
		do
			message := a_message
		ensure
			message_set: equal (message, a_message)
		end

feature -- Status report

	frozen is_ignorable: BOOLEAN
			-- Is current exception ignorable?
		local
			l_internal: INTERNAL
		do
			create l_internal
			if {l_type: TYPE [EXCEPTION]} l_internal.type_of (Current) then
				Result := exception_manager.is_ignorable (l_type)
			end
		end

	frozen is_raisable: BOOLEAN
			-- Is current exception raisable by `raise'?
		local
			l_internal: INTERNAL
		do
			create l_internal
			if {l_type: TYPE [EXCEPTION]} l_internal.type_of (Current) then
				Result := exception_manager.is_raisable (l_type)
			end
		end

	frozen is_ignored: BOOLEAN
			-- If set, no exception is raised.
		local
			l_internal: INTERNAL
		do
			create l_internal
			if {l_type: TYPE [EXCEPTION]} l_internal.type_of (Current) then
				Result := exception_manager.is_ignored (l_type)
			end
		ensure
			is_ignored_implies_is_ignorable: Result implies is_ignorable
			not_is_caught: Result = not is_caught
		end

	frozen is_caught: BOOLEAN
			-- If set, exception is raised.
		do
			Result := not is_ignored
		ensure
			not_is_caught_implies_is_ignorable: not Result implies is_ignorable
			not_is_ignored: Result = not is_ignored
		end

feature -- Output

	out: STRING
			-- New string containing terse printable representation
			-- of current object
		do
			Result := generating_type
			Result.append_character ('%N')
			Result.append_string (exception_trace)
		end

feature {EXCEPTION_MANAGER} -- Implementation

	frozen set_throwing_exception (a_exception: ?EXCEPTION)
			-- Set `throwing_exception' with `a_exception'.
		require
			not_throwing_a_exception: a_exception /= Void implies not is_throwing (a_exception)
		do
			throwing_exception := a_exception
		ensure
			throwing_exception_set: throwing_exception = a_exception
		end

	frozen is_throwing (a_exception: EXCEPTION): BOOLEAN
			-- Is current exception throwing `a_exception'?
			-- If the throwing exception is current, return False.
		require
			a_exception_not_viod: a_exception /= Void
		local
			l_exception: ?EXCEPTION
			l_stop: BOOLEAN
		do
			if a_exception /= Current and then a_exception.throwing_exception /= a_exception then
				from
					l_exception := a_exception.throwing_exception
				until
					l_exception = Void or else l_stop
				loop
					if l_exception = Current then
						Result := True
						l_stop := True
					elseif l_exception = l_exception.throwing_exception then
							-- Allow self-throwing.
							-- In this case, no possibility to throw `a_exception'.
						Result := False
						l_stop := True
					else
						l_exception := l_exception.throwing_exception
					end
				end
			end
		end

	frozen set_type_name (a_type: like type_name)
			-- Set `type_name' with `a_type'
		do
			type_name := a_type
		end

	frozen set_recipient_name (a_name: like recipient_name)
			-- Set `recipient_name' with `a_name'
		do
			recipient_name := a_name
		end

	frozen set_line_number (a_number: like line_number)
			-- Set `line_number' with `a_number'.
		do
			line_number := a_number
		end

	frozen internal_is_ignorable: BOOLEAN
			-- Internal `is_ignorable'

	internal_meaning: STRING
			-- Internal `meaning'
		once
			Result := "General exception."
		end

	exception_message: STRING
		do
			Result := internal_meaning
			if Result /= Void then
				Result := "Code: " + code.out + " (" + Result + ")"
			else
				Result := "Code: " + code.out
			end
			if {l_message: like message} message then
				Result := Result + " Tag: " + l_message
			end
		end

	frozen dotnet_message: SYSTEM_STRING
			-- Message for the .NET runtime.
		do
			Result := exception_message
		end

end
