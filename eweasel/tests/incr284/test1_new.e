
class TEST1 [G -> TEST2 create make end]
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
