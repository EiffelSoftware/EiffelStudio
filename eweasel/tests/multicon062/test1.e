
class TEST1 [G -> {TEST2 [TEST3], TEST2 [TEST4]}]
feature

	try
		local
			x: G
		do
			print (x [2])
			print (x + 2)
		end

end
