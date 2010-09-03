
class TEST

create
	make


feature
	make
		do
			if attached {TEST2 [TEST3]} x as z then
			   print (z.generating_type); io.new_line
			   if z.a /= Void then
			      print (z.a.generating_type); io.new_line
			      print (z.a.c); io.new_line
			   else
			      print ("Void%N")
			   end
			end
		end

	x: TEST2 [DOUBLE]

end

