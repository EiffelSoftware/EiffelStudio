note
	description: "Summary description for {RSA_PRIVATE_KEY}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "If you have ten thousand regulations, you destroy all respect for the law. - Winston Churchill"

class
	RSA_PRIVATE_KEY

create
	make

feature
	make (p_a: INTEGER_X q_a: INTEGER_X n_a: INTEGER_X e_a: INTEGER_X)
		local
			phi: INTEGER_X
		do
			p := p_a
			q := q_a
			n := n_a
			e := e_a
			phi := (p - p.one) * (q - q.one)
			d := e.inverse_value (phi)
		end

	sign (message: INTEGER_X): INTEGER_X
		do
			result := decrypt (message)
		end

	decrypt (cipher: INTEGER_X): INTEGER_X
		do
			result := cipher.powm_value (d, n)
		end

feature
	p: INTEGER_X
	q: INTEGER_X
	d: INTEGER_X
	n: INTEGER_X
	e: INTEGER_X

invariant
	p * q ~ n
end
