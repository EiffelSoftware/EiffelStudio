
class TEST1 [G -> TEST2 create make end]

feature

	try
		do
			create value
			x := {INTEGER_8} 3
		end

	value: G
	
	x: TEST2

end
