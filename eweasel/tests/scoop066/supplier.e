note
	description: "A supplier class with several different queries and commands."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	SUPPLIER

create
	make

feature {NONE} -- Initialization

	make (a_shared: like shared)
			-- Initialization for `Current'.
		do
			shared := a_shared
		end

feature -- Access

	shared: separate ANY
			-- The shared object.

	simple_query: INTEGER
		do
			Result := 42
		end

	regular_lockpassing (arg: separate ANY): INTEGER
			-- A stub query.
		do
			arg.default_pointer.do_nothing
			Result := 42
		end

	passive_query_lockpassing: INTEGER
		do
			lock_shared (shared)
			Result := 42
		end

	passive_command_lockpassing
		do
			lock_shared (shared)
		end

	callback_query (a_test: separate TEST): INTEGER
		do
			a_test.out.do_nothing
			Result := 42
		end

	callback_command (a_test: separate TEST)
		do
			a_test.out.do_nothing
		end

feature {NONE} -- Implementation

	lock_shared (a_shared: like shared)
		do
			a_shared.out.do_nothing
		end

end
