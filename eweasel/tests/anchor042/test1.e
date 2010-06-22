
expanded class TEST1 [G -> ANY create default_create end]
feature
	try
		do
			create x
			print (x.generating_type); io.new_line
			create y
			print (y.generating_type); io.new_line
		end

	x: like {TEST1 [TEST3 [G]]}.y.weasel

	y: G
end

