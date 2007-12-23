class
	EXCEPTION

feature -- Raise

	raise is
			-- Raise current exception
		do
		end

feature -- Access

	meaning: STRING is
			-- A message in English describing what `except' is
		do
		end

	message: STRING
			-- Message(Tag) of current exception

	exception_trace: STRING is
			-- String representation of current exception trace
		do
		end

	frozen original: EXCEPTION is
			-- The original exception caused current exception
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

	code: INTEGER is
			-- Code of the exception.
		do
		end

	line_number: INTEGER
			-- Line number

feature -- Status settings

	set_message (a_message: like message) is
			-- Set `message' with `a_message'.
		do
		end

feature -- Status report

	frozen is_ignorable: BOOLEAN is
			-- Is current exception ignorable?
		do
		end

	frozen is_raisable: BOOLEAN is
			-- Is current exception raisable by `raise'?
		do
		end

	frozen is_ignored: BOOLEAN is
			-- If set, no exception is raised.
		do
		end

	frozen is_caught: BOOLEAN is
			-- If set, exception is raised.
		do
		end

feature {EXCEPTION_MANAGER} -- Implementation

	frozen set_throwing_exception (a_exception: EXCEPTION) is
			-- Set `throwing_exception' with `a_exception'.
		do
		end

	frozen is_throwing (a_exception: EXCEPTION): BOOLEAN is
			-- Is current exception throwing `a_exception'?
			-- If the throwing exception is current, return False.
		do
		end

	set_recipient_name (a_name: like recipient_name) is
			-- Set `recipient_name' with `a_name'
		do
			recipient_name := a_name
		end

	internal_meaning: STRING is
			-- Internal `meaning'
		once
			Result := "General exception."
		end

	frozen set_type_name (a_type: like type_name) is
			-- Set `type_name' with `a_type'
		do
		end

	frozen internal_is_ignorable: BOOLEAN
			-- Internal `is_ignorable'

	frozen exception_manager: EXCEPTION_MANAGER is
		once
			create Result
		end
		
	frozen set_exception_trace (a_trace: like exception_trace) is
			-- Set `exception_trace' with `a_trace'.
		do
		end

	internal_trace: STRING
			-- String representation of the exception trace


end
