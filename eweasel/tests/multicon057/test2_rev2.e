

class TEST2 [G -> {TEST3, TEST4 rename marten as hamster, manu as real_manu end}]
feature
	try
		do
			print ({G}.weasel); io.new_line
			print ({G}.stoat); io.new_line
			print ({G}.marten); io.new_line
			print ({G}.ermine); io.new_line
			print ({G}.hamster); io.new_line
			print ({G}.manu); io.new_line
			print ({G}.real_manu); io.new_line
		end

end

