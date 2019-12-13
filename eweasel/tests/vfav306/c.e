class C [G -> {A rename f as f alias "()" end, B rename g as g alias "()" end}]

feature -- Test

	h (x: G)
		do
			x (Current)
		end

end
