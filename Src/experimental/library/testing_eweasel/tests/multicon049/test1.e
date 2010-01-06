
class TEST1 [G -> {TEST2 rename a as b, b as c, c as a end, TEST2 rename b as c, c as a, a as b end} create make end]
create
	default_create
feature
	try
		do
			create x.make
			print (x.a); io.new_line
			print (x.b); io.new_line
			print (x.c); io.new_line
		end

	x: G
end
