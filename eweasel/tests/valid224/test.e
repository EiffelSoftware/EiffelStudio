
class TEST
create
	make
feature
	
	make is
		do
			n := [[47]]
			print (n.a.out); io.new_line
		end

	n: TUPLE [a: TUPLE [out: INTEGER]]

end
