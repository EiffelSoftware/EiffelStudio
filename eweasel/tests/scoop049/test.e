note
	description: "Test if lock passing works correctly when the impersonation mechanism is used."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make, default_create

feature

	make
			-- Run the test.
		local
			l_test: separate TEST
		do
			create l_test
			run (l_test)
		end

	run (test: separate TEST)
		do
				-- This is a regular separate query.
			sync := test.sync_with_lockpassing (Current)
			print ("No deadlock occurred.%N")
				-- As we are synchronized now, the next query
				-- uses the impersonation mechanism is executed
				-- by the current thread.
			sync := test.sync_with_lockpassing (Current)
			print ("No deadlock occurred.%N")
		end

	sync_with_lockpassing (test: separate TEST): INTEGER
		do
			sync := test.sync
		end

	sync: INTEGER

end
