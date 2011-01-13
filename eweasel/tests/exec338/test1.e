
class TEST1 [G]
feature
	a: G

	try
		do
			print (a ~ False); io.new_line
			print (a ~ '%U'); io.new_line
			print (a ~ default_pointer); io.new_line
		end

end
