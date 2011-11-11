note
	description: "Summary description for {RAND_LC_STRUCT}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Everyone wants to save the planet but no one wants to help Mom clean the dishes. -  P.J. O'Rourke, in All the Trouble in the World "

class
	RAND_LC_STRUCT

inherit
	INTEGER_X_DIVISION
	LIMB_MANIPULATION

create
	make

feature

	make (m2exp_a: INTEGER; a_a: READABLE_INTEGER_X; seedn: INTEGER; c: NATURAL_32)
		do
			create cp.make_filled (0, 1)
			m2exp := m2exp_a
			create seed.make_limbs (bits_to_limbs (m2exp))
			seed.count := seedn
			seed.item [0] := 1
			create a
			fdiv_r_2exp (a, a_a, m2exp)
			if a.count = 0 then
				a.count := 1
				a.item [0] := 0
			end
			cp [0] := c
			cn := (c /= 0).to_integer
		end

feature

	seed: INTEGER_X
	a: INTEGER_X
	cn: INTEGER
	cp: SPECIAL [NATURAL_32]
	m2exp: INTEGER
end
