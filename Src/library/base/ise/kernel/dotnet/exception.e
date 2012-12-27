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
			message as dotnet_message,
			make as dotnet_make
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
			-- Make `Current' with `description' set to `a_tag'.
		obsolete
			"Use `default_create' and `set_description' instead."
		require
			tag_not_void: a_tag /= Void
			trace_string_not_void: a_trace_string /= Void
		do
			set_description (a_tag)
		ensure
			description_set: attached description as l_des and then a_tag.same_string_general (l_des)
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
			-- A short message describing what current exception is
		obsolete
			"Use `tag' instead."
		do
			Result := tag.as_string_8
		end

	tag: IMMUTABLE_STRING_32
			-- A short message describing what current exception is
		once
			create Result.make_from_string_8 ("General exception")
		end

	message: detachable STRING
			-- Message of current exception
		obsolete
			"Use `description' instead."
		do
			if attached internal_description as l_m then
				Result := l_m.as_string_8
			end
		end

	description: detachable STRING_32
			-- Detailed description of current exception
		do
			if attached internal_description as l_m then
				Result := l_m.as_string_32
			end
		end

	exception_trace: detachable STRING
			-- String representation of current exception trace
		obsolete
			"Use `exception_trace_32' instead."
		do
			create Result.make_from_cil (stack_trace)
		end

	trace: detachable STRING_32
			-- String representation of current exception trace
		do
			create Result.make_from_cil (stack_trace)
		end

	code: INTEGER
			-- Code of the exception.
		do
		end

	frozen original: EXCEPTION
			-- The original exception directly triggered current exception
		local
			t: like throwing_exception
		do
			t := throwing_exception
			if t = Current or else t = Void then
				Result := Current
			elseif (attached {ROUTINE_FAILURE} Current) or else (attached {OLD_VIOLATION} Current) then
				Result := t.original
			else
				Result := Current
			end
		ensure
			original_not_void: Result /= Void
		end

	frozen cause: EXCEPTION
			-- The cause of current exception raised during rescue processing
		do
			if attached original.throwing_exception as e then
				Result := e
			else
				Result := Current
			end
		ensure
			cause_not_void: Result /= Void
		end

	frozen recipient_name: detachable STRING
			-- Name of the routine whose execution was
			-- interrupted by current exception

	frozen type_name: detachable STRING
			-- Name of the class that includes the recipient
			-- of original form of current exception

	frozen line_number: INTEGER
			-- Line number

feature -- Access obselete

	trace_as_string: detachable STRING
			-- Exception trace represented as a string
		obsolete
			"Use `exception_trace' instead."
		do
			Result := exception_trace
		end

feature -- Status settings

	set_message (a_message: like message)
			-- Set `message' with `a_message'.
		obsolete
			"Use `set_description' instead."
		do
			set_description (a_message)
		ensure
			message_set: message ~ a_message
		end

	set_description (a_description: detachable READABLE_STRING_GENERAL)
			-- Set `description' with `a_description'.
		do
			internal_description := a_description
		ensure
			description_set: (attached a_description as a_des and then attached description as l_des and then l_des.same_string (l_des)) or else
							(a_description = Void and then description = Void)
		end

feature -- Status report

	frozen is_ignorable: BOOLEAN
			-- Is current exception ignorable?
		local
			l_internal: INTERNAL
		do
			create l_internal
			if attached {TYPE [EXCEPTION]} l_internal.type_of (Current) as l_type then
				Result := exception_manager.is_ignorable (l_type)
			end
		end

	frozen is_raisable: BOOLEAN
			-- Is current exception raisable by `raise'?
		local
			l_internal: INTERNAL
		do
			create l_internal
			if attached {TYPE [EXCEPTION]} l_internal.type_of (Current) as l_type then
				Result := exception_manager.is_raisable (l_type)
			end
		end

	frozen is_ignored: BOOLEAN
			-- If set, no exception is raised.
		local
			l_internal: INTERNAL
		do
			create l_internal
			if attached {TYPE [EXCEPTION]} l_internal.type_of (Current) as l_type then
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
			if attached trace as l_t then
				Result.append_string (l_t.as_string_8)
			end
		end

feature {EXCEPTION} -- Access

	frozen throwing_exception: detachable EXCEPTION
			-- The exception throwing current exception

feature {EXCEPTION_MANAGER} -- Implementation

	frozen set_throwing_exception (a_exception: detachable EXCEPTION)
			-- Set `throwing_exception' with `a_exception'.
		do
			throwing_exception := a_exception
		ensure
			throwing_exception_set: throwing_exception = a_exception
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

	exception_message: STRING_32
		do
			Result := tag
			if Result /= Void then
				Result := {STRING_32} "Code: " + code.out + " (" + Result + ")"
			else
				Result := {STRING_32} "Code: " + code.out
			end
			if attached description as l_des then
				Result := Result + " Tag: " + l_des
			end
		end

	frozen dotnet_message: SYSTEM_STRING
			-- Message for the .NET runtime.
		do
			Result := exception_message
		end

feature {NONE} -- Implementation

	frozen internal_description: detachable READABLE_STRING_GENERAL
			-- Backend storage for description

end
