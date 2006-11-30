class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			l_agent: PROCEDURE [ANY, TUPLE [BOOLEAN]]
		do
			test (False)
			l_agent := agent test({BOOLEAN}?)
			l_agent.call ([False])
		end

	test (a_value: ANY) is
		require
			a_value_not_void: a_value /= Void
		do
			print (a_value)
		end
end
