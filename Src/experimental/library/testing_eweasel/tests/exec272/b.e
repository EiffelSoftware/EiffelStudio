deferred class B [G]

feature

	f (a: G): G is
		do
			io.put_string ("B.f")
			io.put_new_line
			Result := a
			i := a
		end

	g (a: G): G is
		deferred
		end

	h: G is
		deferred
		end

	i: G

end