class A [G]

feature -- Tests

	test (name: STRING)
			-- Run test cases assuming that name of `G' is `name'.
		do
			do_test (create {ARRAY [ARRAY         [G]]}.make_empty, "ARRAY",         name)
$NA			do_test (create {ARRAY [NATIVE_ARRAY  [G]]}.make_empty, "NATIVE_ARRAY",  name)
			do_test (create {ARRAY [TUPLE         [G]]}.make_empty, "TUPLE",         name)
			do_test (create {ARRAY [TYPED_POINTER [G]]}.make_empty, "TYPED_POINTER", name)
		end


feature {NONE} -- Implementation

	do_test (a: ANY; middle: STRING; inner: STRING)
			-- Test whether `a.generating_type' has value
			-- "ARRAY [middle [inner]]".
		require
			a /= Void
			middle /= Void
			inner /= Void
		local
			actual: READABLE_STRING_32
			expected: STRING
		do
			actual := a.generating_type.name_32
			expected := "ARRAY [" + middle + " [" + inner + "]]"
			if not actual.same_string_general (expected) then
				io.put_string ("Expected: %"")
				io.put_string (expected)
				io.put_string ("%" but got %"")
				io.put_string_32 (actual)
				io.put_string ("%".")
				io.put_new_line
			end
		end

end