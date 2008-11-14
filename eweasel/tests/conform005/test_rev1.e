class TEST

create
	make

feature {NONE} -- Initialization

	make
		do
			det_b := << "TEST" >>
			set_b
			set_a ("TEST")
		end

	a: !STRING
	b: !ARRAY [STRING]
	det_b: ?like b

	set_b is
		do
			if {l_b: like b} det_b then
				b := l_b.twin
				io.put_string (b.item (1))
				io.put_new_line
			end
		end

	set_a (an_a: like a) is
		do
			if {l_a: like a} an_a.twin then
				a := l_a
				io.put_string (a)
				io.put_new_line
			end
		ensure
			a_set: a.is_equal (an_a)
		end

end
