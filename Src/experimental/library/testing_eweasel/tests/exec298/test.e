
class TEST

create
	make
feature
	
	make
		local
			s: STRING
		do
			a := 255
			b := 65535
			c := 4294967295
			d := 18446744073709551615
			print (a); io.new_line
			print (b); io.new_line
			print (c); io.new_line
			print (d); io.new_line
			s := out
			if s.substring_index ("NATURAL_8 = 255", 1) > 0 and
			   s.substring_index ("NATURAL_16 = 65535", 1) > 0 and
			   s.substring_index ("NATURAL_32 = 4294967295", 1) > 0 and
			   s.substring_index ("NATURAL_64 = 18446744073709551615", 1) > 0 then
				print ("Out is OK%N")
			else
				print ("Out is wrong%N")
				print (s)
			end
		end

	a: NATURAL_8

	b: NATURAL_16

	c: NATURAL_32

	d: NATURAL_64

end
