deferred class A [G]

feature

	a: G is
		deferred
		end

	f (x: G) is
		require
			x_attached: x /= Void
		do
			io.put_string ("{A}.f (")
			io.put_string (x.out)
			io.put_string (")")
			io.put_new_line
		end

	g (x: G) is
		deferred
		end

	h (x: INTEGER) is
		do
			io.put_string ("{A}.h (")
			io.put_integer (x)
			io.put_string (")")
			io.put_new_line
		end

end