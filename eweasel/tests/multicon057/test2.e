

class TEST2 [G -> {TEST3, TEST4 rename marten as hamster end}]
feature
	try
		do
			print ({G}.weasel); io.new_line	
			print ({G}.stoat); io.new_line	
			print ({G}.marten); io.new_line	
			print ({G}.ermine); io.new_line	
			print ({G}.hamster); io.new_line	
		end

end

