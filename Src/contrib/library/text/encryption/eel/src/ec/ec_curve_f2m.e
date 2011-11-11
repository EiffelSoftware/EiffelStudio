note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "When the government's boot is on your throat, whether it is a left boot or a right boot is of no consequence. - Gary Lloyd"

class
	EC_CURVE_F2M

inherit
	EC_CURVE
		redefine
			is_equal,
			a,
			b
		end
	STANDARD_CURVES
		undefine
			is_equal
		end
	F2M_REPRESENTATIONS
		undefine
			is_equal
		end

create
	make,
	make_sec_t113r1,
	make_sec_t113r2,
	make_sec_t131r1,
	make_sec_t131r2,
	make_sec_t163k1,
	make_sec_t163r1,
	make_sec_t163r2,
	make_sec_t193r1,
	make_sec_t193r2,
	make_sec_t233k1,
	make_sec_t233r1,
	make_sec_t239k1,
	make_sec_t283k1,
	make_sec_t283r1,
	make_sec_t409k1,
	make_sec_t409r1,
	make_sec_t571k1,
	make_sec_t571r1,
	make_k163,
	make_k233,
	make_k283,
	make_k409,
	make_k571,
	make_b163,
	make_b233,
	make_b283,
	make_b409,
	make_b571

feature -- SEC curves
	make_sec_t113r1
		do
			m := sec_t113r1_m
			k1 := sec_t113r1_k1
			k2 := sec_t113r1_k2
			k3 := sec_t113r1_k3
			n := sec_t113r1_r
			create a.make (sec_t113r1_a)
			create b.make (sec_t113r1_b)
		end

	make_sec_t113r2
		do
			m := sec_t113r2_m
			k1 := sec_t113r2_k1
			k2 := sec_t113r2_k2
			k3 := sec_t113r2_k3
			n := sec_t113r2_r
			create a.make (sec_t113r2_a)
			create b.make (sec_t113r2_b)
		end

	make_sec_t131r1
		do
			m := sec_t131r1_m
			k1 := sec_t131r1_k1
			k2 := sec_t131r1_k2
			k3 := sec_t131r1_k3
			n := sec_t131r1_r
			create a.make (sec_t131r1_a)
			create b.make (sec_t131r1_b)
		end

	make_sec_t131r2
		do
			m := sec_t131r2_m
			k1 := sec_t131r2_k1
			k2 := sec_t131r2_k2
			k3 := sec_t131r2_k3
			n := sec_t131r2_r
			create a.make (sec_t131r2_a)
			create b.make (sec_t131r2_b)
		end

	make_sec_t163k1
		do
			m := sec_t163k1_m
			k1 := sec_t163k1_k1
			k2 := sec_t163k1_k2
			k3 := sec_t163k1_k3
			n := sec_t163k1_r
			create a.make (sec_t163k1_a)
			create b.make (sec_t163k1_b)
		end

	make_sec_t163r1
		do
			m := sec_t163r1_m
			k1 := sec_t163r1_k1
			k2 := sec_t163r1_k2
			k3 := sec_t163r1_k3
			n := sec_t163r1_r
			create a.make (sec_t163r1_a)
			create b.make (sec_t163r1_b)
		end

	make_sec_t163r2
		do
			m := sec_t163r2_m
			k1 := sec_t163r2_k1
			k2 := sec_t163r2_k2
			k3 := sec_t163r2_k3
			n := sec_t163r1_r
			create a.make (sec_t163r2_a)
			create b.make (sec_t163r2_b)
		end

	make_sec_t193r1
		do
			m := sec_t193r1_m
			k1 := sec_t193r1_k1
			k2 := sec_t193r1_k2
			k3 := sec_t193r1_k3
			n := sec_t193r1_r
			create a.make (sec_t193r1_a)
			create b.make (sec_t193r1_b)
		end

	make_sec_t193r2
		do
			m := sec_t193r2_m
			k1 := sec_t193r2_k1
			k2 := sec_t193r2_k2
			k3 := sec_t193r2_k3
			n := sec_t193r2_r
			create a.make (sec_t193r2_a)
			create b.make (sec_t193r2_b)
		end

	make_sec_t233k1
		do
			m := sec_t233k1_m
			k1 := sec_t233k1_k1
			k2 := sec_t233k1_k2
			k3 := sec_t233k1_k3
			n := sec_t233k1_r
			create a.make (sec_t233k1_a)
			create b.make (sec_t233k1_b)
		end

	make_sec_t233r1
		do
			m := sec_t233r1_m
			k1 := sec_t233r1_k1
			k2 := sec_t233r1_k2
			k3 := sec_t233r1_k3
			n := sec_t233r1_r
			create a.make (sec_t233r1_a)
			create b.make (sec_t233r1_b)
		end

	make_sec_t239k1
		do
			m := sec_t239k1_m
			k1 := sec_t239k1_k1
			k2 := sec_t239k1_k2
			k3 := sec_t239k1_k3
			n := sec_t239k1_r
			create a.make (sec_t239k1_a)
			create b.make (sec_t239k1_b)
		end

	make_sec_t283k1
		do
			m := sec_t283k1_m
			k1 := sec_t283k1_k1
			k2 := sec_t283k1_k2
			k3 := sec_t283k1_k3
			n := sec_t283k1_r
			create a.make (sec_t283k1_a)
			create b.make (sec_t283k1_b)
		end

	make_sec_t283r1
		do
			m := sec_t283r1_m
			k1 := sec_t283r1_k1
			k2 := sec_t283r1_k2
			k3 := sec_t283r1_k3
			n := sec_t283r1_r
			create a.make (sec_t283r1_a)
			create b.make (sec_t283r1_b)
		end

	make_sec_t409k1
		do
			m := sec_t409k1_m
			k1 := sec_t409k1_k1
			k2 := sec_t409k1_k2
			k3 := sec_t409k1_k3
			n := sec_t409k1_r
			create a.make (sec_t409k1_a)
			create b.make (sec_t409k1_b)
		end

	make_sec_t409r1
		do
			m := sec_t409r1_m
			k1 := sec_t409r1_k1
			k2 := sec_t409r1_k2
			k3 := sec_t409r1_k3
			n := sec_t409r1_r
			create a.make (sec_t409r1_a)
			create b.make (sec_t409r1_b)
		end

	make_sec_t571k1
		do
			m := sec_t571k1_m
			k1 := sec_t571k1_k1
			k2 := sec_t571k1_k2
			k3 := sec_t571k1_k3
			n := sec_t571k1_r
			create a.make (sec_t571k1_a)
			create b.make (sec_t571k1_b)
		end

	make_sec_t571r1
		do
			m := sec_t571r1_m
			k1 := sec_t571r1_k1
			k2 := sec_t571r1_k2
			k3 := sec_t571r1_k3
			n := sec_t571r1_r
			create a.make (sec_t571r1_a)
			create b.make (sec_t571r1_b)
		end

feature -- FIPS curves
	make_k163
		do
			m := k163_m
			k1 := k163_k1
			k2 := k163_k2
			k3 := k163_k3
			n := k163_r
			create a.make (k163_a)
			create b.make (k163_b)
		end

	make_k233
		do
			m := k233_m
			k1 := k233_k1
			k2 := k233_k2
			k3 := k233_k3
			n := k233_r
			create a.make (k233_a)
			create b.make (k233_b)
		end

	make_k283
		do
			m := k283_m
			k1 := k283_k1
			k2 := k283_k2
			k3 := k283_k3
			n := k283_r
			create a.make (k283_a)
			create b.make (k283_b)
		end

	make_k409
		do
			m := k409_m
			k1 := k409_k1
			k2 := k409_k2
			k3 := k409_k3
			n := k409_r
			create a.make (k409_a)
			create b.make (k409_b)
		end

	make_k571
		do
			m := k571_m
			k1 := k571_k1
			k2 := k571_k2
			k3 := k571_k3
			n := k571_r
			create a.make (k571_a)
			create b.make (k571_b)
		end

	make_b163
		do
			m := b163_m
			k1 := b163_k1
			k2 := b163_k2
			k3 := b163_k3
			n := b163_r
			create a.make (b163_a)
			create b.make (b163_b)
		end

	make_b233
		do
			m := b233_m
			k1 := b233_k1
			k2 := b233_k2
			k3 := b233_k3
			n := b233_r
			create a.make (b233_a)
			create b.make (b233_b)
		end

	make_b283
		do
			m := b283_m
			k1 := b283_k1
			k2 := b283_k2
			k3 := b283_k3
			n := b283_r
			create a.make (b283_a)
			create b.make (b283_b)
		end

	make_b409
		do
			m := b409_m
			k1 := b409_k1
			k2 := b409_k2
			k3 := b409_k3
			n := b409_r
			create a.make (b409_a)
			create b.make (b409_b)
		end

	make_b571
		do
			m := b571_m
			k1 := b571_k1
			k2 := b571_k2
			k3 := b571_k3
			n := b571_r
			create a.make (b571_a)
			create b.make (b571_b)
		end

	make (m_new: INTEGER_32 k1_new: INTEGER_32 k2_new: INTEGER_32 k3_new: INTEGER_32 a_a: EC_FIELD_ELEMENT_F2M b_a: EC_FIELD_ELEMENT_F2M n_a: INTEGER_X)
		require
			K1_greater_Than_zero: k1_new > 0
			k2_and_k3_equal_zero: (k2_new = 0) implies (k3_new = 0)
			k2_greater_than_k1: (k2_new /= 0) implies (k2_new > k1_new)
			k3_greater_than_k2: (k3_new /= 0) implies (k3_new > k2_new)
		do
			m := m_new
			k1 := k1_new
			k2 := k2_new
			k3 := k3_new
			a := a_a
			b := b_a
			n := n_a
		end

feature -- F2M components
	m: INTEGER_32
	n: INTEGER_X
	k1: INTEGER_32
	k2: INTEGER_32
	k3: INTEGER_32

feature
	representation: INTEGER
		do
			if
				k2 = 0
			then
				result := TPB
			else
				result := PPB
			end

		end

	is_equal (other: like current): BOOLEAN
		do
			Result := (m = other.m) and (k1 = other.k1) and (k2 = other.k2) and (k3 = other.k3) and a.x ~ other.a.x and b.x ~ other.b.x
		end

	a: EC_FIELD_ELEMENT_F2M
	b: EC_FIELD_ELEMENT_F2M

invariant
--	k2_smaller: k2 = 0 implies k2 < k3
--	k2_zero: k2 = 0 implies k2 /= 0
	K1_greater_Than_zero: k1 > 0
	k2_and_k3_equal_zero: (k2 = 0) implies (k3 = 0)
	k2_greater_than_k1: (k2 /= 0) implies (k2 > k1)
	k3_greater_than_k2: (k3 /= 0) implies (k3 > k2)
end
