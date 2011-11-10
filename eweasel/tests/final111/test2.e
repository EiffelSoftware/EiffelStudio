
class TEST2 [G -> TEST4]
feature
	try
		do
			print ({like {TEST3 [G]}.hamster}.turkey); io.new_line
			print ({like {TEST3 [TEST4]}.hamster}.turkey); io.new_line
			print ({like {TEST3 [TEST5]}.hamster}.ermine); io.new_line
		end

end
