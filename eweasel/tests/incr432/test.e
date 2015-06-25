class TEST
create
	make

feature
	make
		do
			create s.make ($VALUE)
			wrap (s)
		end

	s: separate STRING

	wrap (a_s: separate STRING)
		do
			a_s.do_nothing
		end
end
