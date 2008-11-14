class TEST

create
	make

feature {NONE} -- Initialization

	make
		do
			set_a ("TEST")
			print (a)
			io.put_new_line
		end

	a: !STRING

	set_a (an_a: like a) is
		do
			if {l_a: like a} an_a then
				a := l_a.twin
			end
			a ?= an_a.twin
		ensure
			a_set: a.is_equal (an_a)
		end

end
