class
	TEST1 [ G-> H, H -> G]

feature

	f
		local
			g: G
		do
			print (g.same_type (g))
		end

end
