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

	a: STRING
	b: ARRAY [detachable STRING]
	det_b: detachable like b

	set_b
		do
			if attached {like b} det_b as l_b then
				b := l_b.twin
				print (b.item (1))
				io.put_new_line
			end
		end

	set_a (an_a: like a)
		do
			a ?= an_a.twin
			io.put_string (a)
			io.put_new_line
		ensure
			a_set: a.is_equal (an_a)
		end

end
