
expanded class TEST1
feature
	try
		do
			print ((agent :TEST2 do end).deep_twin.item ([]).a); io.new_line
		end
	
end
