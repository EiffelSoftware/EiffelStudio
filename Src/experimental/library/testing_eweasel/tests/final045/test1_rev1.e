class TEST1 [G -> {STRING rename make as out, out as make end} create make end]
create
		default_create
feature
	try
		do
			create x.make
			print (x.count);
			io.new_line
		end

	x: G
end
