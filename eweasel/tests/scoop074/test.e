class TEST

inherit
	ANY
		redefine
			out
		end

create
	default_create,
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		do
			foo (create {separate TEST})
		end

feature {NONE} -- Test

	foo (t: separate TEST)
			-- Access `t' using an object test local.
		local
			s: STRING
		do
			if attached t as x then
				io.put_string ("Test 1: ")
				io.put_string (create {STRING}.make_from_separate (x.out))
				io.put_new_line
			end
			if attached t.out as x then
				io.put_string ("Test 2: ")
				io.put_string (create {STRING}.make_from_separate (x.out))
				io.put_new_line
			end
		end

feature -- Output

	out: STRING
		do
			Result := "OK"
		end

end
