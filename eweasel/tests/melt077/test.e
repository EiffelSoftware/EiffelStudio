class
	TEST

create
	make

feature -- Initialization

	make
			-- Creation procedure.
		local
			l_null: POINTER
			tp: TYPED_POINTER [POINTER]
			tu: TUPLE [ptr: TYPED_POINTER [POINTER]]
		do
			tp := $l_null
			tu := [tp]
			if tu.ptr = l_null then
				io.put_string ("Not OK%N")
			end

			tu := [$l_null]
			if tu.ptr = l_null then
				io.put_string ("Not OK%N")
			end

			tu := [$(default_pointer)]
			if tu.ptr = l_null then
				io.put_string ("Not OK%N")
			end

			tu := [$(default_pointer.default_pointer)]
			if tu.ptr = l_null then
				io.put_string ("Not OK%N")
			end
		end

end
