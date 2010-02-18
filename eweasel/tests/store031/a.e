note
	$VERSION

class A

create
	make

feature {NONE} -- Creation

	make
		do
			s := "NON_VOLATILE"
			i := 123123
		end

feature -- Access

	s: STRING
	i: INTEGER


end
