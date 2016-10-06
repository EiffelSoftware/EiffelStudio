class
	STORABLE_TEST

create
	make

feature

	make
		do
			create {TEST2 [$CONSTRAINT]} a.make
		end

	a: TEST1

	test
		local
			l_a: TEST1
		do
			create {TEST2 [$CONSTRAINT]} l_a.make
			if a.generating_type /~ l_a.generating_type then
				Io.put_string ("Not of the expected type, got " + a.generating_type.name + " but expected " + l_a.generating_type.name + "%N")
			end
		end

end
