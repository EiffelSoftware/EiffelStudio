
class TEST2 [G -> TEST3, H -> {G, TEST4 rename weasel as stoat end}]
feature
	try
		do
			print ({G}.weasel); io.new_line	
			print ({H}.weasel); io.new_line	
			print ({H}.stoat); io.new_line	
		end

end

