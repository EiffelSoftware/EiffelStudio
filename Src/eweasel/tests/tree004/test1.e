class TEST1 [G]
inherit
	ARRAYED_TREE [G]
		redefine
			make, node_is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER; v: like item) is
		do
			Precursor (n, v)
			s := "Manu"
			val := 19
		end

feature -- Access

	s: STRING
	val: INTEGER

feature -- Comparison

	node_is_equal (other: like Current): BOOLEAN
			-- Is other equal to Current?
		do
			Result := Precursor (other) and then val = other.val and s = other.s
		end
end
