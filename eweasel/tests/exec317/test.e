
class TEST

create
	make

feature

	make
		local
			d1, d2: DOUBLE
			s: STRING
		do
			d1 := 0.96920271475975472
			s := "0.96920271475975472"
			d2 := s.to_double
			if d1 = d2 then
				print ("PASSED%N")
			else
				print ("FAILED%N")
			end
		end

end
