class
	EXCEPTION

feature -- Raise

	raise
			-- Raise current exception
		do
		end

feature -- Access

	meaning: STRING
			-- A message in English describing what `except' is
		do
		end

	tag: IMMUTABLE_STRING_32
		do
		end

	description: READABLE_STRING_GENERAL
		do
		end

	message: STRING
			-- Message(Tag) of current exception

	exception_trace: STRING
			-- String representation of current exception trace
		do
		end

	trace: STRING_32
		do
		end

	frozen original: EXCEPTION
			-- The original exception caused current exception
		do
		end
		
	frozen cause: EXCEPTION
			-- The cause of current exception raised during rescue processing
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

	code: INTEGER
			-- Code of the exception.
		do
		end

	line_number: INTEGER
			-- Line number

feature -- Status settings

	set_message (a_message: like message)
			-- Set `message' with `a_message'.
		do
		end

	set_description (a_description: detachable READABLE_STRING_GENERAL)
			-- Set `description' with `a_description'.
		do
		end

feature -- Status report

	frozen is_ignorable: BOOLEAN
			-- Is current exception ignorable?
		do
		end

	frozen is_raisable: BOOLEAN
			-- Is current exception raisable by `raise'?
		do
		end

	frozen is_ignored: BOOLEAN
			-- If set, no exception is raised.
		do
		end

	frozen is_caught: BOOLEAN
			-- If set, exception is raised.
		do
		end

feature {EXCEPTION_MANAGER} -- Implementation

	frozen set_throwing_exception (a_exception: EXCEPTION)
			-- Set `throwing_exception' with `a_exception'.
		do
		end

	frozen is_throwing (a_exception: EXCEPTION): BOOLEAN
			-- Is current exception throwing `a_exception'?
			-- If the throwing exception is current, return False.
		do
		end

	set_recipient_name (a_name: like recipient_name)
			-- Set `recipient_name' with `a_name'
		do
			recipient_name := a_name
		end

	internal_meaning: STRING
			-- Internal `meaning'
		once
			Result := "General exception."
		end

	frozen set_type_name (a_type: like type_name)
			-- Set `type_name' with `a_type'
		do
		end

	frozen internal_is_ignorable: BOOLEAN
			-- Internal `is_ignorable'

	frozen exception_manager: EXCEPTION_MANAGER
		once
			create Result
		end
		
	frozen set_exception_trace (a_trace: like exception_trace)
			-- Set `exception_trace' with `a_trace'.
		do
		end

	internal_trace: STRING
			-- String representation of the exception trace


end
