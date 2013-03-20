note
	description: "[
		Ancestor of all exception classes.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2008, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	EXCEPTION

inherit
	EXCEPTION_MANAGER_FACTORY
		undefine
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
			-- A message in English describing what current exception is
		do
			Result := internal_meaning
		end

	message: detachable STRING
			-- Message(Tag) of current exception
		local
			m: detachable C_STRING
		do
			m := c_message
			if m /= Void then
				Result := m.substring (1, m.count)
			end
		end

	exception_trace: detachable STRING
			-- String representation of current exception trace
		do
			Result := internal_trace
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

	tag: detachable STRING
			-- Exception tag of `Current'
		obsolete
			"Use `message' instead."
		do
			Result := message
		end

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
		do
			if a_message /= Void then
				create c_message.make (a_message)
			else
				c_message := Void
			end
		ensure
			message_set: message ~ a_message
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
			-- If set, current exception is not raised.
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
			-- If set, current exception is raised.
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
		local
			t: detachable STRING
		do
			Result := generating_type
			t := exception_trace
			if t /= Void then
				Result.append_character ('%N')
				Result.append_string (t)
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

	c_message: detachable C_STRING
			-- Message, stored as C string to keep it alive and usable by the runtime trace printing.		

	internal_meaning: STRING
			-- Internal `meaning'
		once
			Result := "General exception."
		end

	frozen set_type_name (a_type: like type_name)
			-- Set `type_name' with `a_type'
		do
			type_name := a_type
		end

	frozen internal_is_ignorable: BOOLEAN
			-- Internal `is_ignorable'

	frozen set_exception_trace (a_trace: like exception_trace)
			-- Set `exception_trace' with `a_trace'.
		do
			internal_trace := a_trace
		end

	internal_trace: detachable STRING
			-- String representation of the exception trace

end
