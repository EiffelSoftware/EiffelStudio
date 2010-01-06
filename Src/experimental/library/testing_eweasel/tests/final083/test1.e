class
	TEST1 [G, H, K]

feature

	g
		local
			k: K
		do
			create f
			f.failure (k)
		end

	f: TEST2 [K]

end
