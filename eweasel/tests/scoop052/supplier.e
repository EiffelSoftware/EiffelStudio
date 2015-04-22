note
	description: "A supplier that locks a third processor and then fails."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	SUPPLIER

feature -- Access

	perform_query: INTEGER
			-- A stub query.
		local
			proc: separate ANY
		do
			create proc
			sync_and_fail (proc)
			Result := 42
		end

	perform_callback (a_test: separate TEST): INTEGER
			-- Perform a separate callback on a_test.
		do
			Result := a_test.perform_query
		end

feature {NONE} -- Implementation

	sync_and_fail (a_proc: separate ANY)
			-- Make sure we logged a call to `a_proc', and then fail.
		local
			sync: POINTER
		do
			sync := a_proc.default_pointer;
			(create {DEVELOPER_EXCEPTION}).raise
		end

end
