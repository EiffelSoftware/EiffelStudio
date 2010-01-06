class
	TEST

create
	make

feature -- Initialization

	make
			-- Creation procedure.
		local
			p: POINTER
			tp: TYPED_POINTER [POINTER]
			the_foo: TUPLE [ptr: TYPED_POINTER [POINTER]]
			the_foo2: TUPLE [ptr: TYPED_POINTER [POINTER]]
		do
			p := default_pointer
			tp := $p
			the_foo := [$p]
			the_foo2 := [tp]
			print (the_foo.ptr /= default_pointer) io.new_line
			print (the_foo2.ptr /= default_pointer) io.new_line
		end

end
