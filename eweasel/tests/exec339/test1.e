class TEST1
inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature -- Initialization

	make
		do
			str := "Toto"
		end

feature -- Access

	str: STRING

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
		do
			Result := str.same_string (other.str)
		end

end
