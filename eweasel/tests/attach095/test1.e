
class TEST1
feature
	value: TEST2
	       local
			t: TUPLE [c: TUPLE [x: TEST2]]
	       do
			create t
			print (t.c.generating_type); io.new_line
	       end

end

