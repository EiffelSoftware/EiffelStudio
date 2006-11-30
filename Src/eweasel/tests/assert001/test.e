class
	TEST
inherit
	EXCEPTIONS

create
	make

feature

	make
		local
			retries: INTEGER
			a: DA
			x: X
		do
			create x
			x.f
			if retries = 0 then
				(create {DA}).call_a
			elseif retries = 1 then
				(create {DA}).call_b
			elseif retries = 2 then
				(create {DB}).call_a
				retries := 3
				(create {DB}).call_b
				retries := 4	
				(create {DA}).invariant_test
			elseif retries = 5 then
				create a.make_bad
			elseif retries = 6 then
				(create {DA}).invalidate_post
			end
		rescue
			retries := retries + 1
			if retries = 1 and exception = Precondition then
				print ("1: call_a_a caused precondition violation%N")
				retry
			elseif retries = 2 and exception = Precondition then
				print ("2: call_a_b caused precondition violation%N")
				retry
			elseif retries = 3 and exception = Precondition then
				print ("call_b_a caused precondition violation%N")
			elseif retries = 4 and exception = Precondition then
				print ("call_b_b caused precondition violation%N")
			elseif retries = 5 and exception = Class_invariant then
				print ("3: invariant_test caused invariant violation%N")
				retry
			elseif retries = 6 and exception = Class_invariant then
				print ("4: creation caused invariant violation%N")
				retry
			elseif retries = 7 and exception = Postcondition then
				print ("5: creation caused postcondition violation%N")
				retry
			else
				print ("Unexpected exception, retries = " + retries.out + "%N")
				print ("Meaning:%N")
				print (meaning (exception))
				io.new_line
			end
		end


end
