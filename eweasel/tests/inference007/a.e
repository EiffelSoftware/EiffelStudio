class A [G -> COMPARABLE]

feature

	f (g: G)
		local
			x
		do
			x := g
			if x > x or else x.is_less (x) then
				print ("Failed")
			else
				print ("OK")
			end
			io.put_new_line
		end

end