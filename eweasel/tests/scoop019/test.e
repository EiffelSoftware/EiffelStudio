class TEST

create
	default_create, make

feature {NONE} -- Creation

        make
        	local
        		t: separate TEST
		do
			create t
				-- The following calls always perform an unlock operation, so none of them should propagate an exception.
			io.put_integer (1); p (t) -- Command without exception: OK
			io.put_integer (2); r (t) -- Query: OK
			io.put_integer (3); f (t) -- Command with exception: OK
			io.put_integer (4); p (t) -- Command without exception: OK
			io.put_integer (5); r (t) -- Query: OK
			io.put_integer (6); p (t) -- Command without exception: OK
			io.put_new_line

				-- Re-execute the tests while holding a lock on t.
			make_controlled (t)
		rescue
			io.put_integer (7) -- Should not get here.
			io.put_new_line
			;(create {EXCEPTIONS}).die (0)
		end

	make_controlled (t: separate TEST)
		do
			io.put_integer (1); p (t) -- Command without exception: OK
			io.put_integer (2); r (t) -- Query: OK
			io.put_integer (3); f (t) -- Command with exception: OK
			io.put_integer (4); p (t) -- Command without exception: OK
			io.put_integer (5); r (t) -- Query: FAIL
			io.put_integer (6); p (t) -- Should not get here
			io.put_new_line
		rescue
			io.put_integer (7) -- The exception should be caught here.
			io.put_new_line
			;(create {EXCEPTIONS}).die (0)
		end

feature -- Access

	p (t: separate TEST)
		do
			t.pass
		end

	f (t: separate TEST)
		do
			t.fail
		end

	r (t: separate TEST)
		do
			t.out.do_nothing
		end

	pass
		do
		end
	
	fail
		do
			(create {EXCEPTIONS}).raise ("FAIL")
		end

end
