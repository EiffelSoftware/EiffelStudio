expanded class E

create
	default_create,
	make

feature {NONE} -- Creation

	make (x: separate TEST)
		do
			t := x
		end

feature -- Access

	t: detachable separate TEST

end