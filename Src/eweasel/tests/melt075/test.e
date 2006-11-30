
class TEST
create
	make
feature
	
	make is
		do
			c := 'w'
			inspect c
			when Weasel then
				print ("OK 1%N")
			end
			
			inspect {CHARACTER_32} 'w'
			when {CHARACTER_32} 'w' then
				print ("OK 2%N")
			end
			
			inspect c
			when {CHARACTER_32} 'w' then
				print ("OK 3%N")
			end
		end

	c: CHARACTER_32
	
	Weasel: CHARACTER_32 is 'w'

end
