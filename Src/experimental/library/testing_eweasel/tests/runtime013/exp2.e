expanded class EXP2
inherit
	ANY
		redefine
			default_create
		end

feature

	default_create
		do
			n1 := 1
			n2 := 8
			n3 := 16
			s := Void
		end

	set (m1, m2, m3, m4: NATURAL_64)
		do
			n1 := m1
			n2 := m2
			n3 := m3
		end

	n1: NATURAL_64
	n2: NATURAL_64
	n3: NATURAL_64
	s: STRING

end
