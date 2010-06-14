class B

inherit
	A
		redefine
			foo
		end

feature

	foo: B
		do
			create Result
		end

end