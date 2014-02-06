class A [G -> COMPARABLE]

feature

	f
		local
			g: G
			x
		do
			x := g
			if x > x or else x.is_less (x) then
				print ("Failed.")
			end
		end

end