deferred class B [G]
inherit
	A

feature

	a: D [B [G]]

	f is
		do
			create a
			a.out.do_nothing
			io.put_string ("B")
		end

end
