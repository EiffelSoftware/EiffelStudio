note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "It is much more important to kill bad bills than to pass good ones. - Calvin Coolidge"

class
	EC_PUBLIC_KEY

inherit
	EC_KEY_PARAMETERS
	DEBUG_OUTPUT
	EC_CONSTANTS

create
	make_q_parameters

feature -- Creation procedures
	make_q_parameters (q_new: EC_POINT params_new: EC_DOMAIN_PARAMETERS)
		do
			params := params_new
			q := q_new
		end

	agreement (other: EC_PRIVATE_KEY): INTEGER_X
		do
			Result := (q.product_value (other.d, params.curve)).x.x
		ensure
			symmetric: Result ~ other.agreement (Current)
		end

	verify (message: INTEGER_X signature: TUPLE [r: INTEGER_X s: INTEGER_X]): BOOLEAN
		do
			result := verify_r_s (message, signature.r, signature.s, params.curve)
		end

	verify_r_s (e: INTEGER_X r: INTEGER_X s: INTEGER_X curve: EC_CURVE): BOOLEAN
		require
			message_small_enough: e < params.n
		local
			c: INTEGER_X
			u1: INTEGER_X
			u2: INTEGER_X
			point: EC_POINT
			v: INTEGER_X
		do
			if
				(r < r.one) or (r >= params.n)
			then
				result := false
			elseif
				(s < s.one) or (s >= params.n)
			then
				result := false
			else
				c := s.inverse_value (params.n)
				u1 := e * c \\ params.n
				u2 := r * c \\ params.n
				point := (params.g.product_value (u1, params.curve)).plus_value (q.product_value (u2, params.curve), params.curve)
				v := point.x.x \\ params.n
				result := v ~ r
			end
		end

feature
	q: EC_POINT

feature {DEBUG_OUTPUT} -- {DEBUG_OUTPUT}
	debug_output: STRING
		do
			result := q.debug_output
		end
end
