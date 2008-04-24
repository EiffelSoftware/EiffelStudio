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
	EXCEPTION_MANAGER_FACTORY

create
	default_create,
	make_with_tag_and_trace

feature {NONE} -- Initialization

	make_with_tag_and_trace (a_tag, a_trace_string: STRING) is
			-- Make `Current' with `tag' set to `a_tag'.
		obsolete
			"Use `default_create' and `set_message' instead."
		require
			tag_not_void: a_tag /= Void
			trace_string_not_void: a_trace_string /= Void
		do
			set_message (a_tag)
		ensure
			tag_set: tag.is_equal (a_tag)
		end

feature -- Raise

	raise is
			-- Raise current exception
		require
			is_raisable: is_raisable
		do
			exception_manager.raise (Current)
		end

feature -- Access

	meaning: STRING is
			-- A message in English describing what current exception is
		do
			Result := internal_meaning
		end

	message: STRING
			-- Message(Tag) of current exception

	exception_trace: STRING is
			-- String representation of current exception trace
		do
			Result := internal_trace
		end

	code: INTEGER is
			-- Code of the exception.
		do
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

feature -- Access obselete

	tag: STRING is
			-- Exception tag of `Current'
		obsolete
			"Use `message' instead."
		do
			Result := message
		end

	trace_as_string: STRING is
			-- Exception trace represented as a string
		obsolete
			"Use `exception_trace' instead."
		do
			Result := exception_trace
		end

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
			Result := exception_manager.is_ignorable (l_type)
		end

	frozen is_raisable: BOOLEAN is
			-- Is current exception raisable by `raise'?
		local
			l_internal: INTERNAL
			l_type: TYPE [EXCEPTION]
		do
			create l_internal
			l_type ?= l_internal.type_of (Current)
			Result := exception_manager.is_raisable (l_type)
		end

	frozen is_ignored: BOOLEAN is
			-- If set, current exception is not raised.
		local
			l_internal: INTERNAL
			l_type: TYPE [EXCEPTION]
		do
			create l_internal
			l_type ?= l_internal.type_of (Current)
			Result := exception_manager.is_ignored (l_type)
		ensure
			is_ignored_implies_is_ignorable: Result implies is_ignorable
			not_is_caught: Result = not is_caught
		end

	frozen is_caught: BOOLEAN is
			-- If set, current exception is raised.
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

	internal_meaning: STRING is
			-- Internal `meaning'
		once
			Result := "General exception."
		end

	frozen set_type_name (a_type: like type_name) is
			-- Set `type_name' with `a_type'
		do
			type_name := a_type
		end

	frozen internal_is_ignorable: BOOLEAN
			-- Internal `is_ignorable'

	frozen set_exception_trace (a_trace: like exception_trace) is
			-- Set `exception_trace' with `a_trace'.
		do
			internal_trace := a_trace
		end

	internal_trace: STRING
			-- String representation of the exception trace

end
