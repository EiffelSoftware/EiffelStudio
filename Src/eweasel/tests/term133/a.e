class A [G]

feature -- Tests

	test (name: STRING) is
			-- Run test cases assuming that name of `G' is `name'.
		do
			do_test (create {ARRAY [ARRAY         [G]]}.make (1, 0), "ARRAY",         name)
$NA			do_test (create {ARRAY [NATIVE_ARRAY  [G]]}.make (1, 0), "NATIVE_ARRAY",  name)
			do_test (create {ARRAY [TUPLE         [G]]}.make (1, 0), "TUPLE",         name)
			do_test (create {ARRAY [TYPED_POINTER [G]]}.make (1, 0), "TYPED_POINTER", name)
		end


feature {NONE} -- Implementation

	do_test (a: ANY; middle: STRING; inner: STRING) is
			-- Test whether `a.generating_type' has value
			-- "ARRAY [middle [inner]]".
		require
			a /= Void
			middle /= Void
			inner /= Void
		local
			actual: STRING
			expected: STRING
		do
			actual := a.generating_type
			expected := "ARRAY [" + middle + " [" + inner + "]]"
			if not actual.is_equal (expected) then
				io.put_string ("Expected: %"")
				io.put_string (expected)
				io.put_string ("%" but got %"")
				io.put_string (actual)
				io.put_string ("%".")
				io.put_new_line
			end
		end

end