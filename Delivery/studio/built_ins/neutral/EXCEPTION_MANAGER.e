class
	EXCEPTION_MANAGER

feature -- Access

	last_exception: EXCEPTION
			-- Last exception
		do
		end

feature -- Raise

	raise (a_exception: EXCEPTION) is
			-- Raise `a_exception'.
		do
		end

feature -- Status setting

	ignore (a_exception: TYPE [EXCEPTION]) is
			-- Ignore type of `a_exception'.
		do
		end

	catch (a_exception: TYPE [EXCEPTION]) is
			-- Set type of `a_exception' `is_caught'.
		do
		end

	set_is_ignored (a_exception: TYPE [EXCEPTION]; a_ignored: BOOLEAN) is
			-- Set type of `a_exception' to be `a_ignored'.
		do
		end

feature -- Status report

	is_ignorable (a_exception: TYPE [EXCEPTION]): BOOLEAN is
			-- If set, type of `a_exception' is ignorable.
		do
		end

	is_raisable (a_exception: TYPE [EXCEPTION]): BOOLEAN is
			-- If set, type of `a_exception' is raisable.
		do
		end

	is_ignored (a_exception: TYPE [EXCEPTION]): BOOLEAN is
			-- If set, type of `a_exception' is not raised.
		do
		end

	is_caught (a_exception: TYPE [EXCEPTION]): BOOLEAN is
			-- If set, type of `a_exception' is raised.
		do
		end

feature {EXCEPTIONS} -- Backward compatibility support

	type_of_code (a_code: INTEGER): TYPE [EXCEPTION]
			-- Exception type of `a_code'
		do
		end

	exception_from_code (a_code: INTEGER): EXCEPTION is
			-- Create exception object from `a_code'
		do
		end

end