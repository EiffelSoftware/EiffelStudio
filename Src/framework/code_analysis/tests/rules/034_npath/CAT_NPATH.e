class
	CAT_NPATH
	
feature {NONE} -- Test

	npath (a, b, c, d, e, f, g, h, j: INTEGER)
		do
			if a > b then
				print ("a > b")
			end
			if c /= d then
				print ("c /= d")
			elseif f > h then
				print ("f > h")
			else
				print ("c = d")
			end
			
			if e = g then
				print ("e = g")
			end
			
			if j = 0 then
				print ("j = 0!")
			end
			
			if h > a then
				print ("h > a")
			end
			
			if d <= b then
				print ("d <= b")
			end
			
			if c < 0 then
				print ("subzero!")
			end
			
			if b = j then
				print ("b=j...")
			end
		end
	
end
