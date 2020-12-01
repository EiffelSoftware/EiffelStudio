class A

inherit
	ANY
		redefine
			out
		end

create

	make

convert

	make ({READABLE_STRING_8, STRING_8, IMMUTABLE_STRING_8})

feature {NONE} -- Creation

	make (s: READABLE_STRING_8)
		do
			out := s.mirrored.out
		end

feature -- Output

	out: like {ANY}.out
			-- <Precursor>

end