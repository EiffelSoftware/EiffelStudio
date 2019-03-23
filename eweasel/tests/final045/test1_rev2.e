class TEST1 [G -> {STRING rename make as out, out as make end} create out end]
create
		default_create
feature
	try
		do
			create x.out (0)
			print (x.count)
			io.new_line
		end

	x: G
end
