class L_GENERIC [G, H -> L_CONSTRAINT]

feature

	g_attribute: G

	h_attribute: H

	g_function (a_g: G)
		require
			a_g.is_wrapped
		do
			g_attribute := a_g
			g_attribute.do_nothing
		end

	h_function (a_h: H)
		require
			attached a_h
		do
			h_attribute := a_h
			h_attribute.func
		end

end
