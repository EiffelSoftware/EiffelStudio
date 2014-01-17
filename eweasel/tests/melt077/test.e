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
				io.put_string ("Not OK via local%N")
			end

			tu := [$l_null]
			if tu.ptr = l_null then
				io.put_string ("Not OK via manifest tuple%N")
			end

			tu.ptr := $l_null
			if tu.ptr = l_null then
				io.put_string ("Not OK via tuple assignment%N")
			end
		end

end
