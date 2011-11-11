note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Liberty is always dangerous, but it is the safest thing we have. - Harry Emerson Fosdick"

class
	EC_PRIVATE_KEY

inherit
	EC_KEY_PARAMETERS
	DEBUG_OUTPUT
	EC_CONSTANTS

create
	make_d_params

feature
	make_d_params (d_new: INTEGER_X params_new: EC_DOMAIN_PARAMETERS)
		do
			params := params_new
			d := d_new
		end

	agreement (other: EC_PUBLIC_KEY): INTEGER_X
		do
			result := (other.q.product_value (d, params.curve)).x.x
		ensure
			symmetric: result ~ other.agreement (current)
		end

	sign (e: INTEGER_X): TUPLE [r: INTEGER_X s: INTEGER_X]
		require
			message_too_big: e < params.n
		local
			r: INTEGER_X
			s: INTEGER_X
			k: INTEGER_X
			nBitLength: INTEGER_32
			p: EC_POINT
			x: INTEGER_X
			n: INTEGER_X
		do
			n := params.n
			create s.default_create
			create r.default_create
			create k.default_create
			nBitLength := params.n.bits
			from
			until
				s /~ s.zero
			loop
				from
				until
					r /~ r.zero
				loop
					from
					until
						k /~ k.zero
					loop
						create k.make_random (nBitLength)
					end
					p := params.g.product_value (k, params.curve)
					x := p.x.x
					r := x \\ params.n
				end
				--s := ((k.inverse_value (params.n) * (e + d * r))) \\ params.n
				s := d.identity
				s.product (r)
				s.plus (e)
				k.inverse (n)
				s.product (k)
				s.modulo (n)
			end
			create result
			result.r := r
			result.s := s
		end

feature
	d: INTEGER_X

feature {DEBUG_OUTPUT} -- {DEBUG_OUTPUT}
	debug_output: STRING
		do
			result := "0x" + d.out_hex
		end
end
