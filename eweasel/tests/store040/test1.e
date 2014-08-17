class
	TEST1

inherit
	TEST2

create
	make

feature

	s: ARRAY [like args.linear_representation]
		--The declaration below is similar to the one above.
		--s: ARRAY [LINEAR [IMMUTABLE_STRING_32]]

	make
		do
			create s.make (1, 10)
		end

end
