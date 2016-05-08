note

	description:

		"Interface for exception handling"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class KI_EXCEPTIONS

feature -- Status report

	exception_trace: detachable STRING
			-- String representation of the exception trace;
			-- Note that the string may be Void or always return
			-- the same object depending on the implementation.
		deferred
		end

	exception: INTEGER
			-- Code of last exception that occurred
		deferred
		end

	is_developer_exception: BOOLEAN
			-- Is the last exception originally due to
			-- a developer exception?
		deferred
		end

	is_developer_exception_of_name (name: detachable STRING): BOOLEAN
			-- Is the last exception originally due to a developer
			-- exception of name `name'?
		deferred
		end

	developer_exception_name: detachable STRING
			-- Name of last developer-raised exception
		require
			applicable: is_developer_exception
		deferred
		end

feature -- Status setting

	raise (a_name: detachable STRING)
			-- Raise a developer exception of name `a_name'.
		deferred
		end

	die (a_code: INTEGER)
			-- Terminate execution with exit status `a_code',
			-- without triggering an exception.
		deferred
		end

end
