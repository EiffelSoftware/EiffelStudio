class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			execute_byte_code
		end

	execute_byte_code is
		do
				-- Please comment out the following line, and do a c compilation.
				-- After that, uncomment the line and then do a melting.
				-- And then execute the application.
$COMMENT			record_query (agent foo)
		end

	record_query (a_query: FUNCTION [ANY, TUPLE, detachable ANY]) is
		require
			a_query_attached: a_query /= Void
		local
			l_retried: BOOLEAN
			l_result: detachable ANY
		do
			if not l_retried then
				l_result := a_query.item ([])
			end
		rescue
			l_retried := True
			retry
		end

	foo: INTEGER is
		do
		ensure
			Result = 1
		end

end
