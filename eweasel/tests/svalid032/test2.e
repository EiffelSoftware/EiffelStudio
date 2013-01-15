class TEST2 [G]

feature

	append (g: TEST2 [G])
		local
			l_g: TEST2 [G]
			l_like_g: like g
		do
			l_g := g
			l_like_g := g

			l_g := Current
			l_g := twin

			l_like_g := Current
			l_like_g := twin
		end

end
