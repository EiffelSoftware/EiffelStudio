class
	EXCEPTION_MANAGER

feature -- Access

	last_exception: EXCEPTION
			-- Last exception
		do
			Result := (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.last_exception
		end

feature -- Raise

	raise (a_exception: EXCEPTION) is
			-- Raise `a_exception'.
		do
			(create {EXCEPTION_MANAGER_FACTORY}).exception_manager.raise (a_exception)
		end

feature -- Status setting

	ignore (a_exception: TYPE [EXCEPTION]) is
			-- Ignore type of `a_exception'.
		do
			(create {EXCEPTION_MANAGER_FACTORY}).exception_manager.ignore (a_exception)
		end

	catch (a_exception: TYPE [EXCEPTION]) is
			-- Set type of `a_exception' `is_caught'.
		do
			(create {EXCEPTION_MANAGER_FACTORY}).exception_manager.catch (a_exception)
		end

	set_is_ignored (a_exception: TYPE [EXCEPTION]; a_ignored: BOOLEAN) is
			-- Set type of `a_exception' to be `a_ignored'.
		do
			(create {EXCEPTION_MANAGER_FACTORY}).exception_manager.set_is_ignored (a_exception, a_ignored)
		end

feature -- Status report

	is_ignorable (a_exception: TYPE [EXCEPTION]): BOOLEAN is
			-- If set, type of `a_exception' is ignorable.
		do
			Result := (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.is_ignorable (a_exception)
		end

	is_raisable (a_exception: TYPE [EXCEPTION]): BOOLEAN is
			-- If set, type of `a_exception' is raisable.
		do
			Result := (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.is_raisable (a_exception)
		end

	is_ignored (a_exception: TYPE [EXCEPTION]): BOOLEAN is
			-- If set, type of `a_exception' is not raised.
		do
			Result := (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.is_ignored (a_exception)
		end

	is_caught (a_exception: TYPE [EXCEPTION]): BOOLEAN is
			-- If set, type of `a_exception' is raised.
		do
			Result := (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.is_caught (a_exception)
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