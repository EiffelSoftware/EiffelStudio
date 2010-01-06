
class TEST2 [G -> NUMERIC]

feature

	weasel
		do
			print (generating_type); io.new_line
			print (y + y); io.new_line
			print (y - y); io.new_line
			print (y * y); io.new_line
			print (y / y); io.new_line
			print (-y); io.new_line
			print (+y); io.new_line
		end

	y: G

end
