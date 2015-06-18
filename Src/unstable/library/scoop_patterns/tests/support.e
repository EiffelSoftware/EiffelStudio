note
	description: "Summary description for {SUPPORT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUPPORT

feature

	new_tuple_with_expanded: TUPLE [ETEST]
		local
			l_exp: ETEST
		do
			create l_exp
			Result := [l_exp]
		end

	wrap (obj: detachable separate ANY): TUPLE [detachable separate ANY]
		do
			Result := [obj]
		end

feature -- Test agents

	failing_agent
		local
			l_exception: DEVELOPER_EXCEPTION
		do
			create l_exception
			l_exception.set_description ("failing_task_test")
			l_exception.raise
		end


	fibonacci (input: INTEGER_64): INTEGER_64
			-- Compute the fibonacci number.
		local
			i, last, tmp: INTEGER_64
		do
			from
				i := 3
				last := 1
				Result := 1
			until
				i > input
			loop
				tmp := Result
				Result := Result + last
				last := tmp
				i := i + 1
			end
		end

end
