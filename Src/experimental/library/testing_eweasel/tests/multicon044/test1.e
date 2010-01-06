
class TEST1 [G -> STRING rename count as infix "-" end create make end]
feature
	try
		do
			create x.make (47)
			x := x - 3
			print (x); io.new_line
		end

	x: G
end
