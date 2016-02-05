note
	ca_only: "CA075"

class
	A

feature
	foo
		do
			do_nothing
		end

feature
	foo2
		do
			a.foo
		end

	a: A

end
