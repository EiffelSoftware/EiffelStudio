indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	A
create
	default_create
feature
	a (n: INTEGER)
		require
			(agent: BOOLEAN 
				require 
					(agent: BOOLEAN do print ("I should not be seen 1 !%N") end).item ([])
				local
					l: DA
				do
					create l.make_bad;
					(create {A}).inv_invariant
					Result := True
				ensure
					(agent: BOOLEAN do print ("I should not be seen 2 !%N") end).item ([])
				end).item ([])
			n > 11
		do
		end

	call_a
		do
			(create {DA}).a (0)
		end

	call_b
		do
			(create {DB}).b (0)
		end

	invariant_test
		do
			inv_invariant
			print ("Invalidated invariant without violation %N")
		end

	inv_invariant
		do
			number := 10
		end
	
	number: INTEGER

	number_p: INTEGER
		do
			Result := number + 1
		end

	invalidate_post
		do
		ensure
			(agent (nu: INTEGER): BOOLEAN do Result := True; print (nu.out + "%N") end (old number_p)).item ([]) and then
			number = old number_p
		end
	
invariant
	number = 0

end
