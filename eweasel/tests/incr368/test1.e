
class TEST1 [G -> NUMERIC]
feature
	try
		do
			if attached {like {TEST2 [G]}.value} value as x then
				print (x.generating_type); io.new_line
				print (x); io.new_line
			end
			if attached {like {TEST2 [INTEGER_8]}.value} value as x then
				print (x.generating_type); io.new_line
				print (x); io.new_line
			end
			if attached {like {TEST2 [INTEGER_16]}.value} value as x then
				print (x.generating_type); io.new_line
				print (x); io.new_line
			end
			if attached {like {TEST2 [INTEGER_32]}.value} value as x then
				print (x.generating_type); io.new_line
				print (x); io.new_line
			end
			if attached {like {TEST2 [INTEGER_64]}.value} value as x then
				print (x.generating_type); io.new_line
				print (x); io.new_line
			end
			if attached {like {TEST2 [NATURAL_8]}.value} value as x then
				print (x.generating_type); io.new_line
				print (x); io.new_line
			end
			if attached {like {TEST2 [NATURAL_16]}.value} value as x then
				print (x.generating_type); io.new_line
				print (x); io.new_line
			end
			if attached {like {TEST2 [NATURAL_32]}.value} value as x then
				print (x.generating_type); io.new_line
				print (x); io.new_line
			end
			if attached {like {TEST2 [NATURAL_64]}.value} value as x then
				print (x.generating_type); io.new_line
				print (x); io.new_line
			end
			if attached {like {TEST2 [REAL]}.value} value as x then
				print (x.generating_type); io.new_line
				print (x); io.new_line
			end
			if attached {like {TEST2 [DOUBLE]}.value} value as x then
				print (x.generating_type); io.new_line
				print (x); io.new_line
			end
		end
	
	value: detachable G

	set_value (a_value: like value)
		do
			value := a_value
		end

end
