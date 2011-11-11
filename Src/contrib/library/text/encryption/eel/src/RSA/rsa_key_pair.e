note
	description: "Summary description for {RSA_KEY_PAIR}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "If you think health care is expensive now, wait until you see what it costs when it's free. - P.J. O'Rourke (1993)"

class
	RSA_KEY_PAIR

inherit
	DEBUG_OUTPUT

create
	make,
	make_with_exponent

feature {NONE}
	make (bits: INTEGER)
		local
			e: INTEGER_X
			p: INTEGER_X
			q: INTEGER_X
			n: INTEGER_X
			p_bits: INTEGER
		do
			p_bits := (bits + 1) // 2
			create e.make_from_integer (65537)
			create p.make_random_prime (p_bits)
			create q.make_random_prime (bits - p_bits)
			n := p * q
			create public.make (n, e)
			create private.make (p, q, n, e)
		end

	make_with_exponent (bits: INTEGER e_a: INTEGER_X)
		require
			e_a.is_probably_prime
		local
			p: INTEGER_X
			q: INTEGER_X
			n: INTEGER_X
			p_bits: INTEGER
		do
			p_bits := (bits + 1) // 2
			create p.make_random_prime (p_bits)
			create q.make_random_prime (bits - p_bits)
			n := p * q
			create public.make (n, e_a)
			create private.make (p, q, n, e_a)
		end

feature
	public: RSA_PUBLIC_KEY
	private: RSA_PRIVATE_KEY

feature {NONE} --{DEBUG_OUTPUT}
	debug_output: STRING
		do
			result := "P: " + private.p.debug_output + " Q: " + private.q.debug_output + " D: " + private.d.debug_output + " N: " + public.modulus.debug_output	+ " E: " + public.exponent.debug_output
		end
end
