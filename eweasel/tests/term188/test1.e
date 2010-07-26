
class TEST1 [G -> TEST2]
feature
	x: INTEGER

	try
		do
			inspect x
			when {G}.a then
			else
				print ("Oooops!%N")
			end
		end
end
