class
	TEST1 [ G-> H, H -> G]

feature

	f is
		local
			g: G
		do
			print (g.same_type (g))
		end

end
