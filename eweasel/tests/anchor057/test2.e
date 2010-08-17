class TEST2 [G -> {PARENT1 rename default_create as weasel end, PARENT2 rename default as ermine end}]
feature
	try
		do
			print ({like {G}.ermine})
			io.new_line
		end

end

