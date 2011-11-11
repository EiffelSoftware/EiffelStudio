note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The urge to save humanity is almost always a false front for the urge to rule. - H.L. Mencken"

deferred class
	EC_DOMAIN_PARAMETERS

inherit
	EC_CONSTANTS
	DEBUG_OUTPUT

feature
	curve: EC_CURVE
	g: EC_POINT
	n: INTEGER_X
	h: INTEGER_X

	make_curve_g_n (curve_new: like curve g_new: like g n_new: INTEGER_X)
			-- Construct this domain with no seed and h= 1
		do
			curve := curve_new
			g := g_new
			n := n_new
			h := ONE
		end

	make_curve_g_n_h (curve_new: like curve g_new: like g n_new: INTEGER_X h_new: INTEGER_X)
			-- construct this domain with no seed
		do
			curve := curve_new
			g := g_new
			n := n_new
			h := h_new
		end

feature {DEBUG_OUTPUT} -- {DEBUG_OUTPUT}
	debug_output: STRING
		do
			result := "Curve: " + curve.debug_output + "%Ng: " + g.debug_output + "%Nn: " + n.out_hex + "%Nh: " + h.out_hex
		end
end
