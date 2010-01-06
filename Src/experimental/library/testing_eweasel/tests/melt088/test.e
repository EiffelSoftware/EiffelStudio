
class TEST

create
	make

feature

	make
		local
			c: CHARACTER_32
		do
			c := 'A'
			print (c); io.new_line
			print ({CHARACTER_32} 'A'); io.new_line
			c3 := 'A'
			print (c3); io.new_line
			c := {TEST2}.value
			print (c); io.new_line
			print (c2); io.new_line
			print ({TEST2}.value); io.new_line
		end
	
	c2: CHARACTER_32 = 'A'
	
	c3: CHARACTER_32 
end

