class TEST

create
	make

feature {NONE} -- Initialization

	make
		do
			create b.make_filled ("", 1, 1)
			det_b := << "TEST" >>
			set_b
			set_a ("TEST")
		end

	a: attached STRING
	b: attached ARRAY [STRING]
	det_b: detachable like b

	set_b is
		do
			if {l_b: like b} det_b then
				b := l_b.twin
				print (b.item (1))
				io.put_new_line
			end
		end

	set_a (an_a: like a) is
		do
			a ?= an_a.twin
			io.put_string (a)
			io.put_new_line
		ensure
			a_set: a.is_equal (an_a)
		end

end
