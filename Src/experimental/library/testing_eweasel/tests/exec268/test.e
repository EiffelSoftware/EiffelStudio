class
	TEST

create
	make

feature -- Initialization

	make is
		local
			l_int: INTEGER
		do
			l_int := 1
			goo (l_int)
		end

	goo (a_any: ANY) is
		local
			l_agent: PROCEDURE [ANY, TUPLE [ANY]]
		do
			l_agent := agent foo
			l_agent.call ([a_any])
		end

	foo (a_integer: INTEGER) is
		do
			io.put_integer (a_integer)
			io.put_string ("%N")
		end

end

